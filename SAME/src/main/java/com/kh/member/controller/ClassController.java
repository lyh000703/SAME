package com.kh.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.kh.board.model.vo.Category;
import com.kh.member.model.service.memberService;
import com.kh.member.model.vo.ClassVo;
import com.kh.member.model.vo.Member;
/**
 * Servlet implementation class ClassController
 */
@WebServlet("/member/class")
public class ClassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		memberService service = new memberService();
    
    	try {
    	    // 과목과 지역 카테고리 조회
    	    List<String> subjects = service.getCategoryByType("과목");
    	    List<String> regions = service.getCategoryByType("지역");

            // 현재 로그인한 멘토의 강의 정보 조회
            HttpSession session = request.getSession();
            Member loginUser = (Member) session.getAttribute("loginUser");

            if(loginUser != null){
                List<ClassVo> classList = service.getClassInfo(loginUser.getMemberNo());
                request.setAttribute("classList",classList);
            }

    	    // request에 데이터 저장
    	    request.setAttribute("subjects", subjects);
    	    request.setAttribute("regions", regions);
	
    	    // JSP로 포워딩
    	    request.getRequestDispatcher("/views/member/mentorPage/class.jsp").forward(request, response);
	
    	} catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "카테고리 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/error.jsp").forward(request, response);
    	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        memberService service = new memberService();
        
        try {
            HttpSession session = request.getSession();
            Member loginUser = (Member) session.getAttribute("loginUser");
            
            // 가격 처리
            String priceStr = request.getParameter("price").replaceAll("[^0-9]", "");
            int price = Integer.parseInt(priceStr);
            
            // ClassVo 객체 생성
            ClassVo classInfo = ClassVo.builder()
                .mentorNo(loginUser.getMemberNo())
                .classTitle(request.getParameter("lecture-name"))
                .category(request.getParameter("category"))
                .region(request.getParameter("region"))
                .startDate(request.getParameter("start-date"))
                .endDate(request.getParameter("end-date"))
                .classDetail(request.getParameter("description"))
                .amount(price)
                .status("Y")
                .build();
            
            System.out.println("강의 등록 요청: " +classInfo);

            int result = service.insertClass(classInfo);
            
            if(result > 0) {
                session.setAttribute("alertMsg", "강의가 성공적으로 등록되었습니다.");
                response.sendRedirect(request.getContextPath() + "/member/mentorMain");
            } else {
                request.setAttribute("errorMsg", "강의 등록에 실패했습니다.");
                doGet(request, response);
            }
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "강의 등록 중 오류가 발생했습니다: " + e.getMessage());
            doGet(request, response);
        }
    }
}
