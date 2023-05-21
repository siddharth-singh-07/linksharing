var rating = 5;

$(document).ready(function (){
    $.ajax({
        url: '/resourceRating/fetchCurrentRating',
        data: {
            id: resourceId,
        },
        type: 'GET',
        success: function (response) {
            rating = response.rating;
            showFilled(rating);
        },
        error: function (xhr, status, error) {
            console.log(error)
        }
    });
});

function showFilled(num) {
    resetRating()
    let stars = document.getElementById('ratingStars').children
    for (let i = 0; i < num; i++) {
        stars[i].classList.add('checked')
    }
    document.getElementById('ratingDisplay').innerText = `${rating} of 5`
}

function resetRating() {
    let stars = document.getElementById('ratingStars').children
    for (let i = 0; i < 5; i++) {
        stars[i].classList.remove('checked')
    }
}