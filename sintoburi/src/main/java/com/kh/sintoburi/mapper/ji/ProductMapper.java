package com.kh.sintoburi.mapper.ji;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.kh.sintoburi.domain.common.ProductVo;
import com.kh.sintoburi.domain.ji.DefaultProductListDto;
import com.kh.sintoburi.domain.ji.ProductListDto;
import com.kh.sintoburi.domain.ji.RelatedProdDto;

public interface ProductMapper {

	/**
	 * 상품 전체목록
	 * @return
	 */
	// 상품 목록
	public List<DefaultProductListDto> getProducts(Map<String, Integer[]> cates);

	/**
	 * 상품 상세보기
	 * @param pno
	 * @return
	 */
	// 상품 상세보기
	public ProductVo selectByPno(Integer pno);
	
	/**
	 * 카테고리별 상품 가져오기
	 * @param cateNo
	 * @return
	 */
	// 상품 카테고리별 가져오기
	public List<DefaultProductListDto> selectProductsByCate(@Param("cate_no") int cateNo);
	
	/**
	 * 유저가 등록한 상품내역 가져오기
	 * @return
	 */
	// 유저 상품내역 가져오기
	public List<ProductListDto> selectProductsByUser(String user_id);
	
	// 유저 상품내역에서 상품삭제 - 나중에 수정하기
	public int delete(int pno);
	
	// 동일유저 연관된 상품 가져오기
	public List<RelatedProdDto> selectRelatedProdByUser(@Param("user_id") String user_id, @Param("product_no") int product_no);

	// 상품 등록
	public int InsertSelectKey(ProductVo vo);
	
	
	public int Insert (ProductVo vo);
	
	// 상품 수정
	public int updateProduct(ProductVo productVo);
	
	// 문의사항 수정
    public int updateSuggestionCnt(@Param("product_no") int product_no,
    							   @Param("amount") int amount);
    // 상품후기 수정
    public int updateReviewCnt(@Param("product_no") int product_no,
    						   @Param("amount") int amount);	
    
    
    
    // 상품 문의사항 관련 / 상품 등록한 유저 가져오기
    @Select("SELECT user_id FROM tbl_product WHERE product_no = #{product_no}")
    public String getProductOwner(int product_no);
    
    public List<DefaultProductListDto> selectSearchProducts(@Param("type") String type, @Param("keyword") String keyword);
}
