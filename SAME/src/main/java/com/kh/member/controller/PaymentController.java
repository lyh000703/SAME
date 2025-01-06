package com.kh.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.memberService;
import com.kh.member.model.vo.Member;
import com.kh.member.model.vo.Transaction;

/**
 * Servlet implementation class PaymentController
 */
@WebServlet("/member/payment")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        if(loginUser != null) {
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String status = request.getParameter("status");
            String menteeName = request.getParameter("menteeName");
            
            memberService service = new memberService();
            List<Transaction> transactions = service.transactionDetail(
                loginUser.getMemberNo(), startDate, endDate, status, menteeName);
            
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("/views/member/mentorPage/payment.jsp")
                   .forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/member/login");
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
