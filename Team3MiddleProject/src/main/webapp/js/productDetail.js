

// 상품번호 (hidden input#productNo 가 페이지에 있어야 함)
const productNo = document.querySelector("#productNo").value;

// 리뷰 목록/별점 상태
let currentPage = 1;
let currentRating = 0;
let hoverRating = 0;

// 별점 입력 영역 요소들
const stars = document.querySelectorAll(".rating i");   // 사용자가 클릭하는 별들
const ratingContainer = document.querySelector(".review-box"); // 별 컨테이너(영역 밖 클릭시 초기화용)

// ---------- 초기 로드 : 첫 페이지 리뷰 뿌리기 ----------
document.addEventListener("DOMContentLoaded", () => {
  loadReviewList(currentPage);
});

// ---------- 리뷰 목록 호출 ----------
async function loadReviewList(page) {
  try {
    const response = await fetch(`reviewList.do?productNo=${productNo}&page=${page}`);
    const result = await response.json();

    // 서버 응답이 배열인지, {list, paging}인지 모두 처리
    const reviews = Array.isArray(result) ? result : (result.list || []);
    const paging = Array.isArray(result) ? null : (result.paging || null);

    renderReviewList(reviews);
    renderPagination(paging);

    currentPage = page;
  } catch (e) {
    console.error(e);
    document.querySelector("#reviewList").innerHTML = "<p>리뷰를 불러오지 못했습니다.</p>";
  }
}

// ---------- 리뷰 목록 렌더링 ----------
function renderReviewList(reviews) {
  const container = document.querySelector("#reviewList");
  container.innerHTML = "";

  if (!reviews || reviews.length === 0) {
    container.innerHTML = "<p>등록된 리뷰가 없습니다.</p>";
    return;
  }

  reviews.forEach((review) => {
    const reviewEl = document.createElement("div");
    reviewEl.className = "d-flex justify-content-between align-items-start mb-4";

    reviewEl.innerHTML = `
      <div class="d-flex">
        <img src="./upload/${review.reviewImage ? review.reviewImage : 'default.png'}""
             class="img-fluid rounded-circle p-3"
             style="width: 100px; height: 100px;" alt="">
        <div>
          <p class="mb-1" style="font-size: 14px;">${review.reviewDate}</p>
          <h5>${review.memberName}</h5>
          <div class="my-2">${generateStars(review.reviewScore)}</div>
          <p>${review.reviewContent}</p>
        </div>
      </div>
	  <button class="btn btn-sm btn-outline-danger"
	          style="height: 30px;"
			  data-review-no="${review.reviewNo}"
			  data-writer-id="${review.memberId}"
	          onclick="handleDeleteReview(this)">X</button>
    `;
    container.appendChild(reviewEl);
  });
}

// ---------- 별 아이콘 HTML 생성 (표시 전용) ----------
function generateStars(score) {
  let html = "";
  const n = Number(score) || 0;          // 문자열일 수도 있으니 숫자 변환
  const full = Math.floor(n);            // 꽉 찬 별 개수
  const half = (n % 1) >= 0.5;           // 0.5 이상이면 반쪽 별 1개
  const empty = 5 - full - (half ? 1 : 0);

  for (let i = 0; i < full; i++) {
    html += `<i class="fa-solid fa-star text-warning"></i>`;
  }
  if (half) {
    html += `<i class="fa-solid fa-star-half-stroke text-warning"></i>`;
  }
  for (let i = 0; i < empty; i++) {
    html += `<i class="fa-regular fa-star text-warning"></i>`;
  }
  return html;
}

// ---------- 페이징 렌더링 ----------
function renderPagination(paging) {
  const container = document.querySelector("#pagination");
  container.innerHTML = "";

  if (!paging) return; // 서버가 페이징을 안주면 버튼 X

  let html = "";

  if (paging.prev) {
    html += `<button class="btn btn-light mx-1" onclick="loadReviewList(${paging.startPage - 1})">이전</button>`;
  }

  for (let i = paging.startPage; i <= paging.endPage; i++) {
    const active = (i === paging.page) ? "btn-primary text-white" : "btn-outline-secondary";
    html += `<button class="btn ${active} mx-1" onclick="loadReviewList(${i})">${i}</button>`;
  }

  if (paging.next) {
    html += `<button class="btn btn-light mx-1" onclick="loadReviewList(${paging.endPage + 1})">다음</button>`;
  }

  container.innerHTML = html;
}

// ---------- 별점 입력(사용자 상호작용) ----------
function updateStars() {
  stars.forEach((star, index) => {
    star.className = "fa-regular fa-star text-muted";
    const rating = hoverRating || currentRating;

    if (index + 1 <= rating) {
      star.className = "fa-solid fa-star text-warning";
    } else if (index + 0.5 === rating) {
      star.className = "fa-solid fa-star-half-stroke text-warning";
    }
  });
}

stars.forEach((star, index) => {
  star.addEventListener("mousemove", (e) => {
    const rect = star.getBoundingClientRect();
    hoverRating = (e.clientX - rect.left > rect.width / 2) ? index + 1 : index + 0.5;
    updateStars();
  });

  star.addEventListener("mouseout", () => {
    hoverRating = 0;
    updateStars();
  });

  star.addEventListener("click", (e) => {
    const rect = star.getBoundingClientRect();
    const isHalf = (e.clientX - rect.left) < rect.width / 2;
    currentRating = index + (isHalf ? 0.5 : 1);
    updateStars();
  });
});

// 별 영역 밖 클릭 시 입력 초기화
document.addEventListener("click", (e) => {
  if (ratingContainer && !ratingContainer.contains(e.target)) {
    currentRating = 0;
    hoverRating = 0;
    updateStars();
  }
});
updateStars();

// ---------- 리뷰 등록 이벤트 ----------
document.querySelector("#reviewForm").addEventListener("submit", async function (e) {
  e.preventDefault();

  // ✅ 별점 미선택 방지
  if (!currentRating || currentRating === 0) {
    alert("별점을 선택해 주세요.");
    return;
  }

  const form = document.querySelector("#reviewForm");
  const formData = new FormData(form);

  // 서버가 reviewScore를 숫자로 받도록 문자열이어도 전송
  formData.append("reviewScore", String(currentRating));

  try {
    const response = await fetch("review.do", {
      method: "POST",
      body: formData,
    });
    const result = await response.json();

    if (result.status === "NOT_LOGIN") alert("로그인 후 이용해주세요.");
    else if (result.status === "NO_ORDER") alert("주문한 상품만 리뷰를 작성할 수 있습니다.");
    else if (result.status === "SUCCESS") {
      alert("리뷰가 등록되었습니다.");
      form.reset();
      currentRating = 0;
      updateStars();
      // 새로고침 없이 목록 갱신
      loadReviewList(currentPage);
	  
	  if (result.productScore !== undefined) {
	      renderProductStars(result.productScore);
	    }
    } else {
      alert("리뷰 등록에 실패했습니다.");
    }
  } catch (err) {
    console.error(err);
    alert("통신 중 오류가 발생했습니다.");
  }
});

//리뷰삭제
function handleDeleteReview(button) {
  const reviewNo = button.dataset.reviewNo;
  const writerId = button.dataset.writerId;

  if (logId !== writerId) {
    alert("본인이 작성한 리뷰만 삭제할 수 있습니다.");
    return;
  }

  if (!confirm("리뷰를 삭제하시겠습니까?")) return;

  fetch("deleteReview.do?reviewNo=" + reviewNo)
    .then(res => res.json())
    .then(data => {
      if (data.status === "SUCCESS") {
        alert("리뷰가 삭제되었습니다.");
        if (data.productScore !== undefined) {
          renderProductStars(data.productScore);
	      loadReviewList(currentPage);
        }
      } else {
        alert("리뷰 삭제에 실패했습니다.");
      }
    });
}

function renderProductStars(score) {
  const fullStars = Math.floor(score);
  const hasHalfStar = score % 1 >= 0.5;
  const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

  const box = document.querySelector("#productScoreBox");
  box.innerHTML = "";

  for (let i = 0; i < fullStars; i++) {
    box.innerHTML += `<i class="fa-solid fa-star text-warning"></i>`;
  }
  if (hasHalfStar) {
    box.innerHTML += `<i class="fa-solid fa-star-half-stroke text-warning"></i>`;
  }
  for (let i = 0; i < emptyStars; i++) {
    box.innerHTML += `<i class="fa-regular fa-star text-warning"></i>`;
  }

  box.innerHTML += `<p class="mb-0 ms-2" style="margin-left: 6px; position: relative;">${score}점</p>`;
}