package com.kh.sintoburi.controller.gr;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/gr/upload")
@Log4j
public class UploadController {
	//상품 이미지 처리
	//<img src="/display?fileName=D:/upload/2024/07/23/0d781a29-1180-4542-815a-e7b88c16170d_horse.png"/>
	@ResponseBody
	@GetMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception {
		File f = new File(fileName);
		//binary data //http://localhost/display?fileName=
		byte[] data = FileCopyUtils.copyToByteArray(f);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", Files.probeContentType(f.toPath())); //image/png
		ResponseEntity<byte[]> entity = 
				new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
		return entity;
	}
	
}
