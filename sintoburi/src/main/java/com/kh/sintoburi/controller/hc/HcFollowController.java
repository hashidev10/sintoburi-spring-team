package com.kh.sintoburi.controller.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.sintoburi.domain.hc.HcFollowDto;
import com.kh.sintoburi.service.hc.HcFollowService;

@RestController
@RequestMapping("/hc/follow/*")
public class HcFollowController {
	
	@Autowired
	private HcFollowService followService;
	
	@PostMapping("/addFollow")
	public boolean addFollow (@RequestBody HcFollowDto followDto) {
		return followService.addFollow(followDto);
	}
	
	@PostMapping("/removeFollow")
	public boolean removeFollow (@RequestBody HcFollowDto followDto) {
		return followService.removeFollow(followDto);
	}
	
	@GetMapping("/getSumFollow")
	public int getSumFollow (String follow_id) {
		int sumFollow = followService.getCountFollower(follow_id);
		return sumFollow;
	}
}
