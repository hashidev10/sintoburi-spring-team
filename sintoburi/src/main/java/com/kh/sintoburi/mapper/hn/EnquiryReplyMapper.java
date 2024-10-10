package com.kh.sintoburi.mapper.hn;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.hn.EnquiryReplyVo;

public interface EnquiryReplyMapper {
	
	// 문의사항 답변 등록
	public int insertReply(EnquiryReplyVo replyVo);
	
	// 문의사항 답변 목록
	public List<EnquiryReplyVo> selectReply();
	
	// 답변 데이터 1개 
	public EnquiryReplyVo selectByReplyEno(@Param("eno")  int eno);
}
