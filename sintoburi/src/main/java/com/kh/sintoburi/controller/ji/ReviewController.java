package com.kh.sintoburi.controller.ji;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.sintoburi.domain.ji.ReviewVo;
import com.kh.sintoburi.service.ji.ReviewService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/ji/review/*")
@Log4j
public class ReviewController {

	@Autowired
    private ReviewService reviewService;
	
	 // 리뷰 작성
    @PostMapping("/register")
    public boolean register(@RequestBody ReviewVo reviewVo) {
    	System.out.println("내가받은 리뷰 vo는?" + reviewVo);
        return reviewService.insertReview(reviewVo);
    }

    // 리뷰 수정
    @PutMapping("/modify")
    public boolean modify(@RequestBody ReviewVo reviewVo) {
        return reviewService.modifyReview(reviewVo);
    }

    // 리뷰 삭제
    @DeleteMapping("/remove/{review_no}/{pno}")
    public boolean remove(@PathVariable("review_no") int review_no,
                          @PathVariable("pno") int pno) {
        boolean result = reviewService.removeReview(review_no, pno);
        return result;
    }

    // 특정 상품에 대한 리뷰 목록
    @GetMapping("/list/{pno}/{sortOrder}")
    public List<ReviewVo> getReviews(@PathVariable("pno") int pno,
                                     @PathVariable("sortOrder") String sortOrder, Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("pno", pno);
        map.put("sortOrder", sortOrder);
        
        
        Double averageRating = reviewService.getAverageRating(pno);
        model.addAttribute("averageRating", averageRating);
        System.out.println("pno:" + pno);
        ReviewVo ReviewVo = new ReviewVo();
        ReviewVo.setProduct_no(pno);
        ReviewVo.setSortOrder(sortOrder);
        List<ReviewVo> reviews = reviewService.getReviewsByProductNo(ReviewVo);
        return reviews;
    }
    
    // 상품 리뷰 평균 평점
    @GetMapping("/averageRating/{pno}")
    @ResponseBody
    public Double getAverageRating(@PathVariable("pno") int pno) {
        return reviewService.getAverageRating(pno);
    }
    
}

