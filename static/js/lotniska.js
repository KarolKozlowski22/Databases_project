document.addEventListener('DOMContentLoaded', function () {
    getLotniska();
});

function getLotniska() {
    $.get('/lotniska', function (data) {
        console.log(data);
        const lotniskaTable = $('#lotniska-table');
        lotniskaTable.empty();
        console.log(data[0].lotniska);
        if (data[0].lotniska && Array.isArray(data[0].lotniska)) {
            data[0].lotniska.forEach(function (lotnisko) {
                lotniskaTable.append(`
                    <tr>
                        <td>${lotnisko.nazwa_lotniska}</td>
                        <td>${lotnisko.miasto}</td>
                        <td>${lotnisko.kod_lotniska}</td>
                        <td>${lotnisko.kraj}</td>
                    </tr>
                `);
            });
        } else {
            console.error('Brak danych lotnisk w odpowiedzi.');
        }
    });
}

function glownaStrona(){
    window.location.href = '/main';
}