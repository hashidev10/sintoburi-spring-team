package com.kh.sintoburi.gr.dao;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MyBatisTests {

	@Autowired
	private SqlSessionFactory sessionFactory;
	
	@Test
	public void testConnection() {
		 SqlSession session = sessionFactory.openSession();
		 Connection conn = session.getConnection();
		 log.info(conn);
	}
}
