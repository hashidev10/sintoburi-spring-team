package com.kh.sintoburi.service.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hc.HcReplyDto;
import com.kh.sintoburi.mapper.hc.HcReplyMapper;

@Service
public class HcReplyServiceImpl implements HcReplyService {
	
	@Autowired
	private HcReplyMapper replyMapper;

	@Override
	public List<HcReplyDto> getReplyListByBlog_no(int blog_no) {
		List<HcReplyDto> list = replyMapper.getReplyListByBlog_no(blog_no);
		return list;
	}

	@Override
	public boolean insertReply(HcReplyDto replyDto) {
		int count = replyMapper.insertReply(replyDto);
		return (count >0)? true : false;
	}

	@Override
	public boolean modifyReply(HcReplyDto replyDto) {
		int count = replyMapper.modifyReply(replyDto);
		return (count >0)? true : false;
	}

	@Override
	public boolean deleteReply(int blog_rno) {
		int count = replyMapper.deleteByBlog_rno(blog_rno);
		return (count >0)? true : false;
	}
	
	
	

}
