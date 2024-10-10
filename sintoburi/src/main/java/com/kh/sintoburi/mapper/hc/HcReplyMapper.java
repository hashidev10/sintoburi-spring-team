package com.kh.sintoburi.mapper.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.HcReplyDto;


public interface HcReplyMapper {

	public List<HcReplyDto> getReplyListByBlog_no(int blog_no);
	public int insertReply(HcReplyDto replyDto);
	public int modifyReply(HcReplyDto replyDto);
	public int deleteByBlog_rno(int blog_rno);
	
}
