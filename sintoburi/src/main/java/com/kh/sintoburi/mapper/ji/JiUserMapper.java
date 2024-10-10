package com.kh.sintoburi.mapper.ji;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.ji.JiLoginDto;

public interface JiUserMapper {

	public UserVo login(JiLoginDto dto);
}
