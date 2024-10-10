package com.kh.sintoburi.service.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.hc.BlogVo;
import com.kh.sintoburi.domain.hc.HcFollowDto;
import com.kh.sintoburi.domain.hc.HcLikeDto;
@Service
public class HcInjectionServiceImpl implements HcInjectionService {
	
	@Autowired
	private HcLikeService likeService;
	@Autowired
	private HcFollowService followService;
	// 사용자가 좋아요랑 팔로우를 했는지 체크해줌
	@Transactional
	@Override
	public List<BlogVo> checkListFollowAndLike(List<BlogVo> blogList, String login_id) {
		blogList.forEach(blogVo ->{
			int blog_no = blogVo.getBlog_no();
			int countLike = likeService.getLikeCount(blog_no);
			blogVo.setSumLike(countLike);
			if(login_id != null) {
				HcLikeDto likeDto = new HcLikeDto();
				likeDto.setBlog_no(blog_no);
				likeDto.setUser_id(login_id);
				boolean checkLike = likeService.isCheckLike(likeDto);
				blogVo.setCheckLike(checkLike);
			}
			
			int countFollow = followService.getLikeFollow(blogVo.getUser_id());
			blogVo.setSumFollower(countFollow);
			
			if(login_id != null) {
				HcFollowDto followDto = new HcFollowDto();
				followDto.setUser_follower(login_id);
				followDto.setUser_following(blogVo.getUser_id());
				boolean checkFollow = followService.isCheckFollow(followDto);
				blogVo.setCheckFollow(checkFollow);
			}
		});
		
		return blogList;
	}
	
	


	@Override
	public BlogVo checkVoFollowAndLike(BlogVo blogVo, String login_id) {
		int blog_no = blogVo.getBlog_no();
		int countLike = likeService.getLikeCount(blog_no);
		blogVo.setSumLike(countLike);
		
		if (login_id!= null) {
			HcLikeDto likeDto = new HcLikeDto();
			likeDto.setBlog_no(blog_no);
			likeDto.setUser_id(login_id);
			boolean checkLike = likeService.isCheckLike(likeDto);
			blogVo.setCheckLike(checkLike);
		}
		
		int countFollow = followService.getLikeFollow(blogVo.getUser_id());
		blogVo.setSumFollower(countFollow);
		
		if(login_id != null) {
			HcFollowDto followDto = new HcFollowDto();
			followDto.setUser_follower(login_id);
			followDto.setUser_following(blogVo.getUser_id());
			boolean checkFollow = followService.isCheckFollow(followDto);
			blogVo.setCheckFollow(checkFollow);
		}
		return blogVo;
	}
	
	
	
	
	
	
	
	
	

}
