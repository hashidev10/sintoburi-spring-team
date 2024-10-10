package com.kh.sintoburi.service.ds;

import java.util.List;

import com.kh.sintoburi.domain.ds.DsPointDto;
import com.kh.sintoburi.domain.ds.DsQuizVo;


public interface DsGameService {
	// 퀴즈 게임 기록 등록
	public boolean recoardQuiz(DsQuizVo vo);
	
	// 퀴즈 게임 점수 구하기
	public List<DsQuizVo> getScore();
	
	// 퀴즈 게임 포인트 등록
	public boolean getPointQuiz(DsQuizVo vo);
	
	// 달리기 게임 결과
	public boolean resultRunGame(DsPointDto dto);

}
