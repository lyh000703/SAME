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
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MyPageModifyController
 */
@WebServlet("/member/modify")
public class MyPageModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPageModifyController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    			List<Member>list = new memberService().myPage();
    			request.setAttribute("list", list);
    			request.getRequestDispatcher("/views/member/myPageModify.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스입니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            return;
        }

        // 파라미터 받기
        String memberId = request.getParameter("memberId");
        String memberPwd = request.getParameter("memberPwd");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // 값이 비어있으면 기존 값 사용
        if (memberId == null || memberId.trim().isEmpty()) {
            memberId = loginUser.getMemberId();
        }
        if (memberPwd == null || memberPwd.trim().isEmpty()) {
            memberPwd = loginUser.getMemberPwd();
        }
        if (phone == null || phone.trim().isEmpty()) {
            phone = String.valueOf(loginUser.getPhone());
        }
        if (email == null || email.trim().isEmpty()) {
            email = loginUser.getEmail();
        }
        if (address == null || address.trim().isEmpty()) {
            address = loginUser.getAddress();
        }

        System.out.println("MemberId: " + memberId);
        System.out.println("MemberPwd: " + memberPwd);
        System.out.println("Phone: " + phone);
        System.out.println("Email: " + email);
        System.out.println("Address: " + address);

        Member updateMember = Member.builder()
                .memberNo(loginUser.getMemberNo())
                .memberId(memberId)
                .memberPwd(memberPwd)
                .memberName(loginUser.getMemberName())
                .phone(Integer.parseInt(phone))
                .memberSSN(loginUser.getMemberSSN())
                .email(email)
                .address(address)
                .memberType(loginUser.getMemberType())
                .build();

        memberService service = new memberService();
        boolean update = service.myPageModify(updateMember);

        if (update) {
            // 세션 업데이트
            session.setAttribute("loginUser", updateMember);
            response.sendRedirect(request.getContextPath() + "/");  // 메인 페이지로 이동
        } else {
            request.setAttribute("errorMsg", "회원정보 수정 실패");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
}