package com.kh.sintoburi.service.ji;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.common.ProductImageVo;
import com.kh.sintoburi.domain.common.ProductVo;
import com.kh.sintoburi.domain.ji.DefaultProductListDto;
import com.kh.sintoburi.domain.ji.ProductListDto;
import com.kh.sintoburi.domain.ji.RelatedProdDto;
import com.kh.sintoburi.mapper.ji.ImageMapper;
import com.kh.sintoburi.mapper.ji.ProductMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper productMapper;

	@Autowired
	private ImageMapper imageMapper;
	
	
	// 전체 상품 목록 (productMain 화면)
	@Override
	public List<DefaultProductListDto> getProducts() {
		Integer[] cates = {1, 2, 3, 4};
		Map<String, Integer[]> map = new HashMap<String, Integer[]>();
		map.put("cates", cates);
		List<DefaultProductListDto> list = productMapper.getProducts(map);
		return list;
	}

	
	// 상품 상세보기 (productDetail 화면)
	@Override
	@Transactional
	public ProductVo getProductByNo(Integer pno) {
		System.out.println("get...");
		ProductVo vo = productMapper.selectByPno(pno);
		List<ProductImageVo> imageList = imageMapper.getImgList(pno);
		vo.setImgList(imageList);
		return vo;
	}
	
    // 상품 삭제
	@Transactional
	@Override
	public boolean remove(int pno) {
		System.out.println("remove...");
		imageMapper.delete(pno);
		int count = productMapper.delete(pno);
		return (count > 0) ? true : false;
	}
	
	// Main화면에서 해당 카테고리만 나오는 productMainCate
	@Override
	public List<DefaultProductListDto> selectProductsByCate(int cate_no) {
		List<DefaultProductListDto> list = productMapper.selectProductsByCate(cate_no);
		return list;
	}

	// 유저 상품내역 가져오기(마이페이지)
	@Override
	public List<ProductListDto> selectProductsByUser(String user_id) {
		List<ProductListDto> list = productMapper.selectProductsByUser(user_id);
		return list;
	}

	// 동일한 유저가 등록한 상품 가져오기
	@Override
	public List<RelatedProdDto> selectRelatedProdByUser(String user_id, int product_no) {
		List<RelatedProdDto> list = productMapper.selectRelatedProdByUser(user_id, product_no);
		return list;
	}

	
	// 상품 등록
	@Transactional
	@Override
	public int productRegister(ProductVo vo) {
		System.out.println("prodService/register...");
		int count = productMapper.InsertSelectKey(vo);
		List<ProductImageVo> list = vo.getImgList();
		log.info("list:" + list);
		
		
		if (list != null && list.size() > 0) {
	        list.get(0).setRepresent('1');
	        
	        for (int i = 1; i < list.size(); i++) {
	            list.get(i).setRepresent('0');
	        }
	        
	        list.forEach(dto -> {
	            dto.setProduct_no(vo.getProduct_no());
	            imageMapper.Insert(dto);
	        });
	    }	
		
		if (count > 0) {
			return vo.getProduct_no();
		}
		return count;
		
	}


	@Override
	public boolean updateProduct(ProductVo productVo) {
		
		
		int count = productMapper.updateProduct(productVo);
		return (count > 0) ? true : false;
	}


	@Override
	public List<DefaultProductListDto> selectSearchProducts(String type, String keyword) {
		List<DefaultProductListDto> list = productMapper.selectSearchProducts(type, keyword);
		log.info("list:" + list);
		return list;
	}







		

}
