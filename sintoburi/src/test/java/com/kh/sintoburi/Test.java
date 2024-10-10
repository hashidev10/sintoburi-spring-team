package com.kh.sintoburi;


import java.util.List;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.domain.hc.BlogVo;
import com.kh.sintoburi.domain.hc.HcProductTagDto;
import com.kh.sintoburi.mapper.hc.BlogMapper;
import com.kh.sintoburi.mapper.hc.HcProductTagMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class Test {
	
	@Autowired
	private HcProductTagMapper mapper;
	
	@Autowired
	private BlogMapper blogMapper;
	
	@org.junit.Test
	public void mapperTest2() {
		BlogVo vo = new BlogVo();
		vo.setBlog_content("엄준식");
		vo.setUser_id("user01");
		blogMapper.insertSelectKey(vo);
				
		
	}
	@org.junit.Test
	public void mapperTest() {
		HcProductTagDto dto = new HcProductTagDto();
		dto.setProduct_name("테스트");
		System.out.println("프로덕트 dto는?" + dto);
		List<HcProductTagDto> list = mapper.getProductListWithCondition(dto);
	}
	
	
	@org.junit.Test
	public void mapperTest3() {
		int blog_no = 1;
		BlogVo vo = blogMapper.getBlogVoByBlogNo(blog_no);
		System.out.println("vo는?" + vo);
	}
	
	@org.junit.Test
	public void mapperTest4() {
		blogMapper.deteteByBlog_no(8);
	}
	
	
	
	
	

	
}
