package com.kh.sintoburi.service.ds;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.common.LoginDto;
import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.mapper.ds.DsUserMapper;

@Service
public class DsUserServiceImpl implements DsUserService {

	@Autowired
	private DsUserMapper userMapper;

	@Override
	public Integer getUserPoint(String user_id) {
		
		return userMapper.select(user_id);
	}

	@Override
	public boolean registerUser(UserVo vo) {
		
		return userMapper.insert(vo)>0?true:false;
	}

	@Override
	public Integer checkUserId(String user_id) {
	
		return userMapper.selectByUserId(user_id);
	}

	@Override
	public UserVo login(LoginDto dto) {

		
		return userMapper.selectLoginUser(dto);
	}


	
	
	
	
}
