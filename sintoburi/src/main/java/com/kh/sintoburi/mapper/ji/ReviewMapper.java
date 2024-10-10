package com.kh.sintoburi.mapper.ji;

import java.util.List;
import java.util.Map;

import com.kh.sintoburi.domain.ji.ReviewVo;

public interface ReviewMapper {

	 
	 public int insertReview(ReviewVo reviewVo);

	 public int modifyReview(ReviewVo reviewVo);
	
	 public int deleteReview(int review_no);

	 public List<ReviewVo> selectReviewsByProductNo(ReviewVo ReviewVo);
	 
	 public Double selectAverageRating(int pno);
}
	