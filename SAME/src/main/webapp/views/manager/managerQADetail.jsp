<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, 
                 com.kh.board.model.vo.Board,
                 com.kh.board.model.vo.Category,
                 com.kh.board.model.vo.Attachment,
                 com.kh.board.model.dto.BoardDTO" %>
<%
    BoardDTO boardDTO = (BoardDTO)request.getAttribute("board");
    
    // boardDTO가 null인 경우 처리
    if(boardDTO == null) {
        request.setAttribute("errorMsg", "게시글 정보를 찾을 수 없습니다.");
        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        return;
    }
    
    Board board = boardDTO.getB();
    int cPage = 1;
    
    Integer currentPage = (Integer)request.getAttribute("cPage");
    if(currentPage != null) {
        cPage = currentPage;
    }
    
    Category c = board.getCategory();
    Attachment at = boardDTO.getAt();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의게시판 상세보기</title>
<style>
    /* 기존 CSS 스타일 유지 */
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
        min-height: 100vh;
        padding-bottom: 40px;
    }
    
    .detail-container {
        width: 800px;
        background: white;
        border: 1px solid #828282;
        border-radius: 10px;
        padding: 20px;
        position: relative;
        margin-left: 25%;
        margin-bottom: 20px;
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
    
    /* 답변 섹션 스타일 */
    .answer-section {
        width: 800px;
        background: white;
        border: 1px solid #828282;
        border-radius: 10px;
        padding: 20px;
        margin-left: 25%;
        margin-top: 20px;
    }
    
    .answer-container {
        width: 100%;
    }
    
    .answer-container h3 {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 20px;
        color: #333;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    #answerContent {
        width: 100%;
        min-height: 150px;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
        resize: vertical;
    }
    
    .answer-submit {
        background-color: #FF5C3D;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        float: right;
    }
    
    .answer-submit:hover {
        background-color: #ff4424;
    }
    
    .existing-answer {
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 5px;
        padding: 20px;
        margin-bottom: 20px;
    }
    
    .answer-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .answer-date {
        color: #666;
        font-size: 14px;
    }
    
    .answer-content {
        font-size: 16px;
        line-height: 1.6;
        color: #333;
    }
    
    /* 답변 상태 표시 */
    .answer-status {
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: 500;
        margin-left: 10px;
    }
    
    .answer-status.waiting {
        background-color: #ffd7d1;
        color: #FF5C3D;
    }
    
    .answer-status.answered {
        background-color: #d1ffd7;
        color: #28a745;
    }
    
    /* 게시글 상세보기 테이블 스타일 */
    .qa-detail-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    .qa-detail-table td {
        border: 1px solid #ddd;
        padding: 15px;
    }

    .label-cell {
        width: 120px;
        background-color: #FF5C3D;
        color: white;
        text-align: center;
        font-weight: bold;
    }

    .content-cell {
        background-color: white;
    }

    /* 내용 영역 */
    .content-area {
        min-height: 150px;
        padding: 20px;
        line-height: 1.6;
    }

    /* 답변 영역 스타일 */
    .answer-section {
        margin-top: 30px;
    }

    .answer-table {
        width: 100%;
        border-collapse: collapse;
    }

    .answer-table td {
        border: 1px solid #ddd;
        padding: 15px;
    }

    .answer-textarea {
        width: 95%;
        min-height: 150px;
        padding: 15px;
        border: 1px solid #ddd;
        resize: vertical;
    }

    .submit-btn {
        background-color: #FF5C3D;
        color: white;
        border: none;
        padding: 10px 20px;
        float: right;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px;
    }

    /* 버튼 컨테이너 스타일 */
    .button-container {
        display: flex;
        justify-content: flex-end;
        gap: 10px;  /* 버튼 사이 간격 */
        margin-top: 10px;
    }

    /* 버튼 공통 스타일 */
    .btn {
        background-color: #FF5C3D;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 14px;
    }

    .btn:hover {
        background-color: #ff4424;
    }
</style>
</head>
<body>
    <div class="main">
        <%@ include file="/views/common/mainHeader.jsp" %>
        
        <div class="container">
            <%@ include file="/views/common/sidebarManager.jsp" %>
            
            <!-- 게시글 상세 정보 컨테이너 -->
            <div class="detail-container">
                <div class="detail-header">
                    <span class="category">
                        <%= c != null ? c.getCategoryName() : "카테고리 없음" %>
                    </span>
                    <h2 class="detail-title"><%= board.getBoardTitle() %></h2>
                    <span class="detail-user"><%= board.getMemberNo() %></span>
                    <span class="detail-date"><%= board.getCreateDate() %></span>
                    <span class="detail-count">조회수: <%= board.getCount() %></span>
                </div>
                <hr>
                <div class="detail-content">
                    <%= board.getBoardContent() %>
                </div>
                
                <% if(at != null && at.getFilePath() != null && at.getChangedName() != null) { %>
                    <div class="image-container">
                        <img src="<%= request.getContextPath() %><%= at.getFilePath() + at.getChangedName() %>" 
                             alt="첨부이미지"
                             onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/resources/images/noimage.png';">
                    </div>
                <% } %>
            </div>
            
            <!-- 답변 섹션을 detail-container 밖으로 이동 -->
            <div class="answer-section">
                <form id="answerForm" action="<%= request.getContextPath() %>/manager/answer" method="post">
                    <input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>">
                    <input type="hidden" name="currentPage" value="<%= cPage %>">
                    <table class="answer-table">
                        <tr>
                            <td class="label-cell">관리자답변</td>
                            <td class="content-cell">
                                <textarea class="answer-textarea" name="answerContent" 
                                        placeholder="답변을 입력하세요."><%= boardDTO.getAnswer() != null ? boardDTO.getAnswer() : "" %></textarea>
                            </td>
                        </tr>
                    </table>
                    <div class="button-container">
                        <button type="button" class="btn" onclick="location.href='<%= request.getContextPath() %>/manager/listc?cpage=<%= cPage %>'">
                            목록으로
                        </button>
                        <button type="submit" class="btn">
                            <%= boardDTO.getAnswerStatus() != null && boardDTO.getAnswerStatus().equals("Y") ? "답변 수정" : "답변 등록" %>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('answerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const answerContent = document.getElementById('answerContent').value.trim();
            if(!answerContent) {
                alert('답변 내용을 입력해주세요.');
                return;
            }
            
            const formData = new FormData(this);
            
            fetch('<%= request.getContextPath() %>/manager/answer', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if(!response.ok) {
                    throw new Error('서버 응답 오류');
                }
                return response.json();
            })
            .then(data => {
                if(data.success) {
                    alert('답변이 성공적으로 등록되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '답변 등록에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('답변 등록 중 오류가 발생했습니다.');
            });
        });
    </script>
</body>
</html>