package com.kh.sintoburi.domain.ji;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class SuggestionVo {

	private int suggestion_no;
	private String suggestion_content;
	private int product_no;
	private String user_id;
	private Date suggestion_reg_date;
	private Date suggestion_upd_date;
	private Integer parent_no;
}
