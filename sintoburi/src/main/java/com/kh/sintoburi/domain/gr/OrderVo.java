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
public class OrderVo {
	public int ono;
	public String user_phone;
	public String user_name;
	public String address;
	private int delivery_charge;
	public int pay_amount;
	private Date order_date;
	private String delivery_status;
    private int total_price;
    public String user_id;
	private int payment_state;
	public String payment_type;
	public int sum_total;
	public String delivery_number;
}
