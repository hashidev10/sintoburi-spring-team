package com.kh.sintoburi.domain.hc;

import lombok.Data;

@Data
public class BlogSettingVo {
	private String user_id;
	private String isMain;
	private String isVisible;
	private String blog_category;
	private String config_name;
	private String config_value;
	private int blog_priority;

}
