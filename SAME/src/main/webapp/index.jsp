<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.kh.member.model.vo.Member" %>
<%
Member loginUser = (Member) session.getAttribute("loginUser");
String memberType = request.getParameter("memberType"); // URL 파라미터에서 memberType 추출
String contextPath = request.getContextPath(); // /same

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 메인화면</title>
<script src="https://kit.fontawesome.com/88450c0583.js" crossorigin="anonymous"></script>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* 화면 전체 높이에 맞추기 */
       
        background-color: white; /* 배경색 추가 */
    }

    .main {
        width: 100%;
        height: 100%;
        position: absolute;
        background: white;
    }

    .SameSame { 
        position: relative;
        top: 20%;
        margin: auto;
        color: #FF5C3D;
        font-size: 128px;
        font-family: Prompt;
        font-weight: 700;
        text-align: center;
    }
    .login-membership {
        position: absolute;
        top: 0%;
        right: 0;
        font: bold;
        font-size: 18px;
        font-weight: bold;
    }
    .login-membership a {
        text-decoration: none;
        color: #FF5C3D;
    }

    /*검색바 시작*/
    .search-container {
       
        position: relative;
        width: 40%;
    }

    .search-input {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 5px;
        padding: 10px 15px;
        border: 3px solid #FF5C3D;
        border-radius: 20px;
        font-size: 16px;
        cursor: text;
    }

    .search-input input {
        border: none;
        outline: none;
        flex: 1;
        font-size: 14px;
        min-width: 100px;
    }

    .search-input input::placeholder {
        color: #aaa;
    }

    .search-button {
        position: absolute;
        top: 50%;
        right: 1px;
        transform: translateY(-50%);
        background-color: #FF5C3D;
        border: none;
        color: white;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        cursor: pointer;
        a{
        text-decoration:none;
        }
    }

    .dropdown {
        position: absolute;
        top: 110%;
        left: 0;
        width: 100%;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: white;
        padding: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        display: none;
        max-height: 200px;
        overflow-y: auto;
    }

    .dropdown.active {
        display: block;
    }

    .dropdown-section {
        margin-bottom: 10px;
    }

    .dropdown-section h4 {
        margin-bottom: 5px;
        font-size: 16px;
        font-weight: bold;
    }

    .dropdown-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
    }

    .dropdown-item {
        display: flex;
        align-items: center;
    }

    .dropdown-item label {
        margin-left: 5px;
        font-size: 14px;
    }

    .dropdown-item input[type="checkbox"] {
        transform: scale(1.2);
    }

    .tag {
        background-color: #ff5c3d;
        color: white;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 14px;
        display: flex;
        align-items: center;
    }

    .tag span {
        margin-left: 5px;
        cursor: pointer;
        font-weight: bold;
    }
    /*검색바 끝*/

   
</style>
<!-- 카테고리 항목 꾸미기 필요 -->
</head>
<body>
<div class="main">
    <!-- <div class="login-membership">
        <a href="">MYPAGE / LOGOUT</a>
    </div> -->
    <div class="SameSame">SAME SAME</div>



	<div class="login-membership">
	        <% if (loginUser == null) { %>
	            <!-- 로그인 전 -->
	            <a href="<%= contextPath %>/member/login">LOGIN</a> /
	            <a href="<%= contextPath %>/views/manager/managerIndex.jsp">관리자</a>
	        <% } else { %>
	            <!-- 로그인 후 -->
	            <% 
	                String memberNo = loginUser.getMemberNo();
	                char firstChar = memberNo.charAt(0); // MEMBER_NO 첫 글자 확인
	            %>
	            <% if (firstChar == 'B') { %>
	                <a href="<%= contextPath %>/member/mentorMain">MYPAGE</a> /
	            <% } else if (firstChar == 'A') { %>
	                <a href="<%= contextPath %>/views/member/menteePage/main.jsp">MYPAGE</a> /
	            <% } %>
	                 <a href="<%= contextPath %>/member/logout">LOGOUT</a>
	        <% } %>
	</div>

	</div>
	  
	    <!-- <div class="login-membership">
	        <a href="">MYPAGE / LOGOUT</a>
	    </div> -->
	<!--검색창 시작-->
	<div class="search-container">
    <div id="searchInput" class="search-input">
        <input type="text" id="searchText" placeholder="검색어를 입력하세요">
    </div>
    <button class="search-button"> <a href="<%= contextPath %>/search/profile">🔍</a> </button>
    <div id="dropdown" class="dropdown">
        <div class="dropdown-section">
            <h4>성별</h4>
            <div class="dropdown-grid">
                <div class="dropdown-item">
                    <input type="checkbox" id="male" value="남자">
                    <label for="male">남자</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="female" value="여자">
                    <label for="female">여자</label>
                </div>
            </div>


 

        </div>
        <div class="dropdown-section">
            <h4>지역</h4>
            <div class="dropdown-grid">
                <div class="dropdown-item">
                    <input type="checkbox" id="seoul" value="서울">
                    <label for="seoul">서울</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="busan" value="부산">
                    <label for="busan">부산</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="incheon" value="인천">
                    <label for="incheon">인천</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="daejeon" value="대전">
                    <label for="daejeon">대전</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="gwangju" value="광주">
                    <label for="gwangju">광주</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="daegu" value="대구">
                    <label for="daegu">대구</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="ulsan" value="울산">
                    <label for="ulsan">울산</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="jeju" value="제주">
                    <label for="jeju">제주</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="gyeonggi" value="경기도">
                    <label for="gyeonggi">경기도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="chungbuk" value="충청북도">
                    <label for="chungbuk">충청북도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="chungnam" value="충청남도">
                    <label for="chungnam">충청남도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="jeonbuk" value="전라북도">
                    <label for="jeonbuk">전라북도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="jeonnam" value="전라남도">
                    <label for="jeonnam">전라남도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="gyeongbuk" value="경상북도">
                    <label for="gyeongbuk">경상북도</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="gyeongnam" value="경상남도">
                    <label for="gyeongnam">경상남도</label>
                </div>
            </div>
        </div>
        <div class="dropdown-section">
            <h4>과목</h4>
            <div class="dropdown-grid">
                <div class="dropdown-item">
                    <input type="checkbox" id="korean" value="국어">
                    <label for="korean">국어</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="math" value="수학">
                    <label for="math">수학</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="science" value="과학">
                    <label for="science">과학</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="social" value="사회">
                    <label for="social">사회</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="english" value="영어">
                    <label for="english">영어</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="information" value="정보">
                    <label for="information">정보</label>
                </div>
                <div class="dropdown-item">
                    <input type="checkbox" id="foreign" value="제2외국어">
                    <label for="foreign">제2외국어</label>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 검색창 클릭시 카테고리 항목을 나오게 하기위한 script 부분-->
<script>
     const searchInput = document.getElementById("searchInput");
    const dropdown = document.getElementById("dropdown");
    const searchText = document.getElementById("searchText");

    // Show dropdown when search text is focused
    searchText.addEventListener("focus", () => {
        dropdown.classList.add("active");
    });

    // Add/remove tags when checkboxes are clicked
    dropdown.addEventListener("change", (e) => {
        const checkbox = e.target;
        const value = checkbox.value;

        if (checkbox.checked) {
            const tag = document.createElement("div");
            tag.className = "tag";
            tag.textContent = value;

            const removeBtn = document.createElement("span");
            removeBtn.textContent = "×";
            removeBtn.addEventListener("click", () => {
                checkbox.checked = false;
                tag.remove();
            });

            tag.appendChild(removeBtn);
            searchInput.insertBefore(tag, searchText);
        } else {
            const tags = Array.from(searchInput.querySelectorAll(".tag"));
            const tagToRemove = tags.find(tag => tag.textContent.includes(value));
            if (tagToRemove) {
                tagToRemove.remove();
            }
        }
    });

    // Hide dropdown when clicking outside
    document.addEventListener("click", (e) => {
        if (!dropdown.contains(e.target) && !searchInput.contains(e.target)) {
            dropdown.classList.remove("active");
        }
    });
  
</script>

</body>
</html>