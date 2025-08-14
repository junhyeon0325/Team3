/**
 * cart.js
 * 
 */

function totalprice() {
	let pcs = Number(document.querySelector('#productPcs').value);
	let pp = Number(document.querySelector('#productPrice').innerHTML);
	let tp = pp * pcs;
	document.querySelector('#totalPrice').innerHTML = tp + '원';
}

let total = dataList.reduce((sum, item) => sum + item.price, 0);


cartList.forEach(item =>{ 
    totalprice();
});