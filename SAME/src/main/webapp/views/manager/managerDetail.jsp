<%@ page 
    language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.kh.board.model.vo.*, 
            com.kh.board.model.dto.BoardDTO,
            com.kh.manager.model.vo.*" 
%>
<%
    try {
        // null 체크 및 예외 처리 개선
        BoardDTO b = (BoardDTO) request.getAttribute("b");
        int cPage = 1; // 기본값 설정
        
        // 현재 페이지 정보 가져오기 - null 체크 추가
        Integer currentPage = (Integer)request.getAttribute("cPage");
        if(currentPage != null) {
            cPage = currentPage;
        }
        
        if(b == null) {
            request.setAttribute("errorMsg", "게시글 정보를 찾을 수 없습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            return;
        }
        
        Board board = b.getB();
        if(board == null) {
            request.setAttribute("errorMsg", "게시글 상세 정보를 찾을 수 없습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            return;
        }
        
        Category c = board.getCategory();
        Attachment at = b.getAt();
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

.detail-container {
	width: 800px;
	background: white;
	border: 1px solid #828282;
	border-radius: 10px;
	padding: 20px;
	position: relative;
	margin-left: 25%;
}

.detail-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.category {
	color: #828282;
	font-size: 20px;
	font-weight: 500;
	margin-right: 10px;
}

.detail-title {
	font-size: 24px;
	font-weight: 500;
	flex: 1;
}

.detail-user {
	font-size: 20px;
	font-weight: 700;
}

.detail-date {
	font-size: 20px;
	font-weight: 500;
	color: #454545;
	margin-left: 10px;
	margin-right: 10px;
}

.detail-content {
	font-size: 20px;
	margin: 10px 20px;
}

.image-container {
	text-align: center;
	margin: 20px 0;
}

.report {
	text-align: right;
	margin: 10px;
}

.report-button {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 0;
}

.report-icon {
	width: 24px;
	height: 24px;
	display: inline-block;
	background-color: #FF5C3D;
	border-radius: 50%;
	position: relative;
}

.report-icon::before {
	content: '!';
	color: white;
	font-size: 16px;
	font-weight: bold;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

/* 팝업 스타일 */
.popup-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
}

.popup {
	background: white;
	border-radius: 10px;
	padding: 20px;
	width: 400px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	animation: fadeIn 0.3s ease;
}

.popup-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.popup-title {
	font-size: 20px;
	font-weight: bold;
}

.popup-close {
	background: none;
	border: none;
	font-size: 20px;
	cursor: pointer;
}

.popup-content {
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
}

.form-group label {
	width: 80px;
	font-weight: bold;
	color: white;
	background: #ff5c3d;
	padding: 8px;
	text-align: center;
	border-radius: 5px;
	margin-right: 20px;
}

.form-group select, .form-group textarea {
	flex: 1;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

.form-group textarea {
	resize: none;
	height: 100px;
}

.submit-button {
	display: block;
	margin: 0 auto;
	padding: 10px 10px;
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

@
keyframes fadeIn {from { opacity:0;
	transform: scale(0.9);
}

to {
	opacity: 1;
	transform: scale(1);
}
}
</style>
</head>
<body>
	<div class="main">
        <%@ include file="/views/common/mainHeader.jsp"%>
       
        <div class="container">
            <%@ include file="/views/common/sidebarManager.jsp"%>
            
            <div class="detail-container">
                <div class="detail-header">
                    <!-- null 체크 추가 -->
                    <span class="category">
                        <%= c != null ? c.getCategoryName() : "카테고리 없음" %>
                    </span>
                    <h2 class="detail-title">
                        <%= board.getBoardTitle() != null ? board.getBoardTitle() : "제목 없음" %>
                    </h2>
                    <span class="detail-user">
                        <%= board.getMemberNo() != null ? board.getMemberNo() : "작성자 정보 없음" %>
                    </span>
                    <span class="detail-date">
                        <%= board.getCreateDate() != null ? board.getCreateDate() : "작성일 정보 없음" %>
                    </span>
                    <span class="detail-count">조회수: <%= board.getCount() %></span>
                </div>
                <hr>
                <div class="detail-content">
                    <%= board.getBoardContent() != null ? board.getBoardContent() : "내용 없음" %>
                </div>
                
				<!-- 이미지 -->
				 <% if(at != null && at.getFilePath() != null && at.getChangedName() != null) { %>
                    <div class="image-container">
                        <img src="<%= request.getContextPath() %><%= at.getFilePath() + at.getChangedName() %>" 
                             alt="첨부이미지"
                             onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/resources/images/noimage.png';">
                    </div>
                <% } %>

				 <!-- 목록으로 돌아가기 버튼 수정 -->
				 <div class="button-container">
					<%
						// 게시판 유형 확인
						char boardType = board.getBoardType();
						String listUrl = "";
						
						// 게시판 유형에 따른 URL 설정
						switch(boardType) {
							case 'A':
								listUrl = "/manager/lista";
								break;
							case 'B':
								listUrl = "/manager/listb";
								break;
							case 'C':
								listUrl = "/manager/listc";
								break;
							default:
								listUrl = "/manager/lista"; // 기본값
						}
					%>
					<button onclick="location.href='<%= request.getContextPath() %><%= listUrl %>?cpage=<%= cPage %>'">
						목록으로
					</button>
				</div>

				<!-- 신고 버튼 -->
				<div class="report">
					<button type="button" class="report-button" onclick="showReportPopup()">
						<span class="report-icon"></span>
					</button>
				</div>

				<!-- 신고 팝업 -->
				<div class="popup-overlay" id="popupOverlay">
					<div class="popup">
						<div class="popup-header">
							<span class="popup-title">신고하기</span>
							<button class="popup-close" id="popupCloseBtn">&times;</button>
						</div>
						<div class="popup-content">
							<form id="reportForm">
								말머리
								<div class="form-group">
									<label for="reason">말머리</label> <select id="reason"
										name="reason">
										<option value="욕설/비방">욕설/비방</option>
										<option value="스팸">스팸</option>
										<option value="부적절한 내용">부적절한 내용</option>
									</select>
								</div> 

								<!-- 내용 -->
								<div class="form-group">
									<label for="details">내용</label>
									<textarea id="details" name="details"
										placeholder="신고 사유를 입력하세요."></textarea>
								</div>
								<button type="submit" class="submit-button">신고</button>
							</form>
						</div>
					</div>
				</div>
				<%@ include file="/views/board/reply.jsp"%>
			</div>
		</div>
	</div>

		<script>
			 // JavaScript 에러 처리 추가
		    document.addEventListener('DOMContentLoaded', function() {
		        const reportBtn = document.getElementById('reportBtn');
		        const popupOverlay = document.getElementById('popupOverlay');
		        const popupCloseBtn = document.getElementById('popupCloseBtn');
		        
		        if(reportBtn && popupOverlay && popupCloseBtn) {
		            reportBtn.addEventListener('click', () => {
		                popupOverlay.style.display = 'flex';
		            });
		            
		            popupCloseBtn.addEventListener('click', () => {
		                popupOverlay.style.display = 'none';
		            });
		        }
		        
		        const reportForm = document.getElementById('reportForm');
		        if(reportForm) {
		            reportForm.addEventListener('submit', (e) => {
		                e.preventDefault();
		                const reason = document.getElementById('reason').value;
		                const details = document.getElementById('details').value;
		                
		                if(!reason || !details) {
		                    alert('신고 사유와 내용을 모두 입력해주세요.');
		                    return;
		                }
		                
		                alert(`신고가 접수되었습니다.\n말머리: ${reason}\n내용: ${details}`);
		                popupOverlay.style.display = 'none';
		            });
		        }
		    });
        </script>

</body>
</html>

<%
    } catch(Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMsg", "게시글 조회 중 오류가 발생했습니다.");
        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
    }
%>