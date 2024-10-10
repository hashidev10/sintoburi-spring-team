package com.kh.sintoburi.mapper.ji;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.common.ProductImageVo;

public interface ImageMapper {

	// 상품 이미지 등록
	/**
	 * 상품 이미지 등록
	 * */
	public int insertImg(ProductImageVo vo);
	
	// 상품(이미지) 리스트
	/**
	 * 상품(이미지) 리스트
	 * @param rno
	 * @return
	 */
	public List<ProductImageVo> getImgList(Integer pno);
	
	// 상품 상세보기 
	/**
	 * 상품 상세보기 이미지
	 * @param pno
	 * @return
	 */
	public ProductImageVo getImageByProductNo(int pno);

	public int delete(int pno);
	
	// test
	public List<ProductImageVo> getImageListByPno(int pno);
	
	
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 테스트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int Insert(ProductImageVo imgVo);
	
	public int deleteImageByUuidAndName(@Param("uuid") String uuid, @Param("img_name") String img_name);
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 테스트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

}
