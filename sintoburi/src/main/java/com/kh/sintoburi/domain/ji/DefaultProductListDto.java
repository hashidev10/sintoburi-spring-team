package com.kh.sintoburi.domain.ji;

import lombok.Setter;
import lombok.ToString;
import lombok.Getter;

@Getter
@Setter
@ToString
public class DefaultProductListDto {

	private int product_no;
	private String product_name;
	private int price;
	private int cate_no;
	private String user_id;
	private String uuid;
	private String img_name;
	private String img_path;
	
}
