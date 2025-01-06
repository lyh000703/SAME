package com.kh.search.model.dao;

import static com.kh.common.template.JDBCTemplate.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.InvalidPropertiesFormatException;
import java.util.List;
import java.util.Properties;

import com.kh.member.model.vo.Profile;
import com.kh.search.model.vo.SearchResult;

public class SearchDao {
	private Properties prop = new Properties();

	public SearchDao() {
		
		String path = SearchDao.class.getResource("/sql/search/search-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(path));
		} catch (InvalidPropertiesFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	public List<Profile> selectProfileList(Connection conn, String keyword) {
		
		List<Profile>list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchProfileList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			pstmt.setString(2, keyword);
			pstmt.setString(3, keyword);
			
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				Profile p = Profile.builder()
						   		   .memberNo(rset.getString("MEMBER_NAME"))
						   		   .profileTitle(rset.getString("PROFILE_TITLE"))
						   		   .introduction(rset.getString("INTRODUCTION"))
						   		   .gender(rset.getString("GENDER"))
						   		   .build();
				
				list.add(p);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}


	public List<Profile> profileList(Connection conn) {
		List<Profile>list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("profileList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	public List<SearchResult> searchAll(Connection conn, String keyword) {
        List<SearchResult> results = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        String sql = prop.getProperty("searchAll");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            
            rset = pstmt.executeQuery();
            
            while(rset.next()) {
                results.add(SearchResult.builder()
                    .boardNo(rset.getInt("BOARD_NO"))
                    .title(rset.getString("TITLE"))
                    .content(rset.getString("CONTENT"))
                    .type(rset.getString("TYPE"))
                    .url(rset.getString("URL"))
                    .createDate(rset.getString("CREATE_DATE"))
                    .viewCount(rset.getInt("VIEW_COUNT"))
                    .build());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        
        return results;
    }
}
