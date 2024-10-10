package com.kh.sintoburi.service.ji;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.ji.ReviewVo;
import com.kh.sintoburi.mapper.ji.ProductMapper;
import com.kh.sintoburi.mapper.ji.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    private ReviewMapper reviewMapper;
    
    @Autowired
    private ProductMapper prodMapper;

    @Override
    public boolean insertReview(ReviewVo reviewVo) {
    	int count = reviewMapper.insertReview(reviewVo);
        return (count > 0) ? true : false;
    }

    @Override
    public boolean modifyReview(ReviewVo reviewVo) {
        int count = reviewMapper.modifyReview(reviewVo);
        return (count > 0) ? true : false;
    }

    @Override
    public boolean removeReview(int review_no, int product_no) {
        int count = reviewMapper.deleteReview(review_no);
        return (count > 0) ? true : false;
    }

    @Override
    public List<ReviewVo> getReviewsByProductNo(ReviewVo ReviewVo) {
        return reviewMapper.selectReviewsByProductNo(ReviewVo);
    }

	@Override
	public Double getAverageRating(int pno) {
		return reviewMapper.selectAverageRating(pno);
	}
    
//    @Override
//    public List<ReviewVo> getReviewsByProductNo(int pno, String sortOrder) {
//        Map<String, Object> map = new HashMap<>();
//        map.put("pno", pno);
//        map.put("sortOrder", sortOrder);
//        return reviewMapper.selectReviewsByProductNo(map);
//    } 
}
