package com.kh.manager.model.dao;

import static com.kh.common.template.JDBCTemplate.close;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.common.model.vo.PageInfo;
import com.kh.member.model.vo.Member;

public class ManagerDao {
    private Properties prop = new Properties();
    
    public ManagerDao() {
        try {
            String filePath = ManagerDao.class.getResource("/sql/manager/manager-mapper.xml").getPath();
            prop.loadFromXML(new FileInputStream(filePath));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // 멘티 수 조회
    public int selectMenteeListCount(Connection conn) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String sql = prop.getProperty("selectMenteeListCount");
        
         try {
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            
            if(rset.next()) {
                count = rset.getInt("COUNT");
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        return count;
    }
    
     // 멘티 목록 조회
    public List<Member> managerSelectMenteeList(Connection conn, PageInfo pi, String sort) {
        List<Member> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String sql = prop.getProperty("managerSelectMenteeList");
        
        // 정렬 조건 추가
        if(sort.equals("oldest")) {
            sql += " ORDER BY ENROLL_DATE ASC";
        } else {
            sql += " ORDER BY ENROLL_DATE DESC";
        }
        
        // 페이징 처리 추가
        sql = "SELECT * FROM (SELECT ROWNUM RNUM, A.* FROM (" + sql + ") A) "
            + "WHERE RNUM BETWEEN ? AND ?";
            
        try {
            pstmt = conn.prepareStatement(sql);
            
            int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
            int endRow = startRow + pi.getBoardLimit() - 1;
            
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
            
            rset = pstmt.executeQuery();
            
            while(rset.next()) {
                Member m = Member.builder()
                    .memberNo(rset.getString("MEMBER_NO"))
                    .memberId(rset.getString("MEMBER_ID"))
                    .memberName(rset.getString("MEMBER_NAME"))
                    .phone(rset.getInt("PHONE"))
                    .memberSSN(rset.getString("MEMBER_SSN"))
                    .email(rset.getString("EMAIL"))
                    .isQuit(rset.getString("IS_QUIT"))
                    .address(rset.getString("ADDRESS"))
                    .memberType(rset.getString("MEMBER_TYPE"))
                    .enrollDate(rset.getDate("ENROLL_DATE"))
                    .build();
                list.add(m);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        return list;
    }

    
    // 멘토 수 조회
    public int selectMentorListCount(Connection conn) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String sql = prop.getProperty("selectMentorListCount");
        
         try {
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            
            if(rset.next()) {
                count = rset.getInt("COUNT");
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            if(rset != null) close(rset);
            if(pstmt != null) close(pstmt);
        }
        return count;
    }
    
    //멘토목록조회
    public List<Member> managerSelectMentorList(Connection conn, PageInfo pi, String sort) {
    	List<Member> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String sql = prop.getProperty("managerSelectMentorList");
        
     // 정렬 조건 추가
        if(sort.equals("oldest")) {
            sql += " ORDER BY ENROLL_DATE ASC";
        } else {
            sql += " ORDER BY ENROLL_DATE DESC";
        }
        
        // 페이징 처리 추가
        sql = "SELECT * FROM (SELECT ROWNUM RNUM, A.* FROM (" + sql + ") A) "
            + "WHERE RNUM BETWEEN ? AND ?";
            
        try {
            pstmt = conn.prepareStatement(sql);
            
            int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
            int endRow = startRow + pi.getBoardLimit() - 1;
            
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
            
            rset = pstmt.executeQuery();
            
            while(rset.next()) {
                Member m = Member.builder()
                    .memberNo(rset.getString("MEMBER_NO"))
                    .memberId(rset.getString("MEMBER_ID"))
                    .memberName(rset.getString("MEMBER_NAME"))
                    .phone(rset.getInt("PHONE"))
                    .memberSSN(rset.getString("MEMBER_SSN"))
                    .email(rset.getString("EMAIL"))
                    .address(rset.getString("ADDRESS"))
                    .isQuit(rset.getString("IS_QUIT"))
                    .memberType(rset.getString("MEMBER_TYPE"))
                    .enrollDate(rset.getDate("ENROLL_DATE"))
                    .build();
                list.add(m);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        return list;
    }

	

    public Member selectMember(Connection conn, String memberNo) {
        Member member = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String sql = prop.getProperty("selectMember");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberNo);
            
            rset = pstmt.executeQuery();
            
            if(rset.next()) {
                member = Member.builder()
                        .memberNo(rset.getString("MEMBER_NO"))
                        .memberId(rset.getString("MEMBER_ID"))
                        .memberName(rset.getString("MEMBER_NAME"))
                        .phone(rset.getInt("PHONE"))
                        .memberSSN(rset.getString("MEMBER_SSN"))
                        .email(rset.getString("EMAIL"))
                        .address(rset.getString("ADDRESS"))
                        .enrollDate(rset.getDate("ENROLL_DATE"))
                        .memberType(rset.getString("MEMBER_TYPE"))
                        .isQuit(rset.getString("IS_QUIT"))
                        .build();
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        return member;
    }

	public int countMentor(Connection conn) {
	        PreparedStatement pstmt = null;
	        String sql = prop.getProperty("selectMentorListCount");
	        ResultSet rset = null;
	        int mentorNum =0;
	        try {
				pstmt = conn.prepareStatement(sql);
				rset = pstmt.executeQuery();
				 if(rset.next()) {
					 mentorNum = rset.getInt("COUNT");  
		            }
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
	            close(rset);
	            close(pstmt);
	        }
		return mentorNum;
	}

	public int countMentee(Connection conn) {
	        PreparedStatement pstmt = null;
	        String sql = prop.getProperty("selectMenteeListCount");
	        ResultSet rset = null;
	        int menteeNum =0;
	        try {
				pstmt = conn.prepareStatement(sql);
				rset = pstmt.executeQuery();
				 if(rset.next()) {
					 menteeNum = rset.getInt("COUNT");  
		            }
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
	            close(rset);
	            close(pstmt);
	        }
	        
		return menteeNum;
	}
    
	
	
	
	
}