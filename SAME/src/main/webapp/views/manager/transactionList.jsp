<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

  <title>결제목록 관리</title>

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
      width: 100%;
      position: relative;
    }
		 
    /*상세설정기본박스설정값*/
    /* 게시판스타일 시작 */
    .table {
      width: 910px;
      flex-direction: column; /*태그 컬럼형식으로 표기*/
      display: flex;
      font-size: 14px;
      /* border-collapse: collapse; 테이블 경계 합치기 */
      /* font-family: 'Inter', sans-serif;  본문 글꼴 설정*/
      background-color: #fff; /* 배경색 추가로 테이블 강조 */
      border: 1px solid #ddd; /* 테두리 추가 */
      border-radius: 5px; /* 테두리 둥글게 */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
      margin-left: 27%;
      margin-right: auto;
      margin-top: 5%;
    }
    

  .filter-row {
    display: flex;
    align-items: center;
    padding: 10px 10px;
  }

  .filter-item {
    width: 120px;
    text-align: center;
    font-size: 14px;
    font-weight: 600;
    color: #333;
  }

  .filter-content {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .date-input,
  .text-input {
    border: 1px solid #dcdcdc;
    border-radius: 5px;
    padding: 8px;
    font-size: 14px; 
    width: 200px;
  }

  .date-separator {
    font-size: 14px;
    color: #666;
  }

  .text-input {
    width: 150px;
  }

  .radio-group label {
    margin-right: 15px;
    font-size: 14px;
    font-weight: 500;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
  }
  .radio-group input {
    margin-right: 5px;
  }

  .search-button {
    background: #ff5c3d;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background 0.3s ease;
  }

  /* 구분선 스타일 */
  .divider {
    width: 100%;
    height: 1px;
    background: #e0e0e0;
  }


  /* 게시판 시작 */
  
  .table-header,
  .table-row {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr 2fr 1fr 1fr 1fr; /* 열 너비 비율 조정 */
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

  .pagination {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;

  }

  .pagination-button {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
  }

  .page-number {
    margin: 0 5px;
    font-size: 14px;
    cursor: pointer;
}
     

 	a {
    text-decoration: none; /* 링크의 밑줄 제거 */
    color: black;
    
    }
</style>
</head>
<body>
  <div class="main">
    <%@ include file="/views/common/mainHeader.jsp" %> <!-- 샘샘해더글 -->
    
    <div class="container">
        
      <div class="table">
            <%@ include file="/views/common/sidebarManager.jsp" %> <!-- 사이드바메뉴 -->
          
            <div class="filter-row">
              <div class="filter-item">
                <label for="start-date">정산등록일</label>
              </div>
              <div class="filter-content">
                <input type="date" id="start-date" class="date-input" value="2024-12-01" />
                <span class="date-separator">~</span>
                <input type="date" id="end-date" class="date-input" value="2024-12-01" />
              </div>
            </div>
            <div class="divider"></div>
            <div class="filter-row">
              <div class="filter-item">
                <label>정산처리상태</label>
              </div>
              <div class="filter-content radio-group">
                <label><input type="radio" name="status" value="all" checked /> 전체</label>
                <label><input type="radio" name="status" value="processed" /> 처리</label>
                <label><input type="radio" name="status" value="unprocessed" /> 미처리</label>
              </div>
            </div>
            <div class="divider"></div>
            <div class="filter-row">
              <div class="filter-item">
                <label for="mentee-name">멘티명</label>
              </div>
              <div class="filter-content">
                <input type="text" id="mentee-name" class="text-input" placeholder="검색어 입력" />
                <button class="search-button">검색</button>
              </div>
            </div>
         
            
            
              <div class="table-header">
                <div>거래번호</div>
                <div>강좌명</div>
                <div>멘티명</div>
                <div>수업 기간</div>
                <div>결제수단</div>
                <div>거래액</div>
                <div>정산 상태</div>
              </div>
              <!-- 반복되는 행 -->
              <div class="table-row">
                <div>NO_100</div>
                <div>중국어 강의 초급반</div>
                <div>홍길동</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>신용카드</div>
                <div>15,000</div>
                <div>처리</div>
              </div>
                <!-- 추가 행들 -->
              <div class="table-row">
                <div>NO_99</div>
                <div>영어 강의 초급반</div>
                <div>김철수</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>일본어 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>수학 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>국영수 강의 초급반</div>
                <div>이영희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>중국어 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>중국어 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>중국어 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
              <div class="table-row">
                <div>NO_99</div>
                <div>중국어 강의 초급반</div>
                <div>정상희</div>
                <div>2024-12-01 ~ 2024-12-15</div>
                <div>카카오페이</div>
                <div>15,000</div>
                <div>미처리</div>
              </div>
          
            
        </div>
    </div>
  </div>
      
     

</body>
</html>
