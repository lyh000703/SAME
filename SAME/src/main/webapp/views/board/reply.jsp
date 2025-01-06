<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

        .comment-container {
            width: 800px;
            margin: 0 auto;
            padding: 5px;
        }

        .comment-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .comment-input {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .comment-input textarea {
            flex: 1;
            resize: none;
            height: 70px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }

        .comment-input button {
            padding: 10px 20px;
            background-color: #ff5c3d;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .comment-input button:hover {
            background-color: #e54c2e;
        }

        .anonymous-checkbox {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .anonymous-checkbox input {
            margin-right: 5px;
        }

        .comment-list {
            margin-top: 20px;
        }

        .comment {
            display: flex;
            flex-direction: column;
            background: #f7f7f7;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .comment-user {
            font-weight: bold;
            margin-right: 10px;
        }
        .comment-date{
            color: #828282;
            font-size: small;
            font-weight: normal;
        }

        .comment-text {
            margin: 10px 0;
        }

        .comment-actions {
            display: flex;
            gap: 10px;
            margin: 10px 0;
        }

        .comment-actions button {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
            color: #ff5c3d;
        }

        .reply-input {
            margin-top: 10px;
            display: flex;
            flex-direction: column; /* 세로로 정렬 */
            gap: 10px;
        }

        .reply-input textarea {
            flex: 1;
            resize: none;
            height: 50px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .reply-actions {
            display: flex;
            align-items: center;
            justify-content: space-between; /* 버튼과 체크박스를 적절히 배치 */
            gap: 10px; /* 간격 조정 */
        }

        .reply-actions button {
            flex-shrink: 0;
            padding: 10px 20px;
            background-color: #ff5c3d;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .reply-actions button:hover {
            background-color: #e54c2e;
        }

        .reply-anonymous-checkbox {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 팝업 스타일 */
        .comment-popup-overlay {
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

        .comment-popup {
            background: white;
            border-radius: 10px;
            padding: 20px;
            width: 400px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .comment-popup-header {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .comment-form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
            align-items: flex-start;
        }
        .comment-form-group>#details {
            width: 380px;
        }

        .comment-form-group label {
            font-weight: bold;
            color: white;
            background-color: #ff5c3d;
            padding: 5px 10px;
            border-radius: 5px;
            margin-bottom: 5px;
        }

        .comment-form-group select,
        .comment-form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }

        .comment-popup-actions {
            margin-top: 20px;
        }

        .comment-popup-actions button {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            margin: 0 5px;
        }

        .comment-popup-actions .cancel-btn {
            background-color: #ccc;
            color: white;
        }

        .comment-popup-actions .submit-btn {
            background-color: #ff5c3d;
            color: white;
        }
    </style>
</head>
<body>
    <div class="comment-container">
        <div class="comment-header">댓글작성</div>
        <div class="comment-input">
            <textarea id="commentText" placeholder="댓글을 입력하세요."></textarea>
            <button id="addCommentBtn">등록</button>
        </div>
        <div class="comment-anonymous-checkbox">
            <input type="checkbox" id="anonymousCheckbox">
            <label for="anonymousCheckbox">익명</label>
        </div>
        <div class="comment-list" id="commentList"></div>
    </div>

    <!-- 신고 팝업 -->
    <div class="comment-popup-overlay" id="popupOverlay">
        <div class="comment-popup">
            <div class="comment-popup-header">신고하기</div>
            <div class="comment-form-group">
                <label for="reason">말머리</label>
                <select id="reason">
                    <option value="욕설/비방">욕설/비방</option>
                    <option value="스팸">스팸</option>
                    <option value="부적절한 내용">부적절한 내용</option>
                </select>
            </div>
            <div class="comment-form-group">
                <label for="details">내용</label>
                <textarea id="details" placeholder="신고 내용을 입력하세요."></textarea>
            </div>
            <div class="comment-popup-actions">
                <button class="cancel-btn" id="cancelPopup">취소</button>
                <button class="submit-btn" id="submitReport">신고</button>
            </div>
        </div>
    </div>

    <script>
        const commentList = document.getElementById('commentList');
        const commentText = document.getElementById('commentText');
        const anonymousCheckbox = document.getElementById('anonymousCheckbox');
        const addCommentBtn = document.getElementById('addCommentBtn');
        const popupOverlay = document.getElementById('popupOverlay');
        const cancelPopup = document.getElementById('cancelPopup');
        const submitReport = document.getElementById('submitReport');

        let currentTarget = null; // 신고 타겟 저장

        // 댓글 추가 이벤트
        addCommentBtn.addEventListener('click', () => {
            const text = commentText.value.trim();
            const isAnonymous = anonymousCheckbox.checked;

            if (text === '') {
                alert('댓글을 입력해주세요.');
                return;
            }

            const comment = document.createElement('div');
            comment.className = 'comment';

            const header = document.createElement('div');
            header.className = 'comment-header';

            const user = document.createElement('div');
            user.className = 'comment-user';
            user.textContent = isAnonymous ? '익명' : 'user01';

            const date = document.createElement('div');
            date.className = 'comment-date';
            date.textContent = new Date().toISOString().slice(0, 10);

            header.appendChild(user);
            header.appendChild(date);

            const content = document.createElement('div');
            content.className = 'comment-text';
            content.textContent = text;

            const actions = document.createElement('div');
            actions.className = 'comment-actions';

            const replyButton = document.createElement('button');
            replyButton.textContent = '답글';
            replyButton.addEventListener('click', () => {
            const replyInput = document.createElement('div');
            replyInput.className = 'reply-input';

            // 답글 입력창
            const replyTextarea = document.createElement('textarea');
            replyTextarea.placeholder = '답글을 입력하세요.';

            // 익명 체크박스
            const anonymousContainer = document.createElement('div');
            anonymousContainer.className = 'reply-anonymous-checkbox';

            const anonymousCheckbox = document.createElement('input');
            anonymousCheckbox.type = 'checkbox';
            anonymousCheckbox.id = `replyAnonymousCheckbox${Date.now()}`;

            const anonymousLabel = document.createElement('label');
            anonymousLabel.htmlFor = anonymousCheckbox.id;
            anonymousLabel.textContent = '익명';

            anonymousContainer.appendChild(anonymousCheckbox);
            anonymousContainer.appendChild(anonymousLabel);

            // 등록 버튼
            const submitReplyButton = document.createElement('button');
            submitReplyButton.textContent = '등록';

            submitReplyButton.addEventListener('click', () => {
                const replyText = replyTextarea.value.trim();
                const isAnonymous = anonymousCheckbox.checked;

                if (replyText === '') {
                    alert('답글을 입력해주세요.');
                    return;
                }

                const reply = document.createElement('div');
                reply.className = 'comment';
                reply.style.marginLeft = '20px';// 답글들여쓰기

                const replyHeader = document.createElement('div');
                replyHeader.className = 'comment-header';

                const replyUser = document.createElement('div');
                replyUser.className = 'comment-user';
                replyUser.textContent = isAnonymous ? '익명' : 'user01';

                const replyDate = document.createElement('div');
                replyDate.className = 'comment-date';
                replyDate.textContent = new Date().toISOString().slice(0, 10);

                replyHeader.appendChild(replyUser);
                replyHeader.appendChild(replyDate);

                const replyContent = document.createElement('div');
                replyContent.className = 'comment-text';
                replyContent.textContent = replyText;

                const replyActions = document.createElement('div');
                replyActions.className = 'comment-actions';

                 // 삭제 버튼
                const deleteReplyButton = document.createElement('button');
                deleteReplyButton.textContent = '삭제';
                deleteReplyButton.addEventListener('click', () => reply.remove());

                // 신고 버튼
                const reportReplyButton = document.createElement('button');
                reportReplyButton.textContent = '신고';
                reportReplyButton.addEventListener('click', () => {
                    currentTarget = reply; // 현재 답글을 신고 대상으로 설정
                    popupOverlay.style.display = 'flex';
                });



                replyActions.appendChild(deleteReplyButton);
                replyActions.appendChild(reportReplyButton);

                reply.appendChild(replyHeader);
                reply.appendChild(replyContent);
                reply.appendChild(replyActions);

                comment.appendChild(reply);
                replyInput.remove(); // 입력창 제거
            });

            // 버튼과 익명 체크박스를 배치
            const replyActions = document.createElement('div');
            replyActions.className = 'reply-actions';
            replyActions.appendChild(anonymousContainer);
            replyActions.appendChild(submitReplyButton);

            replyInput.appendChild(replyTextarea); // 입력창
            replyInput.appendChild(replyActions); // 버튼 + 체크박스
            comment.appendChild(replyInput);
        });
            const deleteButton = document.createElement('button');
            deleteButton.textContent = '삭제';
            deleteButton.addEventListener('click', () => comment.remove());

            const reportButton = document.createElement('button');
            reportButton.textContent = '신고';
            reportButton.addEventListener('click', () => {
                currentTarget = comment; // 현재 댓글 또는 답글 저장
                popupOverlay.style.display = 'flex';
            });

            actions.appendChild(replyButton);
            actions.appendChild(deleteButton);
            actions.appendChild(reportButton);

            comment.appendChild(header);
            comment.appendChild(content);
            comment.appendChild(actions);

            commentList.appendChild(comment);
            commentText.value = '';
        });

        // 팝업 닫기 이벤트
        cancelPopup.addEventListener('click', () => {
            popupOverlay.style.display = 'none';
        });

        // 신고 접수 이벤트
        submitReport.addEventListener('click', () => {
            const reason = document.getElementById('reason').value;
            const details = document.getElementById('details').value.trim();

            if (details === '') {
                alert('신고 내용을 입력해주세요.');
                return;
            }

            alert(`신고가 접수되었습니다.\n말머리: ${reason}\n내용: ${details}`);
            popupOverlay.style.display = 'none';
        });
    </script>
</body>
</html>