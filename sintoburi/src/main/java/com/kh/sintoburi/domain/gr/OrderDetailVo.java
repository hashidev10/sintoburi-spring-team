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
public class OrderDetailVo {
	private int odno;
	private int ono;
	private int product_no;
	
	private int p_count;
}
