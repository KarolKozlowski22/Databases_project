function generujFormularz() {
    var tabela = document.getElementById('select-table').value;
    var formularzDiv = document.getElementById('formularz-div');
    var formularzHTML = '';

    formularzDiv.innerHTML = '';

    var idFieldName = `${tabela}_id`; 

    fetch(`/kolumny-tabeli?tabela=${tabela}`)
        .then(response => response.json())
        .then(data => {
            var kolumny = data.kolumny;
            kolumny.forEach(function (kolumna) {
                // console.log(idFieldName, kolumna.toLowerCase());
                if (kolumna.toLowerCase() === idFieldName) {
                    idFieldName = kolumna;
                }
            });

            if (!idFieldName) {
                alert('Could not determine the ID field.');
                return;
            }

            formularzHTML += `
                <form id="dane-form">
                    <div class="form-group">
                        <label for="${idFieldName}">${idFieldName}:</label>
                        <input type="text" id="${idFieldName}" class="form-control">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="usunWiersz('${tabela}', '${idFieldName}')">Usuń wiersz</button>
                </form>
            `;

            formularzDiv.innerHTML = formularzHTML;
        })
        .catch(error => console.error('Error:', error));
}


function usunWiersz(tabela, idFieldName) {
    var id = document.getElementById(idFieldName).value;

    if (!id) {
        alert('Wprowadź wartość ID do usunięcia.');
        return;
    }

    fetch(`/usun?tabela=${tabela}&id=${id}`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
        },

    })
    .then(response => {
        console.log('Response Status:', response.status);

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        return response.json();
    })
    .then(data => {
        console.log('Response Data:', data);

        if (data && data.success) {
            alert('Wiersz został pomyślnie usunięty.');
        } else {
            alert('Wystąpił błąd podczas usuwania wiersza.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Wystąpił błąd podczas komunikacji z serwerem.');
    });
}