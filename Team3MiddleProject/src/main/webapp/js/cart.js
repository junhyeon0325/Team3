/**
 * cart.js
 * 
 */
// 적립금 1,000원 형태로 만드는 코드
let cppBefore = document.querySelector('.cartProductPoint').innerHTML;
document.querySelector('.cartProductPoint').innerHTML = cppBefore.toLocaleString() + '원';
let cpp = cppBefore;	// 할인 금액
let price = 0;
let salePrice = 0;
//console.log(cartList);
// 버튼을 누르면 수량에 따른 상품 가격이 바뀌도록

function updateTotal() {
	// 상품 가격 초기화
	let cartProductTotalPrice = 0;
	let totalnum = 0;

	// .cart 클래스 부분부터 다시 찍어내는 코드
	document.querySelectorAll('.cart').forEach(elem => {
		// 1,000원 형태를 1000으로 돌리는 과정
		let priceBefore = elem.querySelector('.productPrice').innerHTML.slice(0, -1);	// 1,000원 -> 1,000
		let num = Number(priceBefore.replace(/,/g, ""));	// 1,000 -> 1000
		let sale = elem.querySelector('.productSalePercent').innerHTML.slice(0 , -1) / 100;
		
		// 수량에 따라 가격 출력
		let pcs = Number(elem.querySelector('.productPcs').value);	// 수량 value를 pcs넣음
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
		elem.querySelector('.totalPrice').innerHTML = (price * pcs).toLocaleString() + '원';	// 수량에 따라 가격 변화를 태그에 넣기 총가격
		cartProductTotalPrice = cartProductTotalPrice + (price * pcs);	// 모든 상품의 가격을 구하기 위한 계산식
		
	}) // end foreach

	console.log(document.querySelectorAll('.cart'));
	console.log(cartProductTotalPrice);
	console.log(cartProductTotalPrice - totalnum);
	document.querySelector('.cartProductTotalPrice').innerHTML = totalnum.toLocaleString() + '원';	// 상품금액
	if (cartProductTotalPrice - cpp < 0) {	// 결제예상금액이 적립금에 의해서 -로 가면은 0으로 출력
		document.querySelector('.totalCartPrice').innerHTML = 0 + '원';	// 결제 예정 금액
		document.querySelector('.totalCartPriceButton').innerHTML = 0 + '원 주문하기';	// 결제 버튼
		return
	} // end if

	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice - cpp).toLocaleString() + '원';	// 결제 예정 금액
	document.querySelector('.totalCartPriceButton').innerHTML = (cartProductTotalPrice - cpp).toLocaleString() + '원 주문하기';	// 결제버튼
	document.querySelector('.cartProductSale').innerHTML = (cartProductTotalPrice - totalnum).toLocaleString() + '원'	// 할인적용된 금액
}// end function

updateTotal();	// 장바구니 초기화면 상품수량별 총 가격 출력

document.querySelectorAll('.cart').forEach(elem => {

	const p1 = elem.querySelector('.productPrice');
	const p2 = elem.querySelector('.productSale');
	const p3 = elem.querySelector('.productSalePercent');
	const container = elem.querySelector('.pricetd');

	// sale부분 원레가격에 취소선 만들고 새로운 가격 찍기
	if ((elem.querySelector('.productSalePercent').innerHTML.slice(0,-1)) > 0) {
		const myText = elem.querySelector('.productPrice');
		addStrikethrough(myText);	// 기존 가격 취소선 추가

		container.insertBefore(p2, p1);
		container.insertBefore(p3, p1);
		elem.querySelector('.productSale').style.paddingTop = "20px";
		elem.querySelector('.productPrice').style.paddingBottom = "20px";
	} else {
		elem.querySelector('.productSalePercent').hidden = true;
		elem.querySelector('.productSale').hidden = true;
		elem.querySelector('.productPrice').style.paddingTop = "20px";
	}
})



// 클릭 이벤트
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

// input이벤트
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


function addStrikethrough(element) {
	element.style.textDecoration = "line-through";
}

