package com.kh.sintoburi.hn;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.EnquiryReplyVo;
import com.kh.sintoburi.domain.hn.EnquiryVo;
import com.kh.sintoburi.domain.hn.FaqVo;
import com.kh.sintoburi.domain.hn.HnLoginDto;
import com.kh.sintoburi.domain.hn.HnUserDto;
import com.kh.sintoburi.domain.hn.NoticeVo;
import com.kh.sintoburi.domain.hn.ReportPostVo;
import com.kh.sintoburi.mapper.hn.EnquiryMapper;
import com.kh.sintoburi.mapper.hn.EnquiryReplyMapper;
import com.kh.sintoburi.mapper.hn.FaqMapper;
import com.kh.sintoburi.mapper.hn.HnUserMapper;
import com.kh.sintoburi.mapper.hn.NoticeMapper;
import com.kh.sintoburi.mapper.hn.ReportPostMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class mapperTest {

	@Autowired
	private EnquiryMapper enquiryMapper;

	@Autowired
	private EnquiryReplyMapper replyMapper;

	@Autowired
	private ReportPostMapper reportPostMapper;

	@Autowired
	private HnUserMapper userMapper;

	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private FaqMapper faqMapper;

	@Test
	public void testInstance() {
		log.info("enquiryMapper:" + enquiryMapper);
	}

	@Test
	public void selectByEno() {
		EnquiryVo vo = enquiryMapper.selectByEno(1);
		log.info(vo);
	}

	@Test
	public void insertReply() {
		EnquiryReplyVo vo = EnquiryReplyVo.builder().eno(1).user_id("user02").reply_content("답변").manager_id("manager").build();

		int count = replyMapper.insertReply(vo);
		log.info("Rows inserted: " + count);
		log.info(vo.toString());
	}

	@Test
	public void getList() {
		List<EnquiryVo> list = enquiryMapper.getList("user00");
		log.info(list);
	}

	@Test
	public void goodsselect() {
		List<EnquiryVo> list = enquiryMapper.goodsGetList();
		log.info(list);
	}

	@Test
	public void gradeSelect() {
		List<EnquiryVo> list = enquiryMapper.gradeGetList();
		log.info(list);
	}

	@Test
	public void updateStatus() {
		int eno = 1;
		int count = enquiryMapper.updateStatus(eno);
		log.info(count);
	}

	@Test
	public void selectReply() {
		List<EnquiryReplyVo> list = replyMapper.selectReply();
		log.info(list);
	}

	@Test
	public void selectByReplyEno() {
		int eno = 2;
		EnquiryReplyVo vo = replyMapper.selectByReplyEno(eno);
		log.info(vo);

	}


	@Test
	public void selectReportPost() {
		List<ReportPostVo> list = reportPostMapper.selectReport();
		log.info(list);
	}

	@Test
	public void selectByReNo() {
		ReportPostVo vo = reportPostMapper.selectByReNo(2);
		log.info(vo);
	}

	@Test
	public void login() {
		HnLoginDto dto = new HnLoginDto();
		dto.setUser_id("user00");
		dto.setUser_pw("user00");
		userMapper.login(dto);
	}

	@Test
	public void goodsList() {
		List<EnquiryVo> list = enquiryMapper.goodsGetList();
		log.info(list);
	}

	@Test
	public void NoticeList() {
		List<NoticeVo> list = noticeMapper.selectNotice();
		log.info(list);
	}


	
	@Test
	public void managerList() {
		List<HnUserDto> list = userMapper.managerList();
		log.info(list);
	}
	
	@Test
	public void selectById() {
		String user_id = "user00";
		UserVo vo = userMapper.selectById(user_id);
		log.info(vo);
	}
	
	@Test
	public void userList() {
	List<HnUserDto> list = userMapper.getList();
		log.info(list);
	}
	
	
	@Test
	public void faqList() {
		List<FaqVo> list = faqMapper.selectFaq();
		log.info(list);
	}

	@Test
	public void noticeMod() {
		NoticeVo noticeVo = NoticeVo.builder()
				.n_no(30)
				.title("dd-수정")
				.content("수정완료")
				.build();
	int count =	noticeMapper.updateNotice(noticeVo);
	log.info(count);
	}
	
	@Test
	public void preNotice() {
		NoticeVo noticeVo = noticeMapper.getPreviousNotice(21);
		log.info(noticeVo);
	}
	
	@Test
	public void nextNotice() {
		NoticeVo noticeVo = noticeMapper.getNextNotice(21);
		log.info(noticeVo);
	}
	
	@Test
	public void list() {
		List<HnUserDto> list=  userMapper.gradeUpdateShow();
		log.info(list);
	}

	@Test
	public void selectUserInfo() {
		String user_id = "user01";
		UserVo vo = userMapper.selectUserInfo(user_id);
		log.info(vo);
	}
	

}
