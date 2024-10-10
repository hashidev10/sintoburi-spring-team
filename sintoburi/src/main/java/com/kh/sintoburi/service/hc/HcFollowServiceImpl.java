package com.kh.sintoburi.service.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hc.HcFollowDto;
import com.kh.sintoburi.mapper.hc.HcFollowMapper;

@Service
public class HcFollowServiceImpl implements HcFollowService {
	
	@Autowired
	private HcFollowMapper followMapper;
	

	@Override
	public int getLikeFollow(String user_following) {
		int sumFollow = followMapper.getFollowCount(user_following);
		return sumFollow;
	}
	

	@Override
	public boolean isCheckFollow(HcFollowDto followDto) {
		HcFollowDto follow = followMapper.isCheckFollow(followDto);
		if(follow != null) {
			return true;
		}
		return false;
	}

	@Override
	public boolean addFollow(HcFollowDto followDto) {
		int count = followMapper.addFollow(followDto);
		return (count > 0)? true : false;
	}

	@Override
	public boolean removeFollow(HcFollowDto followDto) {
		int count = followMapper.removeFollow(followDto);
		return (count > 0)? true : false;
	}


	@Override
	public int getCountFollower(String user_id) {
		return followMapper.getFollowCount(user_id);
	}
	
}
