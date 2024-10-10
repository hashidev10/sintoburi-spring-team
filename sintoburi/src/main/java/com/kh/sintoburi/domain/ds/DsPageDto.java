package com.kh.sintoburi.domain.ds;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class DsPageDto {

	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private DsCriteria cri;
	
	public DsPageDto(DsCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;
	
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1; 
	
		this.next = this.endPage < realEnd;
	}
}
