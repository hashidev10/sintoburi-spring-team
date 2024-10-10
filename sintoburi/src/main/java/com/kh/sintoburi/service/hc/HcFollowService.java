package com.kh.sintoburi.service.hc;

import com.kh.sintoburi.domain.hc.HcFollowDto;

public interface HcFollowService {
	
	public int getLikeFollow(String user_following);
	public boolean isCheckFollow(HcFollowDto followDto);
	public boolean addFollow(HcFollowDto followDto);
	public boolean removeFollow(HcFollowDto followDto);
	public int getCountFollower(String user_id);
	
	

}
