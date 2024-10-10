package com.kh.sintoburi.service.hc;

import com.kh.sintoburi.domain.hc.HcLikeDto;

public interface HcLikeService {
	
	public int getLikeCount(int blog_no);
	public boolean isCheckLike(HcLikeDto likeDto);
	public boolean addLike(HcLikeDto likeDto);
	public boolean removeLike(HcLikeDto likeDto);

}
