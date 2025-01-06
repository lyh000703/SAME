package com.kh.purchase.controller;

import javax.servlet.http.HttpServletRequest;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.kh.member.model.vo.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@WebServlet("/tossPay")
public class WidgetController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	
    	// 세션에서 로그인 유저 정보 확인
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        // 로그인 체크
        if (loginUser == null) {
            request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스입니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            return;
        }
        

        try {
            // form에서 전달된 finalAmount 파라미터 처리
            String finalAmountStr = request.getParameter("finalAmount");
            int amount = 0;
            
            if (finalAmountStr != null && !finalAmountStr.trim().isEmpty()) {
                // 쉼표 제거 후 정수로 변환
                amount = Integer.parseInt(finalAmountStr.replaceAll(",", ""));
            }
            
            // 결제 정보를 checkout.jsp로 전달하기 위해 request에 저장
            request.setAttribute("loginUser", loginUser);
            request.setAttribute("amount", amount);
            

            // checkout.jsp로 포워딩
            request.getRequestDispatcher("/views/purchase/checkout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "잘못된 금액 형식입니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
}

//public class WidgetController {
//
//    private final Logger logger = LoggerFactory.getLogger(this.getClass());
//
//    @RequestMapping(value = "/confirm")
//    public ResponseEntity<JSONObject> confirmPayment(@RequestBody String jsonBody) throws Exception {
//
//        JSONParser parser = new JSONParser();
//        String orderId;
//        String amount;
//        String paymentKey;
//        try {
//            // 클라이언트에서 받은 JSON 요청 바디입니다.
//            JSONObject requestData = (JSONObject) parser.parse(jsonBody);
//            paymentKey = (String) requestData.get("paymentKey");
//            orderId = (String) requestData.get("orderId");
//            amount = (String) requestData.get("amount");
//        } catch (ParseException e) {
//            throw new RuntimeException(e);
//        };
//        JSONObject obj = new JSONObject();
//        obj.put("orderId", orderId);
//        obj.put("amount", amount);
//        obj.put("paymentKey", paymentKey);
//
//        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
//        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
//        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
//        Base64.Encoder encoder = Base64.getEncoder();
//        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
//        String authorizations = "Basic " + new String(encodedBytes);
//
//        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
//        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
//        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
//        connection.setRequestProperty("Authorization", authorizations);
//        connection.setRequestProperty("Content-Type", "application/json");
//        connection.setRequestMethod("POST");
//        connection.setDoOutput(true);
//
//        OutputStream outputStream = connection.getOutputStream();
//        outputStream.write(obj.toString().getBytes("UTF-8"));
//
//        int code = connection.getResponseCode();
//        boolean isSuccess = code == 200;
//
//        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
//
//        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
//        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
//        JSONObject jsonObject = (JSONObject) parser.parse(reader);
//        responseStream.close();
//
//        return ResponseEntity.status(code).body(jsonObject);
//    }
//}