package com.kh.sintoburi.domain.gr;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor 
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class LoginUser {
	private String user_id;
	private String user_name;
	private String user_pw;
	private String grade;
}
