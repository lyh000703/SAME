package com.kh.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.member.model.service.memberService;

@WebServlet("/member/checkDuplicate")
public class CheckDuplicateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 클라이언트로부터 전달받은 아이디
        String memberId = request.getParameter("memberId");
        System.out.println("Received memberId: " + memberId);
        
        // 서비스 호출하여 중복 체크
        memberService service = new memberService();
        boolean isDuplicate = service.checkDuplicateId(memberId);
        System.out.println("Is Duplicate: " + isDuplicate);
        
        // JSON 응답 생성
        response.setContentType("application/json;charset=UTF-8");
        Gson gson = new Gson();
        String json = gson.toJson(new DuplicateResponse(isDuplicate));
        response.getWriter().write(json);
    }
    
    // 응답 데이터를 위한 내부 클래스
    private class DuplicateResponse {
        private boolean isDuplicate;
        
        public DuplicateResponse(boolean isDuplicate) {
            this.isDuplicate = isDuplicate;
        }
        
        public boolean getIsDuplicate() {
            return isDuplicate;
        }
    }
} 