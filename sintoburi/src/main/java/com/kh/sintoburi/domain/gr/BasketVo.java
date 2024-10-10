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
public class BasketVo {
	private int bno; //장바구니 번호
	private String user_id; // 구매자 = 로그인
}
