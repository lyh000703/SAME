package com.kh.common.template;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;

public class JDBCTemplate {
	static BasicDataSource dataSource = new BasicDataSource(); // ConnectionPool 생성 방법
	static {
	// 커넥션풀을 통해 생성하고자 하는 커넥션 옵션을 기술
	dataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver"); // 드라이버 선택
	dataSource.setUrl("jdbc:oracle:thin:@localhost:1521:xe"); // url 선택
	dataSource.setUsername("C##SSAM"); // 계정명
	dataSource.setPassword("SSAM"); // 비밀번호
	dataSource.setInitialSize(10); // 초기 커넥션풀 사이즈 설정
	dataSource.setMaxTotal(50); // 최대 메모리 제한
	dataSource.setDefaultAutoCommit(false); // 자동커밋 여부 F
	dataSource.setMaxWaitMillis(10000); // 사용자가 기다릴 최대 대기시간
	dataSource.setRemoveAbandonedTimeout(300); // 미사용시 일정시간 뒤 자동 반납 (초단위) 설정
	
	
	}
	
	
	
	
	
	

	// 1. Connection 반환 메서드
	public static Connection getConnection() {
		
		Connection conn = null;
		
		
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	
	
	
	// 2. close 기능들 (conn, statement ,resultset)
	
	public static void close(Connection conn) {
		
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public static void close(Statement stmt) {
		
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public static void close(ResultSet rset) {
		try {
			rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	// 3. commit , rollback
	
	public static void commit(Connection conn) {
		
		try {
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public static void rollback(Connection conn) {
		
		try {
			conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
