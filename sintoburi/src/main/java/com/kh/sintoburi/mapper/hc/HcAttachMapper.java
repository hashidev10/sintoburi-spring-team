package com.kh.sintoburi.mapper.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.HcAttachFileDto;


public interface HcAttachMapper {

	public int insert(HcAttachFileDto dto);
	
	public List<HcAttachFileDto> getAttachList(int blog_no);
	
	public int update(HcAttachFileDto dto);
	
	public int deleteAll(int blog_no);
	
	public int deleteByUuid(String uuid);
	
	public List<HcAttachFileDto> getOldAttachList();
	
}
