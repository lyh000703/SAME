package com.kh.manager.model.service;

import static com.kh.common.template.JDBCTemplate.close;
import static com.kh.common.template.JDBCTemplate.commit;
import static com.kh.common.template.JDBCTemplate.getConnection;
import static com.kh.common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.kh.board.model.vo.Category;
import com.kh.manager.model.dao.CategoryDao;

public class CategoryService {
    private CategoryDao categoryDao = new CategoryDao();
    
    public List<Category> getAllCategories() {
        Connection conn = getConnection();
        List<Category> categories = categoryDao.selectAllCategories(conn);
        close(conn);
        return categories;
    }
    
    public List<String> getAllCategoryTypes() {
        Connection conn = getConnection();
        List<String> types = categoryDao.selectAllTypes(conn);
        close(conn);
        return types;
    }
    
    public boolean addCategory(Category category) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = categoryDao.insertCategory(conn, category) > 0;
            if(result) commit(conn);
            else rollback(conn);
        } finally {
            close(conn);
        }
        
        return result;
    }
    
    public boolean deleteCategory(Category category) {
        Connection conn = getConnection();
        boolean result = false;
        
        try {
            result = categoryDao.deleteCategory(conn, category) > 0;
            if(result) commit(conn);
            else rollback(conn);
        } finally {
            close(conn);
        }
        
        return result;
    }
} 