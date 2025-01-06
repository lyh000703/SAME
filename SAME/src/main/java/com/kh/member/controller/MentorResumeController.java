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
import com.kh.member.model.vo.Resume;

/**
 * Servlet implementation class MentorResumeController
 */
@WebServlet("/member/mentorResume")
public class MentorResumeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MentorResumeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	memberService service = new memberService();
    	
        Member loginUser = (Member) request.getSession().getAttribute("loginUser");
        
        if(loginUser != null) {
            Member mentorResume = new memberService().selectMentorResume(loginUser.getMemberNo());
            request.setAttribute("mentorResume", mentorResume);
        }
        
        request.getRequestDispatcher("/views/member/mentorPage/mentorResume.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		memberService service = new memberService();

        Member loginUser = (Member) request.getSession().getAttribute("loginUser");
        
        if(loginUser != null) {
            Member member = new Member();
            member.setMemberNo(loginUser.getMemberNo());
            member.setIntroduction(request.getParameter("introduction"));
            member.setRegionName(request.getParameter("regionName"));
            member.setClassName(request.getParameter("className"));
            member.setEducation(request.getParameter("education"));
            member.setCareer(request.getParameter("career"));
            member.setLicense(request.getParameter("license"));

            int result = new memberService().updateMentorResume(member);
            
            if(result > 0) {
                request.getSession().setAttribute("alertMsg", "이력서가 성공적으로 수정되었습니다.");
                response.sendRedirect(request.getContextPath() + "/member/mentorResume");
            } else {
                request.setAttribute("errorMsg", "이력서 수정에 실패했습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            }
        }
	}

}
