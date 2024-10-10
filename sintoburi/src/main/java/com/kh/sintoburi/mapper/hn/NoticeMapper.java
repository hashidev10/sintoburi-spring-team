package com.kh.sintoburi.mapper.hn;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.NoticeImageVo;
import com.kh.sintoburi.domain.hn.NoticeVo;

public interface NoticeMapper {

	// 공지사항 목록
	public List<NoticeVo> selectNotice();

	// 관리자 공지사항 목록
	public List<NoticeVo> selectManagerNotice();

	// 관리자 공지사항 보여주기
	public NoticeVo managerNoticeShow();
	
	// 중요 공지사항 보여주기
	public NoticeVo importantNoticeShow();

	// 중요 공지사항 일반 공지사항으로 바꾸기
	public int changeN();
	
	// 관리자 공지사항 일반 공지사항으로 바꾸기
	public int changeManagerN();
	
	// 공지사항 페이징
	public List<NoticeVo> getNoticePaging(HnCriteria criteria);

	// 공지사항 게시글 갯수
	public int getTotalCount(HnCriteria criteria);

	// 공지사항 한개데이터
	public NoticeVo selectByNno(@Param("n_no") int n_no);

	// 공지사항 등록
	public int insertNotice(NoticeVo noticeVo);

	// 공지사항 수정
	public int updateNotice(NoticeVo noticeVo);

	// 공지사항 삭제
	public int deleteNotice(@Param("n_no") int n_no);

	// 이전게시글
	public NoticeVo getPreviousNotice(@Param("n_no") int n_no);

	// 다음 게시글
	public NoticeVo getNextNotice(@Param("n_no") int n_no);

	// 공지사항 항목 업데이트
	public int updateImportant(@Param("n_no") int n_no, @Param("important") String important);

	// 첨부파일 등록
	public int imageInsert(NoticeImageVo noticeImageVo);

	// 해당 글 첨부파일 가져오기
	public List<NoticeImageVo> getImage(@Param("n_no") int n_no);

	// 첨부파일삭제
	public int imageDelete(@Param("n_no") int n_no);

	// 선택한 이미지 삭제
	public int choiceImageDelete(@Param("uuid") String uuid);
}
