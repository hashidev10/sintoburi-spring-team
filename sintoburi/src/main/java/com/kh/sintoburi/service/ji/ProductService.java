package com.kh.sintoburi.service.ji;

import java.util.List;

import com.kh.sintoburi.domain.common.ProductVo;
import com.kh.sintoburi.domain.ji.DefaultProductListDto;
import com.kh.sintoburi.domain.ji.ProductListDto;
import com.kh.sintoburi.domain.ji.RelatedProdDto;

public interface ProductService {
	
	/**
	 * 상품 전체목록
	 * @return
	 */
	// 전체상품 목록
	public List<DefaultProductListDto> getProducts();

	
	/**
	 * 상품 상세보기
	 * @param pno
	 * @return
	 */
	// 상품 상세보기
	public ProductVo getProductByNo(Integer pno);	
		

	/**
	 * 카테고리별 상품 가져오기
	 * @param cateNo
	 * @return
	 */
	// Main화면에서 해당 카테고리만 나오는 productMainCate
	public List<DefaultProductListDto> selectProductsByCate(int cate_no);
	
	/**
	 * 유저가 등록한 상품내역 가져오기
	 * @return
	 */
	// 유저 상품내역 가져오기 
	public List<ProductListDto> selectProductsByUser(String user_id);

	// 유저 상품내역에서 상품 삭제
	public boolean remove(int pno);
	
	/**
	 *  동일한 유저가 등록한 상품내역 가져오기
	 *  productDetail.jsp
	 *  -related items section에서 사용
	 */
	// 동일 유저 연관된 상품 가져오기
	public List<RelatedProdDto> selectRelatedProdByUser(String user_id, int pno);

	// 상품등록
	public int productRegister (ProductVo vo);
	
	// 상품 정보 업데이트
    public boolean updateProduct(ProductVo productVo);



	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public List<DefaultProductListDto> selectSearchProducts(String type, String keyword);
	
	
	


   
	
	
	
	
	
	
}
