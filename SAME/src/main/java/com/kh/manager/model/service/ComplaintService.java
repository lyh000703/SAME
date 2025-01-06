package com.kh.manager.model.service;

import static com.kh.common.template.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.kh.common.model.vo.PageInfo;
import com.kh.manager.model.dao.ComplaintDao;
import com.kh.manager.model.vo.Complaint;

public class ComplaintService {
    private ComplaintDao complaintDao = new ComplaintDao();
    
    public int getComplaintCount() {
        Connection conn = getConnection();
        int count = complaintDao.getComplaintCount(conn);
        close(conn);
        return count;
    }
    
    public List<Complaint> selectComplaintList(PageInfo pi) {
        Connection conn = getConnection();
        List<Complaint> list = complaintDao.selectComplaintList(conn, pi);
        close(conn);
        return list;
    }
    
    public Complaint selectComplaint(int compNo) {
        Connection conn = getConnection();
        Complaint complaint = complaintDao.selectComplaint(conn, compNo);
        close(conn);
        return complaint;
    }
    
    public List<Complaint> searchComplaints(String type, String keyword) {
        Connection conn = getConnection();
        List<Complaint> list = complaintDao.searchComplaints(conn, type, keyword);
        close(conn);
        return list;
    }
    
    public boolean updateComplaintStatus(int compNo, String isConfirm) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = complaintDao.updateComplaintStatus(conn, compNo, isConfirm) > 0;
            if(result) commit(conn);
            else rollback(conn);
        } finally {
            close(conn);
        }
        
        return result;
    }
} 