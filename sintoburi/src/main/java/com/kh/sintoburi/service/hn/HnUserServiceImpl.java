package com.kh.sintoburi.service.hn;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnLoginDto;
import com.kh.sintoburi.domain.hn.HnUserDto;
import com.kh.sintoburi.mapper.hn.HnUserMapper;

@Service
public class HnUserServiceImpl implements HnUserService {
	@Autowired
	private HnUserMapper userMapper;

	// 회원 목록
	@Override
	public List<HnUserDto> getList(HnCriteria criteria) {
//		List<UserDto> list = userMapper.getList();
		List<HnUserDto> list = userMapper.getListWithPaging(criteria);
		return list;
	}

	// 회원 목록 갯수
	@Override
	public int getTotal(HnCriteria criteria) {
		int count = userMapper.getTotalCount(criteria);
		return count;
	}

	// 매니저 목록
	@Override
	public List<HnUserDto> managerList(HnCriteria criteria) {
//		List<UserDto> list = userMapper.managerList();
		List<HnUserDto> list = userMapper.managerListPaging(criteria);
		return list;
	}

	// 매니저 목록 갯수 
	@Override
	public int managerTotalCount(HnCriteria criteria) {
		int count = userMapper.managerTotalCount(criteria);
		return count;
	}

	@Override
	public boolean modifyGrade(String user_id, String grade) {
		int count = userMapper.updateGrade(user_id, grade);
		System.out.println("count:" + count);
		return (count == 1) ? true : false;
	}

	// 회원 전체 데이터 1개
	@Override
	public UserVo selectById(String user_id) {
		UserVo vo = userMapper.selectById(user_id);
		return vo;
	}

	@Override
	public UserVo login(HnLoginDto dto) {
		UserVo userDto = userMapper.login(dto);
		return userDto;
	}

	// 사업자번호 등록
	@Override
	public boolean modifyBusinessNum(String user_id, String business_num) {
		int count = userMapper.updateBusinessNum(user_id, business_num);
		return (count == 1) ? true : false;
	}

	// 등급 처리완료시 business 1로 업데이트 
	@Override
	public boolean updateBusiness(String user_id) {
		int count = userMapper.updateBusiness(user_id);
		return (count == 1) ? true : false;
	}

	// 등급 변경해야하는 회원 리스트 
	@Override
	public List<HnUserDto> gradeChangeList() {
		List<HnUserDto> list = userMapper.gradeUpdateShow();
		return list;
	}
	
	// 비밀번호 체크
	@Override
	public HnUserDto checkPw(String user_id) {
		HnUserDto dto =  userMapper.checkPw(user_id);
		return dto;
	}

	// 회원 정보 조회
	@Override
	public UserVo userInfo(String user_id) {
		UserVo userVo = userMapper.selectUserInfo(user_id);
		return userVo;
	}

	@Override
	public boolean userInfoMod(UserVo userVo) {
		int count = userMapper.updateUserInfo(userVo);
		return (count == 1)? true: false;
	}

	@Override
	public boolean unRegister(String user_id) {
		int count = userMapper.unRegister(user_id);
		return (count == 1)? true: false;
	}

}
