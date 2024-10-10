package com.kh.sintoburi.domain.ji;

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
public class RelatedProdDto {
	
	private int product_no;
	private String product_name;
	private int price;
	private String uuid;
	private String user_id;
	private String img_name;
	private String img_path;


}
