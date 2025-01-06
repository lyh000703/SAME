package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.dto.BoardDTO;
import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.rename.FileRenamePolicy;
import com.kh.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

@WebServlet("/board/update")
public class BoardUpdateController extends HttpServlet {
    private BoardService boardService = new BoardService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 디버깅을 위한 로그 추가
            System.out.println("Update Controller doGet - 요청 파라미터: " + request.getQueryString());
            
            // 1. 게시글 번호 받기
            String boardNoStr = request.getParameter("bno");
            if(boardNoStr == null || boardNoStr.trim().isEmpty()) {
                throw new IllegalArgumentException("게시글 번호가 전달되지 않았습니다.");
            }
            
            int boardNo = Integer.parseInt(boardNoStr.trim());
            
            // 2. 게시글 정보 조회
            BoardDTO boardDTO = boardService.selectBoard(boardNo);
            if(boardDTO == null || boardDTO.getB() == null) {
                request.setAttribute("errorMsg", "존재하지 않는 게시글입니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
                return;
            }
            
            // 3. 카테고리 목록 조회
            List<Category> categoryList = boardService.selectCategoryList();
            
            // 4. 게시판 타입 설정
            String[] boardType = { "자유", "리뷰", "문의" };
            
            // 5. 데이터를 request에 저장
            request.setAttribute("b", boardDTO);
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("boardType", boardType);
            
            // 6. 수정 폼으로 포워딩
            request.getRequestDispatcher("/views/board/updateForm.jsp").forward(request, response);
            
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "유효하지 않은 게시글 번호입니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "게시글 수정 폼 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 파일 업로드 처리를 위한 설정
            if(!ServletFileUpload.isMultipartContent(request)) {
                throw new IllegalArgumentException("잘못된 전송 방식입니다.");
            }
            
            // multipart 요청 처리
            String savePath = request.getServletContext().getRealPath("/upload/board/");
            int maxSize = 10 * 1024 * 1024;
            
            MultipartRequest multiRequest = new MultipartRequest(
                request, savePath, maxSize, "UTF-8", new FileRenamePolicy()
            );
            
            // 1. 게시글 정보 수정
            int boardNo = Integer.parseInt(multiRequest.getParameter("boardNo"));
            String categoryType = multiRequest.getParameter("category");
            String type = multiRequest.getParameter("boardType");
            char boardType;
            
            // type이 null이면 기본값 설정 또는 에러 처리
            if (type == null || type.trim().isEmpty()) {
                // 기존 게시글의 타입을 가져오거나 기본값 설정
                boardType = 'a'; // 기본값으로 '자유' 게시판 설정
            } else {
                boardType = type.equals("자유") ? 'a' : type.equals("리뷰") ? 'b' : 'c';
            }
            
            // 게시판 타입에 따른 제목과 내용 처리
            String title, content;
            if("리뷰".equals(type)) {  // equals의 순서를 바꿔서 NPE 방지
                title = multiRequest.getParameter("reviewTitle");
                content = multiRequest.getParameter("reviewContent");
                // 리뷰 평점 처리
                String rating = multiRequest.getParameter("rating");
                if(rating != null && !rating.trim().isEmpty()) {
                    HttpSession session = request.getSession();
                    Member loginUser = (Member) session.getAttribute("loginUser");
                    if(loginUser != null) {
                        boardService.updateReviewRating(boardNo, Integer.parseInt(rating), 
                            String.valueOf(loginUser.getMemberNo()));
                    }
                }
            } else {
                title = multiRequest.getParameter("title");
                content = multiRequest.getParameter("content");
            }
            
            Board b = Board.builder()
                    .boardNo(boardNo)
                    .boardTitle(title)
                    .boardContent(content)
                    .boardType(boardType)
                    .memberNo(String.valueOf(((Member)request.getSession().getAttribute("loginUser")).getMemberNo()))
                    .category(Category.builder()
                            .categoryName(categoryType)
                            .build())
                    .build();
            
            // 2. 첨부파일 처리
            Attachment at = new Attachment();
            Enumeration<String> files = multiRequest.getFileNames();
            
//            while(files.hasMoreElements()) {
               String file = files.nextElement();
                String originalFileName = multiRequest.getOriginalFileName(file);
                
                if(originalFileName != null) {
                    at = Attachment.builder()
                            .originName(originalFileName)
                            .changedName(multiRequest.getFilesystemName(file))
                            .filePath("/upload/board/")
                            .isDelete('N')
                            .atType('1')
                            .build();
                            
                    String originalFileNoStr = multiRequest.getParameter("originalFileNo");
                    if(originalFileNoStr != null && !originalFileNoStr.trim().isEmpty()) {
                        at.setFileNo(Integer.parseInt(originalFileNoStr));
                    }
//                    attachments.add(at);
                }
//            }
            
            // 3. 서비스 호출
            int result = boardService.updateBoard(b, at);
            
            if(result > 0) {
                request.getSession().setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
                response.sendRedirect(request.getContextPath() + "/board/detail?bno=" + boardNo);
            } else {
                // 실패시 업로드된 파일 삭제
                
                    new File(savePath + at.getChangedName()).delete();
                
                throw new Exception("게시글 수정에 실패했습니다.");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "게시글 수정 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
} 