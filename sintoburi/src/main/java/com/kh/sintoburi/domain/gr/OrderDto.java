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
public class OrderDto {
	public int ono;
	public String user_phone;
	public String user_name;
	public String address;
	private int total_price;
	private int delivery_charge;
	private int payment_state;
	private String p_state;
	public int sum_total;
	public int total;
	public int pay_amount;
	private Date order_date;
	private String delivery_status;
    public String user_id;
	public String payment_type;
	public String delivery_number;
	public int user_point;
}
