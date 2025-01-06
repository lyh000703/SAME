<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet">
        <link href="/same/resources/css/pay.css" rel="stylesheet">
        <title>Document</title>
    </head>
    <body>
        <div class="v132_3939">
            <div class="v448_2579">
                
                <div class="v132_3941">
                    <div class="check_icon">
                        <img src="/same/resources/images/결제완료 페이지 button1.png">
                    </div>
                    <div class="v132_3943">
                       
                        <div class="name">

                        </div>
                    </div>
                </div>
                <span class="v132_3946">결제에 성공하였습니다
                <div style="display:inline">
                <!-- <p id="paymentKey"></p> -->
				<p id="orderId" style="font-size:20px"></p>
				<p id="amount" style="font-size:20px"></p>
                </div>
                </span>
                
                	
                
                

                <div class="below">
                   <img src="/same/resources/images/결제완료 button2.png" onclick="moveToSearch();">
                    <span class="v132_3947"></span>
                <img src="/same/resources/images/결제완료 button3.png" onclick="moveToBasket();">
                    

                
                </div>
               
            </div>
        </div>

        <script>
            function moveToSearch(){
                location.href="<%=request.getContextPath()%>/";
            }

            function moveToBasket(){
                location.href="<%=request.getContextPath()%>/views/member/menteePage/cart.jsp";
            }

        </script>
</body>
</html>