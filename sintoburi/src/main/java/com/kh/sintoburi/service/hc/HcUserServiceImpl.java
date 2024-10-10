package com.kh.sintoburi.service.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hc.HcLoginDto;
import com.kh.sintoburi.mapper.hc.HcUserMapper;

@Service
public class HcUserServiceImpl implements HcUserService {
	
	@Autowired
	private HcUserMapper userMapper;

	@Override
	public UserVo login(HcLoginDto dto) {
		UserVo userVo = userMapper.login(dto);
		return userVo;
	}

	@Override
	public UserVo searchByUserId(String user_id) {
		UserVo userVo = userMapper.searchByUserId(user_id);
		return userVo;
	}
	
	
	
	
}
