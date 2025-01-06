<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계차트</title>
<!-- chart.js를 불러오는 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
</head>
<body>


        <canvas id="myBarChart" ></canvas>

       


    <script>
     
            // 막대그래프 시작
            const ctx2 = document.getElementById('myBarChart').getContext('2d');

            const data2 = {
                labels: ['1분기', '2분기', '3분기', '4분기'], // 분기 레이블
                datasets: [{
                    label: '거래액',
                    data: [15000, 20000, 25000, 30000], // 각 분기별 거래액 데이터
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.6)', // 1분기 색상
                        'rgba(255, 99, 132, 0.6)', // 2분기 색상
                        'rgba(75, 192, 192, 0.6)', // 3분기 색상
                        'rgba(255, 206, 86, 0.6)'  // 4분기 색상
                    ],
                    borderColor: [
                        'rgba(54, 162, 235, 1)', // 1분기 테두리 색상
                        'rgba(255, 99, 132, 1)', // 2분기 테두리 색상
                        'rgba(75, 192, 192, 1)', // 3분기 테두리 색상
                        'rgba(255, 206, 86, 1)'  // 4분기 테두리 색상
                    ],
                    borderWidth: 1
                }]
            };

            const myBarChart = new Chart(ctx2, {
                type: 'bar', // 막대그래프 타입
                data: data2,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true, // Y축 0부터 시작
                            title: {
                                display: true,
                                text: '거래액 (원)' // Y축 제목
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: '분기' // X축 제목
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true, // 범례 표시
                            position: 'top' // 범례 위치
                        }
                    }
                }
            });
    </script>
</body>
</html>