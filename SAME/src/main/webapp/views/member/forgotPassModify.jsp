<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인/비밀번호 확인</title>
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
        gap: 20px; 
        margin-top: 5%;
    }

    .bigBox {
        width: 500px;
        height: 50px;
    }
    
    .forgotText {
        text-align: center;
        font-size: 22px; 
        font-weight: 600;
        margin-bottom: 40%; 
        color: black; 
    }
        .forgotText input {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .btn-id {
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

    .btn-id {
        background: #FF5C3D;
        color: white;
    }

    a{
    text-decoration-line : none;
    color: white;
    }
  </style>
</head>
<body>
  <div class="main">
    <%@ include file="/views/common/mainHeader.jsp"%>
    <div class="set">
        
        <div class="bigBox">
        <form id="forgotPassModify" action="/same/member/forgotPassModify" method="post">
             <!-- 찾은 아이디 출력 -->
	        <div class="forgotText">
	          	<input type="hidden" name="memberId" value="${memberId}" />
	            <input type="password" name="newPassword" placeholder="새 비밀번호" required />
	            <input type="password" name="confirmPassword" placeholder="비밀번호 확인" required />
	        </div>
             <!-- <div class="forgotText">가입하신 이메일주소로 새로운 비밀번호가 전송되었습니다.</div> -->
             <div type="submit" class="btn-id"><a href="javascript:document.querySelector('#forgotPassModify').submit()">비밀번호 변경</a></div>
             <div class="btn-id"><a href="/same">메인으로</a></div>
         </form>
         </div>
    </div>
  </div>

</body>
</html>