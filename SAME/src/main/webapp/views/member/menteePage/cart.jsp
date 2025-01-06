<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: white;
}

.container {
	width: 100%;
	position: relative;
	display: flex;
	flex-direction: column;
}

.cart-container {
	width: 800px;
	margin: 0 auto;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	margin-left: 23%;
}

.cart-summary {
	font-size: 18px;
	margin-bottom: 10px;
}

.cart-table {
	border: 1px solid #ddd;
	border-radius: 8px;
}

.cart-header, .cart-product {
	display: flex;
	align-items: center;
	padding: 10px;
}

.cart-header {
	background-color: #f5f5f5;
	font-weight: bold;
}

.cart-product {
	border-bottom: 1px solid #ddd;
}

.cart-product:last-child {
	border-bottom: none;
}

.header-item, .header-price, .header-quantity, .product-total,
	.header-check {
	text-align: center;
	flex: 5;
}
.product-total{
margin-left: 2%;
}
.header-price{
margin-left: 90px;
}

.product-total, .product-price, .product-quantity, .product-total,
	.product-actions {
	text-align: center;
	flex: 5;
}

.product-info {
	display: flex;
	align-items: center;
}

.product-info img {
	width: 80px;
	height: 80px;
	border-radius: 5px;
	margin-right: 10px;
}

.product-details {
	font-size: 14px;
}

.product-name {
	font-weight: bold;
	margin-bottom: 5px;
}

.product-quantity input {
	width: 50px;
	text-align: center;
}

.btn {
	border: none;
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.pay-btn {
	background-color: #ff5c3d;
	color: white;
}

.delete-btn {
	background-color: #828282;
	color: white;
}

.cart-footer {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 10px 0;
	font-size: 18px;
}

.final-price {
	font-weight: bold;
	margin-right: 20px;
}

.checkout-btn {
	background-color: #ff5c3d;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	cursor: pointer;
}

.cart-header, .cart-product {
	display: flex;
	align-items: center;
	padding: 10px;
}

.product-select, .header-item:first-child {
	flex: 0 0 50px; /* 고정된 너비로 설정 */
	text-align: center;
}

.product-select input[type="checkbox"] {
	margin: 0 auto; /* 체크박스를 가운데 정렬 */
}

.cart-product {
	border-bottom: 1px solid #ddd;
}

.cart-product:last-child {
	border-bottom: none;
}
</style>
</head>
<body>

	<div class="main">
		<%@ include file="/views/common/mainHeader.jsp"%>
		<%@ include file="/views/common/searchbar.jsp"%>
		<br> <br>
		<!-- 컨테이너 시작-->
		<div class="container">
			<%@ include file="/views/common/sidebarMentee.jsp"%>

			<div class="cart-container">
				<!-- 상단 정보 -->
				<div class="cart-summary">
					<span>총 ( 2 ) 개</span>
				</div>

				<!-- 테이블 -->
				<div class="cart-table">
					<!-- 헤더 -->
					<div class="cart-header">
						<div class="product-select">
							<input type="checkbox" id="selectAll">
						</div>
						<div class="header-item">상품 정보</div>
						<div class="header-price"> 판매가</div>
						<div class="header-quantity">수량</div>
						<div class="product-total">결제 예정가</div>
						<div class="header-check">선택</div>
					</div>

					<!-- 상품 1 -->
					<div class="cart-product">
						<div class="product-select">
							<input type="checkbox" class="product-checkbox" />
						</div>
						<div class="product-info">
							<img src="https://via.placeholder.com/80" alt="안광주 이미지" />
							<div class="product-details">
								<div class="product-name">안광주</div>
								<div class="product-info">컴퓨터 / JAVA</div>
								<div class="product-info">백엔드의 모든 것</div>
								<div>2024.12.02 - 12.16</div>
							</div>
						</div>
						<div class="product-price">7,000</div>
						<div class="product-quantity">
							<input type="number" value="5" min="1" class="quantity-input" />
						</div>
						<div class="product-total">35,000</div>
						<div class="product-actions">
							<button class="btn pay-btn">결제</button>
							<button class="btn delete-btn">삭제</button>
						</div>
					</div>

					<!-- 상품 2 -->
					<div class="cart-product">
						<div class="product-select">
							<input type="checkbox" class="product-checkbox" />
						</div>
						<div class="product-info">
							<img src="https://via.placeholder.com/80" alt="채소연 이미지" />
							<div class="product-details">
								<div class="product-name">채소연</div>
								<div>컴퓨터 / PPT</div>
								<div>PPT 너도 할 수 있어</div>
								<div>2024.12.16</div>
							</div>
						</div>
						<div class="product-price">3,000</div>
						<div class="product-quantity">
							<input type="number" value="1" min="1" class="quantity-input" />
						</div>
						<div class="product-total">3,000</div>
						<div class="product-actions">
							<button class="btn pay-btn">결제</button>
							<button class="btn delete-btn">삭제</button>
						</div>
					</div>
				</div>

				<form action="<%= contextPath %>/tossPay" method="post" name="finalAmount">
				<!-- 하단 합계 -->
				<div class="cart-footer">
					<div class="final-price">
						최종 금액: <span id="finalAmount">38,000</span>원
					</div>
					<input type="hidden" name="finalAmount" id="finalAmountInput" value="1">
					<button class="btn checkout-btn">결제하기</button>
				</div>
				</form>
			</div>
		</div>
	</div>

	<!-- JavaScript -->
	<script>
		// 삭제 버튼 클릭 시 상품 삭제
		document.querySelectorAll('.delete-btn').forEach((deleteBtn) => {
			deleteBtn.addEventListener('click', function () {
				const cartProduct = this.closest('.cart-product');
				if (cartProduct) {
					cartProduct.remove(); // 해당 상품 제거
					updateFinalAmount(); // 최종 금액 업데이트
				}
			});
		});

		// 전체선택/해제 기능
		const selectAllCheckbox = document.getElementById('selectAll');
		const productCheckboxes = document.querySelectorAll('.product-checkbox');

		selectAllCheckbox.addEventListener('change', function () {
			const isChecked = this.checked;
			productCheckboxes.forEach((checkbox) => {
				checkbox.checked = isChecked; // 전체 선택 또는 해제
			});
		});

		// 수량 변경 시 결제 예정가와 최종 금액 업데이트
		const quantityInputs = document.querySelectorAll('.quantity-input');
		quantityInputs.forEach((input) => {
		    input.addEventListener('input', function () {
		        const cartProduct = this.closest('.cart-product');
		        if (cartProduct) {
		            const productPrice = parseInt(cartProduct.querySelector('.product-price').textContent.replace(/,/g, ''), 10);
		            const quantity = parseInt(this.value, 10);
		            const productTotal = cartProduct.querySelector('.product-total');

		            // 결제 예정가 계산 및 업데이트
		            if (!isNaN(productPrice) && !isNaN(quantity)) {
		                const total = productPrice * quantity;
		                productTotal.textContent = total.toLocaleString(); // 숫자 포맷팅
		            }

		            // 최종 금액 업데이트
		            updateFinalAmount();
		        }
		    });
		});

		// 최종 금액 업데이트 함수
		function updateFinalAmount() {
		    let finalAmount = 0;
		    document.querySelectorAll('.product-total').forEach((total) => {
		        // 결제 예정가 값을 가져와 숫자로 변환
		        const amount = parseInt(total.textContent.replace(/,/g, ''), 10);
		        if (!isNaN(amount)) {
		            finalAmount += amount; // 숫자가 유효한 경우에만 더하기
		        }
		    });
		    // 최종 금액 업데이트
		    document.getElementById('finalAmount').textContent = finalAmount.toLocaleString(); // 숫자 포맷팅
		}
	</script>
</body>
</html>