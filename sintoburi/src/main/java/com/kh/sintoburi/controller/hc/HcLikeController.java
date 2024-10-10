package com.kh.sintoburi.controller.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.sintoburi.domain.hc.HcLikeDto;
import com.kh.sintoburi.service.hc.HcLikeService;

@RestController
@RequestMapping("/hc/like/*")
public class HcLikeController {
	
	@Autowired
	private HcLikeService likeService;
	
	@PostMapping("/addLike")
	public boolean addLike(@RequestBody HcLikeDto likeDto) {
		System.out.println("좋아요 클릭");
		return likeService.addLike(likeDto);
	}
	
	@PostMapping("/removeLike")
	public boolean removeLike(@RequestBody HcLikeDto likeDto) {
		return likeService.removeLike(likeDto);
	}
	
	@GetMapping("/getSumLike")
	public int getSumLike(int blog_no) {
		int sumLike = likeService.getLikeCount(blog_no);
		return sumLike;
	}

}
