package com.kh.sintoburi.hn;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.service.hn.EnquiryService;
import com.kh.sintoburi.service.hn.HnUserService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class serviceTest {
	
	@Autowired
	private EnquiryService enquiryService;
	
	@Autowired
	private HnUserService userService;
	
	@Test
	public void testInstance() {
		log.info("enquiryService:" + enquiryService);
	}
	

	
	
}
