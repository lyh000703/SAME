package com.kh.common.rename;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;


public class FileRenamePolicy implements com.oreilly.servlet.multipart.FileRenamePolicy{

	@Override
	public File rename(File originFile) {
	
				// 파일명 수정 메소드

			
				// 원본파일명
				String originName = originFile.getName();
				
				// 수정된 파일명 : 파일업로드시간(년월일시년분초) + 5자리 랜덤값(10000-99999)을 합쳐 고유한 파일명 추가
				// 확장자 : 원본파일의 확장자 그대로 사용
				// aaa.jpg ===> 202412121245912345.jpg
				
				// 1. 파일 업로드 시간 
				String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
									.format(new Date());
				
				// 2. 5자리 랜덤값
				int random = (int) (Math.random()*90000+10000);
				
				// 3. 확장자
				String ext = originName.substring(originName.lastIndexOf('.'));
				
				String changedName = currentTime+random+ext;
				
				// 원본파일의 파일명을 수정된 파일명으로 변경시켜서 파일객체 반환
				
				
				return new File(originFile.getParent(), changedName);
		
		
	}

}
