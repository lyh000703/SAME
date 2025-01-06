    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.member.model.vo.Member"%>
    <%
    Member loginUser = (Member) session.getAttribute("loginUser");
    String contextPath = request.getContextPath(); // /same
    int amount = (Integer)(session.getAttribute("amount")) ;
    %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>외부 api</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>

  </head>
  <body>
    <!-- 할인 쿠폰 -->
    <div>
      <input type="checkbox" id="coupon-box" />
      <label for="coupon-box"> 5,000원 쿠폰 적용 </label>
    </div>
    <!-- 결제 UI -->
    <div id="payment-method"></div>
    <!-- 이용약관 UI -->
    <div id="agreement"></div>
    <!-- 결제하기 버튼 -->
    <button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>

    <script>
   
      main();

      async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "OyVpOPbhzpa1bsm3rw1dN";
        const widgets = tossPayments.widgets({
          customerKey,
        });
        // 비회원 결제
        // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

        // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
          currency: "KRW",
          value: 100,
        });

        await Promise.all([
          // ------  결제 UI 렌더링 ------
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          // ------  이용약관 UI 렌더링 ------
          widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
        coupon.addEventListener("change", async function () {
          if (coupon.checked) {
            await widgets.setAmount({
              currency: "KRW",
              value: 100 - 5000,
            });

            return;
          }

          await widgets.setAmount({
            currency: "KRW",
            value: 100,
          });
        });

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
          await widgets.requestPayment({
            orderId: "<%=loginUser.getMemberNo() %>",
            orderName: "백엔드의 모든 것 외 2건",
            successUrl: window.location.origin + "<%=contextPath%>/views/purchase/success.jsp",
            failUrl: window.location.origin + "<%=contextPath%>/views/purchase/fail.jsp",
            customerEmail: "<%=loginUser.getEmail() %>",
            customerName: "<%=loginUser.getMemberName() %>",
            customerMobilePhone: "<%=loginUser.getPhone() %>",
          });
        });
      }
    </script>
  </body>
</html>