<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kh.member.model.vo.Profile, com.kh.member.model.vo.Member" %>
<%
	 List<Profile> list = (List<Profile>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/same/resources/css/search.css" rel="stylesheet">
<title>프로필 검색</title>

</head>
<body>
    <div class="container">
        <h1>프로필 검색하기</h1>
        <form action="">
        <div class="search-bar">
            <input type="text" id="search-input" placeholder="이런 게 있을까요?" name="keyword">
            <button id="search-btn">검색</button>
        </div>
        </form>
        <div class="filters">
            <select id="region-select">
                <option value="">지역</option>
                <option value="서울">서울</option>
                <option value="부산">부산</option>
                <option value="대구">대구</option>
                <option value="광주">광주</option>
                <option value="인천">인천</option>
            </select>
            <select id="job-select">
                <option value="">직업</option>
                <option value="디자이너">디자이너</option>
                <option value="개발자">개발자</option>
                <option value="마케터">마케터</option>
            </select>
            <select id="education-select">
                <option value="">교육기관</option>
                <option value="대학교">대학교</option>
                <option value="전문대">전문대</option>
            </select>
            <select id="gender-select">
                <option value="">성별</option>
                <option value="남성">남성</option>
                <option value="여성">여성</option>
            </select>
            <!-- 카테고리 추가 박스생성 -->
            <div class="selected-categories" id="selected-categories">
                <!-- 선택된 카테고리 박스가 여기에 추가됩니다 -->
            </div>
        </div>


  <div class="profiles" id="profiles-container">
           <!--  <div class="profile-card">
                <a href="https://example.com/profile1" class="profile-link">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/한글 무료이미지.jpg" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">나랏말싸미 듕귁에 달아...</div>
                        <div class="profile-category">한국어 교실</div> 과목 카테고리 추가
                    </div>
                </a>
                <div class="profile-id">이 도</div>
                <div class="profile-info">한국어 교실</div>
            </div>
            <div class="profile-card">
                <a href="https://example.com/profile2">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/영어 무료이미지.jpg" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">원어민 선생님의 화상강의</div>
                        <div class="profile-category">영어 회화</div> 과목 카테고리 추가

                    </div>
                </a>
                <div class="profile-id">브루노 마스</div>
                <div class="profile-info">부산</div>
            </div>
            <div class="profile-card">
                <a href="https://example.com/profile3">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/일본어 무료 이미지.jpg" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">번연기 없이 일본여행가자!</div>
                        <div class="profile-category">일본어 회화</div> 과목 카테고리 추가

                    </div>
                </a>
                <div class="profile-id">나까무라</div>
                <div class="profile-info">대구</div>
            </div>
            <div class="profile-card">
                <a href="https://example.com/profile1">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/중국 무료이미지.jpg" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">30일만에 신전 중국어 회화까지</div>
                        <div class="profile-category">중국어 회화 수업</div> 과목 카테고리 추가

                    </div>
                </a>
                <div class="profile-id">칭따오</div>
                <div class="profile-info">서울</div>
            </div>
            <div class="profile-card">
                <a href="https://example.com/profile2">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/수학과외.webp" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">야, 너도 노래 할수 있어</div>
                        <div class="profile-category">노래 교실</div> 과목 카테고리 추가

                    </div>
                </a>
                <div class="profile-id">허각</div>
                <div class="profile-info">부산</div>
            </div>
            <div class="profile-card">
                <a href="https://example.com/profile3">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/수학과외.webp" alt="프로필 사진" class="profile-img">
                        <div class="profile-title">수능만점가자</div>
                        <div class="profile-category">국영수</div> 과목 카테고리 추가

                    </div>
                </a>
                <div class="profile-id">이용희</div>
                <div class="profile-info"></div>
            </div> -->
            
			<% if(!list.isEmpty()) { %>
            <% for (Profile p : list) { %>
            <div class="profile-card">
                <a href="https://example.com/profile3">
                    <div class="profile-img-container">
                        <img src="/same/resources/images/영어 무료이미지.jpg" alt="프로필 사진" class="profile-img">
                        <div class="profile-title"><%=p.getIntroduction() %></div>
                        <div class="profile-category"> <%=p.getProfileTitle() %> </div> <!-- 과목 카테고리 추가 -->

                    </div>
                </a>
                <div class="profile-id"><%= p.getMemberNo() %> </div>
                <div class="profile-info">미국</div>
            </div>
            <% } %>
          <% } %>

        </div>
        
    </div>
    <script>
        document.getElementById('search-btn').addEventListener('click', function() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const profiles = document.querySelectorAll('.profile-card');

            profiles.forEach(profile => {
                const name = profile.querySelector('h2').textContent.toLowerCase();
                if (name.includes(searchTerm)) {
                    profile.style.display = 'block'; // 검색 결과에 맞는 프로필 표시
                } else {
                    profile.style.display = 'none'; // 검색 결과에 맞지 않는 프로필 숨김
                }
            });
        });

        // 카테고리 선택 시 박스 추가
        const selectedCategories = document.getElementById('selected-categories');

        document.querySelectorAll('select').forEach(select => {
            select.addEventListener('change', function() {
                const selectedValue = this.value;
                const selectedText = this.options[this.selectedIndex].text;

                if (selectedValue) {
                    // 선택된 카테고리 박스 생성
                    const categoryBox = document.createElement('div');
                    categoryBox.className = 'category-box';
                    categoryBox.textContent = selectedText;

                    // 제거 버튼 추가
                    const removeBtn = document.createElement('button');
                    removeBtn.className = 'remove-btn';
                    removeBtn.textContent = 'X';
                    removeBtn.onclick = function() {
                        selectedCategories.removeChild(categoryBox);
                    };

                    categoryBox.appendChild(removeBtn);
                    selectedCategories.appendChild(categoryBox);

                    // 선택 후 초기화
                    this.selectedIndex = 0;
                }
            });
        });
    </script>
</body>
</html>