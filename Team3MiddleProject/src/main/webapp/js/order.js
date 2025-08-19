/**
 * order.js
 */


function updateTotal() {
	// 상품 가격 초기화
	let cartProductTotalPrice = 0;
	let totalOriginalPrice = 0; // totalnum 대신 명확한 변수명 사용
	document.querySelectorAll('.cart').forEach(elem => {
		// 상품 가격 1,000원 -> 1000
		let priceBefore = elem.querySelector('.orderProductPrice').innerHTML.slice(0, -1);
		let num = Number(priceBefore.replace(/,/g, ""));
		
		console.log('할인퍼센트 1,000형태 : ' + priceBefore + '/ 상품 가격 1000형태 : ' + num);
		
		// 할인 가격 10% -> 0.1
		let sale = Number(elem.querySelector('.productSalePercent').innerHTML.slice(0, -1)) / 100; // Number()로 명시적 변환

		// 수량에 따라 가격 출력
		let pcs = Number(elem.querySelector('.orderProductPcs').innerHTML);
		totalOriginalPrice += (num * pcs); // 할인 적용 전 총액 계산

		// 테스트
		console.log('할인퍼센트html : ' + elem.querySelector('.productSalePercent').innerHTML);
		console.log('할인퍼센트 : ' + sale + '/ 가격 : ' + num);

		let price; // price 변수 선언
		if (sale > 0) {
			price = num * (1 - sale);
		} else { // sale == 0 || sale < 0
			price = num; // 상품 가격
		}

		console.log('가격 : ' + num + '/ 세일적용된 가격 : ' + price + '/ 수량 : ' + pcs);
		console.log('세일된 가격 : ' + (num * sale));
		console.log('쌩총가격 : ' + totalOriginalPrice); // 변수명 변경 반영

		elem.querySelector('.productSale').innerHTML = price.toLocaleString() + '원';
		elem.querySelector('.ordertotalPrice').innerHTML = (price * pcs).toLocaleString() + '원';
		cartProductTotalPrice += (price * pcs); // 모든 상품의 가격을 구하기 위한 계산식
		
	}); // forEach 끝

	console.log(document.querySelectorAll('.cart'));
	console.log(cartProductTotalPrice);
	console.log(cartProductTotalPrice - totalOriginalPrice); // 변수명 변경 반영

	// 🌟🌟🌟 수정: orderPointInput 클래스 대신 pointInput ID 사용 🌟🌟🌟
	// 이 부분은 order.jsp의 인라인 스크립트에서 updateFinalPaymentAmount() 함수가 처리하도록
	// order.js에서는 삭제하는 것이 올바른 역할 분리입니다.
	// 따라서 아래 줄은 주석 처리 또는 삭제합니다.
	// console.log(document.querySelector('.orderPointInput').value); 
	
	if (cartProductTotalPrice < 0) {
		document.querySelector('.totalCartPrice').innerHTML = 0 + '원';
		return;
	}
	
	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice).toLocaleString() + '원';
	
	// 🌟🌟🌟 수정: 이 부분도 order.jsp의 updateFinalPaymentAmount() 함수가 처리하도록 삭제합니다. 🌟🌟🌟
	// document.querySelector('.totalOrderPrice').innerHTML = (cartProductTotalPrice - document.querySelector('.orderPointInput').value).toLocaleString() + '원';
	// console.log(cartProductTotalPrice - document.querySelector('.orderPointInput').value);
	// console.log(document.querySelector('.orderPointInput').value);

} // end function

updateTotal(); // 페이지 로드 시 초기 계산 실행

// 상품할인 취소선 및 태그위치변경
document.querySelectorAll('.cart').forEach(elem => {
	const p1 = elem.querySelector('.orderProductPrice');
	const p2 = elem.querySelector('.productSale');
	const p3 = elem.querySelector('.productSalePercent');
	const container = elem.querySelector('.ordertd');
	if ((Number(elem.querySelector('.productSalePercent').innerHTML.slice(0,-1))) > 0) { // Number()로 명시적 변환
		addStrikethrough(p1);
		container.insertBefore(p2, p1);
		container.insertBefore(p3, p1);
	} else {
		elem.querySelector('.productSalePercent').hidden = true;
		elem.querySelector('.productSale').hidden = true;
	}
});

// 🌟🌟🌟 수정: order.js에서 적립금 input 이벤트 리스너를 삭제합니다.
// 이 로직은 order.jsp의 인라인 스크립트에서 updateFinalPaymentAmount() 함수가 처리합니다.
/*
document.addEventListener('input', (e) => {
	if (e.target.classList.contains('orderPointInput')) { // 이 클래스는 이제 order.jsp에서 사용하지 않습니다.
		let divone = e.target.closest('.divone');
		let input = divone.querySelector('.orderPointInput'); // 이 선택자도 이제 사용하지 않습니다.
		let point = parseInt(divone.querySelector('.orderpoint').innerHTML);
		let top = parseInt(document.querySelector('.totalOrderPrice').innerHTML.replace(/,/g, ""));
		console.log('현재 결제 급액' + top);
		console.log('쿠폰 : ' + divone.querySelector('#coupon').innerHTML);
		console.log('포인트' + point);
		if (Number(input.value) < 0) {
			input.value = 0;
		} else if (Number(input.value) > point){
			input.value = 0;
			alert('현재 적립금보다 많이 적었습니다. 다시입력해주세요.');
		} else if (Number(input.value) > top){
			input.value = 0;
			alert('결제 금액보다 큰값을 입력했습니다. 다시입력해주세요.');
		}
		updateTotal();	
	}	
});
*/

function addStrikethrough(element) {
	element.style.textDecoration = "line-through";
}
