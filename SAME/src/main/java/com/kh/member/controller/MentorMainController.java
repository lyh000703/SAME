package com.kh.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.memberService;
import com.kh.member.model.vo.ClassVo;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MentorMainController
 */
@WebServlet("/member/mentorMain")
public class MentorMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MentorMainController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	memberService service = new memberService();
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        try {
            if(loginUser != null) {
                // 회원 정보 조회
                Member memberInfo = service.getMemberInfo(loginUser.getMemberId());
                
                // 강좌 정보 조회
                List<ClassVo> classList = service.getClassInfo(loginUser.getMemberNo());
                
                if(memberInfo != null) {
                    request.setAttribute("m", memberInfo);
                    request.setAttribute("classList", classList);
                    request.getRequestDispatcher("/views/member/mentorPage/main.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMsg", "회원 정보를 불러오는데 실패했습니다.");
                    request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/member/login");
            }
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "정보 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/error.jsp").forward(request, response);
        }
	}	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
