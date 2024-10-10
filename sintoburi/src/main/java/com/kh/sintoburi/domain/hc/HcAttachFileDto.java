package com.kh.sintoburi.domain.hc;

import lombok.Data;

@Data
public class HcAttachFileDto {
	private String file_path; // yyyy/MM/dd
	private String uuid;       // random string
	private String file_name;   //1.png
	private boolean image;     //이미지인지 여부
	private int blog_no;			// 어디에 붙일건지
	private boolean isDuplicate; // 중복체크
}
