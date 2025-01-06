<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kh.board.model.vo.*, com.kh.common.model.vo.PageInfo,com.kh.board.model.dto.BoardDTO" %>
<%
	List<Board> list = (List<Board>) request.getAttribute("list");
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage= pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>자유게시판</title>
	<style>
		/* 화면 중앙 배치 스타일 적용 */
		body {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh; /* 화면 전체 높이에 맞추기 */
			margin: 0; /* 기본 마진 제거 */
			background-color: white; /* 배경색 추가 */
		}
		.container {
			width: 100%;
			position: relative;
		}
		
		/*상세설정기본박스설정값*/
		/* 게시판스타일 시작 */
		.table {
			width: 910px;
            display: flex;
            flex-direction: column;
            font-size: 14px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px; /* 패딩 추가 */
			margin-left: 27%;
			margin-right: auto;
			margin-top: 5%;

		}
		
		.Title {
			
			width: 100%;
			font-weight: 900;
			font-size: 20px;
			text-align: left; /*텍스트 정렬*/
			padding : 9px; /*텍스트 시작 패딩 공간 설정*/
			display: flex; /* Flexbox 활성화 */
			justify-content: space-between; /* 양 끝 정렬 */
			align-items: center; /* 세로 중앙 정렬 */
			
		}
		.btn-secondary {
			padding: 10px 20px;         /* 버튼 내 여백 설정 */
			background-color: #ff5c3d;  /* 배경색 설정 */
			color: #fff;                /* 글자색 설정 */
			border: none;               /* 테두리 제거 */
			border-radius: 5px;        /* 테두리 둥글게 */
			font-size: 16px;            /* 글자 크기 설정 */
			text-align: center;         /* 텍스트 중앙 정렬 */
			cursor: pointer;            /* 커서 모양 변경 */
			display: flex;              /* Flexbox로 설정하여 내부 글씨 가로 정렬 */
			align-items: center;        /* 세로 중앙 정렬 */
			justify-content: center;    /* 가로 중앙 정렬 */
		}
		

		
		a {
			text-decoration: none; /* 링크의 밑줄 제거 */
			color: black;
		}
		
		.table-header, .table-row {
			display: grid;
			grid-template-columns: 1fr 4fr 1fr 1fr 1fr; /* 열 너비 비율 조정 */
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
		.write-button {
            background-color: #FF5C3D; /* 버튼 배경색 */
            color: white; /* 버튼 글자색 */
            border: none; /* 테두리 제거 */
            padding: 8px 12px; /* 패딩 줄이기 */
            border-radius: 5px; /* 둥근 모서리 */
            font-size: 14px; /* 글자 크기 줄이기 */
            cursor: pointer; /* 커서 포인터 */
            float: right; /* 오른쪽 정렬 */
            margin-left: 20px; /* 제목과 버튼 사이 마진 추가 */
            transition: background-color 0.3s; /* 배경색 전환 효과 */
        }
        .write-button:hover {
            background-color: #e54c2e; /* 호버시 배경색 변경 */
        }
		input.type > {
		display:none;
		}

	</style>
</head>
<body>
	<div class="main">
		<%@ include file="/views/common/mainHeader.jsp" %> <!-- 샘샘해더글 -->
		<%@ include file="/views/common/searchbar.jsp" %> <!-- 검색바 -->
	
	
		<div class="container">
			
				<div class="table">
					<%@ include file="/views/common/sidebarBoard.jsp" %> <!-- 사이드바메뉴 -->
				<div class="Title">
					<div class="PlaylistSectionTitle">자유게시판</div>
					<button class="write-button" onclick="location.href='<%= contextPath %>/board/insert'" value="a" name="boardType">글 작성</button> <!-- 글 작성 버튼 -->
				</div>
				<div class="table-header">
					<div>번호</div>
					<div class="title">글제목</div>
					<div>작성자ID</div>
					<div>작성일</div>
					<div>조회수</div>
				</div>
				<!-- 반복되는 행 -->
             <div class="table-row">
                         <%if(list.isEmpty()) { %>
                    <div colspan="6">조회된 리스트가 없습니다.</div>
			<% } else{ %>
			
			<% for (Board b : list) { %>
					<div><%= b.getRNum() %></div>
					
					<div class="title"><a href="<%= contextPath %>/board/detail?bno=<%= b.getBoardNo() %>">
					[<%= b.getCategory().getCategoryName() %>] <%= b.getBoardTitle() %></a>
					</div>
					<div><%= b.getMemberNo() %></div>
					<div><%= b.getCreateDate() %></div>
					<div><%= b.getCount() %></div>

				<% } %>
			<% } %>
				
						
				


		</div>
		<!--강의시 사용한 페이징 바-->
				<div align="center" class="paging-area">
					<% if(currentPage != 1){ %>
					<button onclick="movePage(<%= currentPage -1 %>)">&lt;</button>
					<% }%>

					<% for(int p = startPage; p <= endPage; p++) { %>
					<button onclick="movePage(<%=p %>);" <% if(currentPage == p) { %>
						class="on" <% } %>><%= p %></button>
					<% } %>

					<% if(maxPage != currentPage) { %>
					<button onclick="movePage(<%= currentPage + 1 %>)">&gt;</button>
					<% } %>
				</div>
			</div>
			<script>
				function movePage(cpage){
					location.assign('<%= contextPath %>/board/lista?cpage='+cpage);
				}
			</script>
			<!--강의시 사용한 페이징 바-->
	</div>
</div>

		
	

</body>
</html>