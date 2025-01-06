package com.kh.manager.model.dao;

import static com.kh.common.template.JDBCTemplate.close;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.common.model.vo.PageInfo;
import com.kh.manager.model.vo.Complaint;

public class ComplaintDao {
    private Properties prop;
    
    public ComplaintDao() {
        prop = new Properties();
        String filePath = ComplaintDao.class.getResource("/sql/manager/manager-mapper.xml").getPath();
        
        try {
            prop.loadFromXML(new FileInputStream(filePath));
            System.out.println("[INFO] SQL 매퍼 파일 로드 성공: " + filePath);
            
            // SQL 쿼리 존재 확인
            String sql = prop.getProperty("selectComplaintList");
            if(sql == null || sql.trim().isEmpty()) {
                System.out.println("[ERROR] selectComplaintList 쿼리를 찾을 수 없습니다.");
            } else {
                System.out.println("[INFO] selectComplaintList 쿼리 로드 성공");
            }
            
        } catch (Exception e) {
            System.out.println("[ERROR] SQL 매퍼 파일 로드 실패: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public int getComplaintCount(Connection conn) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        int count = 0;
        String sql = prop.getProperty("getComplaintCount");
        
        try {
            if(sql != null) {
                pstmt = conn.prepareStatement(sql);
                rset = pstmt.executeQuery();
                
                if(rset != null && rset.next()) {
                    count = rset.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        
        return count;
    }
    
    public List<Complaint> selectComplaintList(Connection conn, PageInfo pi) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        List<Complaint> list = new ArrayList<>();
        
        String sql = prop.getProperty("selectComplaintList");
        
        try {
            if(sql == null || sql.trim().isEmpty()) {
                System.out.println("[ERROR] SQL 쿼리가 없습니다.");
                return list;
            }
            
            System.out.println("[INFO] 실행할 쿼리: " + sql);
            
            pstmt = conn.prepareStatement(sql);
            
            int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
            int endRow = pi.getCurrentPage() * pi.getBoardLimit();
            
            pstmt.setInt(1, endRow);
            pstmt.setInt(2, startRow);
            
            rset = pstmt.executeQuery();
            
            while(rset != null && rset.next()) {
                list.add(buildComplaint(rset));
            }
            
        } catch (Exception e) {
            System.out.println("[ERROR] 쿼리 실행 중 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        
        return list;
    }
    
    private Complaint buildComplaint(ResultSet rset) {
        try {
            return Complaint.builder()
                    .compNo(rset.getInt("COMP_NO"))
                    .memberNo(rset.getString("MEMBER_NO"))
                    .boardNo(rset.getInt("BOARD_NO"))
                    .compType(rset.getString("COMP_TYPE"))
                    .compContent(rset.getString("COMP_CONTENT"))
                    .compDate(rset.getDate("COMP_DATE"))
                    .isConfirm(rset.getString("IS_CONFIRM"))
                    .build();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Complaint selectComplaint(Connection conn, int compNo) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        Complaint complaint = null;
        String sql = prop.getProperty("selectComplaint");
        
        try {
            if(sql != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, compNo);
                rset = pstmt.executeQuery();
                
                if(rset != null && rset.next()) {
                    complaint = buildComplaint(rset);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        
        return complaint;
    }

    public List<Complaint> searchComplaints(Connection conn, String type, String keyword) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        List<Complaint> list = new ArrayList<>();
        String sql = prop.getProperty("searchComplaints");
        
        try {
            if(sql != null) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + keyword + "%");
                
                rset = pstmt.executeQuery();
                
                while(rset != null && rset.next()) {
                    Complaint complaint = buildComplaint(rset);
                    if(complaint != null) {
                        list.add(complaint);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        
        return list;
    }

    public int updateComplaintStatus(Connection conn, int compNo, String isConfirm) {
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = prop.getProperty("updateComplaintStatus");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, isConfirm);
            pstmt.setInt(2, compNo);
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }
    
    // 나머지 메소드...
} 