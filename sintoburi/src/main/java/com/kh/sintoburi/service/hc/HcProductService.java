package com.kh.sintoburi.service.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.HcProductTagDto;
public interface HcProductService {
	
	public List<HcProductTagDto> getProductList(HcProductTagDto dto);

	public List<HcProductTagDto> getProductListByBlogNo(int blog_no);
	
	public List<HcProductTagDto> getProductListByUserId(String user_id);
	
	
}
