package com.kh.sintoburi.service.ds;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.kh.sintoburi.domain.common.ReportVo;

import com.kh.sintoburi.mapper.ds.DsReportMapper;

@Service
public class DsReportServiceImpl implements DsReportService {

	@Autowired
	private DsReportMapper reportMapper;

	@Override
	public boolean addReport(ReportVo vo) {
		
		return reportMapper.insert(vo)>0?true:false;
	}

	
	
	
	
}
