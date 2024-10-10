package com.kh.sintoburi.service.hc;

import java.util.List;

import com.kh.sintoburi.domain.hc.BlogVo;

public interface HcInjectionService {
	
	public List<BlogVo> checkListFollowAndLike(List<BlogVo> blogList, String login_id);
	public BlogVo checkVoFollowAndLike(BlogVo blogVo, String login_id);

}
