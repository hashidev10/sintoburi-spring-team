package com.kh.sintoburi.controller.hc;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.sintoburi.domain.hn.MainNoticeDto;
import com.kh.sintoburi.domain.hn.NoticeVo;
import com.kh.sintoburi.service.hn.NoticeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private NoticeService noticeService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request) {
		NoticeVo noticeVo = noticeService.importantNoticeShow();
		System.out.println("noticeVo:" + noticeVo);
		if(noticeVo != null) {
			MainNoticeDto dto = new MainNoticeDto();
			dto.setTitle(noticeVo.getTitle());
			dto.setUrl("/hn/mypage/noticeRead?n_no=" + noticeVo.getN_no());
			request.getServletContext().setAttribute("noti", dto);
		}
		

//		context.setAttribute("noti", "테스트공지");
		return "redirect:/hc/main/home";
	}

}
