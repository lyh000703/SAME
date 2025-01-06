package com.kh.manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.manager.model.service.ManagerService;
import com.kh.member.model.vo.Member;

/**
 * 문의게시글 답변 처리를 담당하는 컨트롤러
 */
@WebServlet("/manager/answer")
public class AnswerController extends HttpServlet {
    private ManagerService managerService = new ManagerService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            // 로그인 체크
            Member loginUser = (Member) request.getSession().getAttribute("loginUser");
            if(loginUser == null || !"M".equals(loginUser.getMemberType())) {
                throw new ServletException("관리자만 접근 가능합니다.");
            }
            
            int boardNo = Integer.parseInt(request.getParameter("boardNo"));
            String answerContent = request.getParameter("answerContent");
            
            // 답변 등록/수정
            boolean result = managerService.saveQAAnswer(boardNo, answerContent);
            
            if(result) {
                response.getWriter().write("{\"success\":true}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"답변 처리에 실패했습니다.\"}");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"시스템 오류가 발생했습니다.\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 로그인 체크
            Member loginUser = (Member) request.getSession().getAttribute("loginUser");
            if(loginUser == null || !"M".equals(loginUser.getMemberType())) {
                throw new ServletException("관리자만 접근 가능합니다.");
            }
            
            // 파라미터 받기
            int boardNo = Integer.parseInt(request.getParameter("bno"));
            
            // 답변 조회
            String answer = managerService.getQAAnswer(boardNo);
            
            // JSON 응답
            response.setContentType("application/json;charset=UTF-8");
            if(answer != null) {
                response.getWriter().write("{\"success\":true,\"answer\":\"" + answer + "\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"답변을 찾을 수 없습니다.\"}");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}