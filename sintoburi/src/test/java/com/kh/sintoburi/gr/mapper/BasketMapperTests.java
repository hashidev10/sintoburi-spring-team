package com.kh.sintoburi.gr.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.domain.gr.BasketDetailVo;
import com.kh.sintoburi.domain.gr.BasketVo;
import com.kh.sintoburi.mapper.gr.BasketMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BasketMapperTests {
	
	@Autowired
	private BasketMapper basketMapper;
	
	@Test
	public void testInstance() {
		log.info("basketMapper:" + basketMapper);
	}
	
//	@Test
//	public void testGetList() {
//		String user_id= "user01";
//		List<BasketDetailDto> list = basketMapper.getList(user_id);
//		log.info(list);
//	}
	
	@Test
	public void testGetBnoByUser() {
		String user_id ="user04";
		int bno = basketMapper.getBnoByUser(user_id);
		log.info(bno);
	}
	
	@Test
	public void testInsert() {
		String user_id = "user01";
		int bno = basketMapper.getBnoByUser(user_id);
		
		if (bno == 0) {
			BasketVo vo = new BasketVo();
			vo.setUser_id(user_id);
			basketMapper.insertSelectKey(vo);
			bno = vo.getBno();
		}
		
		BasketDetailVo detailVo = new BasketDetailVo();
		detailVo.setProduct_no(2);
		detailVo.setBno(bno);
		detailVo.setP_count(5);
		int count = basketMapper.insertDetail(detailVo);
		log.info("count:" + count);
	}
	
	@Test
	public void testUpdateCount() {
		int p_count = 0;
		int bdno = 2;
		
		if (p_count == 0) {
			int count = basketMapper.delete(bdno);
			log.info("count:" + count);
		} else {
			int count = basketMapper.update(p_count, bdno);
			log.info("count:" + count);
		}
	}
		
	
	@Test
	public void testDelete() {
		int bdno = 1;
		int count =  basketMapper.delete(bdno);
		log.info(count);
	}
	
	@Test
	public void testDeleteAll() {
		int bno = 1;
		int count =  basketMapper.deleteAll(bno);
		log.info(count);
	}

}
