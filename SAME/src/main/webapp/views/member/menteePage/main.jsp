<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
/* 컨테이너 */
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

.mentee-info {
	width: 750px;
	height: 594px;
	position: relative;
	border-radius: 5px;
	border: 1px solid #828282;
	margin-left: 30%;
}

/* 회원 정보 박스 */
.info-box {
	width: 308px;
	height: 266px;
	position: absolute;
	top: 10px;
	left: 10px;
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

/* 구매내역 타이틀 */
.purchase-title {
	position: absolute;
	top: 285px;
	left: 10px;
	color: black;
	font-size: 20px;
	font-family: Inter, sans-serif;
	font-weight: 600;
}

/* 구매내역 섹션 */
.purchase-section {
	width: 688px;
	height: auto; /* 높이를 자동으로 조정 */
	position: absolute;
	top: 318px;
	left: 10px;
	background: white;
	border-radius: 5px;
	border: 1px solid #828282;
	padding: 10px; /* 내부 여백 추가 */
}
/* 구매 항목 */
.purchase-item {
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 수직 정렬 */
	margin-bottom: 10px; /* 항목 간 간격 추가 */
}

/* 사용자 아이콘 */
.user-icon {
	width: 48px;
	height: 48px;
	margin-right: 10px; /* 아이콘과 텍스트 간 간격 추가 */
}

/* 사용자 이름 */
.user-name {
	color: black;
	font-size: 16px;
	font-family: Inter, sans-serif;
	font-weight: 500;
	line-height: 24px;
}

/* 사용자 설명 */
.user-description {
	color: #454545;
	font-size: 16px;
	font-family: Inter, sans-serif;
	font-weight: 400;
	line-height: 24px;
}

/* 회원탈퇴 버튼 */
.red-button {
	width: 492px;
	height: 55px;
	position: absolute;
	left: 114px;
	top: 527px;
	background: #ff5c3d;
	border-radius: 5px;
	color: white;
	font-size: 20px;
	font-family: Inter, sans-serif;
	font-weight: 700;
	text-align: center;
	line-height: 55px;
	border: none; /* 기본 테두리 제거 */
	cursor: pointer;
}

/* 리뷰 버튼 */
.review-button {
	width: 102px;
	height: 48px;
	background: #ff5c3d;
	border-radius: 5px;
	color: white;
	font-size: 20px;
	font-family: Inter, sans-serif;
	font-weight: 700;
	text-align: center;
	line-height: 48px;
	margin-left: auto; /* 오른쪽으로 정렬 */
	border: none; /* 기본 테두리 제거 */
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
			<div class="mentee-info">
				<!-- 사이드바 -->

				<!-- 회원 정보 박스 -->
				<div class="info-box">
					<img class="profile-image"
						src="https://via.placeholder.com/256x256" alt="Profile Image" />
					<a href="<%=contextPath%>/member/modify" class="text-red"
						style="text-decoration: none;">회원정보 수정</a>
				</div>
				<div class="input-box" style="top: 21px;"><%=loginUser.getMemberId()%></div>
				<div class="input-box" style="top: 99px;"><%=loginUser.getMemberName()%></div>
				<div class="input-box" style="top: 185px;"><%=loginUser.getEmail()%></div>


				<!-- 구매내역 타이틀 -->
				<div class="purchase-title">구매내역</div>

				<!-- 구매 내역 섹션 -->
				<div class="purchase-section">
					<!-- 첫 번째 사용자 -->
					<div class="purchase-item">
						<img class="user-icon" src="https://via.placeholder.com/48x48"
							alt="User Icon" />
						<div class="purchase-info">
							<div class="user-name">안광주</div>
							<div class="user-description">백엔드의 모든 것</div>
						</div>
						<input type="submit" class="review-button" value="REVIEW" />
					</div>

					<!-- 두 번째 사용자 -->
					<div class="purchase-item">
						<img class="user-icon" src="https://via.placeholder.com/48x48"
							alt="User Icon" />
						<div class="purchase-info">
							<div class="user-name">채소연</div>
							<div class="user-description">PPT너도 할 수 있어</div>
						</div>
						<input type="submit" class="review-button" value="REVIEW" />
					</div>
				</div>

				<!-- 회원탈퇴 버튼 -->
				<button type="button" class="red-button" data-toggle="modal"
					data-target="#deleteForm">회원탈퇴</button>
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