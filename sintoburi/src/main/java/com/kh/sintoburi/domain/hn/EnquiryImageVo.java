package com.kh.sintoburi.domain.hn;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnquiryImageVo {

	private String uuid;
	private int eno;
	private String image_name;
	private String upload_path;

}
