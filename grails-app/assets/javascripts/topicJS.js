let docModalSelect = document.getElementById('modalShareDocTopicSelect')
let linkModalSelect = document.getElementById('modalShareLinkTopicSelect')
docModalSelect.disabled = true
linkModalSelect.disabled = true

function updateSeriousness(topicId, seriousness) {
    $.ajax({
        url: '/subscription/editSeriousness',
        type: 'POST',
        data: {
            topic: topicId,
            seriousnessSelect: seriousness
        },
        success: function (response) {
            document.getElementById(`seriousnessSuccess_${topicId}`).classList.remove('d-none');
            setTimeout(function () {
                document.getElementById(`seriousnessSuccess_${topicId}`).classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`seriousnessError_${topicId}`).classList.remove('d-none');
        }
    });
}

function markRead(readingItemId) {
    $.ajax({
        url: '/resource/markRead',
        type: 'POST',
        data: {
            readingItemId: readingItemId
        },
        success: function (response) {
            let readBtn = document.getElementById('markReadBtn')
            readBtn.remove()
        },
        error: function (xhr, status, error) {
            console.log(error)
        }
    });
}

function subscribe(topicId, username) {
    $.ajax({
        url: '/subscription/createSubscription',
        type: 'POST',
        data: {
            topicId: topicId,
            username: username,
            seriousness: "VERY_SERIOUS"
        },
        success: function (response) {
            let messageElement = document.getElementById(`message_${topicId}`);
            messageElement.textContent = "Subscribed";
            messageElement.classList.remove('d-none');
            messageElement.classList.add('text-success');

            let subscriptionCountElement = document.getElementById(`subscriptionCount_${topicId}`);
            subscriptionCountElement.textContent = parseInt(subscriptionCountElement.textContent) + 1;

            document.getElementById(`subscribeBtn_${topicId}`).classList.add('d-none');
            setTimeout(function () {
                messageElement.classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            let messageElement = document.getElementById(`message_${topicId}`);
            messageElement.textContent = "Failed";
            messageElement.classList.remove('d-none');
            messageElement.classList.add('text-danger');

            document.getElementById(`subscribeBtn_${topicId}`).classList.add('d-none');
            setTimeout(function () {
                messageElement.classList.add('d-none');
            }, 3000);
        }
    });
}
function unsubscribe(topicId, username) {
    $.ajax({
        url: '/subscription/deleteSubscription',
        type: 'POST',
        data: {
            topicId: topicId,
            username: username
        },
        success: function (response) {
            window.scrollTo({top: 0, behavior: 'smooth'});

            setTimeout(function () {
                window.location.reload()
            }, 500);
        },
        error: function (xhr, status, error) {
            window.scrollTo({top: 0, behavior: 'smooth'});

            setTimeout(function () {
                window.location.reload()
            }, 500);
        }
    });
}