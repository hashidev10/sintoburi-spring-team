package com.kh.sintoburi.mapper.hc;

import com.kh.sintoburi.domain.hc.HcFollowDto;

public interface HcFollowMapper {
	
	public int getFollowCount (String user_following);
	public int addFollow(HcFollowDto followDto);
	public int removeFollow(HcFollowDto followDto);
	public HcFollowDto isCheckFollow(HcFollowDto followDto);
	
	
}
