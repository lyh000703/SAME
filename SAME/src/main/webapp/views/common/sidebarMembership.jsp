<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

String memberType = request.getParameter("memberType"); // URL 파라미터에서 memberType 추출

// 기본값 설정
if (memberType == null || memberType.isEmpty()) {
	response.sendRedirect(request.getRequestURL() + "?memberType=A");
	return; // 리다이렉트 후 더 이상 코드를 실행하지 않음
}

// 디버깅 코드
System.out.println("DEBUG: Full URL = " + request.getRequestURL() + "?" + request.getQueryString());
System.out.println("DEBUG: memberType = " + memberType);
System.out.println("DEBUG: Trimmed memberType = [" + memberType.trim() + "]");

if ("B".equals(memberType.trim())) {
	System.out.println("DEBUG: 멘토 회원가입 조건 만족");
} else {
	System.out.println("DEBUG: 멘티 회원가입 조건 만족");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Membership</title>
<style>
.Sidebar {
	position: fixed;
	width: 256px;
	height: 100vh;
	padding: 16px;
	display: flex;
	flex-direction: column;
}

.SidebarTitle {
	font-size: 32px;
	font-family: 'Prompt', sans-serif;
	font-weight: 700;
	color: #FF5C3D;
	margin-bottom: 16px;
}

.MenuItems {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.MenuItem {
	width: 100%;
	height: 40px;
	padding: 0 16px;
	background: white;
	border-radius: 8px;
	display: flex;
	align-items: center;
	gap: 16px;
	cursor: pointer;
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	transition: background 0.3s;
}

.SubMenu {
	display: none; /* 기본적으로 숨김 */
	flex-direction: column;
	gap: 8px;
	padding-left: 16px;
}

.LogoPlaceholder {
	width: 24px;
	height: 24px;
	background: #D9D9D9;
	border-radius: 50%;
	transition: background 0.3s;
}

.LogoPlaceholder.red {
	background: #FF5C3D;
}

.Label {
	flex: 1;
	color: black;
	font-size: 16px;
	font-family: Inter, sans-serif;
	font-weight: 500;
	line-height: 24px;
}

a {
	color: black;
	text-decoration: none;
}

.MenuItem.active .LogoPlaceholder {
	background: #FF5C3D;
}

.MenuItem.active .Label {
	font-weight: bold;
	color: #FF5C3D;
}

</style>
</head>
<body>
	<div class="Sidebar">
		<div class="SidebarTitle">MEMBERSHIP</div>
		<div class="MenuItems">
			<div class="MenuItem">
				<div class="LogoPlaceholder"></div>
				<div class="Label">
					<a href="${pageContext.request.contextPath}/views/member/login.jsp">로그인</a>
				</div>
			</div>
			<div class="MenuItem" id="boardMenu">
				<div class="LogoPlaceholder"></div>
				<div class="Label">회원가입</div>
			</div>
			<div class="SubMenu" id="boardSubMenu">
				<div class="MenuItem">
					<div class="LogoPlaceholder"></div>
					<div class="Label">
						<a href="${pageContext.request.contextPath}/views/member/signup.jsp?memberType=A">멘티
							회원가입</a>
					</div>
				</div>
				<div class="MenuItem">
					<div class="LogoPlaceholder"></div>
					<div class="Label">
						<a href="${pageContext.request.contextPath}/views/member/signup.jsp?memberType=B">멘토
							회원가입</a>
					</div>
				</div>
			</div>
			<div class="MenuItem">
				<div class="LogoPlaceholder"></div>
				<div class="Label">문의게시판</div>
			</div>
		</div>
	</div>

	<script>
    // LogoPlaceholder 색상 변경 함수
    function changeLogoColor(clickedLogo) {
        const placeholders = document.querySelectorAll('.LogoPlaceholder');
        placeholders.forEach(placeholder => {
            placeholder.classList.remove('red'); // 기존 색상 제거
        });
        clickedLogo.classList.add('red'); // 클릭한 요소에 색상 추가
    }

 // 서브메뉴 토글 함수
    function toggleSubMenu() {
        const boardSubMenu = document.getElementById('boardSubMenu');
        const currentDisplay = boardSubMenu.style.display;

        if (currentDisplay === 'none' || currentDisplay === '') {
            boardSubMenu.style.display = 'flex'; // 서브메뉴 열기
        } else {
            boardSubMenu.style.display = 'none'; // 서브메뉴 닫기
        }
    }

    // MenuItem 클릭 이벤트 처리
    document.querySelectorAll('.MenuItem').forEach(menuItem => {
        menuItem.addEventListener('click', function (event) {
            const logoPlaceholder = this.querySelector('.LogoPlaceholder');
            const link = this.querySelector('a');

            // LogoPlaceholder 색상 변경
            if (logoPlaceholder) {
                changeLogoColor(logoPlaceholder);
            }

            // 링크가 있는 경우 페이지 이동
            if (link) {
                const url = link.href;

                // 페이지 전환을 약간 지연
                setTimeout(() => {
                    window.location.href = url;
                }, 300); // 0.3초 지연
            } else {
                // 서브메뉴 토글 처리
                if (this.id === 'boardMenu') {
                    toggleSubMenu();
                }
            }

            // 이벤트 전파 방지
            event.stopPropagation();
        });
    });

    // 초기 서브메뉴 닫기
    window.addEventListener('load', function () {
        const boardSubMenu = document.getElementById('boardSubMenu');
        boardSubMenu.style.display = 'none'; // 기본적으로 닫힘
    });

    // 클릭 이벤트 전파 방지
    document.getElementById('boardSubMenu').addEventListener('click', function (event) {
        event.stopPropagation(); // 부모 메뉴로 이벤트 전파 방지
    });
    
    
    </script>
</body>
</html>