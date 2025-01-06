package com.kh.transaction.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.transaction.model.service.TransactionService;
import com.kh.transaction.model.vo.Transaction;
import com.kh.member.model.vo.Member;

@WebServlet("/transaction/*")
public class TransactionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TransactionService  ts = new TransactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        switch(pathInfo) {
            case "/form":
//                showTransactionForm(request, response);
                break;
            case "/list":
            	Member loginUser = (Member) request.getSession().getAttribute("loginUser");
            	if (loginUser == null) {
        	        request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스입니다.");
        	        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        	        return;
        	    }
            	String memberNo = loginUser.getMemberNo();
            	String memberType = loginUser.getMemberType();
            	
            	List<Transaction>list = ts.getTransactionList(memberNo, memberType);
            	request.setAttribute("list", list);
            	request.getRequestDispatcher("/views/transaction/transaction.jsp").forward(request, response);
                break;
            case "/detail":
//                viewTransactionDetail(request, response);
                break;
            default:
                response.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        switch(pathInfo) {
            case "/create":
                createTransaction(request, response);
                break;
            case "/accept":
//                acceptTransaction(request, response);
                break;
            case "/reject":
//                rejectTransaction(request, response);
                break;
            case "/complete":
//                completeTransaction(request, response);
                break;
            case "/cancel":
//                cancelTransaction(request, response);
                break;
            default:
                response.sendError(404);
        }
    }

	/*
	 * private void showTransactionForm(HttpServletRequest request,
	 * HttpServletResponse response) throws ServletException, IOException { int
	 * mentorId = Integer.parseInt(request.getParameter("mentorId")); Member mentor
	 * = transactionService.getMentorInfo(mentorId); request.setAttribute("mentor",
	 * mentor); request.setAttribute("availableTimes",
	 * transactionService.getAvailableTimes(mentorId));
	 * request.getRequestDispatcher("/views/transaction/transactionForm.jsp").
	 * forward(request, response); }
	 */

//    private void createTransaction(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        // 거래 생성 로직
//        Transaction transaction = buildTransactionFromRequest(request);
//        boolean success = ts.createTransaction(transaction);
//        
//        if(success) {
//            response.sendRedirect(request.getContextPath() + "/transaction/list");
//        } else {
//            request.setAttribute("errorMsg", "거래 생성에 실패했습니다.");
//            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
//        }
//    }

   
} 