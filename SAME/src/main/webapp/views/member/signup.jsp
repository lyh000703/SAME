<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SAME SAME</title>
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
}

/* sign-up-form 스타일 */
.sign-up-form {
	display: flex;
	flex-direction: column;
	width: 500px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 5%;
}

.writing-box {
	display: flex;
	margin-bottom: 15px;
}

.id-box {
	flex: 1;
	height: 40px;
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
}

.input-box {
	width: 100%;
	height: 40px;
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
}

.duplicate-btn {
	padding: 5px 25px;
	background-color: #FF5C3D;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

.submit-btn {
	height: 50px;
	background-color: #FF5C3D;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	margin-top: 20px;
	cursor: pointer;
}

.kakao-btn {
	height: 50px;
	background-color: #FBE300;
	color: black;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	margin-top: 10px;
	cursor: pointer;
}
/* 컨테이너 끝 */
</style>
</head>
<body>
	<!-- head 시작-->
	<div class="main">

		<%@ include file="/views/common/mainHeader.jsp"%>
		<%@ include file="/views/common/searchbar.jsp"%>

		<div class="container">
			<%@ include file="/views/common/sidebarMembership.jsp"%>
			<!-- 컨테이너 시작-->
			<div class="sign-up-form">
				<!-- 사이드바 -->
				<form id="signup"
					action="${pageContext.request.contextPath}/member/insert"
					method="post">
					<!-- 히든 필드로 memberType 값 전달 -->
					<input type="hidden" name="memberType" value="<%=memberType != null ? memberType : "A"%>">
					<div class="writing-box">
						<input type="text" id="id" name="memberId" class="id-box"
							placeholder="아이디" required>
						<button type="button" class="duplicate-btn">중복</button>
					</div>
					<div class="writing-box">
						<input type="password" id="password" name="memberPwd"
							class="input-box" placeholder="비밀번호" required>
					</div>
					<div class="writing-box">
						<input type="password" id="password-confirm"
							name="passwordConfirm" class="input-box" placeholder="비밀번호 확인"
							required>
					</div>
					<div class="writing-box">
						<input type="text" id="name" name="memberName" class="input-box"
							placeholder="이름" required>
					</div>
					<div class="writing-box">
						<input type="text" id="phone" name="phone" class="input-box"
							placeholder="연락처" required>
					</div>
					<div class="writing-box">
						<input type="text" id="ssn" name="memberSSN" class="input-box"
							placeholder="주민번호" required>
					</div>
					<div class="writing-box">
						<input type="email" id="email" name="email" class="input-box"
							placeholder="EMAIL" required>
					</div>
					<div class="writing-box">
						<input type="text" id="address" name="address" class="input-box"
							placeholder="주소" required>
					</div>
					<button type="submit" class="submit-btn">회원가입</button>
				</form>
			</div>
		</div>
	</div>

	<script>
	document.querySelector('.duplicate-btn').addEventListener('click', function () {
	    const userId = document.getElementById('id').value;

	    if (!userId) {
	        alert('아이디를 입력하세요.');
	        return;
	    }

	    fetch(`${pageContext.request.contextPath}/member/checkDuplicate?memberId=` + userId)
	        .then(response => {
	            if (!response.ok) {
	                throw new Error('네트워크 응답에 문제가 있습니다.');
	            }
	            return response.json();
	        })
	        .then(data => {
	            if (data.isDuplicate) {
	                alert('이미 사용 중인 아이디입니다.');
	            } else {
	                alert('사용 가능한 아이디입니다.');
	            }
	        })
	        .catch(error => {
	            console.error('오류 발생:', error);
	            alert('중복 확인 중 오류가 발생했습니다. 다시 시도해주세요.');
	        });
	});
        
	document.getElementById('signup').addEventListener('submit', function (event) {
    const memberType = document.querySelector('input[name="memberType"]').value;
    const password = document.getElementById('password').value;
    const passwordConfirm = document.getElementById('password-confirm').value;

    // 비밀번호 확인
    if (password !== passwordConfirm) {
        alert('비밀번호가 일치하지 않습니다.');
        event.preventDefault();
        return;
    }

    // 멘토 회원가입인 경우 알림
    if (memberType === 'B') {
        alert('회원가입 후 이력서 입력 페이지로 이동합니다.');
    }
});
    </script>
</body>
</html>