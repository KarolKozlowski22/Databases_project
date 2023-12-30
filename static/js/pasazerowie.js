document.addEventListener('DOMContentLoaded', function () {
    getPasazerowie();
});


function getPasazerowie() {
    $.get('/liczba_pasazerow_na_lotnisku', function (data) {
        const pasazerowieTable = $('#pasazerowie-table');
        console.log(data.liczba_pasazerow_na_lotnisku);
        pasazerowieTable.empty();
        if (data.liczba_pasazerow_na_lotnisku
            && Array.isArray(data.liczba_pasazerow_na_lotnisku)) {
            data.liczba_pasazerow_na_lotnisku.forEach(function (item) {
                pasazerowieTable.append(`
                    <tr>
                        <td>${item.kraj}</td>
                        <td>${item.liczba_pasazerow}</td>
                        <td>${item.lotnisko}</td>
                    </tr>
                `);
            });
        } else {
            console.error('Brak danych lotnisk w odpowiedzi.');
        }
    });
}
