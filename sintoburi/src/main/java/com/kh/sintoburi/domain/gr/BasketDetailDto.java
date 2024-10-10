package com.kh.sintoburi.domain.gr;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class BasketDetailDto {
	private int bdno; //장바구니 상세번호
	private int product_no;//상품번호
	private String product_name;//상품이름
	private String img_path;//상품 이미지
	private int price;//상품 가격
	private int p_count;//상품 개수
	private int total_price;
	private int bno; // 장바구니 번호
	private String user_id;//로그인한 구매자
	private Date put_date;
	private int delivery_charge;
	
}
