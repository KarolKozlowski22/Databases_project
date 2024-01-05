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
                        <label for="${kolumna}">${kolumna}:</label>
                        <input type="text" id="${kolumna}" class="form-control">
                `;
            });
            formularzHTML += '<button type="button" class="btn btn-primary" onclick="wykonajAlterTable(\'' + tabela + '\')">Zapisz zmiany</button>';
            formularzHTML += '</form>';

            formularzDiv.innerHTML = formularzHTML;
        })
        .catch(error => console.error('Error:', error));
}


function wykonajAlterTable(tabela) {

    var form = document.getElementById('dane-form').getElementsByClassName('form-control');
    
    var formObject={};
    for (var i = 0; i < form.length; i++) {
        var key = form[i].id;
        var value = form[i].value;
        formObject[key] = value;
    }
    console.log(formObject);

    fetch(`/wykonaj-alter-table?tabela=${tabela}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formObject),
    })
    .then(response => {
        console.log('Response Status:', response.status);

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        if (response.status !== 204) {
            return response.json();
        }

        return null; 
    })
    .then(data => {
        console.log('Response Data:', data);

        if (data && data.success) {
            alert('Zmiany zostały zapisane pomyślnie.');
        } else {
            alert('Wystąpił błąd podczas zapisywania zmian.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Wystąpił błąd podczas komunikacji z serwerem.');
    });
}



