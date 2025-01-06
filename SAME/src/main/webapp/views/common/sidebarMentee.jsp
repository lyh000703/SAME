<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.Sidebar {
	position: absolute;
	width: 256px;
	top: 0; /* 위치 조정 */
	left: 0px;
}

.SidebarTitle {
	font-size: 32px;
	font-family: 'Prompt', sans-serif;
	font-weight: bolder;
	font-weight: 700;
	color: #FF5C3D;
	margin-bottom: 16px;
	text-align: left; /* 텍스트 왼쪽 정렬 */
}


.MenuItems {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.MenuItem {
	width: 256px;
	height: 40px;
	padding: 0 16px;
	background: white;
	border-radius: 8px;
	display: flex;
	align-items: center;
	gap: 16px;
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	cursor: pointer; /* 클릭 가능하게 변경 */
}

.SubMenu {
	display: none; /* 기본적으로 숨김 */
	flex-direction: column;
	gap: 8px;
	padding-left: 16px; /* 서브 메뉴의 위치 조정 */
}

.LogoPlaceholder {
	width: 24px;
	height: 24px;
	background: #D9D9D9;
	border-radius: 9999px;
	transition: background 0.3s; /* 부드러운 색상 전환 */
}

.LogoPlaceholder.red {
	background: #FF5C3D; /* 빨간색 */
}

.Label {
	flex: 1;
	color: black;
	font-size: 16px;
	font-family: Inter, sans-serif;
	font-weight: 500;
	line-height: 24px;
}
</style>
</head>
<body>
	<div class="Sidebar">
		<!-- 제목 추가 -->
		<div class="SidebarTitle">MYPAGE</div>

		<div class="MenuItems">
			<div class="MenuItem" id="boardMenu">
				<div class="LogoPlaceholder gray"></div>
				<div class="Label">마이페이지</div>
			</div>
			<div class="SubMenu" id="boardSubMenu">
				<div class="MenuItem">
					<div class="LogoPlaceholder gray"></div>
					<div class="Label"><a href="${pageContext.request.contextPath}/views/member/menteePage/cart.jsp">장바구니</a></div>
				</div>
				<div class="MenuItem">
					<div class="LogoPlaceholder gray"></div>
					<div class="Label"><a href="${pageContext.request.contextPath}/transaction/list">구매내역</a></div>
				</div>
				<div class="MenuItem">
					<div class="LogoPlaceholder gray"></div>
					<div class="Label"><a href="${pageContext.request.contextPath}/board/list">커뮤니티</a></div>
				</div>
				<div class="MenuItem">
					<div class="LogoPlaceholder gray"></div>
					<div class="Label"><a href="${pageContext.request.contextPath}/board/listc">문의내역</a></div>
				</div>
			</div>
		</div>
	</div>

	<script>
        // LogoPlaceholder 색상 변경 함수
        function changeLogoColor(clickedLogo) {
            // 모든 LogoPlaceholder의 색상을 초기화
            const placeholders = document.querySelectorAll('.LogoPlaceholder');
            placeholders.forEach(placeholder => {
                placeholder.classList.remove('red');
            });

            // 클릭한 LogoPlaceholder만 색상을 활성화
            clickedLogo.classList.add('red');
        }

        // MenuItem 클릭 시 이벤트 처리
        document.querySelectorAll('.MenuItem').forEach(menuItem => {
            menuItem.addEventListener('click', function (event) {
                // 클릭한 요소 중 LogoPlaceholder가 있는지 확인
                const logoPlaceholder = this.querySelector('.LogoPlaceholder');
                if (logoPlaceholder) {
                    changeLogoColor(logoPlaceholder);
                }

                // 클릭 이벤트가 전파되지 않도록 방지
                event.stopPropagation();
            });
        });

        // 게시판 메뉴 클릭 시 서브 메뉴 토글
        document.getElementById('boardMenu').addEventListener('click', function () {
            const boardSubMenu = document.getElementById('boardSubMenu');
            boardSubMenu.style.display = boardSubMenu.style.display === 'none' ? 'flex' : 'none';
        });
    </script>
</body>
</html>