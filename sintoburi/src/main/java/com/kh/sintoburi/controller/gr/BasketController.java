package com.kh.sintoburi.controller.gr;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.gr.BasketCriteria;
import com.kh.sintoburi.domain.gr.BasketDetailDto;
import com.kh.sintoburi.domain.gr.BasketDetailVo;
import com.kh.sintoburi.domain.gr.BasketPageDto;
import com.kh.sintoburi.domain.gr.BasketVo;
import com.kh.sintoburi.service.gr.BasketService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/gr/basket/*")
@Log4j
public class BasketController {
	
	@Autowired
	private BasketService basketService;
	
	//장바구니에 물건 담기(TODO 지환: 구매 페이지 장바구니 버튼 누르기와 연동, 상품 번호가 같으면 개수 합하기)
	@PostMapping("/putBasket")
	public String putBasket(HttpSession session, BasketDetailVo detailVo, RedirectAttributes rttr) {
		System.out.println("지금받은 디테일vo는?" + detailVo);
		//장바구니 번호 가져오기
		UserVo dto = (UserVo)session.getAttribute("login");
//		if (dto == null) {
//			return "redirect:/hc/main/home";
//		}
		String user_id = dto.getUser_id();
		int bno =basketService.getBnoByUserId(user_id);
		
		//없다면 장바구니 번호 생성하기
		if (bno == 0) {
			BasketVo vo = new BasketVo();
			vo.setUser_id(user_id);
			basketService.getBasketKey(vo);
			bno = vo.getBno();
		}
		detailVo.setBno(bno);
		//장바구니 상세에 담기
		boolean result = basketService.putBasket(detailVo);
		rttr.addFlashAttribute("resultputBasket", result);
		return "redirect:/gr/basket/list";
	}
	
	// 장바구니 목록 보기(페이징)
	@GetMapping("/list")
	public String list(Model model, HttpSession session, BasketCriteria criteria) {
		UserVo dto = (UserVo)session.getAttribute("login");
		System.out.println("로그인한 유저는?" + dto);
//		if (dto == null) {
//			//return "redirect:/hc/main/home";
//		}
		String user_id = dto.getUser_id();
		criteria.setUser_id(user_id);
//		System.out.println("Page Number: " + criteria.getPageNum());
//		System.out.println("Amount per Page: " + criteria.getAmount());
		List<BasketDetailDto> list = basketService.getListWithPaging(criteria);
		int sumPrice = basketService.getSumPrice(user_id);
		int total = basketService.getTotalCount(criteria, user_id);
		log.info("total:" + total);
		
		BasketPageDto pageMaker = new BasketPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
		model.addAttribute("sumPrice", sumPrice);
		return "/gr/basket/list";
	}
		
	// 장바구니에 담긴 상품 개수 수정
	@PostMapping("/modCount")
	@ResponseBody
	public boolean modCount(@RequestBody Map<String, Integer> map) {
		//System.out.println("modCount...map:" + map);
		int bdno = map.get("bdno");
		int p_count = map.get("p_count");
		//System.out.println("modCount...bdno:" + bdno);
		//System.out.println("modCount...p_count:" + p_count);
		boolean result = false;
		if(p_count == 0)	{
			result = basketService.removeOne(bdno);
		} else {
			result = basketService.modifyCount(p_count, bdno);
		}
		return result;
	}
	
	//장바구니 목록에서 체크한 상품 제거
	@PostMapping("/removeOne")
	@ResponseBody
	public boolean removeOne(@RequestBody Map<String, List<Integer>> bdnos) {
		System.out.println("removeOne...bdnos:" + bdnos);
		List<Integer> list = bdnos.get("bdnos");
		for (Integer bdno : list) {
			basketService.removeOne(bdno);
		}
		return true;
	}
	
	//장바구니 비우기 - 장바구니 상세에 있는 상품들 모두 제거 -> 장바구니 제거
	@PostMapping("/removeAll")
	@ResponseBody
	public String removeAll(/* @RequestBody Map<String, Integer> map, */HttpSession session) {
		
		UserVo dto = (UserVo)session.getAttribute("login");
//		if (dto == null) {
//			//return "redirect:/hc/main/home";
//		}
		String user_id = dto.getUser_id();
	
		int bno = basketService.getBnoByUserId(user_id);
//		System.out.println("removeAll...map:" + map);
//		Integer bno = map.get("bno");
//		System.out.println("removeAll...bno:" + bno);
		boolean result = basketService.removeAll(bno);
		return String.valueOf(result);
	}

}
