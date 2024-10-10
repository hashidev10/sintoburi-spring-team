package com.kh.sintoburi.service.hn;

import java.util.List;

import com.kh.sintoburi.domain.hn.FaqVo;
import com.kh.sintoburi.domain.hn.HnCriteria;

public interface FaqService {

	// 자주하는 질문 목록
	public List<FaqVo> faqList(HnCriteria criteria);
	//  게시글 갯수
	public int getTotalCount(HnCriteria criteria);

	// 등록
	public boolean faqRegister(FaqVo faqVo);

	// 수정
	public boolean faqModify(FaqVo faqVo);

	// 삭제
	public boolean faqRemove(int f_no);

	// 데이터 1개
	public FaqVo selectByFno(int f_no);
}
