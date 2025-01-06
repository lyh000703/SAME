<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, 
                 java.util.ArrayList,
                 com.kh.manager.model.vo.Complaint, 
                 com.kh.common.model.vo.PageInfo" %>
<%
    List<Complaint> list = (List<Complaint>) request.getAttribute("list");
    PageInfo pi = (PageInfo) request.getAttribute("pi");
    
    if(list == null) list = new ArrayList<>();
    
    int currentPage = 1;
    int startPage = 1;
    int endPage = 1;
    int maxPage = 1;
    
    if(pi != null) {
        currentPage = pi.getCurrentPage();
        startPage = pi.getStartPage();
        endPage = pi.getEndPage();
        maxPage = pi.getMaxPage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고목록 관리</title>
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
        
        .Title {
            width: 100%;
            font-weight: 900;
            font-size: 20px;
            text-align: left;
            padding-left: 20px;
        }
        
        a {
            text-decoration: none;
            color: black;
        }
        
        .table-header, .table-row {
            display: grid;
            grid-template-columns: 0.5fr 1fr 1fr 1fr 2fr 1fr 1fr;
            align-items: center;
        }
        
        .table-header {
            background-color: #f9f9f9;
            font-weight: 500;
            text-align: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        
        .table-row {
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .table-row div {
            padding: 10px 0;
        }
        
        .table-row:nth-child(even) {
            background-color: #fdfdfd;
        }
        
        .table-row:nth-child(odd) {
            background-color: #ffffff;
        }
        
        .status {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status.y {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        
        .status.n {
            background-color: #ffebee;
            color: #c62828;
        }
        
        .paging-area {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 5px;
        }
        
        .paging-area button {
            border: none;
            padding: 5px 10px;
            background-color: #f0f0f0;
            cursor: pointer;
            border-radius: 3px;
        }
        
        .paging-area button.on {
            background-color: #4a4a4a;
            color: white;
        }
        
        .search-section {
            display: flex;
            justify-content: flex-end;
            padding: 10px 20px;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
        }
        
        .search-box input, .search-box select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        
        .search-box button {
            padding: 5px 15px;
            background-color: #4a4a4a;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="main">
        <%@ include file="/views/common/mainHeader.jsp" %>
        
        <div class="container">
            <div class="table">
                <%@ include file="/views/common/sidebarManager.jsp" %>
                
                <div class="Title">
                    <div class="search-section">
                        <div class="search-box">
                            <input type="text" id="search-input" placeholder="검색어를 입력하세요...">
                            <select id="search-type">
                                <option value="all">전체</option>
                                <option value="member">신고자</option>
                                <option value="type">신고유형</option>
                                <option value="content">신고내용</option>
                            </select>
                            <button onclick="searchComplaints()">검색</button>
                        </div>
                    </div>
                    <div class="PlaylistSectionTitle">신고게시판_관리모드</div>
                </div>

                <div class="table-header">
                    <div>번호</div>
                    <div>신고자번호</div>
                    <div>게시글번호</div>
                    <div>신고유형</div>
                    <div>신고내용</div>
                    <div>신고일</div>
                    <div>처리상태</div>
                </div>

                <% if(list.isEmpty()) { %>
                    <div class="table-row">
                        <div style="grid-column: 1 / -1; text-align: center; padding: 20px;">
                            조회된 신고 내역이 없습니다.
                        </div>
                    </div>
                <% } else { %>
                    <% for(Complaint c : list) { %>
                        <div class="table-row">
                            <div><%= c.getCompNo() %></div>
                            <div><%= c.getMemberNo() %></div>
                            <div>
                                <a href="<%=request.getContextPath()%>/manager/complaint/detail?no=<%= c.getCompNo() %>">
                                    <%= c.getBoardNo() %>
                                </a>
                            </div>
                            <div><%= c.getCompType() %></div>
                            <div><%= c.getCompContent() %></div>
                            <div><%= c.getCompDate() %></div>
                            <div class="status <%= c.getIsConfirm() != null ? c.getIsConfirm().toLowerCase() : "" %>">
                                <%= "Y".equals(c.getIsConfirm()) ? "처리완료" : "처리중" %>
                            </div>
                        </div>
                    <% } %>
                <% } %>

                <% if(!list.isEmpty()) { %>
                    <div class="paging-area">
                        <% if(currentPage != 1) { %>
                            <button onclick="movePage(<%= currentPage - 1 %>)">&lt;</button>
                        <% } %>
                        
                        <% for(int p = startPage; p <= endPage; p++) { %>
                            <button onclick="movePage(<%= p %>);"
                                <%= (currentPage == p) ? "class='on'" : "" %>>
                                <%= p %>
                            </button>
                        <% } %>
                        
                        <% if(currentPage != maxPage) { %>
                            <button onclick="movePage(<%= currentPage + 1 %>)">&gt;</button>
                        <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        function movePage(cpage) {
            location.href = '<%=request.getContextPath()%>/manager/complaint/list?cpage=' + cpage;
        }

        function searchComplaints() {
            const searchType = document.getElementById('search-type').value;
            const searchKeyword = document.getElementById('search-input').value;
            
            if(!searchKeyword.trim()) {
                alert('검색어를 입력해주세요.');
                return;
            }
            
            location.href = '<%=request.getContextPath()%>/manager/complaint/search'
                + '?type=' + searchType
                + '&keyword=' + encodeURIComponent(searchKeyword);
        }

        document.getElementById('search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchComplaints();
            }
        });
    </script>
</body>
</html>