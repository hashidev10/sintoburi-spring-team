package com.kh.sintoburi.controller.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.sintoburi.domain.hc.BlogSettingVo;
import com.kh.sintoburi.service.hc.BlogSettingService;

@RestController
@RequestMapping("/blogSetting/*")
public class BlogSettingController {
	
	@Autowired
	private BlogSettingService blogSettingService;
	
	
	@PostMapping("/insert")
	public boolean insert(@RequestBody List<BlogSettingVo> list) {
		
		return blogSettingService.insertSettingList(list);
	}
	

}
