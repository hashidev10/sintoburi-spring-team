package com.kh.sintoburi.service.gr;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.gr.BasketDetailDto;
import com.kh.sintoburi.domain.gr.DeliveryDto;
import com.kh.sintoburi.domain.gr.OrderDetailDto;
import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.domain.gr.OrderVo;
import com.kh.sintoburi.domain.gr.PaymentDto;
import com.kh.sintoburi.mapper.gr.BasketMapper;
import com.kh.sintoburi.mapper.gr.OrderMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService{

	@Autowired
	public OrderMapper orderMapper;
	
	@Autowired
	public BasketMapper basketMapper;
	
	@Transactional
	@Override
	public boolean runOrder(OrderVo orderVo, int[] bdnos) {
		// 주문에 추가
		orderMapper.insert(orderVo);
		int ono = orderVo.getOno();
		
		
		// 주문 상세에 추가
		for(int bdno : bdnos) {
			BasketDetailDto dto = basketMapper.selectByBdno(bdno);
			int product_no = dto.getProduct_no();
			int p_count = dto.getP_count();
			OrderDetailDto orderDetailDto = new OrderDetailDto();
			orderDetailDto.setOno(ono);
			orderDetailDto.setProduct_no(product_no);
			orderDetailDto.setP_count(p_count);
			orderMapper.insertDetail(orderDetailDto);
			log.info(bdno + "주문 상세에 추가됨.");
		}
		
		
		//배송비 계산
		orderMapper.updateDeliveryCharge(ono);
		log.info("배송비 계산.");
		//상품 가격 합계 계산
		orderMapper.updateSumTotal(ono);
		log.info("상품 가격 합계 계산.");
		//결제금액 계산
		orderMapper.updatePayAmount(ono);
		log.info("결제금액 계산.");
		
		// 장바구니 상세에서 삭제
		for(int bdno : bdnos) {
			basketMapper.delete(bdno);
			log.info(bdno + "삭제.");
		}
		
		return true;
	}
	
	@Override
	public boolean runOrderNow(int product_no, int p_count, OrderVo orderVo) {
		// 주문에 추가
		orderMapper.insert(orderVo);
		int ono = orderVo.getOno();
		
		
		// 주문 상세에 추가
//		for(int bdno : bdnos) {
//			BasketDetailDto dto = basketMapper.selectByBdno(bdno);
//			int product_no = dto.getProduct_no();
//			int p_count = dto.getP_count();
			OrderDetailDto orderDetailDto = new OrderDetailDto();
			orderDetailDto.setOno(ono);
			orderDetailDto.setProduct_no(product_no);
			orderDetailDto.setP_count(p_count);
			orderMapper.insertDetail(orderDetailDto);
//			log.info(bdno + "주문 상세에 추가됨.");
//		}
		
		
		//배송비 계산
		orderMapper.updateDeliveryCharge(ono);
		log.info("배송비 계산.");
		//상품 가격 합계 계산
		orderMapper.updateSumTotal(ono);
		log.info("상품 가격 합계 계산.");
		//결제금액 계산
		orderMapper.updatePayAmount(ono);
		log.info("결제금액 계산.");
		
		// 장바구니 상세에서 삭제
//		for(int bdno : bdnos) {
//			basketMapper.delete(bdno);
//			log.info(bdno + "삭제.");
//		}
		
		return true;
	};
	
	//배송정보 입력
	@Override
	public DeliveryDto getDeliveryInfo(String user_id) {
		DeliveryDto dto = orderMapper.getDeliveryInfo(user_id);
		return dto;
	}
	
	//주문정보 목록
	@Override
	public List<OrderDto> getOrderList(String user_id) {
		List<OrderDto> list = orderMapper.getOrderList(user_id);
		return list;
	}

	//주문상세 정보 목록(주문번호 누르면 주문상세로 이동)  
	@Override
	public List<OrderDetailDto> getDetailList(int ono) {
		List<OrderDetailDto> detailList = orderMapper.getDetailList(ono);
		return detailList;
	}

	//결제하기
		@Override
		public PaymentDto payment(String user_id, int ono) {
			
			PaymentDto dto = orderMapper.payment(user_id, ono);
			return dto;
		}
	
	// 결제 후 포인트 갱신
	@Override
	public boolean updatePoint(PaymentDto dto) {
		int count = orderMapper.updatePoint(dto);
		return (count ==1 ) ? true : false;
	}
	
	// 결제 후 결제완료 상태 갱신
	@Override
	public boolean updatePaymentState(PaymentDto dto) {
		int count = orderMapper.updatePaymentState(dto);
		return (count == 1) ? true : false;
	}
	
	//결제 후 결제완료 목록
	public List<OrderDto> getPaymentList(String user_id){
		List<OrderDto> list = orderMapper.getPaymentList(user_id);
		return list;
	}

	


}
