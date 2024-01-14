function generujFormularz() {
    const tabela = document.getElementById('select-table').value;
    let formularzDiv = document.getElementById('formularz-div');
    let formularzHTML = '';

    formularzDiv.innerHTML = '';

    fetch(`/kolumny-tabeli?tabela=${tabela}`)
        .then(response => response.json())
        .then(data => {
            const kolumny = data.kolumny;
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

    const form = document.getElementById('dane-form').getElementsByClassName('form-control');
    
    let formObject={};
    for (let i = 0; i < form.length; i++) {
        const key = form[i].id;
        const value = form[i].value;
        formObject[key] = value;
    }

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



