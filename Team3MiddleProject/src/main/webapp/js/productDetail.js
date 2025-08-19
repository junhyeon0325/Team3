const stars = document.querySelectorAll('.rating i');
const ratingContainer = document.querySelector('.review-box'); // 별 div
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
		const isHalf = (e.clientX - rect.left) < rect.width / 2;
		currentRating = index + (isHalf ? 0.5 : 1);
		console.log(currentRating);
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

// 이미지 등록


// ===== 리뷰 등록 이벤트 =====,,
document.querySelector("#reviewForm").addEventListener("submit", async function(e) {
	e.preventDefault();
	
	const form = document.querySelector("#reviewForm");
	const formData = new FormData(form);
	
	formData.append("reviewScore", currentRating.toString());
	
	// GET 방식 fetch 요청 → URL 뒤에 파라미터 붙이기
	let response = await fetch("review.do" , {
		method: 'POST',
		body: formData,
	});
	
	// 서버에서 JSON 받아서 JS 객체로 변환
	let result = await response.json();

	// 서버 응답 상태에 따라 alert 표시
	if (result.status === "NOT_LOGIN") alert("로그인 후 이용해주세요.");
	else if (result.status === "NO_ORDER") alert("주문한 상품만 리뷰를 작성할 수 있습니다.");
	else if (result.status === "SUCCESS") {
		alert("리뷰가 등록되었습니다.");
		// 폼 초기화
		form.reset();
		// 별점 초기화
		currentRating = 0;
		updateStars();
	} else {
		alert("리뷰 등록에 실패했습니다.");
	}
});
