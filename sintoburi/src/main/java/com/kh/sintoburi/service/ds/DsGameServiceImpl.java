package com.kh.sintoburi.service.ds;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.ds.DsPointDto;
import com.kh.sintoburi.domain.ds.DsQuizVo;
import com.kh.sintoburi.mapper.ds.DsQuizGameMapper;
import com.kh.sintoburi.mapper.ds.DsRunGameMapper;

@Service
public class DsGameServiceImpl implements DsGameService {

	@Autowired
	public DsQuizGameMapper quizGameMapper;
	
	@Autowired
	public DsRunGameMapper runGameMapper;

	@Override
	public boolean recoardQuiz(DsQuizVo vo) {
		
		return quizGameMapper.insert(vo)>0?true:false;
	}

	@Override
	public List<DsQuizVo> getScore() {
		// TODO Auto-generated method stub
		return quizGameMapper.selectRanking();
	}

	@Override
	public boolean resultRunGame(DsPointDto dto) {

		return runGameMapper.update(dto)>0?true:false;
	}

	@Override
	public boolean getPointQuiz(DsQuizVo vo) {
		
		return quizGameMapper.update(vo)>0?true:false;
	}
	
	
	
}
