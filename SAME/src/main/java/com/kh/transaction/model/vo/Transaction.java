package com.kh.transaction.model.vo;

import java.sql.Date;
import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Transaction {
    private int tdNo;           // TD_NO (거래번호)
    private int enrollNo;       // ENROLL_NO (강의-강사 테이블의 외래키값)
    private String classCode;   // CLASS_CODE
    private String mentorNo;    // MENTOR_NO
    private String menteeNo;    // MENTEE_NO
    private String categoryName; // CATEGORY_NAME
    private Date tdDate;        // TD_DATE
    private String method;      // 결제방법
    private int amount;      // AMOUNT
    private String status;      // STATUS
    
    // 추가 필드들은 유지
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String paymentStatus; //결제상태

    private String mentorName;
    private String menteeName;
} 