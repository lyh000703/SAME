<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.List , com.kh.member.model.vo.ClassVo" %>

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
.mentor-info {
	width: 917px;
	height: 594px;
	position: relative;
}

/* 회원 정보 박스 */
.info-box {
	width: 308px;
	height: 266px;
	position: absolute;
	top: 0;
	left: 5px;
	background: white;
	border-radius: 5px;
	border: 1px solid #828282;
	position: relative;
}

.text-red {
	width: 345px;
	position: absolute;
	left: 572px;
	top: 255px;
	color: #FF5C3D;
	font-size: 20px;
	font-family: Inter;
	font-weight: 500;
	line-height: 30px;
	word-wrap: break-word;
	text-decoration: none; /* 밑줄 제거 */
}

/* 프로필 이미지 */
.profile-image {
	width: 256px;
	height: 256px;
	position: absolute;
	top: 0;
	left: 31px;
}

/* 입력 박스 */
.input-box {
	width: 349px;
	height: 55px;
	position: absolute;
	left: 339px;
	background: white;
	border-radius: 5px;
	border: 1px solid #828282;
	line-height: 55px;
	padding-left: 20px;
	font-family: Inter, sans-serif;
	font-size: 20px;
	font-weight: 500;
	position: absolute; /* 절대 위치 지정 */
}

.mentor-info {
	width: 710px;
	margin: 0 auto;
	font-family: 'Inter', sans-serif;
}

.section {
	margin-top: 50px;
}

.section-title {
	font-size: 20px;
	font-weight: 700;
	margin-bottom: 10px;
}

.item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 10px 0;
}

.item-title {
	font-size: 18px;
	font-weight: 500;
}

.download-input {
	font-size: 16px;
	color: black;
	background: #EBEBEB;
	border: 1px solid black;
	border-radius: 15px;
	padding: 5px 15px;
	cursor: pointer;
	display: inline-block;
	text-align: center;
}

.file-upload {
	display: none; /* 실제 input 요소는 숨깁니다 */
}

.divider {
	width: 100%;
	height: 1px;
	background: black;
	margin: 20px 0;
}

.lecture-container {
	display: flex;
	align-items: center;
	gap: 15px;
}

.lecture-image {
	width: 130px;
	height: 80px;
	border-radius: 8px;
}

.lecture-details {
	display: flex;
	flex-direction: column;
}

.lecture-title {
	font-size: 16px;
	font-weight: 700;
	color: black;
	text-decoration: none; /* 링크 밑줄 제거 */
	display: block; /* 기존 div와 동일한 block 스타일 유지 */
}

.lecture-title:hover {
	text-decoration: underline; /* 사용자가 마우스를 올렸을 때 강조 효과 */
}

.lecture-subtitle {
	font-size: 14px;
	color: #828282;
	margin: 5px 0;
}

.lecture-date {
	font-size: 14px;
	color: #828282;
}

.delete-button {
	display: block;
	width: 100%;
	font-size: 20px;
	color: white;
	background: #FF5C3D;
	border: none;
	border-radius: 5px;
	padding: 15px;
	cursor: pointer;
	text-align: center;
	margin: 50px 0;
}
a{
    text-decoration-line : none;
}
/* Modal 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-dialog {
    position: relative;
    width: 400px;
    margin: 15% auto;
}

.modal-content {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
    padding: 20px;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-title {
    font-size: 20px;
    font-weight: 500;
    color: #333;
    margin: 0;
}

.close {
    font-size: 24px;
    font-weight: bold;
    color: #666;
    background: none;
    border: none;
    cursor: pointer;
}

.close:hover {
    color: #FF5C3D;
}

.modal-body {
    padding: 20px;
}

.modal-body b {
    display: block;
    margin-bottom: 20px;
    color: #333;
    font-size: 16px;
    line-height: 1.5;
}

.modal-body table {
    width: 100%;
    margin-bottom: 20px;
}

.modal-body td {
    padding: 8px;
}

.modal-body td:first-child {
    width: 30%;
    font-weight: 500;
}

.modal-body input[type="password"] {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.modal-body input[type="password"]:focus {
    border-color: #FF5C3D;
    outline: none;
}

.btn-danger {
    background-color: #FF5C3D;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.btn-danger:hover {
    background-color: #e74c3c;
}

.btn-sm {
    font-size: 14px;
    padding: 8px 16px;
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
			<div class="mentor-info">
				<form action="<%= contextPath %>/member/mentorMain" method="post" name="mentorMain">
				<!-- 회원 정보 박스 -->
				<div class="info-box">
					<img class="profile-image"
						src="https://via.placeholder.com/256x256" alt="Profile Image" />
				</div>
					<a href="<%=contextPath%>/member/modify" class="text-red" style="text-decoration: none;">회원정보 수정</a>

					<div class="input-box" style="top: 21px">
						<span class="info-text">${m.memberId}</span>
					</div>
					<div class="input-box" style="top: 99px;">
						<span class="info-text">${m.memberName}</span>
					</div>
					<div class="input-box" style="top: 185px;">
						<span class="info-text">${m.email}</span>
					</div>

				<div class="container">
					<div class="section">
						<div class="section-title">전문분야</div>
						<div class="item">
							<span class="item-title">
								<a href="/same/views/member/mentorPage/mentorResume.jsp" style="text-decoration: none; color: rgb(0, 0, 0);">이력서</a>        						
							</span>
						</div>
					</div>

					<div class="divider"></div>

					<div class="section">
						<div class="section-title">정산</div>
						<div class="item">
							<span class="item-title"><a href="<%=contextPath%>/transaction/list" style="text-decoration: none; color: rgb(0, 0, 0);">정산 내역 조회</a></span>
						</div>
					</div>

					<div class="divider"></div>

					<div class="section">
						<div class="section-title">
							개설된 강좌
							<a href="<%=contextPath%>/member/class" style="float: right; text-decoration: none; color: rgb(0, 0, 0); font-size: 17px;">추가</a>
						</div>
						<%
							List<ClassVo> classList = (List<ClassVo>)request.getAttribute("classList");
						
							if(classList != null && !classList.isEmpty()) {
            					for(ClassVo classInfo : classList) {
    					%>
							<div class="lecture-container">
								<div class="lecture-details">
									<div class="lecture-title"><%=classInfo.getClassTitle()%></div>
									<div class="lecture-subtitle"><%= classInfo.getCategory() %> , <%= classInfo.getRegion() %></div>
									<div class="lecture-date"><%=classInfo.getStartDate()%> ~ <%=classInfo.getEndDate()%></div>
								</div>
							</div>
					    <%
            					}
        					}
    					%>
					</div>

					<div class="divider"></div>

					<div class="section">
						<div class="section-title">스케줄표</div>
						<div class="item">
							<span class="item-title"><a href="<%=contextPath%>/views/member/mentorPage/schedule.jsp" style="text-decoration: none; color: rgb(0, 0, 0);">스케줄표 수정/삭제</a></span>
						</div>
					</div>
					
					<!-- 회원탈퇴 버튼 -->
					<button type="button" class="delete-button" data-toggle="modal" data-target="#deleteForm">회원탈퇴</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="modal" id="deleteForm">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원탈퇴</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body" align="center">
				<b>탈퇴 후 복구가 불가능합니다. <br>정말로 탈퇴하시겠습니까?
				</b><br> <br>
				<form action="${pageContext.request.contextPath}/member/delete" method="post">
					<table>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="memberPwd" required></td>
						</tr>
					</table>
					<br>
					<button type="submit" class="btn btn-danger btn-sm">탈퇴하기</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>