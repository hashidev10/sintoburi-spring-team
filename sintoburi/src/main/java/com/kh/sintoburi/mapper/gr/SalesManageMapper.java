package com.kh.sintoburi.mapper.gr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.gr.OrderDto;

public interface SalesManageMapper {
	//관리자 판매 목록 전체 보기
	public List<OrderDto> getSalesManageList();


}
