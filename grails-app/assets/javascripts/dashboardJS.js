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
            document.getElementById(`topicDisplay_${topicId}`).innerText = newName
            document.getElementById(`topicDisplay_${topicId}`).classList.remove('d-none');
            document.getElementById(`success_${topicId}`).classList.remove('d-none')
            setTimeout(function () {
                document.getElementById(`success_${topicId}`).classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`error_${topicId}`).textContent = "You already have a topic with this name";
            document.getElementById(`error_${topicId}`).classList.remove('d-none')
        }
    });
}

function updateVisibility(topicId, visibility) {
    $.ajax({
        url: '/topic/editVisibility',
        type: 'POST',
        data: {
            topic: topicId,
            visibilitySelect: visibility
        },
        success: function (response) {
            document.getElementById(`visibilitySuccess_${topicId}`).classList.remove('d-none')
            setTimeout(function () {
                document.getElementById(`visibilitySuccess_${topicId}`).classList.add('d-none');
            }, 3000);

        },
        error: function (xhr, status, error) {
            document.getElementById(`visibilityError_${topicId}`).classList.remove('d-none')
        }
    });
}

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
            let myDiv = document.getElementById(`div_${readingItemId}`)
            myDiv.remove()
            // setTimeout(function () {
            //     document.getElementById(`seriousnessSuccess_${topicId}`).classList.add('d-none');
            // }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`seriousnessError_${topicId}`).classList.remove('d-none');
        }
    });
}

function trendingEditTopic(topicId) {
    // Show the edit input field
    document.getElementById(`trendingTopicField_${topicId}`).classList.remove('d-none');

    // Hide the display field
    document.getElementById(`trendingTopicDisplay_${topicId}`).classList.add('d-none');
}

function trendingCancelEdit(topicId) {
    // Hide the edit field
    document.getElementById(`trendingTopicField_${topicId}`).classList.add('d-none');

    // Show the display field
    document.getElementById(`trendingTopicDisplay_${topicId}`).classList.remove('d-none');
}

function trendingSaveEditTopic(topicId) {
    let newName = document.getElementById(`trendingTopicInput_${topicId}`).value;
    $.ajax({
        url: '/topic/editTopicName',
        type: 'POST',
        data: {
            topicId: topicId,
            newTopicName: newName
        },
        success: function (response) {
            // Hide the edit field
            document.getElementById(`trendingTopicField_${topicId}`).classList.add('d-none');
            // Show the display field
            document.getElementById(`trendingTopicDisplay_${topicId}`).innerText = newName
            document.getElementById(`trendingTopicDisplay_${topicId}`).classList.remove('d-none');
            document.getElementById(`trendingSuccess_${topicId}`).classList.remove('d-none')
            setTimeout(function () {
                document.getElementById(`trendingSuccess_${topicId}`).classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`trendingError_${topicId}`).textContent = "You already have a topic with this name";
            document.getElementById(`trendingError_${topicId}`).classList.remove('d-none')
        }
    });
}

function trendingUpdateSeriousness(topicId, seriousness) {
    $.ajax({
        url: '/subscription/editSeriousness',
        type: 'POST',
        data: {
            topic: topicId,
            seriousnessSelect: seriousness
        },
        success: function (response) {
            document.getElementById(`trendingSeriousnessSuccess_${topicId}`).classList.remove('d-none');
            setTimeout(function () {
                document.getElementById(`trendingSeriousnessSuccess_${topicId}`).classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            document.getElementById(`trendingSeriousnessError_${topicId}`).classList.remove('d-none');
        }
    });
}

function trendingUpdateVisibility(topicId, visibility) {
    $.ajax({
        url: '/topic/editVisibility',
        type: 'POST',
        data: {
            topic: topicId,
            visibilitySelect: visibility
        },
        success: function (response) {
            document.getElementById(`trendingVisibilitySuccess_${topicId}`).classList.remove('d-none')
            setTimeout(function () {
                document.getElementById(`trendingVisibilitySuccess_${topicId}`).classList.add('d-none');
            }, 3000);

        },
        error: function (xhr, status, error) {
            document.getElementById(`trendingVisibilityError_${topicId}`).classList.remove('d-none')
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

$(document).ready(function () {
    $('.page-link').click(function () {
        // $('.page-link').removeClass('active');
        // $(this).addClass('active');

        var pageNumber = $(this).text();
        $.ajax({
            url: '/readingItem/getNextReadingItemPage',
            type: 'GET',
            data: {page: pageNumber},
            success: function (response) {
                $('.userInbox').html(response);
            },
            error: function () {
                // $('.userInbox').html("Error occurred while loading page");
            }
        });
    });
});

function deleteTopic(topicId) {
    $.ajax({
        url: '/topic/deleteTopic',
        type: 'POST',
        data: {
            topicId: topicId,
        },
        success: function (response) {
            window.location.reload()
        },
        error: function (xhr, status, error) {
            window.location.reload()
        }
    });
}
function searchInbox() {
    console.log("inside search method")
    var searchInput = document.getElementById('inboxSearchInput').value;
    $.ajax({
        url: '/readingItem/searchReadingItem',
        type: 'GET',
        data: {'inboxSearchQuery': searchInput},
        success: function (response) {
            $('.userInbox').html(response);
        },
        error: function (xhr, status, error) {
            console.log("so sad")
            console.log(error)
        }
    });
}
document.addEventListener('DOMContentLoaded', function () {
    var searchInput = document.getElementById('inboxSearchInput');
    searchInput.addEventListener('keyup', function (event) {
        event.preventDefault();
        searchInbox();
    });
});