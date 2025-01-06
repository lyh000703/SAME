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
public class Profile {
	private String memberNo;
	private String profileTitle;
	private String introduction;
	private Date contactTime;
	private Date classTime;
	private String gender;
}
