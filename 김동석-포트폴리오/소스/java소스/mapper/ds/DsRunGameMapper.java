package com.kh.sintoburi.mapper.ds;

import org.apache.ibatis.annotations.Update;

import com.kh.sintoburi.domain.ds.DsPointDto;


public interface DsRunGameMapper {
	


	
	
	@Update("update tbl_user"
			+ " set user_point=user_point+#{user_point}"
			+ " where user_id=#{user_id}")
	public Integer update(DsPointDto dto);
	
	
	
	
}
