package com.kh.sintoburi.service.gr;

import java.util.List;

import com.kh.sintoburi.domain.gr.OrderDto;

public interface SellerDeliveryService {
	public List<OrderDto> getDeliveryManageList(String user_id);
	
	public boolean updateDeliveryStatus(int ono, String delivery_status, String delivery_number);
}
