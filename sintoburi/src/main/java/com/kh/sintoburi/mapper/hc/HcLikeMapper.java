package com.kh.sintoburi.mapper.hc;

import com.kh.sintoburi.domain.hc.HcLikeDto;

public interface HcLikeMapper {
	
	public int getLikeCount (int blog_no);
	public int addLike(HcLikeDto likeDto);
	public int removeLike(HcLikeDto likeDto);
	public HcLikeDto isCheckLike(HcLikeDto likeDto);
}
