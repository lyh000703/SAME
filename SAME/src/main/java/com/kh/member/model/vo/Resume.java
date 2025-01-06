package com.kh.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Resume {
    private int resumeNo;
    private int memberNo;
    private int fileNo;
    private String regionName;
    private String className;
    private String education;
    private String career;
    private String license;
}
