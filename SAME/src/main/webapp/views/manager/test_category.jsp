<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>


  <style>
    /* 메인화면기준 중앙 배치 스타일 적용 */
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
    /*상세시작*/
    
    h1 {
            text-align: center;
            background-color: #FF5C3D;
            color: white;
            margin: auto;
        }

    .category-management {
        display: flex;
        width: 100%;
        justify-content: space-between;
        
    }

    .existing-categories, .details {
        width: 45%;
    }

    h2 {
        font-size: 1.2em;
    }

    ul {
        list-style: none;
        padding: 0;
        border: 1px solid #ccc;
        height: 350px;
        overflow-y: auto;
    }

    li {
        padding: 10px;
        border-bottom: 1px solid #eee;
        display: flex;
        justify-content: space-between;
    }

    li:last-child {
        border-bottom: none;
    }

    .controls, .sub-category-controls {
        margin: 10px 0;
    }

    button {
        padding: 10px;
        border: none;
        background-color: #FF5C3D;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 5px;
    }

    button:hover {
        background-color: #FF5C3D;
    }

    .footer {
        text-align: center;
        margin-top: 20px;
    }

    select {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
    }

    .delete-btn {
        background-color: #FF5C3D;
        border: none;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 10px;
    }

    .delete-btn:hover {
        background-color: #FF5C3D;
    }


    
    /*상세끝*/
    
     a {
    text-decoration: none; /* 링크의 밑줄 제거 */
    color: black;
    }
    
    

    /* 모달 스타일 */
    .modal {
        display: none; /* 기본적으로 숨김 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
    }

    .modal-content {
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 300px;
        text-align: center;
        border-radius: 5px;
    }

    .modal-confirm {
        background-color: #FF5C3D; /* 기존 버튼 색상과 동일 */
        color: white;
        border: none;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .modal-confirm:hover {
        background-color: #FF5C3D; /* 호버 색상 */
    }

    
</style>
</head>
<body>
  <!-- 상세정보시작 -->
  <div class="main"> 
    <%@ include file="/views/common/mainHeader.jsp" %> <!-- 샘샘해더글 -->
    <div class="container">
        
        <div class="table">
            <%@ include file="/views/common/sidebarManager.jsp" %> <!-- 사이드바메뉴 -->
            <h1>카테고리 관리</h1>
            <div class="category-management">
                <div class="existing-categories">
                    <h2>기존 카테고리</h2>
                    <ul id="existing-category-list">
                        <li>러시아어 <button class="delete-btn">삭제</button></li>
                        <li>정치학 <button class="delete-btn">삭제</button></li>
                    </ul>
                </div>
                <div class="controls">
                    <input type="text" id="new-category-input" placeholder="새 카테고리 이름">
                    <button id="add-category-btn">추가</button>
                    <button id="add-all-btn">모두 추가 >></button>
                </div>
                <div class="details">
                    <h2>세부 카테고리</h2>
                    <select id="sub-category-select">
                        <option value="">카테고리 선택</option>
                        <option value="과목">과목</option>
                        <option value="과정">과정</option>
                        <option value="영어">영어</option>
                    </select>
                    <div class="sub-category-controls">
                        <button id="add-sub-category-btn">상위 카테고리 추가</button>
                        <button id="add-sub-category-btn-2">하위 카테고리 추가</button>
                    </div>
                </div>
            </div>
            <div class="footer">
                <button id="save-btn">저장하기</button>
                <button id="cancel-btn">취소하기</button>
            </div>
        </div>

        

        </div>
    </div>
    <!-- 모달 창 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <p id="modal-message"></p>
            <button id="modal-confirm-btn" class="modal-confirm">확인</button>
        </div>
    </div>
    <script>
        document.getElementById('add-category-btn').addEventListener('click', function() {
            const newCategoryInput = document.getElementById('new-category-input');
            const newCategory = newCategoryInput.value.trim();
            
            if (newCategory) {
                showModal(`"${newCategory}" 카테고리를 추가하시겠습니까?`, function() {
                    const categoryList = document.getElementById('existing-category-list');
                    const li = document.createElement('li');
                    li.innerHTML = `${newCategory} <button class="delete-btn">삭제</button>`;
                    categoryList.appendChild(li);
                    addDeleteListener(li.querySelector('.delete-btn'));
                    newCategoryInput.value = ''; // 입력 필드 초기화
                });
            } else {
                showModal('카테고리 이름을 입력하세요.');
            }
        });

        document.getElementById('add-sub-category-btn').addEventListener('click', function() {
            const selectedSubCategory = document.getElementById('sub-category-select').value;

            if (selectedSubCategory) {
                showModal(`"${selectedSubCategory}" 세부 카테고리를 추가하시겠습니까?`, function() {
                    const categoryList = document.getElementById('existing-category-list');
                    const li = document.createElement('li');
                    li.innerHTML = `${selectedSubCategory} <button class="delete-btn">삭제</button>`;
                    categoryList.appendChild(li);
                    addDeleteListener(li.querySelector('.delete-btn'));
                });
            } else {
                showModal('세부 카테고리를 선택하세요.');
            }
        });

        document.getElementById('save-btn').addEventListener('click', function() {
            showModal('변경사항을 저장하시겠습니까?', function() {
                showModal('저장되었습니다.');
                // 실제 저장 로직을 여기에 추가
            });
        });

        document.getElementById('cancel-btn').addEventListener('click', function() {
            showModal('작업을 취소하시겠습니까?', function() {
                showModal('작업이 취소되었습니다.');
                // 실제 취소 로직을 여기에 추가
            });
        });

        // 삭제 버튼에 대한 이벤트 리스너 추가 함수 
        function addDeleteListener(deleteButton) {
            deleteButton.addEventListener('click', function() {
                showModal('이 카테고리를 삭제하시겠습니까?', function() {
                    deleteButton.parentElement.remove();
                    // showModal('카테고리가 삭제되었습니다.');
                });
            });
        }

        // 초기 삭제 버튼에 이벤트 리스너 추가
        const deleteButtons = document.querySelectorAll('.delete-btn');
        deleteButtons.forEach(button => addDeleteListener(button));

         // 모달을 표시하는 함수
        function showModal(message, onConfirm) {
            const modal = document.getElementById('modal');
            const modalMessage = document.getElementById('modal-message');
            const modalConfirmBtn = document.getElementById('modal-confirm-btn');
    
        modalMessage.textContent = message;
        modal.style.display = 'block';
    
        modalConfirmBtn.onclick = function() {
            modal.style.display = 'none';
            if (onConfirm) onConfirm();
            // showModal('작업이 완료되었습니다.'); // 확인 후 알림 추가
        };
    
        // 모달 외부 클릭 시 모달 닫기
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };
    }



    </script>

</body>
</html>


