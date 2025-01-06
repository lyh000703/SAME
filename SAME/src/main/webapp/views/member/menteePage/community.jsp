<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kh.board.model.vo.Board, com.kh.common.model.vo.PageInfo, com.kh.member.model.vo.Member" %>
<%
    List<Board> list = (List<Board>) request.getAttribute("list");
    PageInfo pi = (PageInfo) request.getAttribute("pi");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 전체글</title>
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
	flex-direction: column; /*태그 컬럼형식으로 표기*/
	display: flex;
	font-size: 14px;
	/* border-collapse: collapse; 테이블 경계 합치기 */
	/* font-family: 'Inter', sans-serif;  본문 글꼴 설정*/
	background-color: #fff; /* 배경색 추가로 테이블 강조 */
	border: 1px solid #ddd; /* 테두리 추가 */
	border-radius: 5px; /* 테두리 둥글게 */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
	margin-left: 27%;
	margin-right: auto;
	margin-top: 5%;
}

.Title {
	width: 100%;
	font-weight: 900;
	font-size: 20px;
	text-align: left; /*텍스트 정렬*/
	padding-left: 20px; /*텍스트 시작 패딩 공간 설정*/
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
</style>
</head>
<body>
    <div class="main">
        <%@ include file="/views/common/mainHeader.jsp"%>
        <%@ include file="/views/common/searchbar.jsp"%>

        <div class="container">
            <div class="table">
               <%@ include file="/views/common/sidebarMentee.jsp"%>
                <div class="Title">
                    <div class="PlaylistSectionTitle">
                       <%=loginUser.getMemberName()%>님 게시글
                    </div>
                </div>

                <!-- 게시글 목록 -->
                <div id="posts-tab" class="tab-content active">
                    <div class="table-header">
                        <div>번호</div>
                        <div class="title">글제목</div>
                        <div>작성일</div>
                        <div>조회수</div>
                        <div>관리</div>
                    </div>
                   <%
    if (list == null || list.isEmpty()) {
%>
    <div class="table-row">
        <div colspan="5" style="text-align: center;">작성한 게시글이 없습니다.</div>
    </div>
<%
    } else {
        for (Board b : list) {
            if (loginUser.getMemberNo().equals(b.getMemberNo())) {
%>
    <div class="table-row">
        <div><%= b.getBoardNo() %></div>
        <div class="title">
            <a href="<%= request.getContextPath() %>/board/detail?bno=<%= b.getBoardNo() %>">
                [<%= b.getCategory().getCategoryName() %>] <%= b.getBoardTitle() %>
            </a>
        </div>
        <div><%= b.getCreateDate() %></div>
        <div><%= b.getCount() %></div>
        <div class="manage-buttons">
            <button onclick="modifyPost(<%= b.getBoardNo() %>)">수정</button>
            <button onclick="deletePost(<%= b.getBoardNo() %>)">삭제</button>
        </div>
    </div>
<%
            }
        }
    }
%>
                </div>

               <!-- 댓글 목록 -->
            <div class="tab-content">
                <div class="table-header">
                    <div>번호</div>
                    <div>댓글내용</div>
                    <div>작성일</div>
                    <div>관리</div>
                </div>
                <div id="comments-container">
                    <div class="table-row">
                        <div colspan="4" style="text-align: center;">작성한 댓글이 없습니다.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const contextPath = '<%= contextPath %>';

    // 탭 전환 함수
    function showTab(tabName) {
        const tabs = document.querySelectorAll('.tab-content');
        const buttons = document.querySelectorAll('.tab-button');
        
        tabs.forEach(tab => tab.classList.remove('active'));
        buttons.forEach(button => button.classList.remove('active'));
        
        document.getElementById(tabName + '-tab').classList.add('active');
        event.target.classList.add('active');
        
        if (tabName === 'comments') {
            loadComments();
        }
    }

    // 댓글 목록 로드
    function loadComments() {
    	fetch(contextPath + '/board/myComments')
        .then(response => response.json())
        .then(data => {
            const commentsContainer = document.getElementById('comments-container');
            commentsContainer.innerHTML = '';
            if (data.length === 0) {
                commentsContainer.innerHTML = '<div>작성한 댓글이 없습니다.</div>';
            } else {
                data.forEach(comment => {
                    const row = `
                        <div class="table-row">
                            <div>${comment.commentNo}</div>
                            <div>${comment.content}</div>
                            <div>${comment.createDate}</div>
                            <div class="manage-buttons">
                                <button onclick="modifyComment(${comment.commentNo})">수정</button>
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </div>
                        </div>`;
                    commentsContainer.innerHTML += row;
                });
            }
        });
    	}

    // 게시글 수정
   function modifyPost(boardNo) {
    location.href = contextPath + '/board/updateForm?bno=' + boardNo;
}

    // 게시글 삭제
   function deletePost(boardNo) {
    if (confirm('정말 삭제하시겠습니까?')) {
        location.href = contextPath + '/board/delete?bno=' + boardNo;
    }
}

    // 댓글 수정
    function modifyComment(commentNo) {
        location.href = contextPath + '/comment/updateForm?cno=' + commentNo;
    }

    // 댓글 삭제
    function deleteComment(commentNo) {
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = contextPath + '/comment/delete?cno=' + commentNo;
        }
    }

    // 페이지 로드 시 게시글 탭 활성화
   document.addEventListener('DOMContentLoaded', function() {
    console.log('페이지 로드 완료');
});
</script>
</body>
</html>