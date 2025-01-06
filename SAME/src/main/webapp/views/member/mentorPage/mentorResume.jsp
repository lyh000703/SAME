<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 이력서</title>
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
	}
	
	.sign-up-form {
		display: flex;
		flex-direction: column;
		width: 700px;
		margin-left: auto;
		margin-right: auto;
		margin-top: 5%;
	}
	/* Form Section */
	.mentor-profile {
		width: 669px;
		height: 232px;
		display: flex;
		border-radius: 5px;
		background-color: white;
		padding: 15px;
		position: relative;
	}
	
	.avatar-container {
		width: 220px;
		height: 200px;
		display: flex;
		flex-direction: column;
		align-items: center;
		border-right: 1px solid #E0E0E0;
	}
	
	.avatar {
		width: 180px;
		height: 200px;
		background-color: #D9D9D9;
		border-radius: 5px;
		height: 200px;
	}
	
	.upload-btn {
		margin-top: 10px;
		margin-right: 120px;
		color: #FF5C3D;
		font-size: 15px;
		cursor: pointer;
	}
	
	.mentor-details {
		flex-grow: 1;
		padding-left: 20px;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	
	.mentor-name {
		font-size: 25px;
		font-weight: 700;
		padding-top: 10px;
	}
	
	.delete-btn {
		position: absolute;
		top: 10px;
		right: 10px;
		width: 14px;
		height: 14px;
		color: black;
		cursor: pointer;
		margin-right: 475px;
	}
	
	.introduction {
		flex-grow: 1; /* 남은 공간을 차지 */
		margin-top: 77px;
	}
	
	.introduction textarea {
		width: 95%;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
		resize: none;
		height: 60px; /* 높이 조정 */
	}
	
	.category {
		margin-top: 20px;
	}
	
	.category-title {
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	.dropdown {
		display: flex; /* Flexbox 사용 */
		justify-content: space-between; /* 양쪽 정렬 */
		align-items: center; /* 수직 정렬 */
		border: 1px solid #ccc;
		border-radius: 4px;
		padding: 10px;
		margin-bottom: 10px;
	}
	
	.selected {
		background-color: #ff6b6b;
		color: white;
		padding: 5px 10px;
		border-radius: 5px;
		display: flex;
		align-items: center;
	}
	
	.selected-items {
		display: flex;
		gap: 8px; /* 선택된 항목 간격 */
		flex-wrap: wrap; /* 여러 항목이 넘어가면 다음 줄로 */
		margin-bottom: 10px;
	}
	
	.remove {
		margin-left: 5px;
		cursor: pointer;
	}
	
	.menu-dropdown {
		margin-top: 10px;
		width: 80px;
		height: 30px;
	}
	
	.section {
		margin-bottom: 20px;
	}
	
	.section-title {
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	.input-group {
		display: flex;
		align-items: center;
		margin-top: 10px;
	}
	
	.input-group input {
		flex: 1;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
	.input-group button {
		padding: 10px 16px;
		background-color: #FF5C3D;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		margin-left: 10px;
	}
	
	.input-group button:hover {
		background-color: #e74c3c;
	}
	
	.list-container {
		margin-top: 10px;
	}
	
	.list-item {
		display: flex;
		align-items: center;
		justify-content: space-between;
		background: #f7f7f7;
		padding: 8px 12px;
		border-radius: 4px;
		margin-bottom: 8px;
	}
	
	.list-item span {
		flex: 1;
	}
	
	.list-item button {
		background-color: transparent;
		border: none;
		color: #ff5c3d;
		font-weight: bold;
		cursor: pointer;
	}
	
	.list-item button:hover {
		color: #e74c3c;
	}
	
	.portfolio {
		margin-top: 20px;
	}
	
	.portfolio-box {
		display: flex; /* Flexbox 사용 */
		justify-content: space-between; /* 양쪽 정렬 */
		align-items: center; /* 수직 정렬 */
		border: 1px solid #ccc;
		border-radius: 4px;
		padding: 10px;
	}
	
	.portfolio-input {
		margin-left: 400px; /* 오른쪽으로 이동 */
	}
	
	.submit-button {
		/* width: 100%; */
		padding: 8px 16px;
		background-color: #FF5C3D;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		margin-top: 20px;
		float: right;
	}
	
	.submit-button:hover {
		background-color: #e74c3c;
	}
	/* Form Section End*/
	</style>
</head>
<body>
    <div class="main">
        <%@ include file="/views/common/mainHeader.jsp"%>
        <%@ include file="/views/common/searchbar.jsp"%>

        <div class="container">
            <%@ include file="/views/common/sidebarMentor.jsp"%>
            
            <form id="mentorResume" action="<%=request.getContextPath()%>/member/mentorResume" method="post">
                <div class="sign-up-form">
                    <div class="mentor-profile">
                        <div class="avatar-container">
                            <div class="avatar"></div>
                            <div class="upload-btn">업로드</div>
                        </div>
                        <div class="mentor-details">
                            <div class="mentor-name">
                                Mentor <%=((Member)session.getAttribute("loginUser")).getMemberName()%>
                            </div>
                            <div class="introduction">
                                <textarea name="introduction" placeholder="강사의 한마디 입력하세요"><%=request.getAttribute("mentorResume") != null ? ((Member)request.getAttribute("mentorResume")).getIntroduction() : ""%></textarea>
                            </div>
                        </div>
                        <div class="delete-btn">×</div>
                    </div>

                    <div class="category">
                        <div class="category-title">지역</div>
                        <div class="dropdown">
                            <div class="selected-items selected-locations">
                                <% if(request.getAttribute("mentorResume") != null && ((Member)request.getAttribute("mentorResume")).getRegionName() != null) { %>
                                    <span class="selected" data-value="<%=((Member)request.getAttribute("mentorResume")).getRegionName()%>">
                                        <%=((Member)request.getAttribute("mentorResume")).getRegionName()%>
                                        <span class="remove">×</span>
                                    </span>
                                <% } %>
                            </div>
                            <select class="menu-dropdown location-select" name="regionName">
                                <option value="">지역</option>
								<option value="서울">서울</option>
								<option value="경기">경기</option>
								<option value="강원">강원</option>
								<option value="충북">충북</option>
								<option value="충남">충남</option>
								<option value="경북">경북</option>
								<option value="경남">경남</option>
								<option value="전북">전북</option>
								<option value="(제주)서귀포시">(제주)서귀포시</option>
								<option value="(제주)제주시">(제주)제주시</option>
                            </select>
                        </div>

                        <div class="category-title">강의과목</div>
                        <div class="dropdown">
                            <div class="selected-items selected-subjects">
                                <% if(request.getAttribute("mentorResume") != null && ((Member)request.getAttribute("mentorResume")).getClassName() != null) { %>
                                    <span class="selected" data-value="<%=((Member)request.getAttribute("mentorResume")).getClassName()%>">
                                        <%=((Member)request.getAttribute("mentorResume")).getClassName()%>
                                        <span class="remove">×</span>
                                    </span>
                                <% } %>
                            </div>
                            <select class="menu-dropdown subject-select" name="className">
                                <option value="">강의과목</option>
								<option value="국/영/수">국/영/수</option>
								<option value="외국어">외국어</option>
								<option value="과학/수학">과학/수학</option>
								<option value="예체능">예체능</option>
								<option value="기타">기타</option>
                            </select>
                        </div>
                    </div>

                    <!-- 학력 섹션 -->
                    <div class="section" id="education-section">
                        <div class="section-title">학력</div>
                        <div class="list-container" id="education-list">
                            <% if(request.getAttribute("mentorResume") != null && ((Member)request.getAttribute("mentorResume")).getEducation() != null) { %>
                                <div class="list-item">
                                    <span><%=((Member)request.getAttribute("mentorResume")).getEducation()%></span>
                                    <button type="button" onclick="removeItem(this)">삭제</button>
                                </div>
                            <% } %>
                        </div>
                        <div class="input-group">
                            <input type="text" name="education" value="<%=request.getAttribute("mentorResume") != null ? ((Member)request.getAttribute("mentorResume")).getEducation() : ""%>"
                                placeholder="학력 입력 (예: XX대학교 졸업 / 2016-03~2022-02)">
                            <button type="button" onclick="addItem('education')">등록</button>
                        </div>
                    </div>

                    <!-- 경력 섹션 -->
                    <div class="section" id="career-section">
                        <div class="section-title">경력</div>
                        <div class="list-container" id="career-list">
                            <% if(request.getAttribute("mentorResume") != null && ((Member)request.getAttribute("mentorResume")).getCareer() != null) { %>
                                <div class="list-item">
                                    <span><%=((Member)request.getAttribute("mentorResume")).getCareer()%></span>
                                    <button type="button" onclick="removeItem(this)">삭제</button>
                                </div>
                            <% } %>
                        </div>
                        <div class="input-group">
                            <input type="text" name="career" value="<%=request.getAttribute("mentorResume") != null ? ((Member)request.getAttribute("mentorResume")).getCareer() : ""%>"
                                placeholder="경력 입력 (예: XX회사 근무 / 2022-04~2024-09)">
                            <button type="button" onclick="addItem('career')">등록</button>
                        </div>
                    </div>

                    <!-- 자격증/외국어 섹션 -->
                    <div class="section" id="license-section">
                        <div class="section-title">자격증/외국어</div>
                        <div class="list-container" id="license-list">
                            <% if(request.getAttribute("mentorResume") != null && ((Member)request.getAttribute("mentorResume")).getLicense() != null) { %>
                                <div class="list-item">
                                    <span><%=((Member)request.getAttribute("mentorResume")).getLicense()%></span>
                                    <button type="button" onclick="removeItem(this)">삭제</button>
                                </div>
                            <% } %>
                        </div>
                        <div class="input-group">
                            <input type="text" name="license" value="<%=request.getAttribute("mentorResume") != null ? ((Member)request.getAttribute("mentorResume")).getLicense() : ""%>"
                                placeholder="자격증/외국어 입력 (예: TOEIC 850점)">
                            <button type="button" onclick="addItem('license')">등록</button>
                        </div>
                    </div>

                    <button type="submit" class="submit-button">완료</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 기존 JavaScript 함수들 유지하면서 수정된 부분 추가
        document.addEventListener('DOMContentLoaded', function() {
            // 기존 데이터가 있는 경우 화면에 표시
            setupExistingData();
        });

        function setupExistingData() {
            // 지역, 과목 등 기존 데이터 설정
            const regionName = "${mentorResume.regionName}";
            const className = "${mentorResume.className}";
            
            if(regionName) {
                addSelectedItem('location', regionName);
            }
            if(className) {
                addSelectedItem('subject', className);
            }
        }

        function addSelectedItem(type, value) {
            const container = document.querySelector(`.selected-${type}s`);
            const item = document.createElement('span');
            item.className = 'selected';
            item.dataset.value = value;
            item.innerHTML = `${value} <span class="remove">×</span>`;
            
            item.querySelector('.remove').addEventListener('click', function() {
                item.remove();
            });
            
            container.appendChild(item);
        }
    </script>
</body>
</html>