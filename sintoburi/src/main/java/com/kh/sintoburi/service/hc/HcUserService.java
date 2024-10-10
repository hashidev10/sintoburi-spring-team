package com.kh.sintoburi.service.hc;


import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hc.HcLoginDto;

public interface HcUserService {
	
	public UserVo login(HcLoginDto dto);
	public UserVo searchByUserId (String user_id);

}
