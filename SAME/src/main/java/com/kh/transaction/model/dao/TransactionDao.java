package com.kh.transaction.model.dao;

import static com.kh.common.template.JDBCTemplate.close;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.transaction.model.vo.Transaction;
import com.kh.member.model.vo.Member;

public class TransactionDao {
    private Properties prop = new Properties();
    
    public TransactionDao() {
        try {
            String path = TransactionDao.class.getResource("/sql/transaction/transaction-mapper.xml").getPath();
            prop.loadFromXML(new FileInputStream(path));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 거래 생성
    public int insertTransaction(Connection conn, Transaction t) {
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = prop.getProperty("insertTransaction");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, t.getEnrollNo());
            pstmt.setString(2, t.getClassCode());
            pstmt.setString(3, t.getMentorNo());
            pstmt.setString(4, t.getMenteeNo());
            pstmt.setString(5, t.getCategoryName());
            pstmt.setString(6, t.getMethod());
            pstmt.setDouble(7, t.getAmount());
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }
    
    // 멘토 정보 조회 (미완성)
    public Member selectMentor(Connection conn, int mentorId) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        Member mentor = null;
        String sql = prop.getProperty("selectMentor");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mentorId);
            rset = pstmt.executeQuery();
            
            if(rset.next()) {
                mentor = new Member();
                mentor.setUserId(rset.getInt("USER_ID"));
                mentor.setName(rset.getString("NAME"));
                mentor.setHourlyRate(rset.getDouble("HOURLY_RATE"));
                // 필요한 멘토 정보 설정
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        
        return mentor;
    }
    
  
	
    // 거래 목록 조회
    public List<Transaction> selectTransactionList(Connection conn, String memberNo, String memberType) {
    	List<Transaction> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        String sql = prop.getProperty("selectTransactionList");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberNo);
            pstmt.setString(2, memberNo);
            rset = pstmt.executeQuery();
            
            while(rset.next()) {
            	
            	Transaction t = Transaction.builder()
                .tdNo(rset.getInt("TD_NO"))
                .enrollNo(rset.getInt("ENROLL_NO"))
                .classCode(rset.getString("CLASS_CODE"))
                .mentorNo(rset.getString("MENTOR_NO"))
                .menteeNo(rset.getString("MENTEE_NO"))
                .categoryName(rset.getString("CATEGORY_NAME"))
                .tdDate(rset.getDate("TD_DATE"))
                .method(rset.getString("METHOD"))
                .amount(rset.getInt("AMOUNT"))
                .status(rset.getString("STATUS"))
//                .createdAt(rset.getTimestamp("CREATED_AT"))
//                .updatedAt(rset.getTimestamp("UPDATED_AT"))
//                .paymentStatus(rset.getString("PAYMENT_STATUS"))
                .mentorName(rset.getString("MENTOR_NAME"))
                .menteeName(rset.getString("MENTEE_NAME"))
                .build();
            	
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        
        return list;
    }
    
    // Transaction 객체 생성 헬퍼 메소드
    private Transaction buildTransaction(ResultSet rset) throws Exception {
        return Transaction.builder()
                .tdNo(rset.getInt("TD_NO"))
                .enrollNo(rset.getInt("ENROLL_NO"))
                .classCode(rset.getString("CLASS_CODE"))
                .mentorNo(rset.getString("MENTOR_NO"))
                .menteeNo(rset.getString("MENTEE_NO"))
                .categoryName(rset.getString("CATEGORY_NAME"))
                .tdDate(rset.getDate("TD_DATE"))
                .method(rset.getString("METHOD"))
                .amount(rset.getInt("AMOUNT"))
                .status(rset.getString("STATUS"))
//                .createdAt(rset.getTimestamp("CREATED_AT"))
//                .updatedAt(rset.getTimestamp("UPDATED_AT"))
//                .paymentStatus(rset.getString("PAYMENT_STATUS"))
                .mentorName(rset.getString("MENTOR_NAME"))
                .menteeName(rset.getString("MENTEE_NAME"))
                .build();
    }
    
    // 상태 업데이트
    public int updateStatus(Connection conn, int transactionId, String status) {
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = prop.getProperty("updateStatus");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, transactionId);
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }


} 