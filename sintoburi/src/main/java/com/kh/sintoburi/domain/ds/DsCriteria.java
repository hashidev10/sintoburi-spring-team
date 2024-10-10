package com.kh.sintoburi.domain.ds;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DsCriteria {

	private int pageNum;	// 페이지 번호
	private int amount;		// 한 페이지 당 보여질 게시물 갯수
	private String type;	// 검색항목(제목/내용/작성자)
	private String keyword; // 검색어(사용자 입력값)

	public DsCriteria() {

		this(1,8); // 1페이지, 8개
	}

	public DsCriteria(int pageNum, int amount) {
		//System.out.println("(,,)");
		this.pageNum = pageNum;
		this.amount = amount;
		System.out.println(this);
	}

	public String[] getTypeArr() {
		if(type!=null) {
			String[] strs=type.split("");
			return strs;
		}
		
		return null;
	
	}

	
}
