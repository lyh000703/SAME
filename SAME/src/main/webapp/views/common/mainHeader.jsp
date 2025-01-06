<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="com.kh.member.model.vo.Member" %>
<%
Member loginUser = (Member) session.getAttribute("loginUser");
System.out.println(loginUser);

String alertMsg = (String)session.getAttribute("alertMsg");
String contextPath = request.getContextPath(); // /same
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: auto;
	margin: 0; /* 기본 margin 제거 */
}

.main {
	width: 1440px;
	position: relative;
	background: rgb(255, 255, 255);
	display: flex;
	flex-direction: column; /* 수직 정렬 */
	align-items: center; /* 수평 중앙 정렬 */
	justify-content: flex-start; /* 상단에 배치 */
}


/* SAME SAME 로고 */
.SameSame {
	color: #FF5C3D;
	font-size: 128px;
	font-family: Prompt, sans-serif;
	font-weight: 700;
	text-align: center;
	margin-top: 20px; /* 상단 여백 */
}

/* 링크 스타일 */
a {
	text-decoration : none;
	color: black;
}
</style>
</head>
<body>
	<div class="main">
		<div class="SameSame"><a href="<%=contextPath%>" style="color: #FF5C3D;">SAME SAME</a></div>
	</div>
</body>
</html>