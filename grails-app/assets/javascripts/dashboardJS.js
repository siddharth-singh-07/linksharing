function editTopic(topicId) {
    // Show the edit input field
    document.getElementById(`topicField_${topicId}`).classList.remove('d-none');

    // Hide the display field
    document.getElementById(`topicDisplay_${topicId}`).classList.add('d-none');
}
function cancelEdit(topicId) {
    // Hide the edit field
    document.getElementById(`topicField_${topicId}`).classList.add('d-none');

    // Show the display field
    document.getElementById(`topicDisplay_${topicId}`).classList.remove('d-none');
}
function saveEditTopic(topicId) {
    let newName = document.getElementById(`topicInput_${topicId}`).value;
    $.ajax({
        url: '/topic/editTopicName',
        type: 'POST',
        data: {
            topicId: topicId,
            newTopicName: newName
        },
        success: function (response) {
            // Hide the edit field
            document.getElementById(`topicField_${topicId}`).classList.add('d-none');
            // Show the display field
            document.getElementById(`topicDisplay_${topicId}`).innerText= newName
            document.getElementById(`topicDisplay_${topicId}`).classList.remove('d-none');
            document.getElementById(`success_${topicId}`).classList.remove('d-none')
            setTimeout(function() {
                document.getElementById(`success_${topicId}`).classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`error_${topicId}`).textContent = "You already have a topic with this name";
            document.getElementById(`error_${topicId}`).classList.remove('d-none')
        }
    });
}

