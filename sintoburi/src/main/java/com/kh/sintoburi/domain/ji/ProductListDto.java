package com.kh.sintoburi.domain.ji;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductListDto {
	private int product_no;
	private String product_name;
	private int price;
	private int stock;
	private String status;
	private Date reg_date;
	private Date upd_date;
	private String user_id;
}
