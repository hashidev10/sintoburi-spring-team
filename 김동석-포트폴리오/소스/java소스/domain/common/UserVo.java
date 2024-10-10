package com.kh.sintoburi.domain.common;

import java.util.Date;

import lombok.Data;

@Data
public class UserVo {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_point;
	private String grade;
	private String address;
	private String user_phone;
	private Integer business;
	private String business_num;
	private Date last_login;
	private String user_email;
	private int sumFollow;
	private boolean checkFollow;
}
