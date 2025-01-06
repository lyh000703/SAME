package com.kh.search.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.vo.Profile;
import com.kh.search.model.service.ProfileService;

/**
 * Servlet implementation class SearchProfileController
 */
@WebServlet("/search/profile")
public class SearchProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String keyword = request.getParameter("keyword");
		List<Profile>list=null;
		
		if(keyword==null) {
			list = new ProfileService().profileList();
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/search/검색창.jsp").forward(request, response);
		}else {
			
			list = new ProfileService().selectProfileList(keyword);
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/search/검색창.jsp?keyword="+keyword).forward(request, response);
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
