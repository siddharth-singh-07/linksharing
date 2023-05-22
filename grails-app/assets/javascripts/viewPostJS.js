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

var rating = 5;
var count = 0;

function fetchRating() {
    $.ajax({
        url: '/resourceRating/fetchCurrentRating',
        data: {
            id: resourceId,
        },
        type: 'GET',
        success: function (response) {
            rating = response.rating;
            count = response.countRatings;
            showFilled(rating);
        }
    });
}

$(document).ready(fetchRating());

function resetRating() {
    let stars = document.getElementById('ratingStars').children
    for (let i = 0; i < 5; i++) {
        stars[i].classList.remove('checked')
    }
}

function showFilled(num) {
    resetRating()
    let stars = document.getElementById('ratingStars').children
    for (let i = 0; i < num; i++) {
        stars[i].classList.add('checked')
    }
    document.getElementById('ratingDisplay').innerText = `${rating} of 5`
    if (count == 0) {
        document.getElementById('ratingCount').innerText = `No ratings so far!`
    } else {
        document.getElementById('ratingCount').innerText = `${count} rating(s)`
    }
}

function mouseOut() {
    showFilled(rating)
}

function ratingSelect(num) {
    $.ajax({
        url: '/resourceRating/addRating',
        type: 'POST',
        data: {
            id: resourceId,
            score: num
        },
        success: function (response) {
            fetchRating();
            showFilled(rating);
            document.getElementById('ratingResult').classList.add('text-success')
            document.getElementById('ratingResult').innerText = response
            setTimeout(function () {
                document.getElementById('ratingResult').classList.add('d-none');
            }, 3000);
        },
        error: function (xhr, status, error) {
            fetchRating();
            showFilled(rating);
            document.getElementById('ratingResult').classList.add('text-danger')
            document.getElementById('ratingResult').innerText = error
            setTimeout(function () {
                document.getElementById('ratingResult').classList.add('d-none');
            }, 3000);
        }
    });
}

function deleteTopic(topicId, resourceTopicId) {
    $.ajax({
        url: '/topic/deleteTopic',
        type: 'POST',
        data: {
            topicId: topicId,
        },
        success: function (response) {
            if (topicId == resourceTopicId) {
                window.location.href = `/user/dashboard`
            } else {
                window.location.reload()
            }
        },
        error: function (xhr, status, error) {
            window.location.reload()
        }
    });
}

function deleteResource(resourceId, topicId) {
    $.ajax({
        url: '/resource/deleteResource',
        type: 'POST',
        data: {
            resourceId: resourceId,
        },
        success: function (response) {
            window.location.href = `/topic/showTopic?id=${topicId}`
        },
        error: function (xhr, status, error) {
            window.location.reload()
        }
    });
}

// function downloadFile(resourceId) {
//     $.ajax({
//         url: '/resource/downloadResource',
//         type: 'GET',
//         data: {
//             resourceId: resourceId,
//         },
//         success: function (response) {
//             console.log("File download initiated successfully");
//         },
//         error: function (xhr, status, error) {
//             console.error("File download failed:", error);
//         }
//     });
// }