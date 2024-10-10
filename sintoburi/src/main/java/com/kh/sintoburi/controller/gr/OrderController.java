package com.kh.sintoburi.controller.gr;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.gr.DeliveryDto;
import com.kh.sintoburi.domain.gr.OrderDetailDto;
import com.kh.sintoburi.domain.gr.OrderDto;
import com.kh.sintoburi.domain.gr.OrderVo;
import com.kh.sintoburi.domain.gr.PaymentDto;
import com.kh.sintoburi.service.gr.OrderService;
import com.kh.sintoburi.util.gr.GrSessionUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/gr/order/*")
@Log4j
public class OrderController {

	@Autowired
	public OrderService orderService;
	
	//장바구니에서 체크한 것 주문하기로 넘겨주기, 장바구니 목록에서 삭제
	@PostMapping("/run_order")
	public String runOrder(HttpSession session, OrderVo orderVo, RedirectAttributes rttr) {
		UserVo dto = (UserVo)session.getAttribute("login");
		log.info("orderVo:" + orderVo);
		// bdno값 받기
		int[] bdnos = (int[])session.getAttribute("bdnos");
		for (int bdno : bdnos) {
			log.info("bdno:" + bdno);
		}
			
		//로그인한 상태
//		if (dto == null) {
//			return "redirect:/hc/main/home";
//		}
		String user_id = dto.getUser_id();
		orderVo.setUser_id(user_id);
		
		boolean result = orderService.runOrder(orderVo, bdnos);
		//log.info(result);
		//log.info("runOrder, orderVo: " + orderVo);
		rttr.addAttribute("ono", orderVo.getOno());
		return "redirect:/gr/order/order_list";
	}	
			
	//배송정보 입력 폼(주문자 정보와 수취인 정보)
	@GetMapping("/order_form")
	public void orderForm(HttpSession session) {
		 int[] bdnos =(int[])session.getAttribute("bdnos");
		 if (bdnos != null && bdnos.length > 0) {
			 log.info("bdnos:" + Arrays.toString(bdnos));
		 }
	}
	
	//배송정보 입력 폼 (즉시 주문/결제 시)
	// TODO: 지환씨 상품 보기 -> 바로 주문(/gr/order/order_form_now?product_no=1&p_count=2)
	// 바로주문: 상품번호(product_no), 개수(p_count), 바로주문옵션(ordernow=Y)
	@GetMapping("/order_form_now")
	public String orderFormNow(HttpSession session,
			@ModelAttribute("product_no") int product_no,
			@ModelAttribute("p_count") int p_count,
			Model model) {
		log.info("product_no:" + product_no);
		log.info("p_count:" + p_count);
		model.addAttribute("ordernow", "Y");
		return "/gr/order/order_form";
	}
	
	//주문 전에 bdno 넘겨주기(주문하기에 정보 넘겨주고 장바구니 목록에서는 삭제하는 상황)
	@PostMapping("/pre_order")
	public String preOrder(@RequestParam("bdnos") int[] bdnos, HttpSession session) {
		log.info("bdnos:" + Arrays.toString(bdnos));
		session.setAttribute("bdnos", bdnos);
		return "redirect:/gr/order/order_form";
	}
	
	//배송정보(수취인 이름,전화번호, 배송지) 입력
	@GetMapping("/getDeliveryInfo")
	@ResponseBody
	public DeliveryDto getDeliveryInfo(HttpSession session) {
		String user_id =  GrSessionUtil.getUserIdInLoginSession(session);
		DeliveryDto dto = orderService.getDeliveryInfo(user_id);
//		dto.setUser_name("유저03");
//		dto.setUser_phone("010-3333-3333");
//		dto.setAddress("울산시 남구");
		return dto;
	}
	
	//장바구니에서 넘어온 주문서 목록
	@GetMapping("/order_list")
	public String orderList(Model model, HttpSession session, Integer ono){
		UserVo dto = (UserVo)session.getAttribute("login");
		//System.out.println("ono:" + ono);
//	    if (dto == null) {
//	        return "redirect:/hc/main/home"; // 세션에 login 정보가 없으면 로그인 페이지로 리디렉션
//	    }
		//System.out.println("dto:" + dto);
		String user_id = dto.getUser_id();
		//System.o//ut.println("user_id: "+ user_id);
		
		System.out.println("id:"+user_id+", ono:"+ono);
//		결제(가격 계산): 결제 전 정보 처리
//		PaymentDto paymentDto = orderService.payment(user_id, ono);
//		log.info("paymentDto:" + paymentDto);
//		model.addAttribute("paymentDto",paymentDto);
//		System.out.println("paymentDto" + paymentDto);
		
		List<OrderDto> orderList = orderService.getOrderList(user_id);
		model.addAttribute("orderList", orderList);
		return "/gr/order/order_list";
	}
	
	//주문서 상세정보 목록(주문번호 누르면 주문상세로 이동)  
	@GetMapping("/detail/{ono}")
	public String getDetailList(@PathVariable("ono") int ono,
			Model model, HttpSession session ){
		//UserVo dto = (UserVo)session.getAttribute("login");
		// dto가 null인지 확인
//	    if (dto == null) {
//	       // return "redirect:/gr"; // 세션에 login 정보가 없으면 로그인 페이지로 리디렉션
//	    }
		//System.out.println("dto:" + dto);
		//String user_id = dto.getUser_id();
		//System.out.println("user_id: "+ user_id);
		
		List<OrderDetailDto> detailList = orderService.getDetailList(ono);
		model.addAttribute("detailList", detailList);
		return "/gr/order/detail";
	}
	
	//결제하기: 포인트가 결제금액보다 적으면 alert, 포인트-결제금액(pay_amount)해서 가격계산,
	//        tbl_user 포인트 수정, tbl_order에 결제완료1 상태로 바꾸기 
	//TODO 사용자테이블의 포인트: 갱신
    //TODO 포인트테이블에 포인트 사용 내역: 추가
	@PostMapping("/do_pay")
	@ResponseBody
	public void doPay(@RequestBody PaymentDto paymentDto, 
			Model model, HttpSession session) {
		 System.out.println( "paymentDto" + paymentDto);
		 orderService.updatePaymentState(paymentDto);
		 orderService.updatePoint(paymentDto);
		 //System.out.println(result);
		 //JSP에 리턴 만듦 return "redirect:/gr/order/payment_list";
	}
	
	//결제완료 목록
	@GetMapping("/payment_list")
	public String paymentList(Model model, HttpSession session,  
			Integer ono, PaymentDto paymentDto) {
		 System.out.println("Received ono: " + ono);
		UserVo dto = (UserVo)session.getAttribute("login");
//	    if (dto == null) {
//	       // return "redirect:/gr"; 
//	    }
		String user_id = dto.getUser_id();
							
		List<OrderDto> paymentList = orderService.getPaymentList(user_id);
		model.addAttribute("paymentList", paymentList);
		return "/gr/order/payment_list";
	}
	
	//TODO: 지환님 즉시주문
	// 즉시주문 결제시 배송정보 입력 후 주문서로  이동
	@PostMapping("/ordernow")
	public String ordernow(
			int product_no, int p_count, OrderVo orderVo, 
			HttpSession session, RedirectAttributes rttr) {
		log.info("product_no:" + product_no);
		log.info("p_count:" + p_count);
		log.info("orderVo:" + orderVo);
		UserVo dto = (UserVo)session.getAttribute("login");
		orderVo.setUser_id(dto.getUser_id());
		orderService.runOrderNow(product_no, p_count, orderVo);
		rttr.addAttribute("ono", orderVo.getOno());
		return "redirect:/gr/order/order_list";
	}
}
