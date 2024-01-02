function generujFormularz() {
    var tabela = document.getElementById('select-table').value;
    var formularzDiv = document.getElementById('formularz-div');
    var formularzHTML = '';

    formularzDiv.innerHTML = '';

    fetch(`/kolumny-tabeli?tabela=${tabela}`)
        .then(response => response.json())
        .then(data => {
            var kolumny = data.kolumny;
            formularzHTML += '<form id="dane-form">';
            kolumny.forEach(function (kolumna) {
                formularzHTML += `
                    <div class="form-group">
                        <label for="${kolumna}">${kolumna}:</label>
                        <input type="text" id="${kolumna}" class="form-control">
                    </div>
                `;
            });
            formularzHTML += '<button type="button" class="btn btn-primary" onclick="wykonajAlterTable(\'' + tabela + '\')">Zapisz zmiany</button>';
            formularzHTML += '</form>';

            formularzDiv.innerHTML = formularzHTML;
        })
        .catch(error => console.error('Error:', error));
}

function wykonajAlterTable(tabela) {
    var form = document.getElementById('dane-form');
    var formData = new FormData(form);

    fetch(`/wykonaj-alter-table?tabela=${tabela}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'  
        },
        body: JSON.stringify(Object.fromEntries(formData))
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Zmiany zostały zapisane pomyślnie.');
        } else {
            alert('Wystąpił błąd podczas zapisywania zmian.');
        }
    })
    .catch(error => console.error('Error:', error));
}


