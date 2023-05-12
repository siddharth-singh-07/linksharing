function checkPass() {
    let pass = document.getElementById('password').value
    let cnfpass = document.getElementById('cnfPassword').value
    let btn = document.getElementById('pswdSubmit')
    let text = document.getElementById('pswdText')

    if (cnfpass.trim() === '') {

    }

    if (pass == cnfpass && !(cnfpass.trim() === '')) {
        text.classList.add('d-none')
        btn.disabled = false;
        btn.classList.remove('disabled')
    } else {
        btn.disabled = true;
        text.classList.remove('d-none')
    }
}

// function