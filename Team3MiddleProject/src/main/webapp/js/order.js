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
	if (cartProductTotalPrice < 0) {
		document.querySelector('.totalCartPrice').innerHTML = 0 + '원';
		return;
	}
	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice).toLocaleString() + '원';
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



function addStrikethrough(element) {
	element.style.textDecoration = "line-through";
}
