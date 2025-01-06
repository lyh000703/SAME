package com.kh.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reply {
	private int commentNo; // 댓글번호
	private int boardNo;  // 참조게시글 번호
	private String memberNo; // 작성자
	private String commentContent;
	private Date createDate;
	private Date editDate;
	private int parent; // 부모댓글 여부
	
	private String isDelete;
	private String isHidden;
}
