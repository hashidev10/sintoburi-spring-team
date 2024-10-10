package com.kh.sintoburi.domain.gr;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BasketPageDto {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private BasketCriteria cri;
	
	public BasketPageDto(BasketCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//1~10, 11~20
		//현재 페이지에 따라서 페이지 블럭 정하기
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 5.0)) * 5; // 51페이지라면 60
		this.startPage = endPage - 4;
		
		//페이지 블럭을 얻었는데 실제 끝페이지가 endPage가 아닐 수 있다. 
		//데이터 개수가 501개라면 - endPage: 60, 실제 끝페이지는 51
		int realEnd = (int)(Math.ceil((total * 1.0)/cri.getAmount())); //51
		
		if(realEnd <this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전 버튼을 보일 것인지 여부
		this.prev = this.startPage > 1; // 11,21,31
		//다음 버튼을 보일 것인지 여부
		this.next = this.endPage < realEnd;
	}
	
}
