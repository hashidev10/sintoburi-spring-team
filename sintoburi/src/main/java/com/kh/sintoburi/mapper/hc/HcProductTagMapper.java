package com.kh.sintoburi.mapper.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.HcProductTagDto;

public interface HcProductTagMapper {
	
	public int insert(HcProductTagDto tagDto);
	public int update(HcProductTagDto tagDto);
	public int deleteByPrimaryKey(HcProductTagDto tagDto);
	public List<HcProductTagDto> getTagList(int blog_no);
	public List<HcProductTagDto> getProductListWithUserId(String user_id);
	public List<HcProductTagDto> getProductListWithCondition(HcProductTagDto dto);
}
