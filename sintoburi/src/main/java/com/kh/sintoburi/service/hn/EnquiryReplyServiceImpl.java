package com.kh.sintoburi.service.hn;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hn.EnquiryReplyVo;
import com.kh.sintoburi.mapper.hn.EnquiryReplyMapper;

@Service
public class EnquiryReplyServiceImpl implements EnquiryReplyService {

	@Autowired
	private EnquiryReplyMapper replyMapper;
	
	// 답변 등록
	@Override
	public boolean insertReply(EnquiryReplyVo replyVo) {
		int count = replyMapper.insertReply(replyVo);
		return (count == 1 )? true : false;
	}

	@Override
	public List<EnquiryReplyVo> replyList() {
		List<EnquiryReplyVo> list = replyMapper.selectReply();
		return list;
	}

	@Override
	public EnquiryReplyVo selectByReplyEno(int eno) {
		EnquiryReplyVo vo = replyMapper.selectByReplyEno(eno);
		return vo;
	}

	
	
	
}
