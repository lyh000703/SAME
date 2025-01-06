package com.kh.manager.controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.common.model.vo.PageInfo;
import com.kh.manager.model.service.ComplaintService;
import com.kh.manager.model.vo.Complaint;

@WebServlet("/manager/complaint/*")
public class ComplaintController extends HttpServlet {
    private ComplaintService complaintService = new ComplaintService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();
            
            switch(pathInfo) {
                case "/list":
                    listComplaints(request, response);
                    break;
                case "/detail":
                    viewComplaintDetail(request, response);
                    break;
                case "/search":
                    searchComplaints(request, response);
                    break;
                default:
                    response.sendError(404);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "요청 처리 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }

    private void listComplaints(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int currentPage = 1;
            if(request.getParameter("cpage") != null) {
                currentPage = Integer.parseInt(request.getParameter("cpage"));
            }

            int listCount = complaintService.getComplaintCount();
            int pageLimit = 10;
            int boardLimit = 10;
            
            int maxPage = (int)Math.ceil((double)listCount / boardLimit);
            int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
            int endPage = startPage + pageLimit - 1;
            
            if(endPage > maxPage) {
                endPage = maxPage;
            }
            
            PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, 
                                     boardLimit, startPage, endPage, maxPage);
            
            List<Complaint> list = complaintService.selectComplaintList(pi);
            
            request.setAttribute("list", list);
            request.setAttribute("pi", pi);
            request.getRequestDispatcher("/views/manager/complaintList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    private void viewComplaintDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int compNo = Integer.parseInt(request.getParameter("no"));
        Complaint complaint = complaintService.selectComplaint(compNo);
        
        if(complaint != null) {
            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/views/manager/complaintDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "신고 내역을 찾을 수 없습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }

    private void searchComplaints(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        
        List<Complaint> list = complaintService.searchComplaints(type, keyword);
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/manager/complaintList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if("/updateStatus".equals(pathInfo)) {
            updateComplaintStatus(request, response);
        }
    }

    private void updateComplaintStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int compNo = Integer.parseInt(request.getParameter("no"));
        String isConfirm = request.getParameter("status");
        
        boolean result = complaintService.updateComplaintStatus(compNo, isConfirm);
        
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": " + result + "}");
    }
} 