package com.kh.sintoburi.domain.hc;

import lombok.Data;

@Data
public class BlogPageDto {
	
	private int pageNum;
	private int limit;
	private String type;
	private String keyword;
	
	public BlogPageDto() {
		this(1, 10);
	};
	
	public BlogPageDto(int pageNum, int limit) {
		this.pageNum = pageNum;
		this.limit = limit;
	}

}
