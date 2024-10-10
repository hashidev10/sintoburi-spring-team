package com.kh.sintoburi.domain.hn;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeVo {
	
	private int n_no;
	private String title;
	private String content;
	private Date write_date;
	private String important;
	private List<NoticeImageVo> imageList;
	private List<String> imageDel;
}
