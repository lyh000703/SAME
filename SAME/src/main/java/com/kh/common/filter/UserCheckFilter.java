package com.kh.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.dto.BoardDTO;
import com.kh.board.model.service.BoardService;
import com.kh.member.model.vo.Member;

/**
 * Servlet Filter implementation class UserCheckFilter
 */
@WebFilter(urlPatterns = {"/board/update", "/board/delete"})
public class UserCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public UserCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		
		// post방식 요청시 enctype으로 인해 request.getParameter로 값을 받을 수 없음
		if(ServletFileUpload.isMultipartContent(req)) {
			chain.doFilter(request, response);
			return;
		}
		
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		HttpSession session = req.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		// 1. 수정하기가 가능한 사용자인지 확인 (작성자 == 로그인 사용자 ?)
		BoardDTO bd = new BoardService().selectBoard(boardNo);
		String userId = bd.getB().getMemberNo();
		
		if(!(loginUser != null && loginUser.getMemberNo().equals(userId))) {
			request.setAttribute("errorMsg", "수정권한이 존재하지 않습니다.");
			request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
			return;
		}
		request.setAttribute("bd", bd);
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
