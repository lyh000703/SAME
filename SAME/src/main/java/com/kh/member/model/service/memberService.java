package com.kh.member.model.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.kh.board.model.vo.Category;
import com.kh.member.model.dao.memberDao;
import com.kh.member.model.vo.ClassVo;
import com.kh.member.model.vo.Member;
import com.kh.member.model.vo.Resume;
import com.kh.member.model.vo.Transaction;

import static com.kh.common.template.JDBCTemplate.*;

public class memberService {

	static memberDao dao = new memberDao();

	public int insert(Member m) {
		Connection conn = getConnection();

		int result = dao.insert(conn, m);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Member login(String memberId, String memberPwd) {
		Connection conn = getConnection();

		Member m = dao.login(conn, memberId, memberPwd);

		close(conn);

		return m;

	}

	public Member forgotId(String memberName, String email, String memberType) {
		Connection conn = getConnection();
		
		Member m = dao.forgotId(conn, memberName, email, memberType);
		
		close(conn);
		
		return m;
	
	}

	public Member forgotPass(String memberId, String memberName, String email) {
	    Connection conn = getConnection();
	    Member m = dao.forgotPass(conn, memberId, memberName, email);
	    close(conn);
	    return m;
	}

	public boolean updatePassword(String memberId, String newPassword) {
	    Connection conn = getConnection();
	    boolean result = dao.updatePassword(conn, memberId, newPassword);
	    if (result) {
	        commit(conn);
	    } else {
	        rollback(conn);
	    }
	    close(conn);
	    return result;
	}

	public boolean quitMember(String memberId) {
		Connection conn = getConnection();
		boolean success = dao.quitMember(conn, memberId);
		
		if(success) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return success;
	}

    public boolean myPageModify(Member member) {
        Connection conn = getConnection();
        boolean update = dao.myPageModify(conn, member);
        
        if (update) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
        return update;
    }

	public List<Member> myPage() {
		Connection conn = getConnection();
		
		List<Member> list = dao.myPage(conn);
		
		close(conn);
		
		return list;
	
	}
	public Member getMemberInfo(String memberId) {
	    Connection conn = null;
	    Member memberInfo = null;
	
	    try {
	        conn = getConnection();
	        memberInfo = dao.getMemberInfo(conn, memberId);
	    } finally {
	        close(conn);
	    }
	    return memberInfo;
	}

	public List<Transaction> transactionDetail(String mentorNo, String startDate, String endDate,
	        String status, String menteeName) {
	    Connection conn = getConnection();
	
	    List<Transaction> list = dao.transactionDetail(conn, mentorNo, startDate, endDate, status, menteeName);
	
	    close(conn);
		
	    return list;
	}


	public List<String> getCategoryByType(String type) {
	    Connection conn = getConnection();

	    List<String> list = dao.selectCategoryByType(conn, type);

	    close(conn);
		
	    return list;
	}
	
	public int insertClass(ClassVo classInfo) {
	    Connection conn = getConnection();
	    int result = 0;
	
	    try {
	        // DAO에서 DB의 DBMS_RANDOM을 사용하여 CLASS_CODE 생성
	        result = dao.insertClass(conn, classInfo);
	
	        if(result > 0) {
	            commit(conn);
	        } else {
	            rollback(conn);
	        }
	    } catch(Exception e) {
	        rollback(conn);
	    } finally {
	        close(conn);
	    }
	    return result;
	}
	public int insertMentor(Member m) {
		
		Connection conn = getConnection();
		
		int result = dao.insertMentor(conn,m);
	
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int delete(String memberPwd, String memberNo) {
		Connection conn = getConnection();
		
		int result = dao.delete(conn,memberPwd,memberNo);
	
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public List<ClassVo> getClassInfo(String mentorNo) {
		Connection conn = getConnection();
		
		List<ClassVo> classList = null;
		
		classList = dao.selectClassInfo(conn, mentorNo);
		
		close(conn);
		
		return classList;
	
	}
	public boolean checkDuplicateId(String memberId) {
	    Connection conn = getConnection();
	    boolean isDuplicate = dao.checkDuplicateId(conn, memberId);
	    close(conn);
	    return isDuplicate;
	}
	
    // 멘토 이력서 조회
public Member selectMentorResume(String memberNo) {
    Connection conn = getConnection();
    Member member = dao.selectMentorResume(conn, memberNo);
    close(conn);
    return member;
}

public int updateMentorResume(Member member) {
    Connection conn = getConnection();
    int result = dao.updateMentorResume(conn, member);
    
    if(result > 0) {
        commit(conn);
    } else {
        rollback(conn);
    }
    
    close(conn);
    return result;
}
}
