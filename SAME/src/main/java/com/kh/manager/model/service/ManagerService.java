package com.kh.manager.model.service;

import static com.kh.common.template.JDBCTemplate.close;
import static com.kh.common.template.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.kh.common.model.vo.PageInfo;
import com.kh.manager.model.dao.ManagerDao;
import com.kh.member.model.vo.Member;

public class ManagerService {
	private ManagerDao managerDao = new ManagerDao();

	// 전체 멘티 수 조회
	public int selectMenteeListCount() {
		Connection conn = getConnection();
		int count = managerDao.selectMenteeListCount(conn);
		close(conn);
		return count;
	}

	// 멘티 목록 조회 - 메소드명 수정
	public List<Member> selectMenteeList(PageInfo pi, String sort) {
		Connection conn = getConnection();
		List<Member> list = managerDao.managerSelectMenteeList(conn, pi, sort);
		close(conn);
		return list;
	}

	// 멘토 수 조회
	public int selectMentorListCount() {
		Connection conn = getConnection();
		int count = managerDao.selectMentorListCount(conn);
		close(conn);
		return count;
	}

	// 멘티 목록 조회 - 메소드명 수정
	public List<Member> selectMentorList(PageInfo pi, String sort) {
		Connection conn = getConnection();
		List<Member> list = managerDao.managerSelectMentorList(conn, pi, sort);
		close(conn);
		return list;
	}

	 public Member selectMember(String memberNo) {
	        Connection conn = getConnection();
	        Member member = managerDao.selectMember(conn, memberNo);
	        close(conn);
	        return member;
	}

	public int countMentor() {
		 Connection conn = getConnection();
		 int mentorNum = managerDao.countMentor(conn);
		 close(conn);
		return mentorNum;
	}

	public int countMentee() {
		 Connection conn = getConnection();
		 int memteeNum = managerDao.countMentee(conn);
		 close(conn);
		return memteeNum;
	}

	
}