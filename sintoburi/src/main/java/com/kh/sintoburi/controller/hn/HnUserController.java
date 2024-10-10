package com.kh.sintoburi.controller.hn;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnPageDto;
import com.kh.sintoburi.domain.hn.HnUserDto;
import com.kh.sintoburi.service.hn.HnUserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hn/manager/user/")
@Log4j
public class HnUserController {

	@Autowired
	private HnUserService userService;

	// 회원목록
	@GetMapping("/userList")
	public String userList(Model model, HnCriteria criteria, HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");
		System.out.println("관리자 로그인 계급은??" + login.getGrade());
		if (login == null || (!"관리자".equals(login.getGrade().trim()) && !login.getGrade().equals("마스터")) ) {
			System.out.println("나가라");
			session.invalidate();
			return "redirect:/ds/board/login";
		}

		List<HnUserDto> list = userService.getList(criteria);
		model.addAttribute("userList", list);

		int total = userService.getTotal(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);

		return "/hn/manager/user/userList";
	}

	// 매니저목록
	@GetMapping("/managerList")
	public String managerList(Model model, HnCriteria criteria, HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");

		if (login == null || !"마스터".equals(login.getGrade().trim())) {
			session.invalidate();
			return "redirect:/ds/board/login";
		}

		List<HnUserDto> managerList = userService.managerList(criteria);
		int total = userService.managerTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("managerList", managerList);
		model.addAttribute("criteria", criteria);
		return "/hn/manager/user/managerList";
	}

	// 회원 상세보기
	@PostMapping("/userDetail/{user_id}")
	@ResponseBody
	public UserVo userDetail(@PathVariable("user_id") String user_id, Model model) {
		UserVo userVo = userService.selectById(user_id);
		return userVo;
	}

	// 사업자번호업데이트
	@PostMapping("/modBusinessNum")
	@ResponseBody
	public boolean modBusinessNum(@RequestBody UserVo userVo) {
		String user_id = userVo.getUser_id();
		String business_num = userVo.getBusiness_num();
		boolean result = userService.modifyBusinessNum(user_id, business_num);
		return result;
	}

	// 등급수정
	@PostMapping("/modGrade")
	@ResponseBody
	public boolean modGrade(@RequestBody HnUserDto dto) {
		System.out.println("modGrade...dto:" + dto);
		String user_id = dto.getUser_id();
		String grade = dto.getGrade();

		boolean result = userService.modifyGrade(user_id, grade);
		System.out.println("modGrade...result:" + result);
		return result;
	}

	// 등급 변경해야하는 회원 리스트
	@GetMapping("/gradeChangeList")
	public String gradeUpdateShow(Model model) {
		List<HnUserDto> list = userService.gradeChangeList();
		model.addAttribute("gradeChangeList", list);
		return "hn/manager/include/header";
	}

//		로그인한 유저 문의사항
//		@GetMapping("/enqList")
//		public void list(Model model) {
//			List<EnquiryVo> enquiryList = enquiryService.getList();
//			model.addAttribute("enquiryList", enquiryList);
//			// 답변 리스트
//			List<ReplyVo> replyLisy = replyService.replyList();
//			model.addAttribute("replyList", replyLisy);
	//
//		}

}
