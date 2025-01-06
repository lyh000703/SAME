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
 * Servlet implementation class menteeInsert
 */
@WebServlet("/member/insert")
public class insertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertController() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 기본값으로 멘티 설정
				String memberType = request.getParameter("memberType");
				if (memberType == null || memberType.isEmpty()) {
					response.sendRedirect(request.getContextPath() + "/views/member/signup.jsp?memberType=A");
					return;
				}
				request.getRequestDispatcher("/views/member/signup.jsp").forward(request, response);
			}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String memberId = request.getParameter("memberId");
		String memberPwd = request.getParameter("memberPwd");
		String memberName = request.getParameter("memberName");
		int phone = Integer.parseInt(request.getParameter("phone"));
		String memberSSN = request.getParameter("memberSSN");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String memberType = request.getParameter("memberType"); // 멘토/멘티 구분
		
		Member m = Member.builder().memberId(memberId)
									.memberPwd(memberPwd)
									.memberName(memberName)
									.phone(phone)
									.memberSSN(memberSSN)
									.email(email)
									.address(address)
									.memberType(memberType)
									.build();
		
		int result = new memberService().insert(m);
		
        if (result > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("alertMsg", "회원가입 되었습니다");
            session.setAttribute("memberType", memberType);
            session.setAttribute("memberId", memberId);
            session.setAttribute("memberName", memberName);

            if ("B".equals(memberType)) {
                // 멘토인 경우 이력서 입력 페이지로 이동
                response.sendRedirect(request.getContextPath() + "/member/insertMentor");
            } else {
                // 멘티인 경우 메인 페이지로 이동
                response.sendRedirect(request.getContextPath());
            }
        } else {
            request.setAttribute("errorMsg", "회원가입에 실패했습니다.");
            request.getRequestDispatcher("/views/member/signup.jsp").forward(request, response);
        }
	} 
}