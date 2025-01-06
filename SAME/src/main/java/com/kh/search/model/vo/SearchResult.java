package com.kh.search.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SearchResult {
    private int boardNo;
    private String title;
    private String content;
    private String type; // "board", "mentor", "class" 등
    private String url;
    private String createDate;
    private int viewCount;
} 