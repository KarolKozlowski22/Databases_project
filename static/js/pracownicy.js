function znajdzPracownikow() {
    const selectedId = document.getElementById('pracownicy-lotnisko-id').value;

    var pracownicyTableBody = document.getElementById('pracownicy-table');
    pracownicyTableBody.innerHTML = '';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', `/pracownicy_na_lotnisku?lotnisko_id=${selectedId}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            console.log(data);
            data.pracownicy_na_lotnisku.forEach(function (item) {
                var row = document.createElement('tr');
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

