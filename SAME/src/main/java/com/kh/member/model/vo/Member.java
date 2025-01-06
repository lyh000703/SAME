package com.kh.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
	private String memberNo;
	private String memberId;
	private String memberPwd;
	private String memberName;
	private int phone;
	private String memberSSN; // 주민등록번호
	private String email;
	private String isQuit;
	private String socialCode;
	private String address;
	private String memberType; //멘티멘토 구분
	private Date enrollDate;
	
	// 멘토 전용 필드 (이력서)
    private String introduction; // 강사의 한마디
    private String regionName; // 지역
    private String className; // 강의 과목
    private String education; // 학력
    private String career; // 경력
    private String license; // 자격증/외국어
	
}
