package com.kh.sintoburi.mapper.hn;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnLoginDto;
import com.kh.sintoburi.domain.hn.HnUserDto;

public interface HnUserMapper {

	// 회원목록
	public List<HnUserDto> getList();
	
	// 매니저목록
	public List<HnUserDto> managerList();

	// 회원 목록 페이징 적용
	public List<HnUserDto> getListWithPaging(HnCriteria criteria);
	
	// 매니저 목록 페이징 
	public List<HnUserDto> managerListPaging(HnCriteria criteria);
	
	// 회원 게시글 갯수
	public int getTotalCount(HnCriteria criteria);	

	// 매니저 목록 갯수
	public int managerTotalCount(HnCriteria criteria);
	
	// 등급수정
	public int updateGrade(@Param("user_id") String user_id, @Param("grade") String grade);

	// 데이터 1개
	public UserVo selectById(@Param("user_id") String user_id);

	// 로그인
	public UserVo login(HnLoginDto dto);
	
	// 회원정보
	public UserVo selectUserInfo(@Param("user_id") String user_id);
	
	// 회원 정보 수정
	public int updateUserInfo(UserVo userVo);
	
	// 회원 탈퇴
	public int unRegister(@Param("user_id") String user_id);

	// 아이디저장
	public int checkDupId(@Param("user_id") String user_id);

	// 이메일조회
	public String getEmailById(@Param("user_id") String user_id);
	
	// 비밀번호체크
	public HnUserDto checkPw(@Param("user_id") String user_id);
	
	// 사업자번호 업데이트
	public int updateBusinessNum(@Param("user_id") String user_id, @Param("business_num") String business_num);
	
	// 등급 처리완료시 business 1로업데이트
	public int updateBusiness(@Param("user_id") String user_id);
	
	// 등급 변경 해야하는 회원 리스트
	public List<HnUserDto> gradeUpdateShow();
	

}
