function pobierzTerminarz() {
    const selectedDate = document.getElementById('data-input').value;

    var terminarzTableBody = document.getElementById('terminarz-table');
    terminarzTableBody.innerHTML = '';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', `/przyloty_odloty?data=${selectedDate}`, true);
    console.log('readyState:', xhr.readyState, 'status:', xhr.status);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            data.przyloty_odloty.forEach(function (item) {
                var row = document.createElement('tr');
                console.log(item);
                row.innerHTML = `
                    <td>${item.lotnisko}</td>
                    <td>${item.data_przylotu}</td>
                    <td>${item.numer_przylotu}</td>
                    <td>${item.data_odlotu}</td>
                    <td>${item.numer_odlotu}</td>
                `;

                terminarzTableBody.appendChild(row);
            });
        }

    };
    xhr.send();
}




