package com.kh.search.model.service;

import java.util.List;
import static com.kh.common.template.JDBCTemplate.*;
import com.kh.member.model.vo.Profile;
import com.kh.search.model.dao.SearchDao;

import java.io.File;
import java.sql.Connection;

public class ProfileService {

	private SearchDao dao = new SearchDao();
	
	// 키워드 프로필 목록 조회
	public List<Profile> selectProfileList(String keyword) {
		
		Connection conn = getConnection();
		List<Profile> list = dao.selectProfileList(conn, keyword);
		
		close(conn);
		
		return list;
	}

	public List<Profile> profileList() {
		
		Connection conn = getConnection();
		List<Profile> list = dao.profileList(conn);
		
		close(conn);
		
		return list;
	}

}
