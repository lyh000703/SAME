package com.kh.search.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.search.model.service.SearchService;
import com.kh.search.model.vo.SearchResult;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SearchService searchService = new SearchService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        if(keyword != null && !keyword.trim().isEmpty()) {
            // 통합 검색 결과 가져오기
            List<SearchResult> results = searchService.searchAll(keyword);
            
            request.setAttribute("keyword", keyword);
            request.setAttribute("results", results);
            request.getRequestDispatcher("/views/search/searchResult.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath());
        }
    }
} 