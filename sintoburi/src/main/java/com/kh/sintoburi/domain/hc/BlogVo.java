package com.kh.sintoburi.domain.hc;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BlogVo {
	
	private int blog_no;
	private String user_id;
	private String user_name;
	private String blog_content;
	private Date regdate;
	private Date updatedate;
	private List<HcAttachFileDto> fileList;
	private List<HcProductTagDto> productTagList;
	private int sumLike;
	private boolean checkLike;
	private int sumFollower;
	private boolean checkFollow; 
	
	
}
