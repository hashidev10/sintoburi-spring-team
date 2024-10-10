package com.kh.sintoburi.domain.common;

import java.util.Date;
import java.util.List;

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
public class ProductVo {
	
	private int product_no;
	private String product_name;
	private String details;
	private int price;
	private int stock;
	private String status;
	private Date reg_date;
	private Date upd_date;
	private int cate_no;
	private String user_id;
	private String summary;
	
	private List<ProductImageVo> imgList;
	private List<ProductImageVo> delList;
	
	
}

