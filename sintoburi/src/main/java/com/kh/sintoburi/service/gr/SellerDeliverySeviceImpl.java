package com.kh.sintoburi.service.gr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.mapper.gr.SalesManageMapper;
import com.kh.sintoburi.mapper.gr.SellerDeliveryMapper;

@Service
public class SellerDeliverySeviceImpl implements SellerDeliveryService{

	@Autowired
	private SellerDeliveryMapper sellerDeliveryMapper;

	@Override
	public List<OrderDto> getDeliveryManageList(String user_id) {
		List<OrderDto> list = sellerDeliveryMapper.getDeliveryManageList(user_id);
		return list;
	}
	
	@Override
	public boolean updateDeliveryStatus(int ono, String delivery_status, String delivery_number) {
		int count = sellerDeliveryMapper.updateDeliveryStatus(ono, delivery_status,delivery_number);
		return (count == 1)? true: false;
	}

}
