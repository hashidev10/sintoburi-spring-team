package com.kh.sintoburi.service.gr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.gr.DeliveryDto;
import com.kh.sintoburi.domain.gr.OrderDetailDto;
import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.domain.gr.OrderVo;
import com.kh.sintoburi.domain.gr.PaymentDto;

public interface OrderService {
	
	//주문하기 생성, 주문상세 생성, 배송비 계산
	public boolean runOrder(OrderVo orderVo, int[] bdnos);
	
	//주문하기 생성, 주문상세 생성, 배송비 계산
	public boolean runOrderNow(int product_no, int p_count, OrderVo orderVo);
	
	//배송정보 입력
	public DeliveryDto getDeliveryInfo(String user_id);
	
	//주문정보 목록
	public List<OrderDto> getOrderList(String user_id);
	
	//주문상세 정보 목록(주문번호 누르면 주문상세로 이동)  
	public List<OrderDetailDto> getDetailList(int ono);
	
	//결제하기(가격계산)
	public PaymentDto payment(String user_id, int ono); 
	
	//결제 후 포인트 갱신, 결제 후 결제완료 상태 갱신
	//public boolean doPay(PaymentDto dto);
	
	//결제 후 결제완료 목록
	 public List<OrderDto> getPaymentList(String user_id);
	 
	 public boolean updatePoint(PaymentDto dto);
	 
	 public boolean updatePaymentState(PaymentDto dto);
}
