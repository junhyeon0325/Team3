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
		return
	} // end if
	
	//document.querySelector('.cartProductSale').innerHTML = (cartProductTotalPrice - totalnum).toLocaleString() + '원'	// 할인적용된 금액
	//document.querySelector('.totalCartPriceButton').innerHTML = (cartProductTotalPrice).toLocaleString() + '원 주문하기';	// 결제버튼
	document.querySelector('.totalCartPrice').innerHTML = (cartProductTotalPrice).toLocaleString() + '원';	// 결제 예정 금액
	document.querySelector('.totalOrderPrice').innerHTML = (cartProductTotalPrice - document.querySelector('.orderPointInput').value).toLocaleString() + '원';	// 결제금액
	console.log(cartProductTotalPrice - document.querySelector('.orderPointInput').value);
	console.log(document.querySelector('.orderPointInput').value);
}// end function
updateTotal();



// order.js 파일의 기존 updateTotal() 함수 호출 아래에 추가합니다.

// TODO: 'YOUR_CLIENT_KEY'를 실제 토스페이먼츠 클라이언트 키로 변경하세요.
const clientKey = 'test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm';
const customerKey = 'en4-UGNlgbLPI0ZkpBOXo'; // 고객을 식별하는 값, 고유한 값으로 생성해야 합니다.
let amount = Number(document.querySelector('.totalOrderPrice').innerHTML.replace(/,/g, "").slice(0, -1));

// 결제 위젯 렌더링
const paymentWidget = PaymentWidget(clientKey, customerKey);

const paymentMethodsWidget = paymentWidget.renderPaymentMethods(
  '#payment-method',
  { value: amount }
);

paymentWidget.renderAgreement('#agreement');

// 결제하기 버튼 클릭 이벤트
document.getElementById('payment-button').addEventListener('click', function() {
  // 결제 정보 업데이트 (결제 금액이 바뀔 수 있으므로 버튼 클릭 시점에 다시 가져옵니다.)
  amount = Number(document.querySelector('.totalOrderPrice').innerHTML.replace(/,/g, "").slice(0, -1));
  paymentMethodsWidget.updateAmount(amount);

  // 결제 요청
  paymentWidget.requestPayment({
    orderId: 'T' + new Date().getTime(), // 주문 ID, 고유한 값으로 생성해야 합니다.
    orderName: 'Fruitables 상품', // 주문명, 여러 상품일 경우 대표 상품명으로 지정합니다.
    successUrl: window.location.origin + '/success.jsp', // 결제 성공 시 리다이렉트될 URL
    failUrl: window.location.origin + '/fail.jsp', // 결제 실패 시 리다이렉트될 URL
  });
});

// 기존의 updateTotal() 함수 내에서 결제 금액이 변경될 때마다 결제 위젯 금액을 업데이트합니다.
// updateTotal() 함수 끝 부분에 다음 코드를 추가하세요.
function updateTotal() {
  // ... (기존 코드)

  // 결제 금액이 변경될 때마다 결제 위젯의 금액도 업데이트
  const finalAmount = cartProductTotalPrice - document.querySelector('.orderPointInput').value;
  document.querySelector('.totalOrderPrice').innerHTML = finalAmount.toLocaleString() + '원';
  
  if (paymentMethodsWidget) {
    paymentMethodsWidget.updateAmount(finalAmount);
  }
}



// 상품할인 취소선 및 태그위치변경
document.querySelectorAll('.cart').forEach(elem => {
	const p1 = elem.querySelector('.orderProductPrice');	// 상품가격
	//console.log(p1);
	const p2 = elem.querySelector('.productSale');	// 상품할인된 가격
	const p3 = elem.querySelector('.productSalePercent');	// 할인퍼센트
	const container = elem.querySelector('.ordertd');	// 위에 태그들의 부모태그
	//console.log(elem.querySelector('.productSalePercent').innerHTML.slice(0,-1));
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
		console.log('쿠폰 : ' + divone.querySelector('#coupon').innerHTML);
		console.log('포인트' + point);
		if (Number(input.value) < 0) {
			input.value = 0;
		} else if (Number(input.value) > point){	// 현재 가지고 있는 포인트 값보다 크지 않게
			input.value = 0;
			alert('현재 포인트값보다 큽니다 다시적어주세요.');
		}
		updateTotal();	
	}	
})

function addStrikethrough(element) {
	element.style.textDecoration = "line-through";
}
