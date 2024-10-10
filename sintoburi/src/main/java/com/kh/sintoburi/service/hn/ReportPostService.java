package com.kh.sintoburi.service.hn;

import java.util.List;

import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.ReportPostVo;

public interface ReportPostService {

	// 신고한 게시글 목록
	public List<ReportPostVo> ReportList(HnCriteria criteria);

	// 신고한 게시글 1개
	public ReportPostVo selectByReNo(int re_no);

	// 게시글 갯수
	public int getTotalCount(HnCriteria criteria);

	// 처리완료
	public boolean updateStatus(int re_no);

}
