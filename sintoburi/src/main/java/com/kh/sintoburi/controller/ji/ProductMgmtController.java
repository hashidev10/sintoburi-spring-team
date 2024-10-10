package com.kh.sintoburi.controller.ji;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.common.ProductImageVo;
import com.kh.sintoburi.domain.common.ProductVo;
import com.kh.sintoburi.domain.ji.ProductListDto;
import com.kh.sintoburi.service.ji.ImageService;
import com.kh.sintoburi.service.ji.ProductService;
import com.kh.sintoburi.util.ji.JiMyFileUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ji/manager/*")
@Log4j
public class ProductMgmtController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ImageService imgService;
	
	// 내 상품 리스트
	@GetMapping("/productList")
	public String list(Model model, HttpSession session) {

		UserVo uservo = (UserVo)session.getAttribute("login");
		
		
		List<ProductListDto> list = productService.selectProductsByUser(uservo.getUser_id());
		
		model.addAttribute("list", list);
		return "/ji/manager/productList";
	}
	
	// 상품 리스트에서 상품 삭제
	@PostMapping("/remove")
	public String delete(@RequestParam("pno") int pno, RedirectAttributes rttr) {
		boolean result = productService.remove(pno);
		rttr.addFlashAttribute("resultRemove", result);
		return "redirect:/ji/manager/productList";
	}
	
	// 상품 등록 폼
	@GetMapping("/register")
	public void register() {
		
	}
	
	// 상품 등록 처리
	@PostMapping("/register")
	public String register(ProductVo vo, RedirectAttributes rttr, HttpSession session) {
		vo.setUser_id(((UserVo)session.getAttribute("login")).getUser_id());
		int pno = productService.productRegister(vo);
		log.info("vo:"+ vo);
		rttr.addFlashAttribute("resultRegister", pno);
		return "redirect:/ji/product/productMain";
	}
	
	
	// 상품 수정 폼 가져오기
	@GetMapping("/modifyProduct")
	public String modify(@RequestParam("pno") int pno, Model model) {
		log.info("modifyProduct...");
		
		ProductVo productVo = productService.getProductByNo(pno);
		model.addAttribute("productVo", productVo);
		
		
		return "/ji/manager/modifyProduct";
	}
	
	// 수정 처리
	@PostMapping("/modifyProduct")
	public String modifyProduct(ProductVo productVo, RedirectAttributes rttr) {
		
	    List<ProductImageVo> delList = productVo.getDelList();
	    if (delList != null && !delList.isEmpty()) {
	        for (ProductImageVo img : delList) {
	            imgService.delImg(img.getUuid(), img.getImg_name());
	            String imgFile = "D:/" + img.getImg_path() + "/" + img.getUuid() + "_" + img.getImg_name();
	            JiMyFileUtil.delete(imgFile);
	        }
	    }

	    List<ProductImageVo> imgList = productVo.getImgList();
	    if (imgList != null && !imgList.isEmpty()) {
	        for (ProductImageVo img : imgList) {
	            img.setProduct_no(productVo.getProduct_no());
	            imgService.insertImage(img);
	        }
	    }

	    boolean result = productService.updateProduct(productVo);

	    if (result) {
	        rttr.addFlashAttribute("message", "상품 수정이 성공적으로 완료되었습니다.");
	    } else {
	        rttr.addFlashAttribute("message", "상품 수정에 실패했습니다.");
	    }
		
	    return "redirect:/ji/manager/productList"; 
	}
	
	
	
}
