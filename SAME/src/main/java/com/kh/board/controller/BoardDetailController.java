package com.kh.board.controller;

import java.io.IOException;

import com.kh.board.model.dto.BoardDTO;
import com.kh.board.model.service.BoardService;
import com.kh.member.model.vo.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BoardDetailController
 */
@WebServlet(urlPatterns = {"/board/detail", "/manager/detail"})
public class BoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService bs = new BoardService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 현재 url로 요청시 전달한 데이터
		
		try {
            // 요청 URI 확인
            String uri = request.getRequestURI();
            boolean isManagerAccess = uri.contains("/manager/detail");
            System.out.println("[INFO] 요청 URI: " + uri + ", 매니저 접근: " + isManagerAccess);
            
            // 게시글 번호 파라미터 처리
            String bnoStr = request.getParameter("bno");
            System.out.println("[INFO] 요청된 게시글 번호: " + bnoStr);

            if(bnoStr == null || bnoStr.trim().isEmpty()) {
                throw new IllegalArgumentException("게시글 번호가 없습니다.");
            }
            int bno = Integer.parseInt(bnoStr);

            // 세션에서 로그인한 사용자 정보 확인
            HttpSession session = request.getSession();
            Member loginUser = (Member) session.getAttribute("loginUser");
            System.out.println("[INFO] 로그인 사용자 정보: " + loginUser);
            
            BoardDTO board = bs.selectBoard(bno);
            System.out.println("[INFO] 조회된 게시글: " + board);
            
            if(board != null) {
                // 조회수 증가
                int result = bs.increaseCount(bno);
                
                if(result > 0) {
                    request.setAttribute("b", board);
                    
                    // 매니저 페이지 접근 여부에 따른 페이지 포워딩
                    String viewPath;
                    if(isManagerAccess) {
                        // 매니저 페이지에서 접근한 경우
                        System.out.println("[INFO] 매니저 상세보기 페이지로 이동");
                        viewPath = "/views/manager/managerDetail.jsp";
                    } else if(loginUser != null ) {
                        // 일반 사용자인 경우 
                        System.out.println("[INFO] 매니저 권한으로 접근");
                        viewPath = "/views/board/detail.jsp";
                    } else {
                    	 viewPath = "/views/board/detail.jsp";
                    }
                    
                    // 현재 페이지 정보 전달
                    String cPage = request.getParameter("cpage");
                    if(cPage != null) {
                        request.setAttribute("cPage", Integer.parseInt(cPage));
                    }
                    
                    System.out.println("[INFO] 포워딩할 페이지: " + viewPath);
                    
                    request.getRequestDispatcher(viewPath).forward(request, response);
                } else {
                    throw new Exception("조회수 증가에 실패했습니다.");
                }
            } else {
                throw new Exception("게시글을 찾을 수 없습니다.");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            System.out.println("[ERROR] 게시글 조회 중 오류: " + e.getMessage());
            request.setAttribute("errorMsg", "게시글 조회 중 오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
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
