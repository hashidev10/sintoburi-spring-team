package com.kh.sintoburi.domain.gr;

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
public class PaymentDto {
	private String user_id;
	private int current_point;
	private int pay_amount;
	private int remain_point;
	private String payment_state;
	
	private int ono;
	//private int total_price;
	//private int delivery_charge;
	
}
