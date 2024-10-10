package com.kh.sintoburi.controller.hn;

import java.io.File;
import java.nio.file.Files;

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
@RequestMapping("/hn/manager/*")
@Log4j
public class HnUploadController {

	// <img src="/display?fileName="/>
	@ResponseBody
	@GetMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception {
		File f = new File(fileName);
		// binary data
		byte[] data = FileCopyUtils.copyToByteArray(f);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", Files.probeContentType(f.toPath())); // image/png
		ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
		return entity;
	}

}
