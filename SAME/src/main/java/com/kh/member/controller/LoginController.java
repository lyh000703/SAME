package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.memberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/member/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 페이지로 이동
        request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
    }
    
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
        
        // 1. 클라이언트로부터 데이터 가져오기
        String memberId = request.getParameter("memberId");
        String memberPwd = request.getParameter("memberPwd");

        // 2. 서비스 호출
        memberService service = new memberService();
        Member m = service.login(memberId, memberPwd);

        // 3. 로그인 결과 처리
        if (m == null) { // 로그인 실패
            request.setAttribute("errorMsg", "로그인 실패!.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        } else { // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", m);
          
            response.sendRedirect(request.getContextPath());
        }
 
    }
    
}

