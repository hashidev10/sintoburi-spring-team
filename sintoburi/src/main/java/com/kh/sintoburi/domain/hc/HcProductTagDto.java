package com.kh.sintoburi.domain.hc;


import lombok.Data;

@Data
public class HcProductTagDto {
	private int blog_no;
	private int product_no;
	private String product_name;
	private boolean isDuplicate; // 중복체크
	private String file_path; // yyyy/MM/dd
	private String uuid;       // random string
	private String file_name;
}
