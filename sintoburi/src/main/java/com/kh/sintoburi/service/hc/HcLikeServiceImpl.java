package com.kh.sintoburi.service.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hc.HcLikeDto;
import com.kh.sintoburi.mapper.hc.HcLikeMapper;

@Service
public class HcLikeServiceImpl implements HcLikeService {
	
	@Autowired
	private HcLikeMapper likeMapper;
	

	@Override
	public int getLikeCount(int blog_no) {
		int sumLike = likeMapper.getLikeCount(blog_no);
		return sumLike;
	}

	@Override
	public boolean isCheckLike(HcLikeDto likeDto) {
		HcLikeDto like = likeMapper.isCheckLike(likeDto);
		if(like != null) {
			return true;
		}
		return false;
	}

	@Override
	public boolean addLike(HcLikeDto likeDto) {
		int count = likeMapper.addLike(likeDto);
		return (count > 0)? true : false;
	}

	@Override
	public boolean removeLike(HcLikeDto likeDto) {
		int count = likeMapper.removeLike(likeDto);
		return (count > 0)? true : false;
	}
	
}
