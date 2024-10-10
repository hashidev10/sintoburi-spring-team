package com.kh.sintoburi.domain.hn;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NoticeImageVo {
	private String uuid;
	private int n_no;
	private String image_name;
	private String upload_path;

}
