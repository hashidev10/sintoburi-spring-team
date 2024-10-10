package com.kh.sintoburi.domain.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class ProductImageVo {

	private String uuid;	 // random string
	private String img_name; // 상품 이름
	private String img_path; // 상품 경로
	private Integer product_no; 	 // 어느 상품의 첨부파일인지
	private char represent;  // 상품 대표 이미지
}
