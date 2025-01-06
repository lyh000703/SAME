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
public class Board {
	private int boardNo;
	private String memberNo;
	private char boardType;
	private Category category;
	private int count;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date editDate;
	private char isDelete;
	private char isHidden;
	private int rNum;
}
