package com.kh.sintoburi.domain.gr;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class BasketCriteria {

	private int pageNum = 1; //페이지 번호
	private int amount = 5; // 한 페이지 당 보여질 게시물 갯수
	private String user_id;
	
	public BasketCriteria() {
		this(1,5, null); //1페이지 5개
	}
	
	public BasketCriteria(String user_id) {
		this.user_id = user_id;
	}
	public BasketCriteria(int pageNum, int amount, String user_id) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.user_id = user_id;
	}
	
}
