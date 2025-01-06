package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.memberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class forgotIdController
 */
@WebServlet("/member/forgotID")
public class forgotIdController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgotIdController() {
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
		
		String memberName = request.getParameter("memberName");
		String email = request.getParameter("email");
		String memberType = request.getParameter("memberType");
		
		memberService service = new memberService();
		Member m = service.forgotId(memberName, email, memberType);
		
		if(m == null) {
		   request.setAttribute("errorMsg", "아이디 찾기 실패.");
	       request.getRequestDispatcher("//views/common/errorPage.jsp").forward(request, response);
		} else {
			request.setAttribute("memberId", m.getMemberId());
	        request.getRequestDispatcher("/views/member/forgotIDPASSResult.jsp").forward(request, response);
		}
	}
}
