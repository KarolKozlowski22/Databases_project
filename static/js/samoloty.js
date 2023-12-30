function znajdzSamoloty() {
    const selectedId = document.getElementById('samoloty-lotnisko-id').value;

    var samolotyTableBody = document.getElementById('samoloty-table');
    samolotyTableBody.innerHTML = '';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', `/najczesciej_uzywane_samoloty?lotnisko_id=${selectedId}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            console.log(data);
            data.najczesciej_uzywane_samoloty.forEach(function (item) {
                var row = document.createElement('tr');
                console.log(item);
                row.innerHTML = `
                    <td>${item.liczba_odlotow}</td>
                    <td>${item.numer_seryjny}</td>
                `;

                samolotyTableBody.appendChild(row);
            });
        }
    };
    xhr.send();
}


