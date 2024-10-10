package com.kh.sintoburi.service.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.BlogSettingVo;

public interface BlogSettingService {
	
	public List<BlogSettingVo> getSettingList(String user_id);
	public boolean insertSettingList(List<BlogSettingVo> list );
	public boolean insertSetting(BlogSettingVo settingVo);
	public boolean modifySetting(BlogSettingVo settingVo);
	public boolean deleteSetting(BlogSettingVo settingVo);
}
