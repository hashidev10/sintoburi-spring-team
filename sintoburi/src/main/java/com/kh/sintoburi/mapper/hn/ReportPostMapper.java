package com.kh.sintoburi.mapper.hn;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.ReportPostVo;

public interface ReportPostMapper {
	
	// 신고한 게시글 목록
	public List<ReportPostVo> selectReport ();
	
	// 페이징처리
	public List<ReportPostVo> getReportPaging(HnCriteria criteria);
	
	// 게시글 갯수
	public int getTotalCount(HnCriteria criteria);
	
	// 신고한 게시글 1개
	public ReportPostVo selectByReNo(@Param("re_no") int re_no);
	
	// 처리완료
	public int updateStatus(@Param("re_no") int re_no);
}
