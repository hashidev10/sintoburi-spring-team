package com.kh.sintoburi.service.hn;

import java.util.List;

import com.kh.sintoburi.domain.hn.EnquiryReplyVo;

public interface EnquiryReplyService {

	// 문의사항 답변 등록
	public boolean insertReply(EnquiryReplyVo replyVo);

	// 문의사항 답변 목록
	public List<EnquiryReplyVo> replyList();

	// 답변 데이터 1개
	public EnquiryReplyVo selectByReplyEno(int eno);
}
