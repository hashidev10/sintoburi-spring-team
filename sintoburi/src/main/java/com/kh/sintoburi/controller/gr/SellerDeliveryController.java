package com.kh.sintoburi.controller.gr;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.service.gr.SellerDeliveryService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/gr/seller_delivery/*")
@Log4j
public class SellerDeliveryController {

	@Autowired
	public SellerDeliveryService sellerDeliveryService; 
	
	//판매자가 판매한 상품 목록 보기
	@GetMapping("/list")
	public String deliveryManage(Model model,HttpSession session) {
		UserVo dto = (UserVo)session.getAttribute("login");
//	    if (dto == null) {
//	        //return "redirect:/"; // 세션에 login 정보가 없으면 로그인 페이지로 리디렉션
//	    }
		String user_id = dto.getUser_id();
		
		List<OrderDto> deliveryList	= sellerDeliveryService.getDeliveryManageList(user_id);
	    model.addAttribute("deliveryList", deliveryList);
	    return "/gr/seller_delivery/list";
	}
	
	//배송상태 바꾸기(배송전, 배송준비중, 배송중, 배송완료)
	@PostMapping("/updateDeliveryStatus")
	@ResponseBody
	public boolean updateDeliveryStatus(@RequestBody OrderDto orderDto)  {
		log.info("OrderDto" + orderDto);
		
		int ono = orderDto.getOno();
		String delivery_status = orderDto.getDelivery_status();
		String delivery_number = orderDto.getDelivery_number();
		log.info("ono" + ono);
		log.info("delivery_status" + delivery_status);
		log.info("delivery_number" + delivery_number);
		boolean result = sellerDeliveryService.updateDeliveryStatus(ono, delivery_status, delivery_number);
		return result;
	}

	
}
