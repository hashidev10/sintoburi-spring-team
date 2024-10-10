package com.kh.sintoburi.service.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.BlogPageDto;
import com.kh.sintoburi.domain.hc.BlogVo;

public interface BlogService {
	
	public List<BlogVo> getList(BlogPageDto blogPageDto);
	public List<BlogVo> getListByUser_id(String user_id);
	public BlogVo readByBlogNo(int blog_no);
	public boolean insert(BlogVo blogVo);
	public boolean modify(BlogVo blogVo);
	public boolean delete(int blog_no);
		

}
