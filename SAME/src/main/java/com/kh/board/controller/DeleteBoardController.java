package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.board.model.dto.BoardDTO;
import com.kh.board.model.service.BoardService;
import com.kh.member.model.vo.Member;

@WebServlet("/board/delete")
public class DeleteBoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BoardService boardService = new BoardService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 디버깅을 위한 로그 추가
            System.out.println("DeleteBoardController - 전체 파라미터: " + request.getParameterMap());
            System.out.println("DeleteBoardController - bno parameter: " + request.getParameter("bno"));
            
            // 1. 로그인 체크
            Member loginUser = (Member) request.getSession().getAttribute("loginUser");
            if(loginUser == null) {
                request.setAttribute("errorMsg", "로그인이 필요한 서비스입니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
                return;
            }

            // boardNo 파라미터 검증
            String boardNoStr = request.getParameter("bno");
            if(boardNoStr == null || boardNoStr.trim().isEmpty()) {
                throw new IllegalArgumentException("게시글 번호가 전달되지 않았습니다.");
            }
            
            int boardNo = Integer.parseInt(boardNoStr.trim());
            
            // 3. 게시글 정보 조회 (작성자 확인용)
            BoardDTO boardDTO = boardService.selectBoard(boardNo);
            if(boardDTO == null || boardDTO.getB() == null) {
                request.setAttribute("errorMsg", "존재하지 않는 게시글입니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
                return;
            }

            // 4. 작성자 본인 확인
            if(!loginUser.getMemberNo().equals(boardDTO.getB().getMemberNo())) {
                request.setAttribute("errorMsg", "본인이 작성한 게시글만 삭제할 수 있습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
                return;
            }

            // 5. 게시글 및 첨부파일 삭제 처리
            String savePath = request.getServletContext().getRealPath("/upload/board/");
            int result = boardService.deleteBoard(boardNo, savePath);
            
            if(result > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("alertMsg", "게시글이 성공적으로 삭제되었습니다.");
                response.sendRedirect(request.getContextPath() + "/board/list");
            } else {
                request.setAttribute("errorMsg", "게시글 삭제에 실패했습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            }
            
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "유효하지 않은 게시글 번호입니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "게시글 삭제 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
} 