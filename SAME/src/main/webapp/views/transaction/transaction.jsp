<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.List , com.kh.transaction.model.vo.Transaction" %>

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

.payment {
	width: 917px;
	height: 594px;
	position: relative;
	margin-left: 25%;
}

.filter-section {
	width: 100%;
	border-radius: 10px;
	background: #ffffff;
	margin: 0 auto 20px;
	display: flex;
	flex-direction: column;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.filter-row {
	display: flex;
	align-items: center;
	padding: 10px 20px;
}

.filter-item {
	width: 120px;
	text-align: center;
	font-size: 14px;
	font-weight: 600;
	color: #333;
}

.filter-content {
	display: flex;
	align-items: center;
	gap: 10px;
}

.date-input, .text-input {
	border: 1px solid #dcdcdc;
	border-radius: 5px;
	padding: 8px;
	font-size: 14px;
	width: 200px;
}

.date-separator {
	font-size: 14px;
	color: #666;
}

.text-input {
	width: 150px;
}

.radio-group label {
	margin-right: 15px;
	font-size: 14px;
	font-weight: 500;
	color: #333;
	cursor: pointer;
	display: flex;
	align-items: center;
}

.radio-group input {
	margin-right: 5px;
}

.search-button {
	background: #ff5c3d;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 8px 15px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 600;
	transition: background 0.3s ease;
}

/* 구분선 스타일 */
.divider {
	width: 100%;
	height: 1px;
	background: #e0e0e0;
}

.table {
	width: 100%;
	margin-top: 20px; /* 필터 섹션과의 간격 */
	border-collapse: collapse;
	font-family: 'Inter', sans-serif;
	font-size: 14px;
	text-align: center; /* 테이블 내용 가운데 정렬 */
	background-color: #fff; /* 배경색 추가로 테이블 강조 */
	border: 1px solid #ddd; /* 테두리 추가 */
	border-radius: 5px; /* 테두리 둥글게 */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

.table-header, .table-row {
	display: grid;
	grid-template-columns: 1fr 2fr 1fr 2fr 1fr 1fr 1fr; /* 열 너비 비율 조정 */
	align-items: center;
}

.table-header {
	background-color: #f9f9f9;
	font-weight: 500;
	text-align: center;
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.table-row {
	text-align: center;
	border-bottom: 1px solid #eee;
}

.table-row div {
	padding: 10px 0;
}

.table-row:nth-child(even) {
	background-color: #fdfdfd;
}

.table-row:nth-child(odd) {
	background-color: #ffffff;
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

.pagination-button {
	background: none;
	border: none;
	font-size: 16px;
	cursor: pointer;
}

.page-number {
	margin: 0 5px;
	font-size: 14px;
	cursor: pointer;
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
			<div class="payment">
				<form action="<%=contextPath%>/member/payment" method="post" name="payment">
					<div class="filter-section">
						<div class="filter-row">
							<div class="filter-item">
								<label for="start-date">정산등록일</label>
							</div>
							<div class="filter-content">
								<input type="date" id="start-date" class="date-input" name="startDate"
									value="2024-12-01" /> <span class="date-separator">~</span> <input
									type="date" id="end-date" class="date-input" name="endDate" value="2024-12-01" />
							</div>
						</div>
						<div class="divider"></div>
						<div class="filter-row">
							<div class="filter-item">
								<label>정산처리상태</label>
							</div>
							<div class="filter-content radio-group">
								<label><input type="radio" name="status" value="all"
									checked /> 전체</label> <label><input type="radio" name="status"
									value="processed" /> 처리</label> <label><input type="radio"
									name="status" value="unprocessed" /> 미처리</label>
							</div>
						</div>
						<div class="divider"></div>
						<div class="filter-row">
							<div class="filter-item">
								<label for="mentee-name">멘티명</label>
							</div>
							<div class="filter-content">
								<input type="text" id="mentee-name" name="menteeName" class="text-input"
									placeholder="검색어 입력" />
								<button class="search-button">검색</button>
							</div>
						</div>
					</div>
	
					<div class="table">
						<div class="table-header">
							<div>거래번호</div>
							<div>강좌명</div>
							<div>멘티명</div>
							<div>수업 기간</div>
							<div>결제수단</div>
							<div>거래액</div>
							<div>정산 상태</div>
						</div>
						<%
							List<Transaction> list = (List<Transaction>)request.getAttribute("list");
							
							if(!list.isEmpty()) {
								for(Transaction t : list) {
						%>

						<div class="table-row">
							<div>NO_<%= t.getTdNo() %></div>
							<div><%= t.getClassCode() %></div>
							<div><%= t.getMenteeName() %></div>
							<div>2024-12-01 ~ 2024-12-24</div>
							
							<div><%= t.getMethod() %></div>
							<div><%= t.getAmount() %></div>
							<div><%= t.getStatus() %></div>
						</div>
						<%
								}
							} else {
						%>
						<div class="table-row">
							<div style="text-align: center;">조회된 결과가 없습니다.</div>
						</div>
					<%
						}
					%>
				</div>
				
				<script>
				document.querySelector('.search-button').addEventListener('click', function(e) {
					e.preventDefault();
					
					const form = document.forms['payment'];
					form.submit();
				});
				</script>
	
					<!-- 페이징바,,, 배운대로 다시 설정해야함. 임의로 숫자 써 넣음-->
					<div class="pagination">
						<button class="pagination-button">&laquo;</button>
						<span class="page-number">1</span> <span class="page-number">2</span>
						<span class="page-number">3</span> <span class="page-number">4</span>
						<span class="page-number">5</span> <span class="page-number">6</span>
						<span class="page-number">7</span> <span class="page-number">8</span>
						<span class="page-number">9</span> <span class="page-number">10</span>
						<button class="pagination-button">&raquo;</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>