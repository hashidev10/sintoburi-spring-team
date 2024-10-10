package com.kh.sintoburi.service.ds;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.ds.DsReplyVo;
import com.kh.sintoburi.mapper.ds.DsReplyMapper;

@Service
public class DsReplyServiceImpl implements DsReplyService {

	@Autowired
	private DsReplyMapper replyMapper;

	@Override
	public boolean commitComment(DsReplyVo vo) {
		
		return replyMapper.insert(vo)>0?true:false;
	}

	@Override
	public List<DsReplyVo> getReply(Long bno) {
		
		return replyMapper.selectByBno(bno);
	}

	@Override
	public boolean delReply(Long rno) {
		
		return replyMapper.delete(rno)>0?true:false;
	}

	@Override
	public boolean modReply(DsReplyVo vo) {
	
		return replyMapper.update(vo)>0?true:false;
	}
	
	
	
}
