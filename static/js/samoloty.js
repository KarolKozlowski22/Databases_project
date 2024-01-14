function znajdzSamoloty() {
    const selectedId = document.getElementById('samoloty-lotnisko-id').value;

    let samolotyTableBody = document.getElementById('samoloty-table');
    samolotyTableBody.innerHTML = '';

    let xhr = new XMLHttpRequest();
    xhr.open('GET', `/najczesciej_uzywane_samoloty?lotnisko_id=${selectedId}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const data = JSON.parse(xhr.responseText);
            data.najczesciej_uzywane_samoloty.forEach(function (item) {
                let row = document.createElement('tr');
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


