package com.kh.sintoburi.domain.hn;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HnUserDto {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String grade;
	private String user_email;
	private Date  last_login;
	private int business;

}
