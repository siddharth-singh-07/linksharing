function checkPass() {
    let pass = document.getElementById('password').value
    let cnfpass = document.getElementById('cnfPassword').value
    let btn = document.getElementById('btnSubmit')
    let text = document.getElementById('pswdText')

    if (pass == cnfpass && !(cnfpass.trim() === '')) {
        text.classList.add('d-none')
        btn.disabled = false;
        btn.classList.remove('disabled')
    } else {
        btn.disabled = true;
        text.classList.remove('d-none')
    }
}

function forgotPassword() {
    let forgotPasswordEmail = document.getElementById('forgotPasswordEmail').value
    $.ajax({
        url: '/user/forgotPasswordTrigger',
        type: 'POST',
        data: {
            forgotPasswordEmail: forgotPasswordEmail
        },
        success: function (response) {
            document.getElementById('twoKey').classList.remove('d-none')
            document.getElementById('twoPass').classList.remove('d-none')
            document.getElementById('twoButtons').classList.remove('d-none')
            document.getElementById('oneEmail').classList.add('d-none')
            document.getElementById('oneButtons').classList.add('d-none')
        },
        error: function (xhr, status, error) {
            console.log(error)
        }
    });
}

function setNewPassword() {
    let forgotPasswordEmail = document.getElementById('forgotPasswordEmail').value
    console.log(forgotPasswordEmail)
    let forgotPasswordKey = document.getElementById('forgotPasswordKey').value
    console.log(forgotPasswordKey)

    let newPassword = document.getElementById('forgotPasswordNewPass').value
    console.log(newPassword)


    $.ajax({
        url: '/user/resetPassword',
        type: 'POST',
        data: {
            forgotPasswordEmail: forgotPasswordEmail,
            forgotPasswordKey: forgotPasswordKey,
            newPassword: newPassword
        },
        success: function (response) {
            window.location.reload()
        },
        error: function (xhr, status, error) {
            console.log(error)
        }
    });
}