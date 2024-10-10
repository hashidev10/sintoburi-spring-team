package com.kh.sintoburi.service.gr;

import java.util.List;

import com.kh.sintoburi.domain.gr.OrderDto;

public interface SalesManageService {
	//관리자 판매 목록 전체 보기
	public List<OrderDto> getSalesManageList();
	
}
