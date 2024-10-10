package com.kh.sintoburi.controller.ji;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sintoburi.domain.common.ProductImageVo;
import com.kh.sintoburi.domain.common.ProductVo;
import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.ji.DefaultProductListDto;
import com.kh.sintoburi.domain.ji.RelatedProdDto;
import com.kh.sintoburi.service.ji.ImageService;
import com.kh.sintoburi.service.ji.ProductService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ji/product/*")
@Log4j
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ImageService imageService;
	
	
	// 쇼핑몰 메인
	@GetMapping("/productMain")
	public String list(Model model, HttpSession session) {
	    List<DefaultProductListDto> productList = productService.getProducts();
	    
	    model.addAttribute("list", productList); 
	    
	    return "/ji/product/productMain";
	}
	
	@GetMapping("/selectSearchProducts")
	public String selectSearchProdcuts(
			@ModelAttribute("type") String type, 
			@ModelAttribute("keyword") String keyword, 
			Model model) {
		log.info("keyword:" + keyword);
		List<DefaultProductListDto> list = productService.selectSearchProducts(type, keyword);
		log.info("list:" + list);
		model.addAttribute("list", list);
		
		return "/ji/product/selectSearchProducts";
		
	}
	
	// Main화면에서 해당 카테고리만 나오는 productMainCate
	@GetMapping("/productMainCate") 
	public String productMainCate(@RequestParam(required = true, name = "cate_no") int cate_no, Model model, HttpSession session) {
		
		UserVo userVo = (UserVo) session.getAttribute("login");
	    
		if (userVo != null) {
            model.addAttribute("isLoggedIn", true);
            model.addAttribute("loginUser", userVo);
        } else {
            model.addAttribute("isLoggedIn", false);
        }
		
		List<DefaultProductListDto> list = productService.selectProductsByCate(cate_no);
		
		model.addAttribute("list", list);
		
		return "/ji/product/productMainCate";
	}
	
	
	/**
	 * 상품번호를 전달 받아서 상품 상세보기 페이지로 전달
	 * 
	 * @param pno 상품번호: from 클라이언트
	 * @param model 뷰 전달용
	 * @return "product/productDetail" 로 포워드
	 */
	@GetMapping("/productDetail")
	public String productDetail(@RequestParam("pno") int pno, Model model, HttpSession session) {
		// 상품 정보, 이미지 리스트 가져오기
		ProductVo product = productService.getProductByNo(pno);
		List<ProductImageVo> images = imageService.getImgList(pno);
		List<RelatedProdDto> relatedProducts = productService.selectRelatedProdByUser(product.getUser_id(), pno);
		
		UserVo userVo = (UserVo) session.getAttribute("login");
		if (userVo != null) {
			model.addAttribute("login", userVo);
		}
		
	    model.addAttribute("relatedProducts", relatedProducts);
		model.addAttribute("product", product);
		model.addAttribute("images", images);
        
		return "/ji/product/productDetail";
	}
	
	

	
	

		
}
