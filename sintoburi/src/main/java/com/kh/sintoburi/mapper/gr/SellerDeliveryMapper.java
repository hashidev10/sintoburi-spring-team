package com.kh.sintoburi.mapper.gr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.gr.OrderDto;

public interface SellerDeliveryMapper {
	public List<OrderDto> getDeliveryManageList(@Param("user_id") String user_id);
	
	public int updateDeliveryStatus(@Param("ono") int ono, 
			@Param("delivery_status") String delivery_status, 
			@Param("delivery_number") String delivery_number);
}
