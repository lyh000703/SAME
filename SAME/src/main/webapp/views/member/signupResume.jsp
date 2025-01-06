<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멘토정보입력</title>
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
	<!-- head 시작-->
	<div class="main">

		<%@ include file="/views/common/mainHeader.jsp"%>
		<%@ include file="/views/common/searchbar.jsp"%>

		<div class="container">
			<%@ include file="/views/common/sidebarMembership.jsp"%>
			<!-- 컨테이너 시작-->
			<form id="signupMentor"
				action="${pageContext.request.contextPath}/member/insertMentor"
				method="post">

				<div class="sign-up-form">
					<!-- 사이드바 -->
					<div class="mentor-profile">
						<div class="avatar-container">
							<div class="avatar"></div>
							<div class="upload-btn">업로드</div>
						</div>
						<div class="mentor-details">
							<div class="mentor-name">Mentor 김철수</div>
							<div class="introduction">
								<textarea placeholder="강사의 한마디 입력하세요"></textarea>
							</div>
						</div>
						<div class="delete-btn">×</div>
					</div>
					<div class="category">
						<div class="category-title">지역</div>
						<div class="dropdown">
							<div class="selected-items selected-locations">
								<!-- 선택된 지역들이 표시될 영역 -->
							</div>
							<select class="menu-dropdown location-select">
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
								<!-- 선택된 과목들이 표시될 영역 -->
							</div>
							<select class="menu-dropdown subject-select">
								<option value="">강의과목</option>
								<option value="국/영/수">국/영/수</option>
								<option value="외국어">외국어</option>
								<option value="과학/수학">과학/수학</option>
								<option value="예체능">예체능</option>
								<option value="기타">기타</option>
							</select>
						</div>

					</div>


					<script>
      // 지역 선택
      document.querySelector('.location-select').addEventListener('change', function (event) {
          var selectedValue = event.target.value;
  
          if (selectedValue) {
              var selectedItemsContainer = document.querySelector('.selected-locations');
  
              // 중복 방지
              var existingItem = selectedItemsContainer.querySelector(`[data-value="${selectedValue}"]`);
              if (!existingItem) {
                  var item = document.createElement('span');
                  item.className = 'selected';
                  item.dataset.value = selectedValue;
                  item.innerHTML = `${selectedValue} <span class="remove">×</span>`;
                  selectedItemsContainer.appendChild(item);
  
                  // 삭제 이벤트
                  item.querySelector('.remove').addEventListener('click', function () {
                      item.remove();
                  });
              }
  
              event.target.value = '';
          }
      });
  
      // 강의 과목 선택
      document.querySelector('.subject-select').addEventListener('change', function (event) {
          var selectedValue = event.target.value;
  
          if (selectedValue) {
              var selectedItemsContainer = document.querySelector('.selected-subjects');
  
              // 중복 방지
              var existingItem = selectedItemsContainer.querySelector(`[data-value="${selectedValue}"]`);
              if (!existingItem) {
                  var item = document.createElement('span');
                  item.className = 'selected';
                  item.dataset.value = selectedValue;
                  item.innerHTML = `${selectedValue} <span class="remove">×</span>`;
                  selectedItemsContainer.appendChild(item);
  
                  // 삭제 이벤트
                  item.querySelector('.remove').addEventListener('click', function () {
                      item.remove();
                  });
              }
              event.target.value = '';
          }
      });
  </script>

					<!-- 학력 섹션 -->
					<div class="section" id="education-section">
						<div class="section-title">학력</div>
						<div class="list-container" id="education-list">
							<!-- 입력된 학력 항목이 여기에 표시됩니다 -->
						</div>
						<div class="input-group">
							<input type="text" id="education-input"
								placeholder="학력 입력 (예: XX대학교 졸업 / 2016-03~2022-02)">
							<button onclick="addItem('education')">등록</button>
						</div>
					</div>

					<!-- 경력 섹션 -->
					<div class="section" id="experience-section">
						<div class="section-title">경력</div>
						<div class="list-container" id="experience-list">
							<!-- 입력된 경력 항목이 여기에 표시됩니다 -->
						</div>
						<div class="input-group">
							<input type="text" id="experience-input"
								placeholder="경력 입력 (예: XX회사 근무 / 2022-04~2024-09)">
							<button onclick="addItem('experience')">등록</button>
						</div>
					</div>

					<!-- 자격증/외국어 섹션 -->
					<div class="section" id="language-section">
						<div class="section-title">자격증/외국어</div>
						<div class="list-container" id="language-list">
							<!-- 입력된 자격증/외국어 항목이 여기에 표시됩니다 -->
						</div>
						<div class="input-group">
							<input type="text" id="language-input"
								placeholder="자격증/외국어 입력 (예: TOEIC 850점)">
							<button onclick="addItem('language')">등록</button>
						</div>
					</div>

					<div class="portfolio">
						<span class="portfolio-title">포트폴리오</span>
						<div class="portfolio-box">
							<span></span> <input type="file" class="portfolio-input">

						</div>
					</div>


					<script>
				  // 업로드 버튼 동작
				  document.querySelector('.upload-btn').addEventListener('click', () => {
				    alert('이미지 업로드 기능 구현 필요!');
				  });

				  // 삭제 버튼 동작
				  document.querySelector('.delete-btn').addEventListener('click', () => {
				    if (confirm('프로필 사진을 삭제하시겠습니까?')) {
				      document.querySelector('.avatar').style.backgroundColor = '#D9D9D9'; // 기본 이미지로 복원
				    }
				  });
			
</script>



					<button class="submit-button">완료</button>
					<!-- Form Section End-->

				</div>
	</form>
		</div>
		<br> <br>
	</div>
</body>
</html>