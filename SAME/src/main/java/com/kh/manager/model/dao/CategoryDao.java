package com.kh.manager.model.dao;

import static com.kh.common.template.JDBCTemplate.close;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.board.model.vo.Category;


public class CategoryDao {
    private Properties prop;
    
    public CategoryDao() {
        prop = new Properties();
        try {
            String filePath = "/sql/manager/manager-mapper.xml";
            InputStream is = getClass().getResourceAsStream(filePath);
            
            if (is == null) {
                System.out.println("매퍼 파일을 찾을 수 없습니다: " + filePath);
                throw new IOException("매퍼 파일을 찾을 수 없습니다: " + filePath);
            }
            
            // XML 파일 로드 전 디버깅
            System.out.println("매퍼 파일 로드 시작");
            prop.loadFromXML(is);
            System.out.println("매퍼 파일 로드 완료");
            
            // 로드된 쿼리 확인
            System.out.println("selectAllCategories 쿼리: " + prop.getProperty("selectAllCategories"));
            System.out.println("selectAllTypes 쿼리: " + prop.getProperty("selectAllTypes"));
            
            is.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("매퍼 파일 로드 실패: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("원인: " + e.getCause().getMessage());
            }
        }
    }
    
    public List<String> selectAllTypes(Connection conn) {
        List<String> types = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        try {
            String sql = prop.getProperty("selectAllTypes");
            if(sql == null || sql.trim().isEmpty()) {
                System.out.println("SQL 쿼리가 없습니다: selectAllTypes"); // 디버깅
                return types;
            }
            
            System.out.println("실행할 SQL 쿼리: " + sql); // 디버깅
            
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            
            while(rset != null && rset.next()) {
                String type = rset.getString("CATEGORY_TYPE");
                if(type != null && !type.trim().isEmpty()) {
                    types.add(type);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // null 체크 후 close
            try {
                if(rset != null) close(rset);
                if(pstmt != null) close(pstmt);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        System.out.println("조회된 카테고리 타입: " + types); // 디버깅
        return types;
    }
    
    public List<Category> selectAllCategories(Connection conn) {
        List<Category> categories = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        try {
            String sql = prop.getProperty("selectAllCategories");
            if(sql == null || sql.trim().isEmpty()) {
                System.out.println("SQL 쿼리가 없습니다: selectAllCategories"); // 디버깅
                return categories;
            }
            
            System.out.println("실행할 SQL 쿼리: " + sql); // 디버깅
            
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            
            while(rset != null && rset.next()) {
                Category category = new Category();
                category.setCategoryName(rset.getString("CATEGORY_NAME"));
                category.setCategoryType(rset.getString("CATEGORY_TYPE"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // null 체크 후 close
            try {
                if(rset != null) close(rset);
                if(pstmt != null) close(pstmt);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        System.out.println("조회된 카테고리 목록: " + categories); // 디버깅
        return categories;
    }
    
    public int insertCategory(Connection conn, Category category) {
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = prop.getProperty("insertCategory");
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getCategoryName());
            pstmt.setString(2, category.getCategoryType());
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }

	public int updateCategory(Connection conn, Category category) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteCategory(Connection conn, int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteCategory(Connection conn, Category category) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteCategory");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category.getCategoryName());
			pstmt.setString(2, category.getCategoryType());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
} 