package com.kh.sintoburi.mapper.ds;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.common.LoginDto;
import com.kh.sintoburi.domain.common.UserVo;


public interface DsUserMapper {
	
	@Select("select user_point from tbl_user where user_id=#{user_id}")
	public Integer select(String user_id);
	
	@Insert("insert into tbl_user(user_id,user_pw,user_name,address,user_phone,user_email)"
			+ " values(#{user_id},#{user_pw},#{user_name},"
			+ " #{address},#{user_phone},#{user_email})")
	public Integer insert(UserVo vo);
	
	@Select("select count(*) from tbl_user where user_id=#{user_id}")
	public Integer selectByUserId(String user_id);
	
	@Select("select * from tbl_user where user_id=#{user_id} and user_pw=#{user_pw}")
	public UserVo selectLoginUser(LoginDto dto);

	
	

}
