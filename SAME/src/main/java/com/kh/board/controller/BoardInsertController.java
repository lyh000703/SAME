package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.dto.ReviewRating;
import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.rename.FileRenamePolicy;
import com.kh.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

@WebServlet("/board/insert")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BoardInsertController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Category> list = new BoardService().selectCategoryList();
		String[] boardType = { "자유", "리뷰", "문의" };

		request.setAttribute("list", list);
		request.setAttribute("boardType", boardType);
		request.getRequestDispatcher("/views/board/insert.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession();

	    // 1. 로그인 체크
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스입니다.");
	        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	        return;
	    }

	    // 2. multipart 요청 확인
	    if (!ServletFileUpload.isMultipartContent(request)) {
	        request.setAttribute("errorMsg", "잘못된 전송방식입니다. enctype을 변경해주세요.");
	        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	        return;
	    }

	    try {
	        // 1. 기존 파일 업로드 설정 유지
	        long maxSize = 1024 * 1024 * 10;
	        String filePath = request.getServletContext().getRealPath("/upload/board/");
	        MultipartRequest multiRequest = new MultipartRequest(request, filePath, maxSize, "UTF-8",
	                new FileRenamePolicy());

	        // 2. 기존 게시글 정보 설정 유지
	        String categoryType = multiRequest.getParameter("category");
	        String boardTitle = multiRequest.getParameter("title");
	        String boardContent = multiRequest.getParameter("content");
	        String type = multiRequest.getParameter("boardType");
	        char boardType = type.equals("자유") ? 'a' : type.equals("리뷰") ? 'b' : 'c';
	        String boardWriter = String.valueOf(loginUser.getMemberNo());

	        // 3. 필수 입력값 검증 유지
	        if (boardTitle == null || boardTitle.trim().isEmpty() || 
	            boardContent == null || boardContent.trim().isEmpty()) {
	            request.setAttribute("errorMsg", "제목과 내용은 필수 입력항목입니다.");
	            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	            return;
	        }

	        // 4. Board 객체 생성
	        Board b = Board.builder()
	                .boardTitle(boardTitle)
	                .boardContent(boardContent)
	                .memberNo(boardWriter)
	                .boardType(boardType)
	                .category(Category.builder()
	                        .categoryName(categoryType)
	                        .build())
	                .build();

	        // 5. 첨부파일 처리 추가
	        List<Attachment> attachments = new ArrayList<>();
	        Enumeration<String> files = multiRequest.getFileNames();
	        
	        while(files.hasMoreElements()) {
	            String file = files.nextElement();
	            String originalFileName = multiRequest.getOriginalFileName(file);
	            
	            if(originalFileName != null) {
	                Attachment at = Attachment.builder()
	                        .originName(originalFileName)
	                        .changedName(multiRequest.getFilesystemName(file))
	                        .filePath("/upload/board/")
	                        .isDelete('N')
	                        .atType('1')  // 게시판 첨부파일은 '1'
	                        .build();
	                attachments.add(at);
	            }
	        }
	        
	        // 6. 게시글 및 첨부파일 등록
	        int result = new BoardService().insertBoard(b, attachments);
	        
	        if(result > 0) {
	            response.sendRedirect(request.getContextPath() + "/board/list");
	        } else {
	            // 실패시 업로드된 파일 삭제
	            for(Attachment at : attachments) {
	                new File(filePath + at.getChangedName()).delete();
	            }
	            request.setAttribute("errorMsg", "게시글 등록 실패");
	            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	        }
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMsg", "게시글 등록 중 오류 발생");
	        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
	    }
	}
}