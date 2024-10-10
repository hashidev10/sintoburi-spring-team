package com.kh.sintoburi.gr.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.domain.gr.OrderVo;
import com.kh.sintoburi.domain.gr.PaymentDto;
import com.kh.sintoburi.mapper.gr.OrderMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMapperTests {
	@Autowired
	public OrderMapper orderMapper;
	
	
	@Test
	public void testInstance() {
		log.info("orderMapper:" + orderMapper);
	}
	
	@Test
	public void testInsert() {
		OrderVo vo = new OrderVo();
		vo.setOno(2);
		vo.setUser_phone("010-111-1111");
		vo.setUser_name("유저01");
		vo.setAddress("울산시 남구");
		vo.setPayment_type("포인트");
		vo.setUser_id("user01");
		int count = orderMapper.insert(vo);
		log.info(count);
	}
	
	@Test
	public void testGetOrderList() {
		String user_id= "user01";
		int ono = 22;
		List<OrderDto> list = orderMapper.getOrderList(user_id);
		log.info(list);
	}
	
	@Test
	public void testPayment() {
		String user_id= "user01";
		int ono = 40;
		PaymentDto dto = orderMapper.payment(user_id, ono);
		log.info(dto);
	}
	
	@Test
	public void testGetPaymentList() {
		String user_id = "user01";
		List<OrderDto> list = orderMapper.getPaymentList(user_id);
		log.info(list);
	}

}
