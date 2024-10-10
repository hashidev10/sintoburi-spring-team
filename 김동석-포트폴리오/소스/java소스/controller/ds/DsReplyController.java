package com.kh.sintoburi.controller.ds;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.sintoburi.domain.ds.DsReplyVo;
import com.kh.sintoburi.service.ds.DsReplyService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/ds/reply/*")
public class DsReplyController {
	@Autowired
	private DsReplyService replyService;
	
	@ResponseBody
	@PostMapping("/commitComment")
	public boolean register(@RequestBody DsReplyVo vo) {
		
		return replyService.commitComment(vo);
	}
	

		@PostMapping("/getReply")
		@ResponseBody
		public List<DsReplyVo> getReply(@RequestBody Map<String, Long>map) {
			
			Long bno = map.get("bno");
			List<DsReplyVo> list = replyService.getReply(bno);
			
			System.out.println("리스트:"+list.toString());
			
			return list;
			
		
		}
		
		
		@DeleteMapping("/del/{rno}")
		@ResponseBody
		public boolean delReply(@PathVariable("rno") Long rno) {
		
			
			
			return replyService.delReply(rno);
		}
		
		
		@PostMapping("/mod")
		@ResponseBody
		public boolean modReply(@RequestBody DsReplyVo vo) {
		

			return replyService.modReply(vo);
		}
}
