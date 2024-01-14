function pobierzDane() {
    const tabela = document.getElementById('select-table').value;

    fetch(`/dane?tabela=${tabela}`)
        .then(response => response.json())
        .then(data => {
            if ('error' in data) {
                console.error(data.error);
            } else {
                wyswietlTabele(data.dane);
            }
        })
        .catch(error => console.error(error));
}

function wyswietlTabele(dane) {
    let tabelaDiv = document.getElementById('tabela-danych');
    tabelaDiv.innerHTML = '';

    if (dane.length === 0) {
        tabelaDiv.innerHTML = '<p>Brak danych.</p>';
        return;
    }

    let table = document.createElement('table');
    table.classList.add('table', 'table-bordered', 'table-striped'); 
    let headers = Object.keys(dane[0]);

    let headerRow = document.createElement('tr');
    headers.forEach(header => {
        let th = document.createElement('th');
        th.textContent = header;
        headerRow.appendChild(th);
    });
    table.appendChild(headerRow);

    dane.forEach(row => {
        let tr = document.createElement('tr');
        headers.forEach(header => {
            let td = document.createElement('td');
            td.textContent = row[header];
            tr.appendChild(td);
        });
        table.appendChild(tr);
    });

    tabelaDiv.appendChild(table);
}