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
 * Servlet implementation class forgotPassController
 */
@WebServlet("/member/forgotPass")
public class forgotPassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgotPassController() {
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
        String memberName = request.getParameter("memberName");
        String email = request.getParameter("email");
        
        memberService service = new memberService();
        Member m = service.forgotPass(memberId, memberName, email);

        if (m != null) {
            request.setAttribute("memberId", memberId);
            request.getRequestDispatcher("/views/member/forgotPassModify.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "입력한 정보와 일치하는 회원이 없습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
	}

}
