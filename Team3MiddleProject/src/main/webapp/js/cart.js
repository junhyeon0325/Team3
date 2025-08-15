/**
 * cart.js
 * 
 */

// 적립금 1,000원 형태로 만드는 코드
let cppBefore = document.querySelector('.cartProductPoint').innerHTML;
document.querySelector('.cartProductPoint').innerHTML = cppBefore.toLocaleString() + '원';
let cpp = cppBefore;	// 할인 금액

// 버튼을 누르면 수량에 따른 상품 가격이 바뀌도록
function updateTotal() {

	let cartProductTotalPrice = 0;

	// 숫자형태변환, 상품 가격 
	document.querySelectorAll('.cart').forEach(elem => {
		if ((elem.querySelector('.productSale').innerHTML) > 0) {
			const newtag = elem.createElement('del');
			const parenttag = elem.querySelector('.productPrice');
			parenttag.appendChild(newtag);
		} else {
			elem.querySelector('.productSale').remove();
		}

		// 1,000원 형태를 1000으로 돌리는 과정
		let priceBefore = elem.querySelector('.productPrice').innerHTML.slice(0, -1);
		let num = Number(priceBefore.replace(/,/g, ""));
		let price = num;// 상품 가격

		// 수량에 따라 가격 출력
		let pcs = Number(elem.querySelector('.productPcs').value);
		elem.querySelector('.totalPrice').innerHTML = (price * pcs).toLocaleString() + '원';	// 수량에 따라 가격 변화를 태그에 넣기
		cartProductTotalPrice = cartProductTotalPrice + (price * pcs);	// 모든 상품의 가격을 구하기 위한 계산식
	})
	//console.log(document.querySelectorAll('.cart'));
	//console.log(cartProductTotalPrice);
	document.querySelector('.cartProductTotalPrice').innerHTML = cartProductTotalPrice.toLocaleString() + '원';	// 상품금액
	if (cartProductTotalPrice - cpp < 0) {	// 결제예상금액이 적립금에 의해서 -로 가면은 0으로 출력
		document.querySelector('.totalCartPrice').innerHTML = 0 + '원';
		document.querySelector('.totalCartPriceButton').innerHTML = 0 + '원 주문하기';
		return
	}
	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice - cpp).toLocaleString() + '원';	// 결제 예정 금액
	document.querySelector('.totalCartPriceButton').innerHTML = (cartProductTotalPrice - cpp).toLocaleString() + '원 주문하기';	// 결제버튼
}

updateTotal();	// 장바구니 초기화면 상품수량별 총 가격 출력

// 상품 수량 +,-버튼 눌렀을때 
document.addEventListener('click', (e) => {
	// +버튼
	if (e.target.classList.contains('btn-plus')) {
		let cart = e.target.closest('.cart');
		let input = cart.querySelector('.productPcs');
		input.value = Number(input.value) + 1;	// 수량

		let pcs = input.value;	// productPcs
		let cno = cart.querySelector('.cno').value;	// cartNo
		console.log('+버튼 눌렀을때' + cno + ',' + pcs);
		fetch('modifyCartProductPcs.do?cno=' + cno + '&pcs=' + pcs)
			.then(resolve => resolve.json())
			.then(result => {
				if (result.retCode == 'OK') {  // 수정 성공
					updateTotal();
				} else if (result.retCode == 'NG') { // 수정 실패
					alert('수정실패!!');
				} else {
					alert('알 수 없는 코드입니다.');
				}
			})
			.catch(err => console.error(err));
	}	// end if

	// -버튼
	if (e.target.classList.contains('btn-minus')) {
		let cart = e.target.closest('.cart');
		//console.log(cart);
		let input = cart.querySelector('.productPcs');
		if (Number(input.value) > 0) {
			input.value = Number(input.value) - 1;
		} else {
			return
		} // end if

		let pcs = input.value;	// productPcs
		let cno = cart.querySelector('.cno').value;	// cartNo
		console.log('-버튼 눌렀을때' + cno + ',' + pcs);
		fetch('modifyCartProductPcs.do?cno=' + cno + '&pcs=' + pcs)
			.then(resolve => resolve.json())
			.then(result => {
				if (result.retCode == 'OK') {  // 수정 성공
					updateTotal();
				} else if (result.retCode == 'NG') { // 수정 실패
					alert('수정실패!!');
				} else {
					alert('알 수 없는 코드입니다.');
				}
			})
			.catch(err => console.error(err));

	}	// end if

	// X버튼
	if (e.target.classList.contains('btn-md')) {
		let cart = e.target.closest('.cart');

		let cno = cart.querySelector('.cno').value;	// cartNo
		console.log('취소버튼' + cno);
		fetch('removeCartListSingle.do?cno=' + cno)
			.then(resolve => resolve.json())
			.then(result => {
				if (result.retCode == 'OK') {  // 삭제 성공
					e.target.parentElement.parentElement.remove();
				} else if (result.retCode == 'NG') { // 삭제 실패
					alert('수정실패!!');
				} else {
					alert('알 수 없는 코드입니다.');
				}
			})
			.catch(err => console.error(err));
	} // end if


})

// 수량 칸 상자
document.addEventListener('input', (e) => {
	if (e.target.classList.contains('productPcs')) {
		let cart = e.target.closest('.cart');
		let input = cart.querySelector('.productPcs')
		if (Number(input.value) < 0) {
			input.value = 0;
		}
		updateTotal();
	}
})



