function znajdzPracownikow() {
    const selectedId = document.getElementById('pracownicy-lotnisko-id').value;

    let pracownicyTableBody = document.getElementById('pracownicy-table');
    pracownicyTableBody.innerHTML = '';

    let xhr = new XMLHttpRequest();
    xhr.open('GET', `/pracownicy_na_lotnisku?lotnisko_id=${selectedId}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const data = JSON.parse(xhr.responseText);
            data.pracownicy_na_lotnisku.forEach(function (item) {
                let row = document.createElement('tr');
                console.log(item);
                row.innerHTML = `
                    <td>${item.imie}</td>
                    <td>${item.nazwisko}</td>
                `;

                pracownicyTableBody.appendChild(row);
            });
        }
    };
    xhr.send();
}

