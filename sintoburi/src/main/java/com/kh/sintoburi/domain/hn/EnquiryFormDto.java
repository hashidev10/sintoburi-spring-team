package com.kh.sintoburi.domain.hn;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnquiryFormDto {
	private int eno;
	private String user_id;
	private String enquiry_type;
	private String content;
	private List<MultipartFile> image;
	private List<String> imageDel;

}
