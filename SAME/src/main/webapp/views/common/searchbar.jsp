<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* headbar start*/
.head-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
	margin-top: 10px;
}

.head-bar a {
	text-decoration: none;
}

.little-same {
	font-size: 20px;
	font-weight: bold;
	color: #FF5C3D;
}

.head-item {
	font-size: 15px;
	color: black;
}

.search {
	position: relative;
	display: flex;
	align-items: center;
}

.search-input {
	width: 300px;
	padding: 10px 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #f2f2f2;
	color: black;
}

.search-btn {
	padding: 10px 20px;
	background-color: #FF5C3D;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-left: 5px;
}

.search-btn:hover {
	background-color: #ff4424;
	/* 링크 스타일 */
	a {
	text-decoration : none;
	}
}
/*headbar end*/
</style>
<script>
function performSearch() {
	const searchInput = document.querySelector('.search-input');
	const keyword = searchInput.value.trim();
	const contextPath = '<%= request.getContextPath() %>'; 
	
	if (keyword) {
		window.location.href = contextPath + '/search?keyword=' + encodeURIComponent(keyword);
	} else {
		alert('검색어를 입력하세요.');
		searchInput.focus();
	}
}

// 엔터키 이벤트 처리
document.addEventListener('DOMContentLoaded', function() {
	const searchInput = document.querySelector('.search-input');
	
	searchInput.addEventListener('keypress', function(e) {
		if (e.key === 'Enter') {
			e.preventDefault();
			performSearch();
		}
	});
});
</script>
</head>
<body>
	<div class="head-bar">
		<a href="<%=contextPath%>" class="little-same">SAME SAME</a> 
		<a href="<%=contextPath%>/search/profile" class="head-item">쌤찾기</a> 
		<a href="<%=contextPath%>/board/list" class="head-item">커뮤니티</a>
		<form class="search" onsubmit="event.preventDefault(); performSearch();">
			<input type="text" class="search-input" placeholder="어떤 서비스가 필요하세요?" 
				   value="${param.keyword != null ? param.keyword : ''}" />
			<button type="submit" class="search-btn">검색</button>
		</form>
		<% if(loginUser == null) { %>
			<a href="<%=contextPath%>/member/login">로그인</a>
			<a href="<%=contextPath%>/member/myPage" class="head-item">마이페이지</a>
		<% } else { %>
			<b><%=loginUser.getMemberName()%>님 환영합니다.</b>
			<% 
            String memberNo = loginUser.getMemberNo();
            char firstChar = memberNo.charAt(0); // MEMBER_NO의 첫 글자 확인
        	%>
			<% if (firstChar == 'B') { %>
				
				<a href="<%= contextPath %>/views/member/mentorPage/main.jsp">마이페이지</a> 
			<% } else if (firstChar == 'A') { %>
				<a href="<%= contextPath %>/views/member/menteePage/main.jsp">마이페이지</a> 
			<% } %>
			<a href="<%= contextPath %>/member/logout">로그아웃</a>
		<% } %>
	</div>
</body>
</html>