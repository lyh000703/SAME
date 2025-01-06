package com.kh.board.controller;

import java.io.IOException;
import java.util.List;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListController
 */
@WebServlet("/board/list")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 페이징 처리에 필요한 변수
				int listCount; // 게시글 총 갯수
				int currentPage; // 요청한 페이지
				int pageLimit; // 페이징바에 표시할 최대 갯수 (<< < 10 > >>)
				int boardLimit; // 한 페이지 당 보여질 게시글의 최대 갯수 (10)
				
				int startPage; // 페이징바의 시작 수
				int endPage; // 페이징바의 끝 수
				int maxPage; // 가장 마지막 페이지
				
				
				// *listCount
				listCount = new BoardService().selectListCount(); // 1. 일반게시글만 얻어오기
				
				currentPage = request.getParameter("cpage") == null ? 1 : Integer.parseInt(request.getParameter("cpage"));
				
				pageLimit = 10;
				boardLimit =10;
				
				maxPage = (int) Math.ceil(listCount/(double)boardLimit);
				
				
				/*
				 * startPage : 페이징바의 시작 수
				 * 				pageLimit, currentPage에 영향을 받는다.
				 * startPage : 1, 11, ...
				 * */
				int n = (int) (currentPage -1)/pageLimit;
				startPage = n*pageLimit+1;
				
				endPage = startPage+pageLimit -1;
				if(endPage > maxPage) {
					endPage = maxPage;
				}
				
				PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, startPage, endPage, maxPage);
				
				// 1. 현재 사용자가 요청한 페이지에 맞는 "게시글 목록" 데이터 조회하기
				List<Board> list = new BoardService().selectBoardList(pi);
				request.setAttribute("list", list);
				request.setAttribute("pi", pi);
				
				System.out.println(list);
				
				// 2. 게시글 목록 데이터를 request에 저장 후 목록 페이지로 forward
				request.getRequestDispatcher("/views/board/boardList.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}