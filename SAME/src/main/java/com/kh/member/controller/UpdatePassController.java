package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.memberService;


/**
 * Servlet implementation class forgotPassModify
 */
@WebServlet("/member/forgotPassModify")
public class UpdatePassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePassController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");

	     String memberId = request.getParameter("memberId");
	     String newPassword = request.getParameter("newPassword");
	     String confirmPassword = request.getParameter("confirmPassword");

	     if (!newPassword.equals(confirmPassword)) {
	         request.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	         request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	         return;
	     }

	     memberService service = new memberService();
	     // 암호화를 생략한 비밀번호 저장
	     boolean Updated = service.updatePassword(memberId, newPassword);

	     if (Updated) {
	         response.sendRedirect(request.getContextPath()+"/member/login");
	     } else {
	         request.setAttribute("errorMsg", "비밀번호 변경 실패");
	         request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	     }
	 }
}
