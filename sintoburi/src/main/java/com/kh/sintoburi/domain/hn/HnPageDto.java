package com.kh.sintoburi.domain.hn;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class HnPageDto {

	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private HnCriteria cri;
	
	public HnPageDto(HnCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		// 1 ~ 10, 11 ~ 20, ..., 51 ~ 60
		// 현재페이지에 따라서 페이지 블럭 정하기
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;
		
		// 페이지 블럭을 얻었는데, 실제 끝페이지가 endPage가 아닐 수 있다.
		// 데이터갯수가 501개라면 -> endPage : 60, 실제 끝페이지는 51
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		// 이전 버튼을 보일 것인지 여부
		this.prev = this.startPage > 1; // 11, 21, 31, ...
		// 다음 버튼을 보일 것인지 여부
		this.next = this.endPage < realEnd;
	}
}
