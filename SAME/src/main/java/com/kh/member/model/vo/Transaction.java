package com.kh.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Transaction {
	
    private int tdNo;            // TD_NO
    private int enrollNo;        // ENROLL_NO
    private String classCode;    // CLASS_CODE
    private String mentorNo;     // MENTOR_NO
    private String menteeNo;     // MENTEE_NO
    private String categoryName; // CATEGORY_NAME
    private String tdDate;       // TD_DATE
    private String method;       // METHOD
    private int amount;          // AMOUNT
    private String status;       // STATUS
    
    // JOIN으로 가져올 추가 정보
    private String className;    // CLASS_MENTEE 테이블의 강좌명
    private String menteeName;   // MEMBER 테이블의 멘티 이름
    private String startDate;    // 수업 시작일
    private String endDate;      // 수업 종료일
}
