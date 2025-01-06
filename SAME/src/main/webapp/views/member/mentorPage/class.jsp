<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List , com.kh.board.model.vo.Category , com.kh.member.model.vo.Member" %>
<%
    List<String> subjects = (List<String>)request.getAttribute("subjects");
	List<String> regions = (List<String>)request.getAttribute("regions");
%>
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

.form-container {
	width: 600px;
	margin: 50px auto;
	padding: 20px;
	background: #ffffff;
	border: 1px solid #ddd;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	font-weight: bold;
	color: #333;
	margin-bottom: 5px;
	display: block;
}

input, textarea, select {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

textarea {
	resize: none;
}

.tags {
	margin: 10px 0;
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.tag {
	background-color: #ff5c3d;
	color: #fff;
	padding: 5px 10px;
	border-radius: 5px;
	font-size: 14px;
	display: flex;
	align-items: center;
	gap: 5px;
}

.tag .remove {
	background: none;
	border: none;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	padding: 0;
}

select {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.register-button {
	width: 100%;
	padding: 10px;
	background-color: #ff5c3d;
	color: #fff;
	font-size: 16px;
	font-weight: bold;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.register-button:hover {
	background-color: #e54c2e;
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
			<div class="form-container">
				<h2>강의 등록</h2>
				<form action="<%=contextPath%>/member/class" id="classForm" method="post">
					<!-- 강사 -->
					<div class="form-group">
						<label for="teacher">강사</label> 
						<input type="text" id="teacher"name="teacher" value="<%=loginUser.getMemberName()%>" readonly>
					</div>

					<!-- 강의명 -->
					<div class="form-group">
						<label for="lecture-name">강의명</label> 
						<input type="text"id="lecture-name" name="lecture-name" placeholder="강의명을 입력하세요"required>
					</div>

					<!-- 분야 선택 -->
					<div class="form-group">
					    <label for="category">분야</label>
					    <select id="category" name="category" required>
					        <option value="">분야를 선택하세요</option>
					        <% if(subjects != null && !subjects.isEmpty()) {
					            for(String subject : subjects) { %>
					                <option value="<%= subject %>"><%= subject %></option>
					        <% }
					        } %>
					    </select>
					</div>

					<!-- 지역 선택 -->
					<div class="form-group">
					    <label for="region">지역</label>
					    <select id="region" name="region" required>
					        <option value="">지역을 선택하세요</option>
					        <% if(regions != null && !regions.isEmpty()) {
					            for(String region : regions) { %>
					                <option value="<%= region %>"><%= region %></option>
					        <% }
					        } %>
					    </select>
					</div>

					<!-- 강의 시간 -->
					<div class="form-group">
						<label for="start-date">강의 시작 날짜</label> 
						<input type="date"id="start-date" name="start-date" value="2024-12-11" required>

						<br><br> 

						<label for="end-date" class="inline-label">강의 종료 날짜</label> 
						<input type="date" id="end-date" name="end-date" value="2024-12-17" required>
					</div>

					<!-- 내용 -->
					<div class="form-group">
						<label for="description">내용</label>
						<textarea id="description" name="description" rows="6">이 강의에서는 고등학교 영어에서 꼭 필요한 문법, 독해, 어휘를 내신 대비부터 수능 실전 팁까지, 학습 수준에 맞춰 차근차근 가르칩니다. 어려운 영어, 쉽게 풀어가는 수업으로 함께해요!
                
일 시: 월~금 11:00~12:00 / 13:00~14:00 / 14:00~15:00
장 소: 경기도 인천시 한리스카피(3층)
가 격: 3,000원 (1시간 기준)
준비물: 노트</textarea>
					</div>

					<!-- 가격 -->
					<div class="form-group">
						<label for="price">가격</label> <input type="text" id="price" name="price" value="20,000원">
					</div>

					<!-- 등록 버튼 -->
					<button type="submit" class="register-button">등록</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>