package com.kh.sintoburi.service.ji;

import java.util.List;

import com.kh.sintoburi.domain.ji.SuggestionVo;

public interface SuggestionService {

	public boolean register(SuggestionVo vo);
	
	public boolean registerAnswer(SuggestionVo vo);
	
	public SuggestionVo get(int suggestion_no);
	
	public boolean remove(int suggestion_no, int product_no);
	
	public boolean modify(SuggestionVo suggestionVo);
	
	public List<SuggestionVo> getList(int product_no);
}
