package com.kh.sintoburi.domain.common;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVo {
	private Long re_no;
	private String post_url;
	private String post_id;
	private String re_reason;
	private String re_id;
	private Date re_date;
	private String status;
	private String delete_url;
	private String category;
	private Long write_num;
}
