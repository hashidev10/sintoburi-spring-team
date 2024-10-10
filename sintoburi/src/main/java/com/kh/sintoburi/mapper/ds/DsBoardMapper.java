package com.kh.sintoburi.mapper.ds;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.ds.DsBoardVo;
import com.kh.sintoburi.domain.ds.DsCriteria;

public interface DsBoardMapper {
	
	// 글 상세보기
	@Select("select * from tbl_board where bno=#{bno}")
	public DsBoardVo selectByBno(Long bno);
	// 총갯수
	public int getTotalCount(DsCriteria criteria);
	// 리스트 가져오기
	public List<DsBoardVo> selectList();
	// 페이징 처리
	public List<DsBoardVo> selectListWithPaging(DsCriteria ci);
	// 인기글 처리
	public List<DsBoardVo> selectListMostLike(DsCriteria ci);
	// 게시글 쓰기
	public Integer insert(DsBoardVo vo);
	// 게시글 삭제
	public Integer delete(Long bno);
	// 게시글 수정
	public Integer update(DsBoardVo vo);
	// 조회수 증가
	public Integer updataViewCount(Long bno);

}
