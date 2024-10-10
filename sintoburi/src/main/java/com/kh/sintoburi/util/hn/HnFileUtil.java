package com.kh.sintoburi.util.hn;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.http.MediaType;

import lombok.extern.log4j.Log4j;

@Log4j
public class HnFileUtil {
	// 이미지 파일인지 체크
	public static boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType:" + contentType);
			if (contentType == null) {
				contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
			}
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	

	public static String delete(String imageName) {
		log.info("fileName:" + imageName);
		File f = new File(imageName);

		// 원본 파일 삭제
		if (f.exists()) {
			f.delete();
		}
		// 삭제 처리
		return "success";
	}
}
