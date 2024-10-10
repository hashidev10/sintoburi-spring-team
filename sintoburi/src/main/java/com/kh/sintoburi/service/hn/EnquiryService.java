package com.kh.sintoburi.service.hn;

import java.util.List;

import com.kh.sintoburi.domain.hn.EnquiryVo;
import com.kh.sintoburi.domain.hn.HnCriteria;

public interface EnquiryService {

	// 로그인한사용자목록
	public List<EnquiryVo> getList(HnCriteria criteria);

	// 상품문의사항목록
	public List<EnquiryVo> goodsGetList(HnCriteria criteria);

	// 등급문의사항
	public List<EnquiryVo> gradeGetList(HnCriteria criteria);

	// 전체 게시글 갯수
	public int getTotalCount(HnCriteria criteria);

	// 상품 게시글 갯수
	public int goodsTotalCount(HnCriteria criteria);

	// 등급 게시글 갯수
	public int gradeTotalCount(HnCriteria criteria);

	// 문의사항등록
	public int register(EnquiryVo vo);

	// 문의사항수정
	public int modify(EnquiryVo vo);

	// 문의사항삭제
	public boolean remove(int eno);

	// 문의사항데이터1개
	public EnquiryVo selectByEno(int eno);

	// 문의사항 답변완료변경
	public boolean updateStatus(int eno);

	// 등급 문의사항 처리완료
	public boolean gradeUpdateStatus(int eno, String status);

	// 미답변 알람
	public List<EnquiryVo> noReplyShow();

	// 선택 이미지 삭제
	public boolean choiceImageDelete(String uuid);
	
}
