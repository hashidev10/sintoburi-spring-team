package com.kh.sintoburi.service.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hc.HcProductTagDto;
import com.kh.sintoburi.mapper.hc.HcProductTagMapper;

@Service
public class HcProductServiceImpl implements HcProductService {
	
	@Autowired
	private HcProductTagMapper productMapper;
	
	@Override
	public List<HcProductTagDto> getProductList(HcProductTagDto dto) {
		List<HcProductTagDto> list = productMapper.getProductListWithCondition(dto);
		
		return list;
	}

	@Override
	public List<HcProductTagDto> getProductListByBlogNo(int blog_no) {
		List<HcProductTagDto> list = productMapper.getTagList(blog_no);
		
		return list;
	}

	@Override
	public List<HcProductTagDto> getProductListByUserId(String user_id) {
		List<HcProductTagDto> list = productMapper.getProductListWithUserId(user_id);
		
		return list;
	}
	
	
	
	
	

}
