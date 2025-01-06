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
 * Servlet implementation class mentorInsertController
 */
@WebServlet("/member/insertMentor")
public class mentorInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SUCCESS_MESSAGE = "멘토 정보가 성공적으로 등록되었습니다.";
    private static final String FAILURE_MESSAGE = "멘토 정보 등록에 실패했습니다.";
	public mentorInsertController() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String memberType = (String) session.getAttribute("memberType");
    
    if (!"B".equals(memberType)) {
        response.sendRedirect(request.getContextPath());
        return;
    }
    
    request.getRequestDispatcher("/views/member/signupResume.jsp").forward(request, response);
}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		
		try {
			// 세션에서 memberId 가져오기
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId");
			
			// 폼 데이터 가져오기
			String introduction = request.getParameter("introduction");
			String regionName = request.getParameter("regionName");
			String className = request.getParameter("className");
			String education = request.getParameter("education");
			String career = request.getParameter("career");
			String license = request.getParameter("license");
			
			// Member 객체 생성
			Member m = Member.builder()
					.memberId(memberId)
					.introduction(introduction)
					.regionName(regionName)
					.className(className)
					.education(education)
					.career(career)
					.license(license)
					.build();
			
			// 서비스 호출
			int result = new memberService().insertMentor(m);
			
			// JSON 응답 생성
			String jsonResponse;
			if (result > 0) {
				jsonResponse = "{\"success\": true, \"redirectUrl\": \"" + request.getContextPath() + "\"}";
			} else {
				jsonResponse = "{\"success\": false}";
			}
			
			response.getWriter().write(jsonResponse);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
		}
	}
}