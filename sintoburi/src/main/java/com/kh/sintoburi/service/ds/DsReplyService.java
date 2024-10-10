package com.kh.sintoburi.service.ds;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.ds.DsReplyVo;


public interface DsReplyService {
	public boolean commitComment(DsReplyVo vo);
	
	public List<DsReplyVo> getReply(@Param("bno") Long bno);
	
	public boolean delReply(Long rno);
	public boolean modReply(DsReplyVo vo);

}
