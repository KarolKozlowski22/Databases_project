function wyswietlWidok() {
    const nazwa_widoku = document.getElementById('select-table').value;
    fetch(`/zobacz-widok?view=${nazwa_widoku}`)
        .then(response => response.json())
        .then(data => {
            if ('view_data' in data) {
                generujTabele(data.view_data);
            } else {
                console.error('Błąd podczas pobierania danych z API');
            }
        })
        .catch(error => console.error('Błąd podczas pobierania danych:', error));
}

function generujTabele(data) {
    const tabelaDiv = document.getElementById('tabela-widoku');

    const tabela = document.createElement('table');
    tabela.className = 'table';

    const naglowek = tabela.createTHead();
    const wierszNaglowka = naglowek.insertRow();

    for (const kolumna in data[0]) {
        const komorkaNaglowka = wierszNaglowka.insertCell();
        komorkaNaglowka.textContent = kolumna;
    }

    const cialo = tabela.createTBody();

    data.forEach((wiersz) => {
        const nowyWiersz = cialo.insertRow();

        for (const kolumna in wiersz) {
            const komorka = nowyWiersz.insertCell();
            komorka.textContent = wiersz[kolumna];
        }
    });

    tabelaDiv.innerHTML = '';
    tabelaDiv.appendChild(tabela);
}