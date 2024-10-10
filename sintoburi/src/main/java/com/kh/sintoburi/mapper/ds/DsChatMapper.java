package com.kh.sintoburi.mapper.ds;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.ds.DsChatVo;

public interface DsChatMapper {
	
	

	public Integer insert(DsChatVo vo);
	
	@Select("select * from tbl_chat order by cno")
	public List<DsChatVo> selectList();
	
	@Delete("delete from tbl_chat")
	public Integer delete();
	
	
	
}
