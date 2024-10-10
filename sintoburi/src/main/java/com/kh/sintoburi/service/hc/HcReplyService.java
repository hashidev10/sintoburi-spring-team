package com.kh.sintoburi.service.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.HcReplyDto;

public interface HcReplyService {

	public List<HcReplyDto> getReplyListByBlog_no(int blog_no);
	public boolean insertReply(HcReplyDto replyDto);
	public boolean modifyReply(HcReplyDto replyDto);
	public boolean deleteReply(int blog_rno);
}
