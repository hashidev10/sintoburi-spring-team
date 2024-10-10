package com.kh.sintoburi.mapper.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.BlogPageDto;
import com.kh.sintoburi.domain.hc.BlogVo;


public interface BlogMapper {

	public int insertSelectKey(BlogVo blogVo);
	public int updateBlog(BlogVo blogVo);
	public int deteteByBlog_no(int blog_no);
	public List<BlogVo> getListWithPage(BlogPageDto blogPageDto);
	public List<BlogVo> getListByUser_id(String user_id);
	public BlogVo getBlogVoByBlogNo(int blog_no);
	
	
}
