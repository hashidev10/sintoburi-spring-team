package com.kh.sintoburi.service.hn;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hn.FaqVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.mapper.hn.FaqMapper;

@Service
public class FaqServiceImpl implements FaqService{
	@Autowired
	private FaqMapper faqMapper;

	// 자주하는질문 목록
	@Override
	public List<FaqVo> faqList(HnCriteria criteria) {
//		List<FaqVo> list = faqMapper.selectFaq();
		List<FaqVo> list = faqMapper.getFaqPaging(criteria);
		return list;
	}
	// 자주하는질문 등록
	@Override
	public boolean faqRegister(FaqVo faqVo) {
		int count = faqMapper.insertFaq(faqVo);
		return (count == 1)? true : false;
	}
	// 자주하는질문 수정
	@Override
	public boolean faqModify(FaqVo faqVo) {
		int count = faqMapper.updateFaq(faqVo);
		return (count == 1)? true : false;
	}
	// 자주하는질문 삭제
	@Override
	public boolean faqRemove(int f_no) {
		int count =  faqMapper.deleteFaq(f_no);
		return (count == 1)? true : false;
	}
	// 자주하는질문 데이터 1개
	@Override
	public FaqVo selectByFno(int f_no) {
		FaqVo faqVo = faqMapper.selectByFno(f_no);
		return faqVo;
	}
	// 게시글 갯수
	@Override
	public int getTotalCount(HnCriteria criteria) {
		int count = faqMapper.getTotalCount(criteria);
		return count;
	}

}
