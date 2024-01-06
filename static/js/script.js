function przekieruj_1() {
    window.location.href = '/tabela_lotnisk';
}

function przekieruj_2() {
    window.location.href = '/tabela_przylotow_odlotow';
}

function przekieruj_3() {
    window.location.href = '/liczba_pasazerow';
}

function przekieruj_4() {
    window.location.href = '/uzywane_samoloty';
}

function przekieruj_5() {
    window.location.href = '/pracownicy';
}

function przekieruj_6() {
    window.location.href = '/dodawanie';
}

function glownaStrona(){
    window.location.href = '/main';
}

function przekieruj_7() {
    window.location.href = '/usuwanie';
}

function przekieruj_8() {
    window.location.href = '/widoki';
}


function usunZawartoscTabeli() {
    var selectedTable = document.getElementById('select-table').value;

    fetch(`/usun-zawartosc-tabeli?tabela=${selectedTable}`, {
        method: 'DELETE',
    })
    .then(response => response.json())
    .then(data => {
        if (data && data.success) {
            alert('Zawartość tabeli została pomyślnie usunięta.');
        } else {
            alert('Wystąpił błąd podczas usuwania zawartości tabeli.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Wystąpił błąd podczas komunikacji z serwerem.');
    });
}

