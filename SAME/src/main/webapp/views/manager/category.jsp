<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<style>
    /* 메인화면 중앙 배치 스타일 */
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
    }
    
    /* 테이블 기본 스타일 */
    .table {
        width: 910px;
        flex-direction: column;
        display: flex;
        font-size: 14px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-left: 27%;
        margin-right: auto;
        margin-top: 5%;
    }

    /* 카테고리 관리 섹션 */
    h1 {
        text-align: center;
        background-color: #FF5C3D;
        color: white;
        margin: auto;
        padding: 10px;
    }

    .category-management {
        display: flex;
        padding: 20px;
    }

    /* 왼쪽 영역 (기존 카테고리 + 입력 영역) */
    .left-section {
        width: 45%;
        display: flex;
        flex-direction: column;
    }

    .existing-categories {
        margin: 20px 0;
        width: 100%;
        max-width: 800px;
    }

    .category-type {
        font-weight: bold;
        color: #FF5C3D;
        display: block;
        margin-bottom: 10px;
        font-size: 1.1em;
        padding: 5px 0;
    }

    .category-names {
        list-style: none;
        padding-left: 20px;
        margin: 10px 0;
    }

    /* li 태그 스타일 수정 */
    .category-names li {
        display: flex;
        align-items: center;
        padding: 10px 15px;
        margin: 8px 0;
        background-color: #f8f8f8;
        border-radius: 4px;
        min-height: 45px;
    }

    /* 카테고리 이름 스타일 수정 */
    .category-name {
        display: inline-block;
        min-width: 60px;
        margin-right: 15px;
        font-size: 0.95em;
    }

    /* 버튼 그룹 스타일 수정 */
    .button-group {
        display: flex;
        margin-left: auto;
    }

    /* 버튼 공통 스타일 */
    .edit-btn, .delete-btn, #addCategoryBtn {
        padding: 5px 12px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 0.9em;
        min-width: 50px;
        height: 30px;
        background-color: #FF5C3D;
        color: white;
        transition: background-color 0.2s;
    }

    .edit-btn:hover, .delete-btn:hover, #addCategoryBtn:hover {
        background-color: #ff4424;
    }

    /* 버튼 내 아이콘 스타일 */
    .btn-icon {
        margin-right: 4px;
        font-size: 14px;
    }

    /* 데이터 없음 메시지 스타일 */
    .no-data-message {
        text-align: center;
        padding: 20px;
        color: #666;
        font-style: italic;
    }

    /* 카테고리 입력 영역 */
    .category-input {
        width: 100%;
        padding: 15px;
        background: #f8f8f8;
        border-radius: 5px;
        margin-top: 20px;
    }

    .category-input input[type="text"] {
        width: calc(100% - 20px);
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    /* 컨른쪽 영역 (세부 카테고리) */
    .details {
        width: 45%;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .sub-category-controls {
        margin-bottom: 20px;
    }

    /* 리스트 영역 크기 조정 */
    ul {
        list-style: none;
        padding: 0;
        border: 1px solid #ccc;
        height: 300px;
        overflow-y: auto;
        background: white;
        border-radius: 4px;
    }

    li {
        padding: 10px;
        border-bottom: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* 하단 버튼 영역 */
    .footer {
        text-align: center;
        margin-top: 20px;
        padding: 20px;
        border-top: 1px solid #eee;
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 300px;
        border-radius: 5px;
        text-align: center;
    }

    .modal-confirm {
        margin-top: 15px;
        padding: 8px 20px;
        background-color: #FF5C3D;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .modal-confirm:hover {
        background-color: #ff4424;
    }

    select {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .category-type-section {
        margin-bottom: 20px;
    }
    
    .category-type-section label,
    .category-input label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }
    
    .category-input {
        margin-top: 20px;
        padding: 15px;
        background: #f8f8f8;
        border-radius: 5px;
    }
    
    /* 리스트 아이템 스타일 수정 */
    li {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }
    
    li .category-type {
        font-weight: bold;
        color: #FF5C3D;
    }

    /* 버튼 영역 스타일 */
    .button-area {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 20px;
        padding: 15px;
    }

    /* 공통 버튼 스타일 (기존 버튼들과 통일) */
    .common-btn {
        padding: 5px 12px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 0.9em;
        min-width: 80px;
        height: 35px;
        background-color: #FF5C3D;
        color: white;
        transition: background-color 0.2s;
    }

    .common-btn:hover {
        background-color: #ff4424;
    }

    /* 삭제 버튼 스타일 */
    .delete-btn {
        padding: 5px 12px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 0.9em;
        min-width: 50px;
        height: 30px;
        background-color: #FF5C3D;
        color: white;
        transition: background-color 0.2s;
    }

    .delete-btn:hover {
        background-color: #ff4424;
    }
</style>
</head>
<body>
    <div class="main">
        <%@ include file="/views/common/mainHeader.jsp" %>
        <div class="container">
            <div class="table">
                <%@ include file="/views/common/sidebarManager.jsp" %>
                <h1>카테고리 관리</h1>
                
                <div class="category-management">
                    <div class="left-section">
                        <div class="existing-categories">
                            <h2>카테고리 목록</h2>
                            <ul id="existing-category-list">
                                <!-- 동적으로 카테고리가 추가될 영역 -->
                            </ul>
                        </div>
                    </div>
                    
                    <div class="details">
                        <h2>카테고리 추가</h2>
                        <!-- 상위 카테고리(카테고리 타입) 선택 -->
                        <div class="category-type-section">
                            <label for="category-type">상위 카테고리</label>
                            <select id="category-type">
                                <option value="">상위 카테고리 선택</option>
                                <option value="과목">과목</option>
                                <option value="과정">과정</option>
                                <option value="영어">영어</option>
                            </select>
                        </div>
                        
                        <!-- 하위 카테고리(카테고리 이름) 입력 -->
                        <div class="category-input">
                            <label for="categoryName">하위 카테고리</label>
                            <input type="text" id="categoryName" placeholder="하위 카테고리 이름 입력" maxlength="30">
                            <div class="button-group">
                                <button id="addCategoryBtn">등록</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="button-area">
                    <button type="button" id="resetBtn" class="common-btn">초기화</button>
                    <button type="button" id="backBtn" class="common-btn">뒤로가기</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modal" class="modal">
        <div class="modal-content">
            <p id="modal-message"></p>
            <button id="modal-confirm-btn" class="modal-confirm">확인</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 카기 데이터 로드
            loadCategoryTypes();
            
            // 카테고리 타입 목록 로드 함수 수정
            function loadCategoryTypes() {
                fetch('${pageContext.request.contextPath}/category/types')
                    .then(response => response.json())
                    .then(types => {
                        const select = document.getElementById('category-type');
                        select.innerHTML = '<option value="">카테고리 타입 선택</option>';
                        
                        // Set을 사용하여 중복 제거
                        const uniqueTypes = [...new Set(types)];
                        
                        uniqueTypes.forEach(type => {
                            const option = document.createElement('option');
                            option.value = type;    // 값을 타입으로 설정
                            option.textContent = type; // 표시 텍스트도 타입으로 설정
                            select.appendChild(option);
                        });
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('카테고리 타입 목록을 불러오는데 실패했습니다.');
                    });
            }

            // 카테고리 타입 선택 이벤트 리스너 추가
            document.getElementById('category-type').addEventListener('change', function() {
                const selectedType = this.value;
                if(selectedType) {
                    loadCategoriesByType(selectedType);
                } else {
                    document.getElementById('existing-category-list').innerHTML = '';
                }
            });

            // 특정 타입의 카테고리만 로드하는 함수
            function loadCategoriesByType(selectedType) {
                fetch('${pageContext.request.contextPath}/category/list')
                    .then(response => response.json())
                    .then(categories => {
                        const list = document.getElementById('existing-category-list');
                        list.innerHTML = '';
                        
                        const filteredCategories = categories.filter(category => 
                            category.categoryType === selectedType
                        );
                        
                        if(filteredCategories.length > 0) {
                            const typeItem = document.createElement('li');
                            const categoryList = document.createElement('ul');
                            categoryList.className = 'category-names';
                            
                            const typeHeader = document.createElement('span');
                            typeHeader.className = 'category-type';
                            typeHeader.textContent = selectedType;
                            typeItem.appendChild(typeHeader);
                            
                            filteredCategories.forEach(category => {
                                const categoryItem = document.createElement('li');
                                
                                const nameSpan = document.createElement('span');
                                nameSpan.className = 'category-name';
                                nameSpan.textContent = category.categoryName;
                                
                                const buttonGroup = document.createElement('div');
                                buttonGroup.className = 'button-group';
                                
                                const deleteBtn = document.createElement('button');
                                deleteBtn.className = 'delete-btn';
                                deleteBtn.textContent = '삭제';
                                deleteBtn.onclick = () => deleteCategory(category.categoryType, category.categoryName);
                                
                                buttonGroup.appendChild(deleteBtn);
                                
                                categoryItem.appendChild(nameSpan);
                                categoryItem.appendChild(buttonGroup);
                                categoryList.appendChild(categoryItem);
                            });
                            
                            typeItem.appendChild(categoryList);
                            list.appendChild(typeItem);
                        } else {
                            const noDataMsg = document.createElement('li');
                            noDataMsg.className = 'no-data-message';
                            noDataMsg.textContent = '등록된 카테고리가 없습니다.';
                            list.appendChild(noDataMsg);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showModal('카테고리 목록을 불러오는데 실패했습니다.');
                    });
            }

            // 카테고리 추가 버튼 이벤트 수정
            document.getElementById('addCategoryBtn').addEventListener('click', function() {
                // 입력값 가져오기
                const categoryTypeSelect = document.getElementById('category-type');
                const selectedType = categoryTypeSelect.value;
                const categoryNameInput = document.getElementById('categoryName');
                const inputName = categoryNameInput.value.trim();
                
                // 디버깅용 로그
                console.log('입력된 이름:', inputName);
                console.log('선택된 타입:', selectedType);
                
                // 유효성 검사
                if(!selectedType) {
                    alert('카테고리 타입을 선택하세요.');
                    return;
                }
                
                if(!inputName) {
                    alert('카테고리 이름을 입력하세요.');
                    return;
                }

                // 첫 번째 확인 메시지
                const message = `다음 카테고리를 등록하시겠습니까?\n\n` + 
                              `타입: ${selectedType}\n` + 
                              `이름: ${inputName}`;
                
                if(confirm(message)) {
                    // 두 번째 확인 메시지
                    const secondMessage = `정말로 다음 카테고리를 등록하시겠습니까?\n\n` + 
                                        `타입: ${selectedType}\n` + 
                                        `이름: ${inputName}`;
                    
                    if(confirm(secondMessage)) {
                        const category = {
                            categoryType: selectedType,
                            categoryName: inputName
                        };

                        fetch('${pageContext.request.contextPath}/category/add', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(category)
                        })
                        .then(response => response.json())
                        .then(result => {
                            if(result.success) {
                                const successMessage = `카테고리가 성공적으로 등록되었습니다.\n\n` + 
                                                     `타입: ${selectedType}\n` + 
                                                     `이름: ${inputName}`;
                                alert(successMessage);
                                categoryNameInput.value = '';
                                loadCategoriesByType(selectedType);
                            } else {
                                alert('카테고리 추가에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('카테고리 추가 중 오류가 발생했습니다.');
                        });
                    }
                }
            });

            // 카테고리 삭제 함수 수정
            function deleteCategory(type, name) {
                const deleteMessage = `다음 카테고리를 삭제하시겠습니까?\n\n` + 
                                    `타입: ${type}\n` + 
                                    `이름: ${name}`;
                
                if(confirm(deleteMessage)) {
                    const secondDeleteMessage = `정말로 다음 카테고리를 삭제하시겠습니까?\n\n` + 
                                                `타입: ${type}\n` + 
                                                `이름: ${name}`;
                    
                    if(confirm(secondDeleteMessage)) {
                        fetch('${pageContext.request.contextPath}/category/delete', {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                categoryType: type,
                                categoryName: name
                            })
                        })
                        .then(response => response.json())
                        .then(result => {
                            if(result.success) {
                                const successMessage = `카테고리가 성공적으로 삭제되었습니다.\n\n` + 
                                                     `타입: ${type}\n` + 
                                                     `이름: ${name}`;
                                alert(successMessage);
                                loadCategoriesByType(type);
                            } else {
                                alert('카테고리 삭제에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('카테고리 삭제 중 오류가 발생했습니다.');
                        });
                    }
                }
            }

            // 초기화 버튼 기능
            document.getElementById('resetBtn').addEventListener('click', function() {
                if(confirm('모든 입력을 초기화하시겠습니까?')) {
                    // 입력 필드 초기화
                    document.getElementById('category-type').value = '';
                    document.getElementById('categoryName').value = '';
                    
                    // 카테고리 목록 초기화
                    document.getElementById('existing-category-list').innerHTML = '';
                    
                    // 선택된 항목 초기화
                    const selects = document.querySelectorAll('select');
                    selects.forEach(select => select.selectedIndex = 0);
                    
                    showAlert('모든 항목이 초기화되었습니다.');
                }
            });

            // 뒤로가기 버튼 기능
            document.getElementById('backBtn').addEventListener('click', function() {
                if(confirm('이전 페이지로 돌아가시겠습니까?')) {
                    // 변경사항 있을 경우 경고
                    const hasChanges = document.getElementById('categoryName').value.trim() !== '';
                    
                    if(hasChanges) {
                        if(confirm('저장되지 않은 변경사항이 있습니다. 계속하시겠습니까?')) {
                            window.history.back();
                        }
                    } else {
                        window.history.back();
                    }
                }
            });

            // 페이지 이탈 시 경고
            window.addEventListener('beforeunload', function(e) {
                const hasChanges = document.getElementById('categoryName').value.trim() !== '';
                if(hasChanges) {
                    e.preventDefault();
                    e.returnValue = ''; // Chrome에서 필요
                }
            });
        });
    </script>
</body>
</html>


