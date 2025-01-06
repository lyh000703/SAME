<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kh.board.model.vo.Category"%>

<% 
	
	List<Category> list = (List<Category>)  request.getAttribute("list");
	String[] boardType = (String[]) request.getAttribute("boardType");	
%>

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

.form-container {
	width: 800px;
	margin: 10px auto;
	padding: 40px;
	background: #ffffff;
	border: 1px solid #828282;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	position: relative;
	margin-left: 25%;
}

.anonymous {
	position: absolute;
	top: 10px;
	right: 40px;
	display: flex;
	align-items: center;
}

.anonymous input {
	margin-right: 5px;
}

.form-group {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
}

.form-group label {
	width: 100px;
	font-weight: bold;
	color: white;
	background: #ff5c3d;
	padding: 8px;
	text-align: center;
	border-radius: 5px;
	margin-right: 20px;
}

.form-group input[type="text"], .form-group textarea, .form-group select
	{
	flex: 1;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

.form-group textarea {
	resize: none;
	height: 120px;
}

.file-upload {
	display: flex;
	align-items: center;
}

.submit-button {
	display: block;
	margin: 20px auto;
	padding: 10px 20px;
	background-color: #ff5c3d;
	color: #fff;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-button:hover {
	background-color: #e54c2e;
}

/* 리뷰폼시작 */
#reviewForm {
	display: none; /* 초기에는 숨김 */
	width: 100%;
}

.star-rating {
    display: flex;
    gap: 5px;
    margin-left: 10px;
    align-items: center;
}

.star {
    font-size: 24px;
    color: #ddd;
    cursor: pointer;
    transition: color 0.2s;
    user-select: none;
}

.star.selected {
    color: #ffd700;
}

/* 호버 효과 */
.star:hover {
    color: #ffd700;
}
</style>
</head>
<body>
	<div class="main">
		<%@ include file="/views/common/mainHeader.jsp"%>
		<%@ include file="/views/common/searchbar.jsp"%>
		<br>
		<br>

		<div class="container">
			<%@ include file="/views/common/sidebarBoard.jsp"%>
			<div class="form-container">
				<form action="<%= contextPath%>/board/insert" method="post"
					enctype="multipart/form-data" onsubmit="return validateForm()">
					<!-- 게시판 타입 선택 -->
					<div class="form-group">
						<label for="boardType">작성게시판</label> <select id="boardType"
							name="boardType" onchange="toggleForms()">
							<% for(String str : boardType) { %>
							<option value="<%= str %>"><%=str %></option>
							<% } %>
						</select>
					</div>

					<!-- 일반 게시글 폼 -->
					<div id="normalForm">
						<div class="form-group">
							<label for="category">말머리</label> <select id="category"
								name="category">
								<% for(Category c : list) { %>
								<option value="<%= c.getCategoryName() %>"><%=c.getCategoryName() %></option>
								<% } %>
							</select>
						</div>

						<div class="form-group">
							<label for="title">제목</label> <input type="text" id="title"
								name="title" placeholder="제목을 입력하세요." required>
						</div>

						<div class="form-group">
							<label for="content">내용</label>
							<textarea id="content" name="content" placeholder="내용을 입력하세요."
								required></textarea>
						</div>
					</div>

					<!-- 리뷰 게시글 폼 -->
					<div id="reviewForm" style="display:none;">
						    <div class="form-group">
						        <label for="reviewCategory">말머리</label>
						        <select id="reviewCategory" name="category">
						            <% for(Category c : list) { %>
						                <option value="<%= c.getCategoryName() %>"><%=c.getCategoryName() %></option>
						            <% } %>
						        </select>
						    </div>
						
						    <div class="form-group">
						        <label for="reviewTitle">제목</label>
						        <input type="text" id="reviewTitle" name="title" placeholder="제목을 입력하세요." required>
						    </div>
						
							<div class="form-group">
								<label>평점</label>
								<div class="star-rating" id="starRating">
									<span class="star" data-value="1">★</span>
									<span class="star" data-value="2">★</span>
									<span class="star" data-value="3">★</span>
									<span class="star" data-value="4">★</span>
									<span class="star" data-value="5">★</span>
								</div>
								<input type="hidden" name="rating" id="ratingValue" value="">
							</div>
						
						    <div class="form-group">
						        <label for="reviewContent">내용</label>
						        <textarea id="reviewContent" name="content" placeholder="내용을 입력하세요." required></textarea>
						    </div>
						</div>

					<!-- 첨부파일 -->
					<div class="form-group">
						<label for="upfile">첨부파일</label>
						<div class="file-upload">
							<input type="file" id="upfile" name="upfile" accept="image/*">
						</div>
					</div>

					<button type="submit" class="submit-button">등록</button>
				</form>
			</div>
		</div>
	</div>

	<script>
	// 별점 기능
	function initStarRating() {
		const stars = document.querySelectorAll('.star');
		const ratingValue = document.getElementById('ratingValue');
		
		stars.forEach(star => {
			star.addEventListener('click', function() {
				const value = this.dataset.value;
				console.log('별점 클릭:', value); // 디버깅용
				
				// hidden input에 값 설정
				ratingValue.value = value;
				
				// 별점 시각적 표시
				stars.forEach(s => {
					if(parseInt(s.dataset.value) <= parseInt(value)) {
						s.classList.add('selected');
					} else {
						s.classList.remove('selected');
					}
				});
			});

			// 호버 효과
			star.addEventListener('mouseover', function() {
				const value = this.dataset.value;
				stars.forEach(s => {
					if(parseInt(s.dataset.value) <= parseInt(value)) {
						s.style.color = '#ffd700';
					}
				});
			});

			star.addEventListener('mouseout', function() {
				stars.forEach(s => {
					if(!s.classList.contains('selected')) {
						s.style.color = '#ddd';
					}
				});
			});
		});
	}
	
	
	function validateForm() {
		const boardType = document.getElementById('boardType').value;
		let title, content;
		
		console.log('폼 검증 시작');
		console.log('게시판 타입:', boardType);
		
		if(boardType === '리뷰') {
			title = document.getElementById('reviewTitle').value.trim();
			content = document.getElementById('reviewContent').value.trim();
			const rating = document.getElementById('ratingValue').value;
			
			console.log('리뷰 데이터:', { title, content, rating });
			
			if(!rating) {
				alert('평점을 선택해주세요.');
				return false;
			}
			
			if(!title || !content) {
				alert('제목과 내용을 모두 입력해주세요.');
				return false;
			}
		} else {
			title = document.getElementById('title').value.trim();
			content = document.getElementById('content').value.trim();
			
			console.log('일반 게시글 데이터:', { title, content });
			
			if(!title || !content) {
				alert('제목과 내용을 모두 입력해주세요.');
				return false;
			}
		}
		
		console.log('폼 검증 통과');
		return true;
	}

	// 폼 전환 함수 수정
	function toggleForms() {
	    const boardType = document.getElementById('boardType').value;
		const normalForm = document.getElementById('normalForm');
		const reviewForm = document.getElementById('reviewForm');
		
		console.log('게시판 전환:', boardType);
		
		if(boardType === '리뷰') {
			normalForm.style.display = 'none';
			reviewForm.style.display = 'block';
			
			// 일반 폼 필드 비활성화
			document.getElementById('title').value = '';
			document.getElementById('content').value = '';
			document.getElementById('title').disabled = true;
			document.getElementById('content').disabled = true;
			
			// 리뷰 폼 필드 활성화
			document.getElementById('reviewTitle').disabled = false;
			document.getElementById('reviewContent').disabled = false;
			
			// 별점 초기화
			document.getElementById('ratingValue').value = '';
			document.querySelectorAll('.star').forEach(s => {
				s.classList.remove('selected');
			});
			
		} else {
			normalForm.style.display = 'block';
			reviewForm.style.display = 'none';
			
			// 리뷰 폼 필드 비활성화
			document.getElementById('reviewTitle').value = '';
			document.getElementById('reviewContent').value = '';
			document.getElementById('reviewTitle').disabled = true;
			document.getElementById('reviewContent').disabled = true;
			
			// 일반 폼 필드 활성화
			document.getElementById('title').disabled = false;
			document.getElementById('content').disabled = false;
		}
	}

	// 페이지 로드 시 초기화
	document.addEventListener('DOMContentLoaded', function() {
		console.log('페이지 로드됨');
	    toggleForms();
		initStarRating(); // 별점 기능 초기화 추가
	});
    </script>
</body>
</html>