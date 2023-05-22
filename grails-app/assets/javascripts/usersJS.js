$(document).ready(function () {
    $.fn.dataTable.ext.errMode = 'none';
    $('#allUsersTable').DataTable();
    var myTable = $("#allUsersTable").DataTable({
    });
    $('<select>')
        .appendTo(myTable.column(5).header())
        .on('change', function () {
            var selectedValue = $(this).val();
            myTable.column(5).search(selectedValue).draw();
        })
        .append($('<option>', {value: '', text: 'All'})) // Add an option for all values
        .append($('<option>', {value: 'Yes', text: 'Active'})) // Add options for specific values
        .append($('<option>', {value: 'No', text: 'Inactive'}));
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