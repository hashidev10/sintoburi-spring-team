package com.kh.sintoburi.service.hn;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.ReportPostVo;
import com.kh.sintoburi.mapper.hn.ReportPostMapper;

@Service
public class ReportPostServiceImpl implements ReportPostService{
	
	@Autowired
	private ReportPostMapper reportPostMapper;

	@Override
	public List<ReportPostVo> ReportList(HnCriteria criteria) {
//		List<ReportPostVo> list = reportPostMapper.selectReport();
		List<ReportPostVo> list = reportPostMapper.getReportPaging(criteria);
		return list;
	}

	@Override
	public ReportPostVo selectByReNo(int re_no) {
		ReportPostVo vo =  reportPostMapper.selectByReNo(re_no);
		return vo;
	}

	@Override
	public int getTotalCount(HnCriteria criteria) {
		int count = reportPostMapper.getTotalCount(criteria);
		return count;
	}

	// 처리완료
	@Override
	public boolean updateStatus(int re_no) {
		int count = reportPostMapper.updateStatus(re_no);
		return (count == 1)? true : false;
	}



}
