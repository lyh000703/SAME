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
public class Attachment {
	 // 첨부파일 타입 상수
    public static final int TYPE_BOARD = 1;    // 게시판 첨부파일
    public static final int TYPE_PROFILE = 2;  // 프로필 첨부파일
    // 추가가능

    private int fileNo;          // 파일 번호
    private int refNo;           // 참조 번호 (게시글 번호)
    private String originName;   // 원본 파일명
    private String changedName;  // 변경된 파일명
    private String filePath;     // 파일 경로
    private Date uploadDate;     // 업로드 일자
    private char isDelete;       // 삭제 여부 ('Y'/'N')
    private char atType;         // 첨부파일 타입
}
