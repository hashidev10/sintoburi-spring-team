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
public class ReviewVo {

	private int review_no;
	private String review_content;
	private int review_rating;
	private Date review_reg_date;
	private Date review_upd_date;
	private int product_no;
	private String user_id;
	private String sortOrder;
	private String formattedDate;
	
	
	public Date getReviewRegDate() {
		return null;
	}

	
}
