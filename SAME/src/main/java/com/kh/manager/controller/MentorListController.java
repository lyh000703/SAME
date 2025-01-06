package com.kh.manager.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.common.model.vo.PageInfo;
import com.kh.manager.model.service.ManagerService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MentorController
 */
@WebServlet("/manager/mentorList")
public class MentorListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ManagerService managerService = new ManagerService(); // 추가 필요
       
    
	public MentorListController() {
        super();
        
    }

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 정렬 기준 파라미터 받기
            String sort = request.getParameter("sort");
            if(sort == null) sort = "newest";
            
            // 페이징 처리 변수
            int listCount;      // 총 게시글 개수
            int currentPage;    // 현재 페이지
            int pageLimit;      // 페이지 하단에 보여질 페이징바의 페이지 최대 개수
            int boardLimit;     // 한 페이지에서 보여질 게시글 최대 개수
            
            int maxPage;        // 가장 마지막 페이지
            int startPage;      // 페이지 하단에 보여질 페이징바의 시작수
            int endPage;        // 페이지 하단에 보여질 페이징바의 끝수
            
            // 값 초기화
            listCount = managerService.selectMenteeListCount();
            
            currentPage = request.getParameter("cpage") != null ? 
                         Integer.parseInt(request.getParameter("cpage")) : 1;
            
            pageLimit = 10;
            boardLimit = 10;
            
            maxPage = (int)Math.ceil((double)listCount / boardLimit);
            startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
            endPage = startPage + pageLimit - 1;
            
            if(endPage > maxPage) {
                endPage = maxPage;
            }
            
            // PageInfo 객체 생성 (기존에 만들어둔 클래스 사용)
            PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, 
                                     boardLimit, startPage, endPage, maxPage);
            
            // 멘티 목록 조회
            List<Member> list = managerService.selectMentorList(pi, sort);
            
            request.setAttribute("pi", pi);
            request.setAttribute("list", list);
            request.setAttribute("sort", sort);
            
            request.getRequestDispatcher("/views/manager/mentorInfoList.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "멘티 목록 조회 실패");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}