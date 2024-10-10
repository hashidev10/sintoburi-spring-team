package com.kh.sintoburi.domain.hn;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HnCriteria {
	private int pageNum; // 페이지 번호
	private int amount;  // 한 페이지 당 보여질 게시물 갯수
	private String type; // 검색항목(제목/내용/작성자) - TC
	private String keyword; // 검색어(사용자 입력값)
	private String user_id;
	
	public HnCriteria() {
		this(1, 10, null); // 1페이지, 10개
	}
	public HnCriteria(String user_id) {
		this.user_id = user_id;
	}
	
	public HnCriteria(int pageNum, int amount,String user_id) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.user_id = user_id;
	}
	public String[] getTypeArr() {
	    if (type != null && !type.isEmpty()) {
	        return type.split(",");
	    }
	    return new String[0];
	}
}
