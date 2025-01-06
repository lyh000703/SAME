package com.kh.board.model.dto;

import java.sql.Date;

public class BoardAttachmentDTO {
	// 데이터를 옮기는데 필요한 필드들 하나하나 선언
		private int boardNo;
		private String categoryName;
		private String boardTitle;
		private String boardContent;
		private String memberNo;
		private Date createDate;
		private String originName;
		private String filePath;
}
