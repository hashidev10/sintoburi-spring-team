package com.kh.sintoburi.domain.ds;

import java.util.Date;

import lombok.Data;
@Data
public class DsReplyVo {
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
