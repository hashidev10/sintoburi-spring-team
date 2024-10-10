package com.kh.sintoburi.gr.service;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.domain.gr.OrderVo;
import com.kh.sintoburi.service.gr.OrderService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderServiceTests {
	
	@Autowired
	public OrderService orderService;
	
	@Test
	public void testGetOrderList() {
		String user_id= "user01";
		int ono = 28;
		List<OrderDto> list = orderService.getOrderList(user_id);
		log.info(list);
	}
	
	@Test
	public void testInsert() {
		List<Integer> bdnos = Arrays.asList(1, 2, 3);
		
		OrderVo vo = new OrderVo();
		vo.setOno(4);
		vo.setUser_phone("010-111-1111");
		vo.setUser_name("유저01");
		vo.setAddress("울산시 남구");
		vo.setPayment_type("포인트");
		vo.setUser_id("user01");
		//boolean result	= orderService.runOrder(vo, bdnos);
		//log.info(result);
	}
	
	@Test
	public void testGetPaymentList() {
		String user_id = "user01";
		List<OrderDto> list = orderService.getPaymentList(user_id);
		log.info(list);
	}

}
