<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.kh.member.model.vo.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>로그인 페이지</title>
 <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
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

    /* LOGIN 텍스트 */
    .Login {
        margin-top: 10px;
        color: #FF5C3D;
        font-size: 50px;
        font-weight: 900;
        text-align: center;
    }

    
.idBox, .passBox {
    width: 100%;
    height: 50px; /* 높이를 설정합니다. */
    background: white;
    border-radius: 5px;
    border: 1px solid #828282;
    margin-bottom: 5%;
    display: flex; /* 자식 요소를 정렬 */
    align-items: center; /* 세로 가운데 정렬 */
}

.text-input {
    width: 100%; /* 부모 박스의 100% 사용 */
    height: 100%; /* 부모 박스의 높이와 동일하게 설정 */
    border: none;
    font-size: 16px;
    padding: 0 15px;
    outline: none;
}


    /* 버튼 스타일 */
    .loginGo, .kakaoGo {
        width: 100%;
        height: 100%;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 500;
        text-align: center;
        line-height: 50px;
        cursor: pointer;
        margin-bottom: 5%;
    }

    .loginGo {
        background: #FF5C3D;
        color: white;
        margin-top: 15%;
    }

    .kakaoGo {
        background: #FBE300;
        color: black;
        position: relative;
    }

    /* 하단 텍스트 */
    .info-text, .link-button {
        font-size: 14px;
        color: black;
        text-align: center;
        cursor: pointer;
        margin-bottom: 5%;
    }
    /* a 태그 밑줄 제거*/
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
		<form id="login" action="<%= contextPath %>/member/login" method="post">
		
		    <div class="Login">LOGIN</div>
		
		    <!-- ID 입력 -->
		    <div class="idBox">
		        <input type="text" name="memberId" class="text-input" placeholder="ID">
		    </div>
		
		    <!-- 비밀번호 입력 -->
		    <div class="passBox">
		        <input type="password" name="memberPwd" class="text-input" placeholder="PASS">
		    </div>
		    <button type="submit" class="loginGo">로그인</button>
     
             <div class="info-text"><a href="/same/views/member/forgotID.jsp">아이디 찾기</a> / <a href="/same/views/member/forgotPass.jsp">비밀번호 찾기</a></div>
     
             <div class="link-button"><a href="/same/views/member/signup.jsp">회원가입</a></div>
         </form>
         </div>
    </div>
  </div>

</body>
</html>