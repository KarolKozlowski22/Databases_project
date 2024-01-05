from sqlalchemy import Column, Integer, String, Date, Time, ForeignKey
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from sqlalchemy import Column, Integer, String, Date, Time, ForeignKey
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Lotnisko(db.Model):
    __tablename__ = 'lotnisko'

    lotnisko_id = Column(Integer, primary_key=True, autoincrement=True)
    nazwa_lotniska = Column(String, nullable=False)
    miasto = Column(String, nullable=False)
    kod_lotniska = Column(String, nullable=False)
    kraj = Column(String, nullable=False)

class Przyloty(db.Model):
    __tablename__ = 'przyloty'

    przylot_id = Column(Integer, primary_key=True, autoincrement=True)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    samolot_id = Column(Integer, nullable=False)
    data_przylotu = Column(Date, nullable=False)
    godzina_przylotu = Column(Time, nullable=False)
    numer_rejsu = Column(Integer, nullable=False)

class Odloty(db.Model):
    __tablename__ = 'odloty'

    odlot_id = Column(Integer, primary_key=True, autoincrement=True)
    samolot_id = Column(Integer, nullable=False)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    data_odlotu = Column(Date, nullable=False)
    godzina_odlotu = Column(Time, nullable=False)
    numer_rejsu = Column(Integer, nullable=False)

class PasStartowy(db.Model):
    __tablename__ = 'pas_startowy'

    pas_startowy_id = Column(Integer, primary_key=True, autoincrement=True)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    nazwa_pasa = Column(String, nullable=False)

class Pasazer(db.Model):
    __tablename__ = 'pasazer'

    pasazer_id = Column(Integer, primary_key=True, autoincrement=True)
    samolot_id = Column(Integer, nullable=False)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    imie = Column(String, nullable=False)
    narodowosc = Column(String, nullable=False)
    pesel = Column(String, nullable=False)
    nazwisko = Column(String, nullable=False)
    numer_rejsu = Column(Integer, nullable=False)

class PasazerOdlot(db.Model):
    __tablename__ = 'pasazer_odlot'

    pasazer_odlot_id = Column(Integer, primary_key=True, autoincrement=True)
    pasazer_id = Column(Integer, ForeignKey('pasazer.pasazer_id'), nullable=False)
    samolot_id = Column(Integer, nullable=False)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    odlot_id = Column(Integer, ForeignKey('odloty.odlot_id'), nullable=False)

class PasazerPrzylot(db.Model):
    __tablename__ = 'pasazer_przylot'

    pasazer_przylot_id = Column(Integer, primary_key=True, autoincrement=True)
    przylot_id = Column(Integer, ForeignKey('przyloty.przylot_id'), nullable=False)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    samolot_id = Column(Integer, nullable=False)
    pasazer_id = Column(Integer, ForeignKey('pasazer.pasazer_id'), nullable=False)

class Pracownik(db.Model):
    __tablename__ = 'pracownik'

    pracownik_id = Column(Integer, primary_key=True, autoincrement=True)
    lotnisko_id = Column(Integer, ForeignKey('lotnisko.lotnisko_id'), nullable=False)
    imie = Column(String, nullable=False)
    nazwisko = Column(String, nullable=False)
    narodowosc = Column(String, nullable=False)
    pesel = Column(String, nullable=False)


class Samolot(db.Model):
    __tablename__ = 'samolot'

    samolot_id = Column(Integer, primary_key=True, autoincrement=True)
    numer_seryjny = Column(Integer, nullable=False)
    model_samolotu = Column(String, nullable=False)
    linia_lotnicza = Column(String, nullable=False)
