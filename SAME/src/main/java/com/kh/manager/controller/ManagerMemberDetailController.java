package com.kh.manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.manager.model.service.ManagerService;
import com.kh.member.model.vo.Member;

@WebServlet("/manager/memberDetail")  // URL 패턴 변경
public class ManagerMemberDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManagerService managerService = new ManagerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String memberNo = request.getParameter("mno");
            String memberType = request.getParameter("type");
            
            // 기본 회원 정보 조회
            Member member = managerService.selectMember(memberNo);
            
            if(member != null) {
                request.setAttribute("member", member);
                
                // 회원 타입에 따라 다른 JSP로 포워딩
                String viewPath = "";
                if("B".equals(memberType)) {
                    viewPath = "/views/manager/mentorDetail.jsp";
                } else if("A".equals(memberType)) {
                    viewPath = "/views/manager/menteeDetail.jsp";
                }
                
                request.getRequestDispatcher(viewPath).forward(request, response);
            } else {
                request.setAttribute("errorMsg", "회원 정보를 찾을 수 없습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "회원 상세 정보 조회 실패");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
}
