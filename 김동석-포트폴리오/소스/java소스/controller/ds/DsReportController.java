package com.kh.sintoburi.controller.ds;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.kh.sintoburi.domain.common.ReportVo;

import com.kh.sintoburi.service.ds.DsReportService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/ds/report/*")
public class DsReportController {
	
	@Autowired
	private DsReportService reportService;
	
	@PostMapping("/addReport")
	@ResponseBody
	public boolean addReport(@RequestBody ReportVo vo) {
		
	
		return reportService.addReport(vo);
		
	
	}
	
	

}
