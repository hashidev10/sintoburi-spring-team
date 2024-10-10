package com.kh.sintoburi.domain.ji;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ImageFileDto {
	
	private String uuid;
	private String img_name;
	private String img_path;

}
