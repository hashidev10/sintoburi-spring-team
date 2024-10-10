package com.kh.sintoburi.domain.gr;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class DeliveryDto {
	public String user_name;
	public String user_phone;
	public String address;
	public String payment;
	
}
