package com.kh.sintoburi.service.ds;

import com.kh.sintoburi.domain.ds.DsLikeDto;


public interface DsLikeService {

	// 좋아요하기
	public boolean doLike(DsLikeDto dto);
	// 좋아요취소
	public boolean undoLike(DsLikeDto dto);
	// 좋아요 했는지 체크
	public boolean checkLike(String user_id,Long bno);
	// 좋아요 갯수
	public Integer getLikeCount(Long bno);
	// 좋아요 수 게시글 업데이트
	public boolean updateLikeCount(Long bno, Integer like_count);
	
	
}
