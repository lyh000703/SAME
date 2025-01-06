package com.kh.transaction.model.service;

import static com.kh.common.template.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.ArrayList;

import com.kh.transaction.model.dao.TransactionDao;
import com.kh.transaction.model.vo.Transaction;
import com.kh.member.model.vo.Member;

public class TransactionService {
    private TransactionDao dao = new TransactionDao();
    
    // 거래 생성
    public boolean createTransaction(Transaction transaction) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = dao.insertTransaction(conn, transaction) > 0;
            if(result) {
                commit(conn);
            } else {
                rollback(conn);
            }
        } finally {
            close(conn);
        }
        
        return result;
    }
    
    // 멘토 정보 조회
    public Member getMentorInfo(int mentorId) {
        Connection conn = getConnection();
        Member mentor = dao.selectMentor(conn, mentorId);
        close(conn);
        return mentor;
    }
    
    // 가능한 시간대 조회
    public List<String> getAvailableTimes(int mentorId) {
        Connection conn = getConnection();
        List<String> times = dao.selectAvailableTimes(conn, mentorId);
        close(conn);
        return times;
    }
    
 
	
    // 거래 목록 조회 (멘토/멘티별)
    public List<Transaction> getTransactionList(String memberNo, String memberType) {
        Connection conn = getConnection();
        List<Transaction> list = dao.selectTransactionList(conn, memberNo, memberType);
        close(conn);
        return list;
    }
    
    // 거래 상세 조회
    public Transaction getTransactionDetail(int transactionId) {
        Connection conn = getConnection();
        Transaction transaction = dao.selectTransaction(conn, transactionId);
        close(conn);
        return transaction;
    }
    
    // 거래 상태 업데이트
    public boolean updateTransactionStatus(int transactionId, String status) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = dao.updateStatus(conn, transactionId, status) > 0;
            if(result) {
                commit(conn);
            } else {
                rollback(conn);
            }
        } finally {
            close(conn);
        }
        
        return result;
    }
    
    // 결제 상태 업데이트
    public boolean updatePaymentStatus(int transactionId, String paymentStatus) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = dao.updatePaymentStatus(conn, transactionId, paymentStatus) > 0;
            if(result) {
                commit(conn);
            } else {
                rollback(conn);
            }
        } finally {
            close(conn);
        }
        
        return result;
    }


} 