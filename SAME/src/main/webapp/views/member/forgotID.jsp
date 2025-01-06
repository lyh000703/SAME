<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
  <style>
   body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: white;
    }

    .main {
        width: 1440px;
        position: relative;
        background: rgb(255, 255, 255);
    }

    /* SAME SAME 로고 */
    .SameSame {
        color: #FF5C3D;
        font-size: 128px;
        font-family: Prompt, sans-serif;
        font-weight: 700;
        text-align: center;
        margin-bottom: 20px;
    }

    /* set 컨테이너 */
    .set {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 20px; /* 요소 간 간격 */
        margin-top: 5%;
    }


    .bigBox {
        width: 500px;
        height: 50px;
    }
    /* 멘티/멘토 버튼 컨테이너 */
    .login-tabs {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-left: -38%;
        
    }

    .loginMe, .loginMt {
        width: 120px;
        height: 40px;
        text-align: center;
        line-height: 40px;
        font-size: 16px;
        font-weight: 500;
        border-radius: 20px 20px 0 0;
        cursor: pointer;
        margin-bottom: 3%;
        
    }

    .loginMe {
        background: #FF5C3D;
        color: white;
        margin-left: -10%;
    }

    .loginMt {
        background: white;
        color: black;
        border: 1px solid #E0E0E0;
        margin-left: -10px;
    }

    .loginMe.active, .loginMt.active {
        background: #FF5C3D;
        color: white;
    }

    .loginMe.inactive, .loginMt.inactive {
        background: white;
        color: black;
        border: 1px solid #E0E0E0;
    }

    .forgot {
        color: #FF5C3D;
        font-size: 50px;
        font-weight: 900;
        text-align: center;
        margin-top: -5%;
    }

    
    .writing-name, .writing-email {
        width: 100%;
        height: 50px; /* login.jsp와 동일한 높이 */
        background: white;
        border-radius: 5px;
        border: 1px solid #828282;
        margin-bottom: 5%;
        display: flex; /* 추가 */
        align-items: center; /* 추가 */
    }

    .text-input {
        width: 100%; /* 수정 */
        height: 100%; /* 수정 */
        border: none;
        font-size: 16px;
        padding: 0 15px;
        outline: none;
    }

.btn-id {
    width: 100%;
    height: 50px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 500;
    text-align: center;
    background: #FF5C3D;
    color: white;
    cursor: pointer;
    border: none;
    margin-top: 15%;
}

.btn-id button {
    all: unset;
    width: 100%;
    height: 100%;
    cursor: pointer;
}

    /* 하단 텍스트 */
    .forgot-pass {
        font-size: 14px;
        color: black;
        text-align: center;
        cursor: pointer;
        margin-bottom: 5%;
        margin-right: -80%;
    }
    a{
    text-decoration-line : none;
    color: black;
    }
  </style>
</head>
<body>
  <div class="main">
    <%@ include file="/views/common/mainHeader.jsp"%>
    <div class="set">
        
        <div class="bigBox">
        <form id="forgotId" action="<%=contextPath%>/member/forgotID" method="post">
            <div class="login-tabs">
                <!-- 멘티/멘토 버튼 -->
				<input type="hidden" id="memberType" name="memberType" value="A%">
				<div class="loginMe active" id="mentee" onclick="setType('A%')">멘티</div>
				<div class="loginMt inactive" id="mentor" onclick="setType('B%')">멘토</div>
            </div>

            <div class="forgot">아이디찾기</div>
            <div class="forgot">ID</div>
        
                <!-- 이름 email 작성 -->
             	<div class="writing-name">
    			    <input type="text" class="text-input" name="memberName" placeholder="NAME">
    			</div>
    			<div class="writing-email">
        			<input type="text" class="text-input" name="email" placeholder="EMAIL">
    			</div>

 			    <div class="btn-id">
        			<button type="submit">아이디 찾기</button>
			    </div>

			    <div class="forgot-pass">
        			<a href="/same/views/member/forgotPass.jsp">비밀번호 찾기</a>
    			</div>
    	</form>
    	</div>
    </div>
</div>
	
  <!-- 멘토, 멘티 클릭시 색을 바꾸는 script-->
  <script>
    var menteeButton = document.getElementById("mentee");
    var mentorButton = document.getElementById("mentor");

    menteeButton.addEventListener("click", () => {
      menteeButton.classList.add("active");
      menteeButton.classList.remove("inactive");
      mentorButton.classList.add("inactive");
      mentorButton.classList.remove("active");
    });

    mentorButton.addEventListener("click", () => {
      mentorButton.classList.add("active");
      mentorButton.classList.remove("inactive");
      menteeButton.classList.add("inactive");
      menteeButton.classList.remove("active");
    });
    
    function setType(type) {
        document.getElementById("memberType").value = type;
    }
  </script>
</body>
</html>