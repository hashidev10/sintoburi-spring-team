package com.kh.sintoburi.service.ds;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.ds.DsLikeDto;
import com.kh.sintoburi.mapper.ds.DsLikeMapper;

@Service
public class DsLikeServiceImpl implements DsLikeService {

	@Autowired
	private DsLikeMapper likeMapper;



	@Override
	public boolean doLike(DsLikeDto dto) {
		//Map<String, Object> map = new HashMap<>();
	
		return likeMapper.insert(dto)>0 ? true:false;
	}



	@Override
	public boolean undoLike(DsLikeDto dto) {
		//Map<String, Object> map = new HashMap<>();
		
		return likeMapper.delete(dto)>0 ? true: false;
	}



	@Override
	public boolean checkLike(String user_id,Long bno) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("bno", bno);
		
		return likeMapper.select(map)>0 ? true : false;
	}

	@Override
	public Integer getLikeCount(Long bno) {
		
		return likeMapper.selectCount(bno);
	}



	@Override
	public boolean updateLikeCount(Long bno, Integer like_count) {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("like_count", like_count);
		return likeMapper.updateLikeCountByBno(map)>0?true:false;
	}
	
	
	
}
