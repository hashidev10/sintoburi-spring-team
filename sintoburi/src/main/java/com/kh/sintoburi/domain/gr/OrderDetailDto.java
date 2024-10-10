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
public class OrderDetailDto {
    private String user_id;
	private int ono;
	private int product_no;
	private String product_name;
	private String img_path;
	private int p_count;//상품 개수
	private int price;
	private int total_price;
	private int delivery_charge;
	private int pay_amount;
	private String delivery_status;
	private Date order_date;
}
