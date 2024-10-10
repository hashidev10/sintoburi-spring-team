package com.kh.sintoburi.service.ji;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.ji.JiLoginDto;

public interface JiuserService {

	public UserVo login(JiLoginDto dto);
}
