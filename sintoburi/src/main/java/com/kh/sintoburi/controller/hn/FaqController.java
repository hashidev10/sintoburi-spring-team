package com.kh.sintoburi.controller.hn;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.FaqVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnPageDto;
import com.kh.sintoburi.service.hn.FaqService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hn/manager/faq")
@Log4j
public class FaqController {
	
	@Autowired
	private FaqService faqService;

	// 자주하는 질문
	@GetMapping("/faqList")
	public String faqList(Model model, HnCriteria criteria,HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");

		if (login == null || (!"관리자".equals(login.getGrade()) && !login.getGrade().equals("마스터")) ) {
			session.invalidate();
			return "redirect:/ds/board/login";
		}
		List<FaqVo> list = faqService.faqList(criteria);
		model.addAttribute("faqList", list);
		
		int total = faqService.getTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		System.out.println("Criteria: " + criteria);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
		return "/hn/manager/faq/faqList";

	}

	@GetMapping("/faqRegisterForm")
	public void faqRegisterForm() {

	}

	// 자주하는 질문 작성
	@PostMapping("/faqRegister")
	public String faqRegister(FaqVo faqVo, RedirectAttributes rttr) {
		boolean result = faqService.faqRegister(faqVo);
		rttr.addAttribute("faqresult", result);
		return "redirect:/hn/manager/faq/faqList";
	}

	// 자주하는 질문 상세보기
	@GetMapping("/faqDetail/{f_no}")
	public String faqDetail(@PathVariable("f_no") int f_no, Model model) {
		FaqVo faqVo = faqService.selectByFno(f_no);
		model.addAttribute("faqVo", faqVo);

		return "hn/manager/faq/faqDetail";
	}

	// 자주하는 질문 수정
	@PostMapping("/faqMod")
	public String faqMod(FaqVo faqVo, RedirectAttributes rttr) {

		boolean result = faqService.faqModify(faqVo);
		rttr.addFlashAttribute("faqMod", result);
		return "redirect:/hn/manager/faq/faqList";
	}

	// 자주하는 질문 삭제
	@PostMapping("/faqDel")
	public String faqDel(@RequestParam("f_no") int f_no, RedirectAttributes rttr) {
		boolean result = faqService.faqRemove(f_no);
		rttr.addFlashAttribute("faqDel", result);
		return "redirect:/hn/manager/faq/faqList";
	}

}
