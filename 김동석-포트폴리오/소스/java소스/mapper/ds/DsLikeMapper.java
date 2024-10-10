package com.kh.sintoburi.mapper.ds;

import java.util.Map;

import com.kh.sintoburi.domain.ds.DsLikeDto;

public interface DsLikeMapper {

	// 좋아요 하기
	public Integer insert(DsLikeDto vo);
	// 좋아요 해제
	public Integer delete(DsLikeDto vo);
	public Integer select(Map<String, Object> map);
	public Integer selectCount(Long bno);
	public Integer updateLikeCountByBno(Map<String, Object> map);
}
