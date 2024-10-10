package com.kh.sintoburi.service.ds;

import java.util.List;

import com.kh.sintoburi.domain.ds.DsChatVo;


public interface DsChatService {
	public boolean sendChat(DsChatVo vo);
	public List<DsChatVo> getChatLog();
	public boolean deleteChatLog();

}
