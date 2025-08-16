/**
 * order.js
 */
function updateTotal() {
	// 상품 가격 초기화
	let cartProductTotalPrice = 0;
	let totalnum = 0;
	document.querySelectorAll('.cart').forEach(elem => {
		// 상품 가격 1,000원 -> 1000
		let priceBefore = elem.querySelector('.orderProductPrice').innerHTML.slice(0, -1);	// 1,000원 -> 1,000
		let num = Number(priceBefore.replace(/,/g, ""));	// 상품 가격 1,000 -> 1000 형태
		
		console.log('할인퍼센트 1,000형태 : ' + priceBefore + '/ 상품 가격 1000형태 : ' + num);
		
		// 할인 가격 10% -> 0.1
		let sale = elem.querySelector('.productSalePercent').innerHTML.slice(0, -1) / 100;

		// 수량에 따라 가격 출력
		let pcs = Number(elem.querySelector('.orderProductPcs').innerHTML);	// 수량 value를 pcs넣음
		totalnum += (num * pcs);

		// 테스트
		console.log('할인퍼센트html : ' + elem.querySelector('.productSalePercent').innerHTML);
		console.log('할인퍼센트 : ' + sale + '/ 가격 : ' + num);

		if (sale > 0) {
			price = num * (1 - sale);
		} else if (sale == 0) {
			price = num;// 상품 가격
		}

		console.log('가격 : ' + num + '/ 세일적용된 가격 : ' + price + '/ 수량 : ' + pcs);
		console.log('세일된 가격 : ' + (num * sale));
		console.log('쌩총가격 : ' + totalnum)

		elem.querySelector('.productSale').innerHTML = price.toLocaleString() + '원';
		elem.querySelector('.ordertotalPrice').innerHTML = (price * pcs).toLocaleString() + '원';	// 수량에 따라 가격 변화를 태그에 넣기 총가격
		cartProductTotalPrice = cartProductTotalPrice + (price * pcs);	// 모든 상품의 가격을 구하기 위한 계산식

	})

	console.log(document.querySelectorAll('.cart'));
	console.log(cartProductTotalPrice);
	console.log(cartProductTotalPrice - totalnum);
	console.log(document.querySelector('.orderPointInput').value);
	//document.querySelector('.cartProductTotalPrice').innerHTML = totalnum.toLocaleString() + '원';	// 상품금액
	if (cartProductTotalPrice < 0) {	// 결제예상금액이 적립금에 의해서 -로 가면은 0으로 출력
		document.querySelector('.totalCartPrice').innerHTML = 0 + '원';	// 결제 예정 금액
		document.querySelector('.totalCartPriceButton').innerHTML = 0 + '원 주문하기';	// 결제 버튼
		return
	} // end if
	
	//document.querySelector('.cartProductSale').innerHTML = (cartProductTotalPrice - totalnum).toLocaleString() + '원'	// 할인적용된 금액
	//document.querySelector('.totalCartPriceButton').innerHTML = (cartProductTotalPrice).toLocaleString() + '원 주문하기';	// 결제버튼
	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice).toLocaleString() + '원';	// 결제 예정 금액
	document.querySelector('.totalOrderPrice').innerHTML = (cartProductTotalPrice - document.querySelector('.orderPointInput').value).toLocaleString() + '원';	// 결제금액
}// end function
updateTotal();

document.querySelectorAll('.cart').forEach(elem => {

	const p1 = elem.querySelector('.orderProductPrice');	// 상품가격
	console.log(p1);
	const p2 = elem.querySelector('.productSale');	// 상품할인된 가격
	const p3 = elem.querySelector('.productSalePercent');	// 할인퍼센트
	const container = elem.querySelector('.ordertd');	// 위에 태그들의 부모태그
	console.log(elem.querySelector('.productSalePercent').innerHTML.slice(0,-1));
	// sale부분 원레가격에 취소선 만들고 새로운 가격 찍기
	if ((elem.querySelector('.productSalePercent').innerHTML.slice(0,-1)) > 0) {
		addStrikethrough(p1);	// 기존 가격 취소선 추가

		container.insertBefore(p2, p1);
		container.insertBefore(p3, p1);
	} else {
		elem.querySelector('.productSalePercent').hidden = true;
		elem.querySelector('.productSale').hidden = true;
	}
})

document.addEventListener('input', (e) => {
	if (e.target.classList.contains('orderPointInput')) {
		let divone = e.target.closest('.divone');
		let input = divone.querySelector('.orderPointInput');
		let point = parseInt(divone.querySelector('.orderpoint').innerHTML);
		console.log('포인트' + point);
		if (Number(input.value) < 0) {
			input.value = 0;
		} else if (Number(input.value) > point){	// 현재 가지고 있는 포인트 값보다 크지 않게
			input.value = point;
		}
		updateTotal();
	}
})

function addStrikethrough(element) {
	element.style.textDecoration = "line-through";
}
