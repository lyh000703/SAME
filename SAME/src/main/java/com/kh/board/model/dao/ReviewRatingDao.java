package com.kh.board.model.dao;

import java.sql.Connection;
import static com.kh.common.template.JDBCTemplate.close;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.kh.board.model.dto.ReviewRating;

public class ReviewRatingDao {

	 public int insertRating(Connection conn, ReviewRating rating) {
	        int result = 0;
	        PreparedStatement pstmt = null;
	        String sql = "INSERT INTO REVIEW_RATING(RATING_NO, BOARD_NO, MEMBER_NO, RATING) "
	                  + "VALUES(SEQ_RATING_NO.NEXTVAL, ?, ?, ?)";
	        
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, rating.getBoardNo());
	            pstmt.setString(2, rating.getMemberNo());
	            pstmt.setInt(3, rating.getRating());
	            
	            result = pstmt.executeUpdate();
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            close(pstmt);
	        }
	        return result;
	    }
	}