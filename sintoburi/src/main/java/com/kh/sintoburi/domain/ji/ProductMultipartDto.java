package com.kh.sintoburi.domain.ji;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ProductMultipartDto {
	
	private int product_no;
	private String product_name;
    private String details;
    private int price;
    private int stock;
    private String status;
    private int cate_no;
    private String summary;
    private MultipartFile[] productImg; 

}
