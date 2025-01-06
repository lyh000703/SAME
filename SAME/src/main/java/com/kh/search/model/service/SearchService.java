package com.kh.search.model.service;

import static com.kh.common.template.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.kh.search.model.dao.SearchDao;
import com.kh.search.model.vo.SearchResult;

public class SearchService {
    private SearchDao searchDao = new SearchDao();
    
    public List<SearchResult> searchAll(String keyword) {
        Connection conn = getConnection();
        List<SearchResult> results = searchDao.searchAll(conn, keyword);
        close(conn);
        return results;
    }
} 