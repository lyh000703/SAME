package com.kh.manager.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Complaint {
    private int compNo;          // COMP_NO
    private String memberNo;     // MEMBER_NO
    private int boardNo;         // BOARD_NO
    private String compType;     // COMP_TYPE
    private String compContent;  // COMP_CONTENT
    private Date compDate;       // COMP_DATE
    private String isConfirm;    // IS_CONFIRM
} 