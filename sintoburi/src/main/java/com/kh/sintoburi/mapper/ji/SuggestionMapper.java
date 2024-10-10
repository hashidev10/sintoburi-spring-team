package com.kh.sintoburi.mapper.ji;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.ji.SuggestionVo;

public interface SuggestionMapper {
	
	public int insert(SuggestionVo vo);
	
	public int insertAnswer(SuggestionVo vo);
	
	public int updateParentNo(@Param("suggestion_no") int suggestion_no);
	
	public SuggestionVo read(@Param("suggestion_no") int suggestion_no);
	
	public int delete(@Param("suggestion_no") int suggestion_no);
	
	public int update(SuggestionVo suggestionVo);
	
	public List<SuggestionVo> getList(@Param("product_no") int product_no);
}
