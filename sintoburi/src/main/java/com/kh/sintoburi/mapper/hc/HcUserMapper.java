package com.kh.sintoburi.mapper.hc;


import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hc.HcLoginDto;


public interface HcUserMapper {

	public UserVo login(HcLoginDto dto);
	public UserVo searchByUserId(String user_id);
	
	
	
}
