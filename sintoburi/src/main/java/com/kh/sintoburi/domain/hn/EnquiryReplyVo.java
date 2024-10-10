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
public class EnquiryReplyVo {
	
	private int rno;
	private int eno;
	private String user_id;
	private String reply_content;
	private Date reply_date;
	private String manager_id;

}
