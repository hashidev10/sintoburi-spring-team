package com.kh.sintoburi.mapper.hc;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.hc.BlogSettingVo;

public interface BlogSettingMapper {
	
	public int insertSetting(BlogSettingVo vo);
	public List<BlogSettingVo> getBlogSettingList(String user_id);
	public int deleteBlogSettingListByCategory(@Param("user_id") String user_id,
			@Param("blog_category") String blog_category);
	public int modifySetting(BlogSettingVo vo);
	public int deleteSetting(BlogSettingVo vo);
	
}
