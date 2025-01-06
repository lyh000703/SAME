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
	left: 26px;
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
a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: black;
}

/* 로그아웃버튼 속성 */
.button-group {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 10px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    
}

.nav-button {
    background-color: #FF5C3D; /* 요청하신 색상으로 변경 */
    border: none;
    border-radius: 5px;
    color: white; /* 글자색 흰색 */
    padding: 10px 15px;
    cursor: pointer;
    transition: all 0.3s ease;
    width: 100%;
    text-align: center;
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: 700; /* 글자 약간 두껍게 */
    font-size: 14px;
}

.nav-button:hover {
    background-color: gainsboro;
    transform: translateX(5px);
}

.nav-button i {
    font-size: 16px;
    width: 60px;
}

</style>
</head>
<body>
	<div class="Sidebar">
        <!-- 새로 추가하는 버튼 영역 -->
     
        
        <!-- 제목 추가 -->
		<div class="SidebarTitle">MANAGER</div>

		<div class="MenuItems">
            <div class="MenuItem" id="memberInfo">
                <div class="LogoPlaceholder"></div>
                <div class="Label">회원정보</div>
            </div>
            <div class="SubMenu" id="subMenu">
                <div class="MenuItem">
                    <div class="LogoPlaceholder gray"></div>
                    <div class="Label"><a href="<%=contextPath %>/manager/mentorList">멘토 회원정보</a></div>
                </div>
                <div class="MenuItem">
                    <div class="LogoPlaceholder gray"></div>
                    <div class="Label"><a href="<%=contextPath %>/manager/menteeList">멘티 회원정보</a></div>
                </div>
            </div>
            
            <div class="MenuItem" id="boardMenu">
                <div class="LogoPlaceholder gray"></div>
                <div class="Label">게시판</div>
            </div>
            <div class="SubMenu" id="boardSubMenu">
                <div class="MenuItem">
                    <div class="LogoPlaceholder gray"></div>
                    <div class="Label"><a href="<%=contextPath %>/manager/lista">자유게시판</a></div>
                </div>
                <div class="MenuItem">
                    <div class="LogoPlaceholder gray"></div>
                    <div class="Label"><a href="<%=contextPath %>/manager/listb">리뷰게시판</a></div>
                </div>
                <div class="MenuItem">
                    <div class="LogoPlaceholder gray"></div>
                    <div class="Label"><a href="<%=contextPath %>/manager/listc">문의게시판</a></div>
                </div>
            </div>
            
            <div class="MenuItem">
                <div class="LogoPlaceholder gray"></div>
                <div class="Label"><a href="/same/views/manager/category.jsp">카테고리</a></div>
            </div>
            <div class="MenuItem">
                <div class="LogoPlaceholder gray"></div>
                <div class="Label"> <a href="/same/views/manager/transactionList.jsp">결제관리</a></div>
            </div>
            <div class="MenuItem">
                <div class="LogoPlaceholder gray"></div>
                <div class="Label"><a href="<%=contextPath%>/manager/complaint/list">신고관리</a></div>
            </div>
            <div class="MenuItem">
                <div class="LogoPlaceholder gray"></div>
                <div class="Label"><a href="<%=contextPath%>/views/manager/statistic.jsp">통계</a></div>
            </div>
            
        </div>
        <div class="button-group">
            <button class="nav-button" onclick="location.href='<%= contextPath %>/views/manager/managerIndex.jsp'">
                <i class="fas fa-home"></i> 메인페이지
            </button>
            <button class="nav-button" onclick="location.href='<%= request.getContextPath() %>/logout'">
                <i class="fas fa-sign-out-alt"></i> 로그아웃
            </button>
        </div>
	</div>

    <script>
        // 회원정보 클릭 시 서브 메뉴 토글
        document.getElementById('memberInfo').addEventListener('click', function () {
            const subMenu = document.getElementById('subMenu');
            const isOpen = subMenu.style.display === 'flex';
    
            // 모든 서브 메뉴 닫기
            closeAllSubMenus();
    
            // 현재 서브 메뉴 열기 또는 닫기
            subMenu.style.display = isOpen ? 'none' : 'flex';
            // 현재 상태 저장
            localStorage.setItem('memberInfoOpen', subMenu.style.display === 'flex');
    
            // 색상 변경
            if (!isOpen) {
                changeColor(document.querySelector('#memberInfo .LogoPlaceholder'));
            }
        });
    
        // 게시판 클릭 시 서브 메뉴 토글
        document.getElementById('boardMenu').addEventListener('click', function () {
            const boardSubMenu = document.getElementById('boardSubMenu');
            const isOpen = boardSubMenu.style.display === 'flex';
    
            // 모든 서브 메뉴 닫기
            closeAllSubMenus();
    
            // 현재 서브 메뉴 열기 또는 닫기
            boardSubMenu.style.display = isOpen ? 'none' : 'flex';
            // 현재 상태 저장
            localStorage.setItem('boardMenuOpen', boardSubMenu.style.display === 'flex');
    
            // 색상 변경
            if (!isOpen) {
                changeColor(document.querySelector('#boardMenu .LogoPlaceholder'));
            }
        });
    
        // 모든 서브 메뉴 닫기
        function closeAllSubMenus() {
            document.getElementById('subMenu').style.display = 'none';
            document.getElementById('boardSubMenu').style.display = 'none';
            // 색상 초기화
            resetColors();
            // 로컬 스토리지 상태 초기화
            localStorage.setItem('memberInfoOpen', false);
            localStorage.setItem('boardMenuOpen', false);
        }
    
        // 서브 메뉴 상태 복원
        window.addEventListener('load', function() {
            const memberInfoOpen = localStorage.getItem('memberInfoOpen') === 'true';
            const boardMenuOpen = localStorage.getItem('boardMenuOpen') === 'true';
    
            // 상태에 따라 서브 메뉴 표시
            if (memberInfoOpen) {
                document.getElementById('subMenu').style.display = 'flex';
                changeColor(document.querySelector('#memberInfo .LogoPlaceholder')); // 색상 유지
            }
    
            if (boardMenuOpen) {
                document.getElementById('boardSubMenu').style.display = 'flex';
                changeColor(document.querySelector('#boardMenu .LogoPlaceholder')); // 색상 유지
            }
    
            // URL에 따라 선택된 메뉴 아이템을 찾기
            const currentUrl = window.location.href;
            document.querySelectorAll('.MenuItem').forEach(item => {
                const link = item.querySelector('.Label a').href;
                if (link === currentUrl) {
                    const logoPlaceholder = item.querySelector('.LogoPlaceholder');
                    if (logoPlaceholder) {
                        changeColor(logoPlaceholder);
                    }
                }
            });
        });
    
        // LogoPlaceholder 색상 변경 함수
        function changeColor(element) {
            // 모든 LogoPlaceholder에서 빨간색 클래스를 제거
            const placeholders = document.querySelectorAll('.LogoPlaceholder');
            placeholders.forEach(function(placeholder) {
                placeholder.classList.remove('red');
            });
            // 클릭한 LogoPlaceholder에 빨간색 클래스 추가
            element.classList.add('red');
        }
    
        // 색상 초기화 함수
        function resetColors() {
            const placeholders = document.querySelectorAll('.LogoPlaceholder');
            placeholders.forEach(function(placeholder) {
                placeholder.classList.remove('red');
            });
        }
    
        // 현재 선택된 메뉴 아이템을 저장하는 변수
        let selectedMenuItem = null;
    
        // MenuItem 클릭 시 색상 변경 및 페이지 전환
        document.querySelectorAll('.MenuItem').forEach(item => {
            item.addEventListener('click', function (event) {
                // LogoPlaceholder 색상 변경
                const logoPlaceholder = this.querySelector('.LogoPlaceholder');
                if (logoPlaceholder) {
                    changeColor(logoPlaceholder);
                    selectedMenuItem = logoPlaceholder; // 선택된 메뉴 아이템 저장
                }
                // 페이지 전환을 약간 지연
                const link = this.querySelector('.Label a').href; // 링크 주소
                setTimeout(() => {
                    window.location.href = link; // 페이지 전환
                }, 300); // 0.3초 후에 전환
    
                // 클릭 이벤트가 전파되지 않도록 함
                event.stopPropagation();
            });
        });
    </script>
    
    
</body>
</html>