package com.kh.sintoburi.mapper.ds;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.ds.DsReplyVo;

public interface DsReplyMapper {
	
	
	@Select("select *from tbl_reply where bno=#{bno} order by rno desc")
	public List<DsReplyVo> selectByBno(Long bno);
	public Integer insert(DsReplyVo vo);
	public Integer delete(Long rno);
	public Integer update(DsReplyVo vo);
	
	
	
}
