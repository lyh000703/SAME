<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List , com.kh.member.model.vo.Transaction" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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

.calendar-container {
  position: relative; 
  border: 1px solid #ff5c3d;
  border-radius: 4px;
  width: 800px;
  margin: auto;
  font-family: 'Inter', sans-serif;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #ff5c3d;
  color: white;
  padding: 10px 20px;
}

.nav-button {
  background: none;
  border: none;
  color: white;
  font-size: 18px;
  cursor: pointer;
}

.calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 5px;
  padding: 10px;
}

.day-name {
  text-align: center;
  font-weight: bold;
  color: #17a1fa;
}

.date-cell {
  text-align: center;
  padding: 5px;
  border-radius: 4px;
}

.date-cell:hover {
  background-color: #f5f5f5;
}

.event {
  font-size: 11px;
  color: white;
  padding: 2px 5px;
  border-radius: 3px;
  margin-top: 5px;
  background-color: #337af7;
}
.table {
    width: 800px;  /* calendar-container와 동일한 너비로 수정 */
    margin: 20px auto; /* 상하 여백 20px, 좌우 중앙 정렬 */
    border-collapse: collapse;
    font-family: 'Inter', sans-serif;
    font-size: 14px;
    text-align: center;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table-header, .table-row {
	display: grid;
	grid-template-columns: 1fr 2fr 1fr 2fr 1fr 1fr; /* 열 너비 비율 조정 */
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
.action-buttons {
    display: flex;
    gap: 5px;
    justify-content: center;
}

.accept-btn, .reject-btn {
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
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
			<%@ include file="/views/common/sidebarMentor.jsp"%>

    <div id="calendar-container" class="calendar-container">
        <div id="calendar-header" class="calendar-header">
          <button id="prev-month" class="nav-button">◀</button>
          <span id="month-title" class="month-title"></span>
          <button id="next-month" class="nav-button">▶</button>
        </div>
        <div class="calendar-grid">
          <!-- 요일 -->
          <div class="day-name">일</div>
          <div class="day-name">월</div>
          <div class="day-name">화</div>
          <div class="day-name">수</div>
          <div class="day-name">목</div>
          <div class="day-name">금</div>
          <div class="day-name">토</div>
          <!-- 날짜가 여기에 JavaScript로 추가됩니다 -->
           <script>
          const calendarGrid = document.querySelector(".calendar-grid");
          const monthTitle = document.getElementById("month-title");
          const prevMonthButton = document.getElementById("prev-month");
          const nextMonthButton = document.getElementById("next-month");
          
          let currentDate = new Date();
          
          function renderCalendar(date) {
            // 현재 월과 년도
            const year = date.getFullYear();
            const month = date.getMonth();
          
            // 1일이 시작되는 요일과 월의 마지막 날짜 계산
            const firstDayOfMonth = new Date(year, month, 1).getDay();
            const lastDateOfMonth = new Date(year, month + 1, 0).getDate();
          
            // 월 제목 업데이트
            monthTitle.textContent = `${year}년 ${month + 1}월`;
          
            // 기존 날짜 삭제
            calendarGrid.querySelectorAll(".date-cell").forEach((cell) => cell.remove());
          
            // 빈칸 추가
            for (let i = 0; i < firstDayOfMonth; i++) {
              const emptyCell = document.createElement("div");
              emptyCell.className = "empty-cell";
              calendarGrid.appendChild(emptyCell);
            }
          
            // 날짜 추가
            for (let day = 1; day <= lastDateOfMonth; day++) {
              const dateCell = document.createElement("div");
              dateCell.className = "date-cell";
              dateCell.textContent = day;
              calendarGrid.appendChild(dateCell);
            }
          }
          
          // 이전 월로 이동
          prevMonthButton.addEventListener("click", () => {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar(currentDate);
          });
          
          // 다음 월로 이동
          nextMonthButton.addEventListener("click", () => {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar(currentDate);
          });
          
          // 초기 렌더링
          renderCalendar(currentDate);
        </script>
        </div>
      </div>
        <div class="table">
						<div class="table-header">
              <div>거래번호</div>
              <div>강좌명</div>
              <div>멘티명</div>
              <div>수업 기간</div>
              <div>거래액</div>
              <div>수락여부</div>
						</div>
						<%
							List<Transaction> transactions = (List<Transaction>)request.getAttribute("transactions");
							if(transactions != null && !transactions.isEmpty()) {
								for(Transaction t : transactions) {
						%>

            <div class="table-row">
              <div>NO_<%= t.getTdNo() %></div>
              <div><%= t.getClassName() %></div>
              <div><%= t.getMenteeName() %></div>
              <div><%= t.getStartDate() %> ~ <%= t.getEndDate() %></div>
              <div><%= String.format("%,d", t.getAmount()) %></div>
              <div class="action-buttons">
                  <button class="accept-btn">수락</button>
                  <button class="reject-btn">거절</button>
              </div>
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
    </div>
</div>
</body>
</html>