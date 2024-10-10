package com.kh.sintoburi.service.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.hc.BlogSettingVo;
import com.kh.sintoburi.mapper.hc.BlogSettingMapper;

@Service
public class BlogSettingServiceImpl implements BlogSettingService {
	@Autowired
	private BlogSettingMapper blogSettingMapper;
	
	@Override
	public List<BlogSettingVo> getSettingList(String user_id) {
		List<BlogSettingVo> list = blogSettingMapper.getBlogSettingList(user_id);
		return list;
	}

	@Override
	public boolean insertSetting(BlogSettingVo settingVo) {
		System.out.println("내가 추가할 블로그 vo는?" + settingVo);
		int count = blogSettingMapper.insertSetting(settingVo);
		return (count > 0)? true : false;
	}

	@Override
	public boolean modifySetting(BlogSettingVo settingVo) {
		int count = blogSettingMapper.modifySetting(settingVo);
		return (count > 0)? true : false;
	}

	@Override
	public boolean deleteSetting(BlogSettingVo settingVo) {
		int count = blogSettingMapper.deleteSetting(settingVo);
		return (count > 0)? true : false;
	}
	
	@Transactional
	@Override
	public boolean insertSettingList(List<BlogSettingVo> list) {
		System.out.println("내가받은 블로그 셋팅은?" + list);
		String blogCategory = list.get(0).getBlog_category();
		String user_id = list.get(0).getUser_id();
		int count = blogSettingMapper.deleteBlogSettingListByCategory(user_id, blogCategory);
		list.forEach(dto->{
			blogSettingMapper.insertSetting(dto);
		});
		return (count>0)? true : false;
	}

}
