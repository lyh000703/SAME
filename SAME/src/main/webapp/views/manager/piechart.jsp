<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

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


		 <canvas id="myDoughnutChart"></canvas>


       


    <script>
        // 도넛차트 시작
        const ctx1 = document.getElementById('myDoughnutChart').getContext('2d');
        const data1 = {
            labels: ['멘티', '멘토'],
            datasets: [{
                label: '비율',
                data: [<%=menteeNum %>, <%=mentorNum %>],
                backgroundColor: ['#36A2EB', '#FF6384'], //칸 색상
                hoverBackgroundColor: ['#2A9DF4', '#FF4C6E'], // hover시 변경색상
                borderWidth: 1
            }]
        };
        
        const myDoughnutChart = new Chart(ctx1, {
                type: 'doughnut',
                data: data1,
                options: {
                    responsive: true,
                    plugins: {
                        tooltip: {
                            enabled: false // 툴팁 비활성화
                        },
                        legend: {
                            display: true,
                            position: 'top'
                        },
                        // 커스텀 플러그인 추가
                        datalabels: {
                            anchor: 'center',
                            align: 'center',
                          /*   formatter: (value, context) => {
                                const total = context.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                const percentage = Math.floor((value / total) * 100 + 0.5);
                                return `${percentage}%`; */
                                formatter: (value, ctx) => {
                                    return value; 
                            },
                            color: '#fff', // 텍스트 색상
                            font: {
                                weight: 'bold',
                                size: '16'
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels] // ChartDataLabels 플러그인 사용
            });



    </script>
</body>
</html>