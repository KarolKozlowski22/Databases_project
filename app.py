from flask import Flask, render_template, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text, inspect, insert
from sqlalchemy.exc import NoSuchTableError, IntegrityError
from models.models import Lotnisko, Przyloty, Odloty, PasStartowy, Pasazer, Samolot, Pracownik, db

import json


from os import environ

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get('DB_URL')


with app.app_context():
    db.init_app(app)
    db.create_all()

@app.route('/dane', methods=['GET'])
def get_dane():
    try:
        tabela = request.args.get('tabela')

        if tabela is None:
            return jsonify({'error': 'Brak nazwy tabeli'}, 400)

        connection = db.engine.connect()
        raw_query = text(f'SELECT * FROM {tabela};')
        result = connection.execute(raw_query)

        dane_list = []
        columns = result.keys()

        for row in result:
            dane_dict = dict(zip(columns, row))
            dane_list.append(dane_dict)

        dane_json = json.dumps({'dane': dane_list}, default=str)
        return app.response_class(response=dane_json, status=200, mimetype='application/json')
    except Exception as e:
        return jsonify({'error': str(e)}, 500)



@app.route('/przyloty_odloty', methods=['GET'])
def get_przyloty_odloty():
    try:
        data = request.args.get('data')

        raw_query = text('''
            SELECT
                lotnisko.nazwa_lotniska,
                przyloty.data_przylotu,
                przyloty.numer_rejsu AS numer_przylotu,
                odloty.data_odlotu,
                odloty.numer_rejsu AS numer_odlotu
            FROM
                lotnisko
            LEFT JOIN przyloty ON lotnisko.lotnisko_id = przyloty.lotnisko_id
            LEFT JOIN odloty ON lotnisko.lotnisko_id = odloty.lotnisko_id
            WHERE
                przyloty.data_przylotu = :data OR odloty.data_odlotu = :data
        ''')
        connection = db.engine.connect()
        result = connection.execute(raw_query, {'data': data})

        przyloty_odloty = []
        for row in result:
            przyloty_odloty.append({
                'lotnisko': row.nazwa_lotniska,
                'data_przylotu': row.data_przylotu,
                'numer_przylotu': row.numer_przylotu,
                'data_odlotu': row.data_odlotu,
                'numer_odlotu': row.numer_odlotu
            })

        return jsonify({'przyloty_odloty': przyloty_odloty})
    except Exception as e:
        return jsonify({'error': str(e)}), 500




@app.route('/liczba_pasazerow_na_lotnisku', methods=['GET'])
def liczba_pasazerow_na_lotnisku():
    try:
        raw_query = text('''
            SELECT
                lotnisko.kraj,
                lotnisko.nazwa_lotniska,
                SUM(pasazer.numer_rejsu) AS liczba_pasazerow
            FROM
                lotnisko
            JOIN
                pasazer ON lotnisko.lotnisko_id = pasazer.lotnisko_id
            GROUP BY
                lotnisko.kraj, lotnisko.nazwa_lotniska
        ''')

        connection = db.engine.connect()
        result = connection.execute(raw_query)

        wyniki = []
        for row in result:
            wyniki.append({
                'kraj': row.kraj,
                'lotnisko': row.nazwa_lotniska,
                'liczba_pasazerow': row.liczba_pasazerow
            })

        return jsonify({'liczba_pasazerow_na_lotnisku': wyniki})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/najczesciej_uzywane_samoloty', methods=['GET'])
def najczesciej_uzywane_samoloty():
    try:
        lotnisko_id = request.args.get('lotnisko_id')

        if not lotnisko_id.isdigit():
            raise ValueError("Lotnisko_id must be a valid integer.")

        raw_query = text('''
            SELECT
                samolot.numer_seryjny,
                COUNT(*) AS liczba_odlotow
            FROM
                samolot
            JOIN
                odloty ON samolot.samolot_id = odloty.samolot_id
            WHERE
                odloty.lotnisko_id = :lotnisko_id
            GROUP BY
                samolot.numer_seryjny
            ORDER BY
                COUNT(*) DESC
            LIMIT 5
        ''')

        connection = db.engine.connect()
        result = connection.execute(raw_query, {'lotnisko_id': int(lotnisko_id)})

        najczesciej_uzywane_samoloty_list = [
            {'numer_seryjny': row.numer_seryjny, 'liczba_odlotow': row.liczba_odlotow}
            for row in result
        ]

        return jsonify({'najczesciej_uzywane_samoloty': najczesciej_uzywane_samoloty_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/pracownicy_na_lotnisku', methods=['GET'])
def pracownicy_na_lotnisku():
    try:
        lotnisko_id = request.args.get('lotnisko_id')

        if not lotnisko_id.isdigit():
            raise ValueError("Lotnisko_id must be a valid integer.")

        raw_query = text('''
            SELECT
                pracownik.imie,
                pracownik.nazwisko
            FROM
                pracownik
            WHERE
                pracownik.lotnisko_id = :lotnisko_id
            ORDER BY
                pracownik.nazwisko,
                pracownik.imie
        ''')

        connection = db.engine.connect()
        result = connection.execute(raw_query, {'lotnisko_id': int(lotnisko_id)})

        pracownicy_na_lotnisku_list = [
            {'imie': row.imie, 'nazwisko': row.nazwisko}
            for row in result
        ]

        return jsonify({'pracownicy_na_lotnisku': pracownicy_na_lotnisku_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/kolumny-tabeli', methods=['GET'])
def get_kolumny_tabeli():
    tabela = request.args.get('tabela')

    if tabela is None:
        return jsonify({'error': 'Brak nazwy tabeli'}, 400)

    inspector = inspect(db.engine)

    if not inspector.has_table(tabela):
        return jsonify({'error': 'Tabela nie istnieje'}, 404)

    kolumny = [column['name'] for column in inspector.get_columns(tabela)]
    
    return jsonify({'kolumny': kolumny})



@app.route('/wykonaj-alter-table', methods=['POST'])
def wykonaj_alter_table():
    try:
        tabela = request.args.get('tabela')

        if tabela is None:
            return jsonify({'error': 'Brak nazwy tabeli'}, 400)

        inspector = inspect(db.engine)

        try:
            if tabela not in inspector.get_table_names():
                raise NoSuchTableError(tabela)

            dane = request.get_json()
            model_class = globals().get(tabela.capitalize())  
            if not model_class:
                raise NoSuchTableError(tabela)

            columns = model_class.__table__.columns.keys()
            valid_keys = [key for key in dane.keys() if key in columns]

            data_to_insert = {key: dane[key] for key in valid_keys}

            try:
                new_record = model_class(**data_to_insert)
                db.session.add(new_record)
                db.session.commit()
                return jsonify({'success': True})
            except Exception as e:
                db.session.rollback()
                print(e)
                return jsonify({'error': str(e)}), 500
        except NoSuchTableError:
            return jsonify({'error': 'Tabela nie istnieje'}, 404)
    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500
    
# @app.route('/usun', methods=['DELETE'])
# def usun_wiersz():
#     try:
#         tabela = request.args.get('tabela')
#         id_field_name = f'{tabela.lower()}_id'
#         id_value = request.args.get('id')

#         if tabela is None or id_value is None:
#             return jsonify({'error': 'Brak nazwy tabeli lub ID'}, 400)

#         inspector = inspect(db.engine)

#         try:
#             if tabela not in inspector.get_table_names():
#                 raise NoSuchTableError(tabela)

#             model_class = globals().get(tabela.capitalize())

#             if not model_class:
#                 raise NoSuchTableError(tabela)
#             print(f'DELETE FROM {tabela} WHERE {id_field_name} = {id_value}')
#             raw_query = text(f'DELETE FROM {tabela} WHERE {id_field_name} = :id_value')
#             connection = db.engine.connect()
#             connection.execute(raw_query, {'id_value': id_value})
#             db.session.commit()
#             return jsonify({'success': True})
#         except NoSuchTableError:
#             return jsonify({'error': 'Tabela nie istnieje'}, 404)
#     except Exception as e:
#         print(e)
#         return jsonify({'error': str(e)}), 500
    
@app.route('/usun', methods=['DELETE'])
def usun_wiersz():
    try:
        tabela = request.args.get('tabela')
        id_field_name = f'{tabela.lower()}_id'
        id_value = request.args.get('id')

        if tabela is None or id_value is None:
            return jsonify({'error': 'Brak nazwy tabeli lub ID'}, 400)

        inspector = inspect(db.engine)

        try:
            if tabela not in inspector.get_table_names():
                raise NoSuchTableError(tabela)

            model_class = globals().get(tabela.capitalize())

            if not model_class:
                raise NoSuchTableError(tabela)

            record_to_delete = model_class.query.get(id_value)

            if not record_to_delete:
                return jsonify({'error': 'Nie znaleziono rekordu do usunięcia'}, 404)

            try:
                db.session.delete(record_to_delete)
                db.session.commit()

                return jsonify({'success': True})
            except IntegrityError as e:
                db.session.rollback()
                return jsonify({'error': 'Nie można usunąć rekordu z powodu ograniczenia integralności'}, 500)
        except NoSuchTableError:
            return jsonify({'error': 'Tabela nie istnieje'}, 404)
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/main')
def glowna_strona():
    return render_template('index.html')

@app.route('/tabela_lotnisk')
def tabela_lotnisk():
    return render_template('tabele.html')

@app.route('/tabela_przylotow_odlotow')
def tabela_przylotow_odlotow():
    return render_template('terminarz.html')

@app.route('/liczba_pasazerow')
def liczba_pasazerow():
    return render_template('pasazerowie.html')

@app.route('/uzywane_samoloty')
def uzywane_samoloty():
    return render_template('samoloty.html')

@app.route('/pracownicy')
def pracownicy():
    return render_template('pracownicy.html')

@app.route('/dodawanie')
def dodawanie():
    return render_template('dodawanie.html')

@app.route('/usuwanie')
def usuwanie():
    return render_template('usuwanie.html')


