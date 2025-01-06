package com.kh.board.model.dto;

import java.sql.Date;


import lombok.AllArgsConstructor;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewRating {
    private int ratingNo;       // RATING_NO NUMBER
    private int boardNo;        // BOARD_NO NUMBER
    private String memberNo;    // MEMBER_NO VARCHAR2(5)
    private int rating;         // RATING NUMBER
    private Date ratingDate;    // RATING_DATE DATE
}