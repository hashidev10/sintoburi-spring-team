package com.kh.sintoburi.service.ji;

import java.util.List;

import com.kh.sintoburi.domain.common.ProductImageVo;

public interface ImageService {
	
	// 상품 이미지 등록
	/**
	 * 상품 이미지 등록
	 * @param ProductImageVo image
	 * @return
	 */
	public boolean insertImage(ProductImageVo image); 

	// 상품 상세보기
	/**
	 * 상품 상세보기 이미지
	 * @param pno
	 * @return
	 */
	public List<ProductImageVo> getImgList(int pno);

	/**
	 * 메인화면에서 상품 카테고리별 사진 가져오기
	 * @param pno
	 * @return
	 */
	// 상품 카테고리 사진 가져오기
	public ProductImageVo getImageByProductNo(int pno);

	//test
	public List<ProductImageVo> getImageListByPno(int pno);
	
	// 이미지 삭제
    public boolean delImg(String uuid, String img_name);
}
