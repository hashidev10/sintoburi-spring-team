package com.kh.sintoburi.service.gr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.mapper.gr.SalesManageMapper;

@Service
public class SalesManageServiceImpl implements SalesManageService{

	@Autowired
	private SalesManageMapper salesManageMapper;
	
	//관리자 판매 목록 전체 보기
	@Override
	public List<OrderDto> getSalesManageList() {
		List<OrderDto> list = salesManageMapper.getSalesManageList();
		return list;
	}

}
