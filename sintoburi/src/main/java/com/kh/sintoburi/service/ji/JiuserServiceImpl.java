package com.kh.sintoburi.service.ji;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.ji.JiLoginDto;
import com.kh.sintoburi.mapper.ji.JiUserMapper;

@Service
public class JiuserServiceImpl implements JiuserService {

	@Autowired
	private JiUserMapper userMapper;
	
	@Override
	public UserVo login(JiLoginDto dto){
		UserVo uservo = userMapper.login(dto);
		return uservo;
	}


	
}
