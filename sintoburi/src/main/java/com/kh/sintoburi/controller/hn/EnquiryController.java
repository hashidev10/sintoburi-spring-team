package com.kh.sintoburi.controller.hn;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.EnquiryReplyVo;
import com.kh.sintoburi.domain.hn.EnquiryVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnPageDto;
import com.kh.sintoburi.service.hn.EnquiryReplyService;
import com.kh.sintoburi.service.hn.EnquiryService;
import com.kh.sintoburi.service.hn.HnUserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hn/manager/enquiry")
@Log4j
public class EnquiryController {

	@Autowired
	private EnquiryService enquiryService;

	@Autowired
	private EnquiryReplyService replyService;

	@Autowired
	private HnUserService userService;

	// 상품문의사항목록
	@GetMapping("/goodsList")
	public String goodsEnqList(Model model, HnCriteria criteria,HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");

		if (login == null || (!"관리자".equals(login.getGrade()) && !login.getGrade().equals("마스터")) ) {
			session.invalidate();
			return "redirect:/ds/board/login";
		}

		
		
		List<EnquiryVo> list = enquiryService.goodsGetList(criteria);

		int total = enquiryService.goodsTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("goodsEnqList", list);
		model.addAttribute("criteria", criteria);
		// 답변 리스트
		List<EnquiryReplyVo> replyLisy = replyService.replyList();
		model.addAttribute("replyList", replyLisy);
		return "/hn/manager/enquiry/goodsList";
	}

	// 상품문의사항, 답변 상세보기
	@GetMapping("/goodsDetail/{eno}")
	public String enquiryDetail(@PathVariable("eno") int eno, Model model) {
		System.out.println("enquiryDetail...");
		EnquiryVo enquiryVo = enquiryService.selectByEno(eno);
		log.info("EnquiryVo: " + enquiryVo);
		model.addAttribute("enquiryVo", enquiryVo);

		EnquiryReplyVo replyVo = replyService.selectByReplyEno(eno);
		// 문의 이미지
//			enquiryService. -> 이미지 리스트(List<EnquiryVo>를 리턴하는 메서드
		model.addAttribute("replyVo", replyVo);
		return "hn/manager/enquiry/goodsDetail";
	}

	// 상품 문의사항 답변완료 변경
	@PostMapping("/updateStatus")
	public ResponseEntity<String> updateStatus(@RequestParam int eno) {
		boolean result = enquiryService.updateStatus(eno);

		if (result) {
			return ResponseEntity.ok("문의사항 상태가 '답변완료'로 업데이트되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의사항 상태 업데이트에 실패했습니다.");
		}
	}

	// 등급리스트

	// 등급문의사항목록
	@GetMapping("/gradeList")
	public String gradeEnqList(Model model, HnCriteria criteria,HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");

		if (login == null || (!"관리자".equals(login.getGrade()) && !login.getGrade().equals("마스터")) ) {
			session.invalidate();
			return "redirect:/ds/board/login";
		}
		
		List<EnquiryVo> list = enquiryService.gradeGetList(criteria);

		int total = enquiryService.gradeTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("gradeEnqList", list);
		model.addAttribute("criteria", criteria);

		// 답변리스트
		List<EnquiryReplyVo> replyLisy = replyService.replyList();
		model.addAttribute("gradeReplyList", replyLisy);
		return "/hn/manager/enquiry/gradeList";
	}

	// 등급문의사항, 답변 상세보기
	@GetMapping("/gradeDetail/{eno}")
	public String gradeEnqDetail(@PathVariable("eno") int eno, Model model) {
		// 등급 상세
		System.out.println("enquiryDetail...");
		EnquiryVo enquiryVo = enquiryService.selectByEno(eno);
		model.addAttribute("enquiryVo", enquiryVo);
		// 답변등록
		EnquiryReplyVo replyVo = replyService.selectByReplyEno(eno);
		model.addAttribute("replyVo", replyVo);
		return "hn/manager/enquiry/gradeDetail";
	}

	// 등급문의사항 답변완료 변경
	@PostMapping("/gradeupdateStatus")
	public ResponseEntity<String> gradeUpdateStatus(@RequestParam int eno, @RequestParam String status) {
		boolean result = enquiryService.gradeUpdateStatus(eno, status);

		if (result) {
			return ResponseEntity.ok("문의사항 상태가 '" + status + "'로 업데이트되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의사항 상태 업데이트에 실패했습니다.");
		}
	}

	// 등급 처리완료시 Business 1로 변경
	@PostMapping("/updateBusiness/{user_id}")
	public ResponseEntity<String> updateBusiness(@PathVariable("user_id") String user_id) {

		boolean result = userService.updateBusiness(user_id);
		if (result) {
			return ResponseEntity.ok("비즈니스 값이 1로 업데이트되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("비즈니스 값 업데이트에 실패했습니다.");
		}
	}

	// 미답변 알림 보여주기
	@GetMapping("/noReplyShow")
	public String noReplyShow(Model model) {
		List<EnquiryVo> list = enquiryService.noReplyShow();
		model.addAttribute("alarmList",list);
		return "hn/manager/include/header";
	}
}
