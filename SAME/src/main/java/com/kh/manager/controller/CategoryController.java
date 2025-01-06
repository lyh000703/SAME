package com.kh.manager.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.board.model.vo.Category;
import com.kh.manager.model.service.CategoryService;

@WebServlet("/category/*")
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService categoryService = new CategoryService();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        response.setContentType("application/json;charset=UTF-8");
        
        switch(pathInfo) {
            case "/list":
                // 전체 카테고리 목록 조회
                List<Category> categories = categoryService.getAllCategories();
                response.getWriter().write(gson.toJson(categories));
                break;
                
            case "/types":
                // 카테고리 타입 목록 조회
                List<String> types = categoryService.getAllCategoryTypes();
                System.out.println("조회된 카테고리 타입: " + types); // 디버깅용
                
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(gson.toJson(types));
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        response.setContentType("application/json;charset=UTF-8");
        
        if("/add".equals(pathInfo)) {
            Category category = gson.fromJson(request.getReader(), Category.class);
            boolean success = categoryService.addCategory(category);
            response.getWriter().write(gson.toJson(new Result(success)));
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Category category = gson.fromJson(request.getReader(), Category.class);
        boolean success = categoryService.deleteCategory(category);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(gson.toJson(new Result(success)));
    }
    
    private static class Result {
        private boolean success;
        private String message;
        
        public Result(boolean success) {
            this.success = success;
            this.message = success ? "작업이 성공적으로 완료되었습니다." : "작업 중 오류가 발생했습니다.";
        }
    }
} 