package com.kh.sintoburi.util.hc;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.http.MediaType;

import lombok.extern.log4j.Log4j;

@Log4j
public class MyfileUtil {
	
	// 이미지 파일인지 체크
	public static boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contetType: " + contentType);
			if(contentType == null) {
				contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
			}
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public static String delete(String fileName) {
		log.info("fileName:" + fileName);
		log.info("fileName:" +"s_"+fileName);
		File f = new File(fileName);
		boolean result = checkImageType(f);
		if(result) {
			// 썸네일 이미지 삭제
			// 중간에 s_가 붙어잇다 E:/upload/2024/07/25/7feff155-fef7-43e4-b8e5-887f751ba9e0_mov07.jpg
			int slashIndex = fileName.lastIndexOf("/");
			// -> E:/upload/2024/07/25/
			String front = fileName.substring(0, slashIndex + 1);
			// -> 7feff155-fef7-43e4-b8e5-887f751ba9e0_mov07.jpg
			String rear = fileName.substring(slashIndex + 1);
			
			String thumbnail = front + "s_" + rear;
			File fThumbnail = new File(thumbnail);
			if (fThumbnail.exists()) {
				fThumbnail.delete();
			}
		}
		// 원본파일 삭제
		if(f.exists()) {
			f.delete();
		}
		// 삭제처리
		return "success";
	}

}
