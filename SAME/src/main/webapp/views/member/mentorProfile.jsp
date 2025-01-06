<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /* 컨테이너 */
        .container {
            display: flex;
        flex-direction: column;
        width: 920px;
        margin-left: auto;
        margin-right: auto;
        margin-top: 5%;
        }

        /* 헤드 부분  */
        .head-box {
          width: 308px;
          height: 266px;
          background: white;
          border-radius: 5px;
          border: 1px solid #828282;
        }
        /* 프로필 이미지 */
        .profile-image {
          width: 256px;
          height: 256px;
        }
        .profile-info{
          position: relative;
          top: -70%;
          left: 330px;
          line-height: 1.5;
        }
        .info-item-name {
            font-size: 20px;
            font-weight: 1000;
            font: bold;
            margin-bottom: 5px;
        }
        .info-item-side{
            font-size: 20px;
        }

        /* 고용횟수 강의별점 전체경력*/
        .middle-box {
            height: 1000px;
        }
        .stats {
            border: 1px solid;
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            text-align: center;
         }
        .stat-item .label {
            font-size: 15px;
            font-weight: 800;
            margin-bottom: 5px; 
        }
        .stat-item .value {
            font-size: 30px;
            font-weight: 1000;
            font: bold;
            color: #FF5C3D;
        }
        /* 고용횟수 강의별점 전체경력 끝 */

        /* 상단바 + 상세정보 */
        .under-box {
            border: 1px solid;
        }
        .top-bar {
            height: 50px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            font-size: 18px;
            background-color: #FF5C3D;
            color: white ;
            margin-bottom: 20px;
            cursor: pointer;
        }
        .section-title {
            font-size: 16px;
            font-weight: bold;
            padding: 15px;
        }
        .info-item {
            display: flex;
            margin-left: 30px;
            margin-bottom: 10px;
        }
        .info-item .label {
            margin-right: 5px;
        }
        .selected {
            background-color: #FF5C3D;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            margin-right: 10px;
            display: flex;
            align-items: center;
        }
        .info-item .value-side {
            margin-left: 30px;
        }
        /* 상단바 + 상세정보 끝 */

        /* 스케줄표 */        
        .calendar-container {
            border: 1px solid #ff5c3d;
            border-radius: 4px;
            width: 917px;
            font-family: 'Inter', sans-serif;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5c3d;
            color: white;
            padding: 10px 20px;
        }

        .nav-button {
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            padding: 10px;
        }

        .day-name {
            text-align: start;
            font-weight: bold;
            background-color: #ff5c3d;
            color: white;
            padding: 5px;
        }

        .date-cell {
            width: 100px;
            height: 80px;
            text-align: start;
            padding: 5px;
            border-radius: 4px;
            cursor: pointer; /* 포인터 커서 추가 */
        }
       
        .date-cell:hover {
            background-color: #f5f5f5;
        }

        /* 팝업 스타일 */
        .popup {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000; /* 다른 요소 위에 표시 */
            width: 300px; /* 팝업 너비 */
            height: auto;
        }

        .popup h3 {
            margin: 0 0 15px; /* 제목과 버튼 간의 간격 */
        }

        .time-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px; /* 시간 버튼 간격 */
            margin-bottom: 15px; /* 선택 버튼과의 간격 */
        }

        .time-button, .dc-button{
            justify-content: center;
            width: 90px;
            height: 60px;
            padding: 0%;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #ff5c3d;
            cursor: pointer;
            text-align: center;
            font-size: 13px;
            color: white;
        }

        .time-button.selected {
            background-color: #ff5c3d; /* 선택된 시간 버튼 색상 */
            color: white; /* 선택된 시간 버튼 텍스트 색상 */
        }

        #confirm-button {
            width: 100%; /* 버튼 너비 100% */
            padding: 10px;
            background-color: #ff5c3d; /* 버튼 색상 */
            color: white; /* 버튼 텍스트 색상 */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        
        .popup-background {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
            z-index: 999; /* 팝업 뒤에 배치 */
        }
        /* 스케줄표 끝 */

        /* 강의리뷰 */
        .review {
            margin-top: 3%;
            padding: 15px;
        }
        .plus {
            margin-left: 94%;
            margin-bottom: 2%;
        }
        .review-item {
            border: 1px solid;
            justify-content: space-evenly;
            align-items: center;
            padding: 10px;
            margin-bottom: 3%;
            border-radius: 5px;
        }
        .review-title {
            font: bold;
        }
        /* 강의리뷰 끝 */

        /* 포트폴리오 */
        .portfolio {
            padding: 15px;
            margin-top: -10px;
        }
        .education span , .experience span , .language span{
            font-size: 16px;
            font-weight: bold;
            padding: 15px;

        }
        .education {
            margin-top: 20px;
        }
        .education-item {
            display: flex;
            margin-bottom: 9px;
        }

        .experience {
            margin-top: 20px;
        }

        .experience-item {
            display: flex;
            margin-bottom: 9px;
        }

        .language {
            margin-top: 20px;
        }

        .language-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 9px;
        }

        .item-box {
            width: 100%; 
            padding: 10px; 
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-top: 5px;
        }

        .file-input {
            display: none; /* 파일 선택 버튼 숨기기 */
        }
        /* 포트폴리오 끝*/
    </style>
</head>
<body>
    <div class="container">
        <div class="head-box">
            <img class="profile-image" src="https://via.placeholder.com/256x256" alt="Profile Image" />
            <div class="profile-info">
                <div class="info-item-name">
                    <div class="value">(아니두할수있어) 채소연</div>
                </div>
                <div class="info-item-side">
                    <div class="value">컴퓨터/PPT  경기도 이천시<br>PPT 만들기에 필요한 모든 것<br>한번의 수업으로 해결하세요</div>
                </div>
            </div>
        </div>

        <div class="middle-box">
            <div class="stats">
                <div class="stat-item">
                    <div class="label">고용횟수</div>
                    <div class="value">7</div>
                </div>
                <div class="stat-item">
                    <div class="label">강의별점</div>
                    <div class="value">3.5</div>
                </div>
                <div class="stat-item">
                    <div class="label">전체경력</div>
                    <div class="value">3개월</div>
                </div>
            </div>
            
            <div class="under-box">
                <div class="information">
                    <div class="top-bar">
                        <div class="label">상세정보</div>
                        <div class="label">스케줄표</div>
                        <div class="label">강의리뷰</div>
                        <div class="label">포트폴리오</div>
                    </div>
                    <div class="section-title">고수 정보</div>
                    <div class="info-item">
                        <div class="label">고수 이름:</div>
                        <div class="value">채소연</div>
                    </div>
                    <div class="info-item">
                        <div class="label">고수 경력:</div>
                        <div class="value">3개월</div>
                    </div>
                    <div class="info-item">
                        <div class="label">결제 방법:</div>
                        <div class="value">카카오페이 / 신용카드</div>
                    </div>
                    <div class="info-item">
                        <div class="label">제공 서비스:</div>
                        <span class="selected">PPT <span class="remove">×</span></span>
                        <span class="selected">Figma <span class="remove">×</span></span>
                    </div>
    
                    <div class="section-title">서비스 상세설명</div>
                    <div class="info-item">
                        <div class="value">1장 디자인 고르기</div>
                    </div>
                    <div class="info-item">
                        <div class="value-side">망고보드</div>
                        <div class="value-side">미리캔버스</div>
                    </div>
                    <div class="info-item">
                        <div class="value">2장 유료/무료 선택하기</div>
                    </div>
                    <div class="info-item">
                        <div class="value-side">돈많으면 유료 추천</div>
                    </div>
                </div>
               
                <br>
                <hr>

                <div class="schedul">
                    <div id="popup-background" class="popup-background"></div>
                    <div id="calendar-container" class="calendar-container">
                        <div id="calendar-header" class="calendar-header">
                            <button id="prev-month" class="nav-button">◀</button>
                            <span id="month-title" class="month-title"></span>
                            <button id="next-month" class="nav-button">▶</button>
                        </div>
                        <div class="calendar-grid">
                            <!-- 요일 -->
                            <div class="day-name">일</div>
                            <div class="day-name">월</div>
                            <div class="day-name">화</div>
                            <div class="day-name">수</div>
                            <div class="day-name">목</div>
                            <div class="day-name">금</div>
                            <div class="day-name">토</div>
                        </div>
                    </div>
                
                    <!-- 팝업 -->
                    <div id="popup" class="popup">
                        <h3>시간 선택</h3>
                        <div class="">
                            <button class="time-button" data-time="09:00">09:00</button>
                            <button class="time-button" data-time="10:00">10:00</button>
                            <button class="time-button" data-time="11:00">11:00</button>
                            <button class="time-button" data-time="12:00">12:00</button>
                            <button class="time-button" data-time="13:00">13:00</button>
                            <button class="time-button" data-time="14:00">14:00</button>
                            <button class="time-button" data-time="15:00">15:00</button>
                            <button class="time-button" data-time="16:00">16:00</button>
                            <button class="time-button" data-time="17:00">17:00</button>
                            <button class="time-button" data-time="18:00">18:00</button>
                            <button class="time-button" data-time="19:00">19:00</button>
                            <button class="time-button" data-time="20:00">20:00</button>
                            <button class="time-button" data-time="21:00">21:00</button>
                            <button class="time-button" data-time="22:00">22:00</button>
                            <button class="time-button" data-time="23:00">23:00</button>
                            <button class="time-button" data-time="합의">합의</button>
                            <button id="delete-time" class="dc-button">삭제</button> <!-- 시간 삭제 버튼 추가 -->
                            <button id="close-popup" class="dc-button">닫기</button>
                        </div>
                    </div>
                
                
                    <script>
                        let currentDate = new Date(); 
                        document.addEventListener("DOMContentLoaded", () => {
                            renderCalendar(currentDate); // 초기 렌더링 시 현재 날짜로 달력 표시
                        });

                        const bookedTimes = []; // 예약된 시간을 저장하는 배열
                        const calendarGrid = document.querySelector(".calendar-grid");
                        const monthTitle = document.getElementById("month-title");
                        const prevMonthButton = document.getElementById("prev-month");
                        const nextMonthButton = document.getElementById("next-month");
                        const popup = document.getElementById("popup");
                        const popupBackground = document.getElementById("popup-background");
                        const closePopupButton = document.getElementById("close-popup");
                        const deleteTimeButton = document.getElementById("delete-time");
                        let selectedDayCell = null; // 선택된 날짜 셀 저장
                    
                        function renderCalendar(date) {
                            // 현재 월과 년도
                            const year = date.getFullYear();
                            const month = date.getMonth();
                        
                            // 1일이 시작되는 요일과 월의 마지막 날짜 계산
                            const firstDayOfMonth = new Date(year, month, 1).getDay();
                            const lastDateOfMonth = new Date(year, month + 1, 0).getDate();
                        
                            // 월 제목 업데이트
                            monthTitle.textContent = `${year}년 ${month + 1}월`;
                        
                            // 기존 날짜 삭제
                            calendarGrid.querySelectorAll(".date-cell").forEach((cell) => cell.remove());
                        
                            // 빈칸 추가
                            for (let i = 0; i < firstDayOfMonth; i++) {
                                const emptyCell = document.createElement("div");
                                emptyCell.className = "empty-cell";
                                calendarGrid.appendChild(emptyCell);
                            }
                        
                            // 날짜 추가
                            for (let day = 1; day <= lastDateOfMonth; day++) {
                                const dateCell = document.createElement("div");
                                dateCell.className = "date-cell";
                                dateCell.textContent = day;
                            
                                // 날짜 클릭 시 팝업 열기
                                dateCell.addEventListener("click", () => {
                                    selectedDayCell = dateCell; // 클릭한 날짜 셀 저장
                                    popup.style.display = "block"; // 팝업 표시
                                    popupBackground.style.display = "block"; // 배경 표시
                                });
                            
                                calendarGrid.appendChild(dateCell);
                            }
                        }
                    
                        // 이전 월로 이동
                        prevMonthButton.addEventListener("click", () => {
                            currentDate.setMonth(currentDate.getMonth() - 1);
                            renderCalendar(currentDate);
                        });
                    
                        // 다음 월로 이동
                        nextMonthButton.addEventListener("click", () => {
                            currentDate.setMonth(currentDate.getMonth() + 1);
                            renderCalendar(currentDate);
                        });
                    
                        // 시간 버튼 클릭 시 해당 시간 표시
                        document.querySelectorAll(".time-button").forEach(button => {
                            button.addEventListener("click", () => {
                                const time = button.getAttribute("data-time");
                            
                                //  // 이미 예약된 시간인지 확인
                                //  if (bookedTimes.includes(time)) {
                                //     alert("이 시간은 이미 예약되었습니다.");
                                //     return; // 이미 예약된 시간이라면 함수를 종료
                                // }
                            
                                // // 예약 상태 업데이트
                                // bookedTimes.push(time);
                            
                                // // 버튼 비활성화 및 스타일 적용
                                // button.classList.add("disabled");
                            
                            
                            
                                if (selectedDayCell) {
                                    selectedDayCell.textContent += ` ${time}`; // 선택한 시간 추가
                                }
                                popup.style.display = "none"; // 팝업 닫기
                                popupBackground.style.display = "none"; // 배경 닫기
                            });
                        });
                    
                        // 시간 삭제 버튼 클릭 시 선택한 시간 삭제
                        deleteTimeButton.addEventListener("click", () => {
                            if (selectedDayCell) {
                                const currentText = selectedDayCell.textContent;
                                const timePattern = /\s*(오전|오후|합의|[0-1]?\d:\d{2}|2[0-3]:\d{2})\s*$/; // 시간 패턴
                                const newText = currentText.replace(timePattern, '').trim(); // 선택된 시간 삭제
                                selectedDayCell.textContent = newText; // 업데이트된 텍스트 설정

                                popup.style.display = "none"; // 팝업 닫기
                                popupBackground.style.display = "none"; // 배경 닫기
                            }
                        });
                    
                        // 팝업 닫기
                        closePopupButton.addEventListener("click", () => {
                            popup.style.display = "none"; // 팝업 닫기
                            popupBackground.style.display = "none"; // 배경 닫기
                        });
                    </script>
                </div>
                <br>
                <hr>
        
                <div class="review">
                    <div class="plus">더보기</div>
                    <div class="review-item">
                        <div class="review-title">이** PPT는 채소연에게! <span class="review-star">⭐ 5</span></div>
                        <div class="review-content">
                            강사님 너무 꼼꼼하시고 체계적이에요<br>
                            다음에 심화강의 예약자분도 또 듣고 싶어요
                        </div>
                    </div>
                    <div class="review-item">
                        <div class="review-title">윤** PPT보다 그냥 디자인 <span class="review-star">⭐ 3.5</span></div>
                        <div class="review-content">
                            PPT 기능이나 단축키같은거 배우고 싶으면<br>
                            완전 비추천이에요.
                        </div>
                    </div>
                    <div class="review-item">
                        <div class="review-title">채** 노트북대여도 해주세요 <span class="review-star">⭐ 4.5</span></div>
                        <div class="review-content">
                            강의들은데 노트북이 필수인데, 노트북 없는 수강생을 위해<br>
                            노트북 빌려주셨으면 좋겠어요. 그것 빼곤 만족이에요
                        </div>
                    </div>
                    <div class="review-item">
                        <div class="review-title">박** 만족 <span class="review-star">⭐ 5</span></div>
                        <div class="review-content">
                            만족<br>
                            대만족
                        </div>
                    </div>
                </div>
                <br>
                <hr>
        
                <div class="portfolio ">
                    <div class="education">
                        <span>학력</span>
                        <div class="education-item">
                            <div class="item-box">XX고등학교 / 졸업                                                                                          (2009.02 ~ 2012.02)"</div>
                        </div>
                        <div class="education-item">
                            <div class="item-box">XX대학교 / 영어영문학과 / 졸업                                                                      (2012.03 ~ 2019.02)"</div>
                        </div>
                    </div>
              
                    <div class="experience">
                        <span>경력</span>
                        <div class="experience-item">
                            <div class="item-box">개인과외 / 고등학생 영어 전 개인과외                                                            (2019.06 ~ 2023.12)"</div>
                        </div>
                        <div class="experience-item">
                            <div class="item-box">ABCD 영어학원 / 전임강사                                                                             (2017.04 ~ 2018.11)"</div>
                        </div>
                    </div>
              
                    <div class="language">
                        <span>자격증/외국어</span>
                        <div class="language-item">
                            <div class="item-box">TOEIC 850/990"</div>
                            
                        </div>
                        <div class="language-item">
                            <div class="item-box">TOEIC SPEAKING</div>
                        </div>
                    </div>
              
                </div>
            </div>
            <script>
                // 네비게이션 버튼 클릭 시 이동 및 색상 변경
                document.querySelectorAll(".top-bar .label").forEach(item => {
                    item.addEventListener("click", () => {
                        // 모든 네비게이션 버튼 초기화
                        document.querySelectorAll(".top-bar .label").forEach(nav => {
                            nav.style.color = "white";
                            nav.style.backgroundColor = "#FF5C3D";
                        });
            
                        // 클릭된 버튼 활성화
                        item.style.color = "black";
                        item.style.backgroundColor = "#FFDDC1";
            
                        // 섹션으로 스크롤 이동
                        const targetText = item.textContent.trim(); // 버튼 텍스트를 기준으로 구분
                        const sectionMap = {
                            "상세정보": ".information",
                            "스케줄표": ".schedul",
                            "강의리뷰": ".review",
                            "포트폴리오": ".portfolio"
                        };
            
                        const targetSection = document.querySelector(sectionMap[targetText]);
                        if (targetSection) {
                            targetSection.scrollIntoView({ behavior: "smooth" });
                        }
                    });
                });
            
                // 리뷰 더보기 기능
                var moreButton = document.querySelector(".plus");
                var isExpanded = false;

                moreButton.addEventListener("click", () => {
                    document.querySelectorAll(".review .review-item").forEach((item, index) => {
                        if (index >= 3) { // 4번째 리뷰부터 표시
                            item.style.display = isExpanded ? "none" : "block";
                        }
                    });
                    moreButton.textContent = isExpanded ? "더보기" : "닫기"; // 버튼 텍스트 변경
                    isExpanded = !isExpanded; // 확장 상태 변경
                });
            
                // 초기 리뷰 설정
                document.querySelectorAll(".review .review-item").forEach((item, index) => {
                    if (index >= 3) { // 4번째 리뷰부터 숨김
                        item.style.display = "none";
                    }
                });
            </script>
        </div>
    </div>
</body>
</html>