package com.kh.sintoburi.domain.hn;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HnLoginDto {
	
	private String user_id;
	private String user_pw;
	private boolean useCookie;

}
