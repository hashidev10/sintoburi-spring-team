package com.kh.sintoburi.mapper.gr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.gr.BasketCriteria;
import com.kh.sintoburi.domain.gr.BasketDetailDto;
import com.kh.sintoburi.domain.gr.BasketDetailVo;
import com.kh.sintoburi.domain.gr.BasketVo;

public interface BasketMapper {
	//장바구니 키 얻기
	public int insertSelectKey(BasketVo basketVo);
	
	//장바구니에 넣기
	public int insertDetail(BasketDetailVo detailVo);
	
	//장바구니 번호 확인(0이면 장바구니 없는 것)
	public int getBnoByUser(@Param("user_id") String user_id);
	
	//장바구니에서 상품 개수 수정 (0 -> 제거)
	public int update(@Param("p_count")int p_count, @Param("bdno") int bdno);
	
	//장바구니 상세에서 상품 제거 - 1개씩 제거
	public int delete(@Param("bdno") int bdno);
	
	//장바구니 비우기 - 장바구니 상세에 있는 상품들 모두 제거 -> 장바구니 제거
	public int deleteAll(@Param("bno") int bno);
			
	//장바구니 지우기
	public int deleteBasket(@Param("bno") int bno);
	
	//게시글 개수
	public int getTotalCount(BasketCriteria criteria, @Param("user_id") String user_id);
	
	// 글목록 -  페이징 적용 
	public List<BasketDetailDto> getListWithPaging(BasketCriteria ci);
	
	//가격 합계
	public int getSumPrice(@Param("user_id") String user_id);
	
	//bdno 삭제해도 bdno에서 얻을 수 있는 정보를 주문상세에 넘겨주기 
	public BasketDetailDto selectByBdno(@Param("bdno") int bdno);
	
}
