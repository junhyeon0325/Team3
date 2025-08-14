const stars = document.querySelectorAll('.rating i'); 
const ratingContainer = document.querySelector('.rating'); // 별 div
let currentRating = 0; 
let hoverRating = 0;   

function updateStars() {
    stars.forEach((star, index) => {
        star.className = 'fa-regular fa-star text-muted';
        let rating = hoverRating || currentRating;

        if (index + 1 <= rating) star.className = 'fa-solid fa-star text-warning';
        else if (index + 0.5 === rating) star.className = 'fa-solid fa-star-half-stroke text-warning';
    });
}

stars.forEach((star, index) => {
    star.addEventListener('mousemove', (e) => {
        const rect = star.getBoundingClientRect();
        hoverRating = (e.clientX - rect.left > rect.width / 2) ? index + 1 : index + 0.5;
        updateStars();
    });

    star.addEventListener('mouseout', () => {
        hoverRating = 0;
        updateStars();
    });

    star.addEventListener('click', (e) => {
        const rect = star.getBoundingClientRect();
        currentRating = (e.clientX - rect.left > rect.width / 2) ? index + 1 : index + 0.5;
        updateStars();
    });
});

// ⭐ 별 영역 외부 클릭 시 초기화
document.addEventListener('click', (e) => {
    if (!ratingContainer.contains(e.target)) {
        currentRating = 0; // 클릭 초기화
        hoverRating = 0;
        updateStars();
    }
});

updateStars();