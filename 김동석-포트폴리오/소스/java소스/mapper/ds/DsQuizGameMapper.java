package com.kh.sintoburi.mapper.ds;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.ds.DsQuizVo;

public interface DsQuizGameMapper {
	
	// 기록등록
	public Integer insert(DsQuizVo vo);
	
	// 유저 포인트 갱신
	public Integer update(DsQuizVo vo);
	
	// 유저 랭킹 구하기(내림차순)
	@Select("select distinct * from tbl_quiz order by score desc")
	public List<DsQuizVo> selectRanking();
	
}
