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
 * Servlet implementation class deleteController
 */
@WebServlet("/member/delete")
public class deleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberPwd = request.getParameter("memberPwd");
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		String memberNo = loginUser.getMemberNo();
		
		int result = new memberService().delete(memberPwd,memberNo);
	
		if(result > 0) {
			session.setAttribute("alertMsg", "회원탈퇴되었습니다.");
			session.removeAttribute("loginUser");
			
			response.sendRedirect(request.getContextPath());
		}else {
			session.setAttribute("alertMsg", "잘못된 비밀번호입니다. 다시 입력해주세요");
			response.sendRedirect(request.getContextPath());
		}
		
	}

}
