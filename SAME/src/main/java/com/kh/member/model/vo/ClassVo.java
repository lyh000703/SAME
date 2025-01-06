package com.kh.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClassVo {
    private String classCode;      // 강의 코드
    private String mentorNo;       // 멘토 번호
    private String classTitle;     // 강의명
    private String category;       // 카테고리(과목)
    private String region;         // 지역
    private String startDate;      // 시작일
    private String endDate;        // 종료일
    private String classDetail;    // 강의 상세내용
    private int amount;            // 금액
    private String status;         // 상태
}