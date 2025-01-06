<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>

<style>
        /* 화면 중앙 배치 스타일 적용 */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* 화면 전체 높이에 맞추기 */
            margin: 0; /* 기본 마진 제거 */
            background-color: white; /* 배경색 추가 */
        }
        .container {
            width: 1440px;
            height: 960px;
            background: white;
            position: relative;
        }
        .box {
            width: 258px;
            height: 85px;
            background: #FF5C3D;
            border-radius: 5px;
            position: absolute;
            display: flex; /* 내부 요소를 중앙에 배치하기 위한 설정 */
            justify-content: center;
            align-items: center;
            cursor: pointer; /* 마우스 포인터 변경 */
            text-decoration: none; /* 링크의 기본 밑줄 제거 */
            color: white; /* 글자 색상 */
        }
        .게시판 {
            left: 609px;
            top: 413px;
        }
        .회원정보 {
            left: 258px;
            top: 413px;
        }
        .결제관리 {
            left: 442px;
            top: 705px;
        }
        .신고관리 {
            left: 0px;
            top: 0px;
        }

     
        .Group0 {
            width: 1000px;
            height: 361px;
            top: 410px;
            left: 220px;
            position: absolute;
        }
        .Group .회원정보 {
            left: 0px;
            top: 0px;
        }
        
        .Group .카테고리 {
            left: 800px;
            top: 0px;
        }
        .Group .게시판 {
            left: 400px;
            top: 0px;
        }
        .Group .결제관리 {
            left: 0px;
            top: 300px;
        }
        .Group .신고관리 {
            left: 400px;
            top: 300px;
        }
        .Group .통계 {
            left: 800px;
            top: 300px;
        }
        
        .title {
            width: 816px;
            height: 238px;
            left: 355px;
            top: 89px;
            position: absolute;
            color: #FF5C3D;
            font-size: 128px;
            font-family: Prompt;
            font-weight: 700;
            word-wrap: break-word;
        }
        
        .Component {
            width: 80px;
            position: absolute;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            display: inline-flex;
        }
        .Component6 {
            left: 1350px;
            top: 24px;
        }
        .Component7 {
            left: 1253px;
            top: 24px;
        }

        /* 드롭다운 스타일 */
       
        .dropdown {
            display: none; /* 기본적으로 숨김 */
            position: absolute;
            left: 0; /* 그룹의 왼쪽에 정렬 */
            top: 85px; /* 박스 아래에 위치 */
            background: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 2; /* 드롭다운이 위에 표시되도록 설정 */
            width: 258px; /* 드롭다운 너비 설정 */
        }

        .board-dropdown {
            display: none; /* 기본적으로 숨김 */
            position: absolute;
            left: 400px;
            top: 85px; /* 박스 아래에 위치 */
            background: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 2; /* 드롭다운이 위에 표시되도록 설정 */
            width: 258px; /* 드롭다운 너비 설정 */
        }

        .dropdown a, .board-dropdown a {
            display: block;
            height: 40px; /* 드롭다운 항목 높이 */
            background: white; /* 드롭다운 항목 배경색 */
            color: rgb(7, 7, 7); /* 글자 색상 */
            text-align: center; /* 중앙 정렬 */
            line-height: 40px; /* 세로 가운데 정렬 */
            text-decoration: none; /* 링크의 기본 밑줄 제거 */
        }
        .title {
            width: 816px;
            height: 238px;
            left: 355px;
            top: 89px;
            position: absolute;
            color: #FF5C3D;
            font-size: 128px;
            font-family: Prompt;
            font-weight: 700;
            word-wrap: break-word;
        }
        
        .Component {
            width: 80px;
            position: absolute;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            display: inline-flex;
        }
        .Component6 {
            left: 1350px;
            top: 24px;
        }
        .Component7 {
            left: 1253px;
            top: 24px;
        }
       
        a{
        text-decoration-line : none;
        color: black;
        }
    </style>
</head>
<body>

    <div>

        <div class="container">
            <%@ include file="/views/common/mainHeader.jsp" %> <!-- 샘샘해더글 -->
        <!-- 각 링크 필요한 박스 부분 -->
        <!-- <a href="" class="box 회원정보" style="font-size: 25px;" onclick="toggleUserDropdown(event)">회원정보</a> -->
        <!-- <a href="" class="box 게시판" style="font-size: 25px;" onclick="toggleBoardDropdown">게시판</a> -->
       <div class="Group0">

           <div class="Group">
               <a href="" class="box 회원정보" style="font-size: 25px;" onclick="toggleUserDropdown(event)"">회원정보</a>
               <div class="dropdown" id="userDropdown">
                <a href="<%=contextPath %>/manager/menteeList">멘티 회원정보</a>
                <a href="<%=contextPath %>/manager/mentorList">멘토 회원정보</a>
            </div>
           </div>
   
           <div class="Group">
               <a href="/same/views/manager/transactionList.jsp" class="box 결제관리" style="font-size: 25px;">결제관리</a>
           </div>
   
           <div class="Group">
               <a href="" class="box 게시판" style="font-size: 25px;" onclick="toggleBoardDropdown(event)">게시판</a>
               <div class="board-dropdown" id="boardDropdown">
                <a href="<%=contextPath %>/manager/lista">자유게시판</a>
                <a href="<%=contextPath %>/manager/listb">리뷰게시판</a>
                <a href="<%=contextPath %>/manager/listc">문의게시판</a>
            </div>
           </div>
           <div class="Group">
               <a href="/same/views/manager/category.jsp" class="box 카테고리" style="font-size: 25px;">카테고리</a>
           </div>
           <div class="Group">
               <a href="/same/views/manager/complaintList.jsp" class="box 신고관리" style="font-size: 25px;">신고관리</a>
           </div>
           <div class="Group">
               <a href="/same/views/manager/statistic.jsp" class="box 통계" style="font-size: 25px;">통계</a>
           </div>
       </div>

        
        <!-- 우상단 관리자 관리 설정 링크 필요? -->
        <div class="Component Component6">
            <div class="text-small"><a href="">관리자설정</a></div>
        </div>
        <div class="Component Component7">
            <div class="text-small"><a href="">관리자님</a></div>
        </div>
    </div>

    <!-- 드롭다운JS -->
    <script>
        function toggleUserDropdown(event) {
            event.preventDefault(); // 링크 기본 동작 방지
            const dropdown = document.getElementById('userDropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block'; // 드롭다운 토글
            document.getElementById('boardDropdown').style.display = 'none'; // 게시판 드롭다운 숨기기
        }

        function toggleBoardDropdown(event) {
            event.preventDefault(); // 링크 기본 동작 방지
            const boardDropdown = document.getElementById('boardDropdown');
            boardDropdown.style.display = boardDropdown.style.display === 'block' ? 'none' : 'block'; // 게시판 드롭다운 토글
            document.getElementById('userDropdown').style.display = 'none'; // 사용자 드롭다운 숨기기
        }

        // 클릭 시 드롭다운 메뉴가 닫히도록
        window.onclick = function(event) {
            if (!event.target.matches('.box')) {
                const userDropdown = document.getElementById('userDropdown');
                const boardDropdown = document.getElementById('boardDropdown');
                userDropdown.style.display = 'none';
                boardDropdown.style.display = 'none';
            }
        }
    </script>
    </div>
</body>
</html>