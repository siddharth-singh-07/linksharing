$(document).ready(function () {
    $('#allUsersTable').DataTable();
});

function changeUserStatus(username) {
    $.ajax({
        url: '/admin/changeUserStatus',
        type: 'POST',
        data: {
            username: username,
        },
        success: function (response) {
            if (document.getElementById(`changeUserStatusBtn_${username}`).innerText == "Activate") {
                document.getElementById(`changeUserStatusBtn_${username}`).innerText = "Deactivate";
                document.getElementById(`isActive_${username}`).innerText = "Yes";
            } else {
                document.getElementById(`changeUserStatusBtn_${username}`).innerText = "Activate";
                document.getElementById(`isActive_${username}`).innerText = "No";
            }

        },
        error: function (xhr, status, error) {
        }
    });
}