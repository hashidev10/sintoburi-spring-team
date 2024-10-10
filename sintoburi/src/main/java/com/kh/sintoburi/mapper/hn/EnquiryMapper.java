package com.kh.sintoburi.mapper.hn;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.hn.EnquiryImageVo;
import com.kh.sintoburi.domain.hn.EnquiryVo;
import com.kh.sintoburi.domain.hn.HnCriteria;

public interface EnquiryMapper {

	// 로그인 문의사항 목록
	public List<EnquiryVo> getList(@Param("user_id") String user_id);

	// 상품문의사항목록
	public List<EnquiryVo> goodsGetList();

	// 등급문의사항
	public List<EnquiryVo> gradeGetList();

	// 전체문의사항페이징
	public List<EnquiryVo> getWithPaging(HnCriteria criteria);

	// 전체 게시글 갯수
	public int getTotalCount(HnCriteria criteria);

	// 상품목록페이징
	public List<EnquiryVo> getGoodsWithPaging(HnCriteria criteria);

	// 상품 게시글 갯수
	public int goodsTotalCount(HnCriteria criteria);

	// 등급목록페이징
	public List<EnquiryVo> getGradeWithPaging(HnCriteria criteria);

	// 등급 게시글 갯수
	public int gradeTotalCount(HnCriteria criteria);

	// 문의사항등록
	public int insert(EnquiryVo vo);

	// 문의사항수정
	public int update(EnquiryVo vo);

	// 문의사항삭제
	public int delete(@Param("eno") int eno);

	// 문의사항한개데이터
	public EnquiryVo selectByEno(@Param("eno") int eno);

	// 상품 문의사항 답변완료변경
	public int updateStatus(@Param("eno") int eno);

	// 등급 문의사항 처리완료
	public int gradeUpdateStatus(@Param("eno") int eno, @Param("status") String status);

	// 첨부파일 등록
	public int imageInsert(EnquiryImageVo imageVo);

	// 해당 글 첨부파일 가져오기
	public List<EnquiryImageVo> getImage(@Param("eno") int eno);

	// 삭제
	public int imageDelete(@Param("eno") int eno);
	
	//선택 이미지 삭제
	public int choiceImageDelete(@Param("uuid") String uuid);
	
	// 미답변 알람
	public List<EnquiryVo> noReplyShow();
}
