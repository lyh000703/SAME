<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kh.member.model.vo.Member" %>
<%
    // 데이터베이스에서 멘티 정보를 가져오는 가정
    Member member = (Member) request.getAttribute("member"); // member 객체를 가져옴
%>
<%!
    // 전화번호 포맷팅 함수
    public String formatPhoneNumber(int phone) {
        String phoneStr = String.valueOf(phone);
        if(phoneStr.length() == 11) {  // 11자리 전화번호
            return phoneStr.substring(0, 3) + "-" 
                 + phoneStr.substring(3, 7) + "-" 
                 + phoneStr.substring(7);
        } else if(phoneStr.length() == 10) {  // 10자리 전화번호
            return phoneStr.substring(0, 2) + "-" 
                 + phoneStr.substring(2, 6) + "-" 
                 + phoneStr.substring(6);
        }
        return phoneStr;  // 그 외의 경우는 원본 반환
    }

    // 주민번호 포맷팅 함수
    public String formatSSN(String ssn) {
        if(ssn != null && ssn.length() == 13) {  // 13자리 주민번호
            return ssn.substring(0, 6) + "-" + ssn.substring(6);
        }
        return ssn;  // 그 외의 경우는 원본 반환
    }
%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멘티 회원 정보</title>
    <style>
         body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #fff;
        }
        .container {
            width: 100%;
	        position: relative;
        }

        .table {
            width: 600px;
            flex-direction: column; /*태그 컬럼형식으로 표기*/
            display: flex;
            font-size: 20px;
           
            background-color: #fff; /* 배경색 추가로 테이블 강조 */
            border: 1px solid #ddd; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 둥글게 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
            margin-left: 40%;
            margin-right: auto;
            margin-top: 5%;
        }
        .header {
            background-color: #FF5C3D;
            color: white;
            text-align: center;
            padding: 10px;
            border-radius: 10px 10px 0 0;
            font-size: 18px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .info-row:last-child {
            border-bottom: none; /* 마지막 행의 경계 제거 */
        }
        .info-label {
            font-weight: bold;
            color: #333;
        }
        .info-value {
            color: #555;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .button {
            background-color: #FF5C3D;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="main">
		<%@ include file="/views/common/mainHeader.jsp"%>
		<!-- 샘샘해더글 -->

		<div class="container">
			<div class="table">
				<!-- 사이드바메뉴 -->
				<%@ include file="/views/common/sidebarManager.jsp"%>
                
                <div class="header">멘티 회원 정보</div>
                <div class="photo-container">
                    <div class="photo"></div>
                </div>
                <div class="info-row">
                    <div class="info-label">아이디</div>
                    <div class="info-value"><%= member.getMemberId() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">이름</div>
                    <div class="info-value"><%= member.getMemberName() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">연락처</div>
                    <div class="info-value">0<%= formatPhoneNumber(member.getPhone()) %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">주민번호</div>
                    <div class="info-value"><%= formatSSN(member.getMemberSSN()) %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Email</div>
                    <div class="info-value"><%= member.getEmail() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">주소</div>
                    <div class="info-value"><%= member.getAddress() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">가입일</div>
                    <div class="info-value"><%= member.getEnrollDate() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">회원상태</div>
                    <div class="info-value"><%= member.getIsQuit().equals("N") ? "활동" : "휴면" %></div>
                </div>
                
                <div class="button-group">
                    <button class="button" onclick="history.back()">목록으로</button>
                    <button class="button" onclick="location.href='<%= request.getContextPath() %>/manager/memberQuit?mno=<%= member.getMemberNo() %>'">탈퇴</button>
                    <button class="button" onclick="location.href='<%= request.getContextPath() %>/manager/memberSuspend?mno=<%= member.getMemberNo() %>'">휴면</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
