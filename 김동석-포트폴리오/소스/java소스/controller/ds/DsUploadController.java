package com.kh.sintoburi.controller.ds;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequestMapping("/ds/upload/*")
@RestController
@RequiredArgsConstructor
public class DsUploadController {

	    @Autowired
		private final WebApplicationContext context; 
	    
	    @PostMapping(value = "/image-upload")
	    @ResponseBody
	  
		public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file,HttpSession session) throws IllegalStateException, IOException {
			try {
				// 서버에 저장할 경로
				String uploadDirectory = context.getServletContext().getRealPath("/resources/assets/images/upload"); 
				
				// 업로드 된 파일의 이름
				String originalFileName = file.getOriginalFilename();
				
				// 업로드 된 파일의 확장자
				String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				// 업로드 될 파일의 이름 재설정 (중복 방지를 위해 UUID 사용)
				String uuidFileName = UUID.randomUUID().toString() + fileExtension;
				
				// 위에서 설정한 서버 경로에 이미지 저장
				
				File files = new File(uploadDirectory, uuidFileName);
				System.out.println("files:"+files);
			
				file.transferTo(new File(uploadDirectory, uuidFileName));

				System.out.println("uploadDirectory:"+uploadDirectory);
				session.setAttribute("thumbPath", files);
				
				return ResponseEntity.ok(uuidFileName);
			} catch (Exception e) {
				return ResponseEntity.badRequest().body("이미지 업로드 실패");
			}
			
		}
}
