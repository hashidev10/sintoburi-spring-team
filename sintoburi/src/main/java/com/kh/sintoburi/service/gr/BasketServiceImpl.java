package com.kh.sintoburi.service.gr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.gr.BasketCriteria;
import com.kh.sintoburi.domain.gr.BasketDetailDto;
import com.kh.sintoburi.domain.gr.BasketDetailVo;
import com.kh.sintoburi.domain.gr.BasketVo;
import com.kh.sintoburi.mapper.gr.BasketMapper;

@Service
public class BasketServiceImpl implements BasketService{
	
	@Autowired
	private BasketMapper basketMapper;
	
//장바구니 키 얻기
	@Override
	public boolean getBasketKey(BasketVo basketVo) {
		int count = basketMapper.insertSelectKey(basketVo);
		return (count == 1) ? true : false;
	}

	//장바구니에 넣기
	@Override
	public boolean putBasket(BasketDetailVo detailVo) {
		int count = basketMapper.insertDetail(detailVo);
		return (count == 1) ? true : false;
	}

	//장바구니 번호 확인
	@Override
	public int getBnoByUserId(String user_id) {
		int bno = basketMapper.getBnoByUser(user_id);
		return bno;
	}

	//장바구니에서 상품 개수 수정 (0 -> 제거)
	@Override
	public boolean modifyCount(int p_count, int bdno) {
		int count = basketMapper.update(p_count, bdno);
		return (count == 1) ? true : false;
	}

	//장바구니 상세에서 상품 제거 - 1개씩 제거
	@Override
	public boolean removeOne(int bdno) {
		int count = basketMapper.delete(bdno);
		return (count == 1) ? true : false;
	}

	//장바구니 비우기 - 장바구니 상세에 있는 상품들 모두 제거 -> 장바구니 제거
	@Override
	public boolean removeAll(int bno) {
		int count = basketMapper.deleteAll(bno); // 장바구니 내용물 모두 삭제
		count += basketMapper.deleteBasket(bno); // 장바구니 삭제
		return (count == 2) ? true : false;
	}

	//게시글 개수
	@Override
	public int getTotalCount(BasketCriteria criteria, String user_id) {
		int count = basketMapper.getTotalCount(criteria, user_id);
		return count;
	}
	
	//글 목록(페이징)
	@Override
	public List<BasketDetailDto> getListWithPaging(BasketCriteria criteria) {
		List<BasketDetailDto> listPage = basketMapper.getListWithPaging(criteria);
		return listPage;
	}

	//가격합계
	@Override
	public int getSumPrice(String user_id) {
		int sumPrice = basketMapper.getSumPrice(user_id);
		return sumPrice;
	}
}
