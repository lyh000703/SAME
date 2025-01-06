package com.kh.manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.dto.BoardDTO;
import com.kh.manager.model.service.ManagerService;

@WebServlet("/manager/qadetail")
public class QADetailController extends HttpServlet {
    private BoardService boardService = new BoardService();
    private ManagerService managerService = new ManagerService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int bno = Integer.parseInt(request.getParameter("bno"));
            int cPage = Integer.parseInt(request.getParameter("cpage"));
            
            // selectQABoard -> getQABoardDetail로 메서드명 변경
            BoardDTO board = boardService.getQABoardDetail(bno);
            
            if(board != null) {
                request.setAttribute("board", board);
                request.setAttribute("cPage", cPage);
                request.getRequestDispatcher("/views/manager/managerQADetail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMsg", "게시글을 찾을 수 없습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "게시글 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
}