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
public class EnquiryVo {
	
	private int eno;
	private String user_id;
	private String enquiry_type;
	private String content;
	private String status;
	private Date write_date;
	
	private List<EnquiryImageVo> imageList;
	private List<String> imageDel;

}
