package com.kh.sintoburi.service.ji;

import java.util.List;

import com.kh.sintoburi.domain.ji.ReviewVo;

public interface ReviewService {

	// 리뷰 등록
    public boolean insertReview(ReviewVo reviewVo);

    // 리뷰 수정
    public boolean modifyReview(ReviewVo reviewVo);

    // 리뷰 삭제
    public boolean removeReview(int review_no, int pno);

    public List<ReviewVo> getReviewsByProductNo(ReviewVo ReviewVo);
    
    public Double getAverageRating(int pno);
}
