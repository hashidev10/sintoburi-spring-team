package com.kh.sintoburi.controller.ji;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.ji.JiLoginDto;
import com.kh.sintoburi.service.ji.JiuserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ji/user/*")
@Log4j
public class JiUserController {

	@Autowired
	private JiuserService userService;
	
	@GetMapping("/login")
	public String login() {
		System.out.println("login...");
		return "/ds/board/login";
	}
	
	@PostMapping("/loginPost")
	@ResponseBody
	public void loginPost(@RequestBody JiLoginDto dto, HttpSession session) {
		UserVo vo = userService.login(dto);
		session.setAttribute("login", vo);
		
	}
	
//	@GetMapping("/logout")
//	public String logout(HttpSession session) {
//		session.invalidate();
//		return "redirect:/product/productMain";
//	}
}
