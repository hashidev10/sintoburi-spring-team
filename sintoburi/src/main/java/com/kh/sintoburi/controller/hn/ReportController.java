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
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnPageDto;
import com.kh.sintoburi.domain.hn.ReportPostVo;
import com.kh.sintoburi.service.hn.ReportPostService;

import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/hn/manager/report")
@Log4j
public class ReportController {
	

	@Autowired
	private ReportPostService reportPostService;


	// 신고게시글목록
	@GetMapping("/reportList")
	public String reportList(Model model, HnCriteria criteria,HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");

		if (login == null || (!"관리자".equals(login.getGrade()) && !login.getGrade().equals("마스터")) ) {
			session.invalidate();
			return "redirect:/ds/board/login";
		}
		List<ReportPostVo> list = reportPostService.ReportList(criteria);
		model.addAttribute("reportList", list);
		
		int total = reportPostService.getTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
		return "/hn/manager/report/reportList";
	}

	// 신고게시글상세보기
	@GetMapping("/reportDetail/{re_no}")
	public String reportDetail(@PathVariable("re_no") int re_no, Model model) {

		ReportPostVo reportPostVo = reportPostService.selectByReNo(re_no);
		model.addAttribute("reportPostVo", reportPostVo);

		return "hn/manager/report/reportDetail";
	}
	
	// 신고게시글 처리완료
	@PostMapping("/updateStatus")
	public ResponseEntity<String> updateStatus(@RequestParam int re_no) {
		boolean result = reportPostService.updateStatus(re_no);

		if (result) {
			return ResponseEntity.ok("문의사항 상태가 '처리완료'로 업데이트되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의사항 상태 업데이트에 실패했습니다.");
		}
	}

}
