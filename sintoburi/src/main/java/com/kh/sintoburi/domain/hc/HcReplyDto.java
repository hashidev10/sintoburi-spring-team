package com.kh.sintoburi.domain.hc;

import java.util.Date;

import lombok.Data;

@Data
public class HcReplyDto {
	private int blog_rno;
	private int blog_no;
	private String replyer;
	private String reply_content;
	private Date regdate;
	private Date updatedate;
}
