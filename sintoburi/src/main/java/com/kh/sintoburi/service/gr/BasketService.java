package com.kh.sintoburi.service.gr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.gr.BasketCriteria;
import com.kh.sintoburi.domain.gr.BasketDetailDto;
import com.kh.sintoburi.domain.gr.BasketDetailVo;
import com.kh.sintoburi.domain.gr.BasketVo;

public interface BasketService {
		
	//장바구니 키 얻기
	public boolean getBasketKey(BasketVo basketVo);
	
	//장바구니에 넣기
	public boolean putBasket(BasketDetailVo detailVo);
	
	//장바구니 번호 확인
	public int getBnoByUserId(String user_id);
	
	//장바구니에서 상품 개수 수정 (0 -> 제거)
	public boolean modifyCount(int p_count, int bdno);
	
	//장바구니 상세에서 상품 제거 - 1개씩 제거
	public boolean removeOne(int bdno);
	
	//장바구니 비우기 - 장바구니 상세에 있는 상품들 모두 제거 -> 장바구니 제거
	public boolean removeAll(int bno);
	
	//게시글 개수
	public int getTotalCount(BasketCriteria criteria, String user_id);
	
	// 글 목록(페이징)
	public List<BasketDetailDto> getListWithPaging(BasketCriteria criteria);
		
	//가격합계
	public int getSumPrice(String user_id);
}
