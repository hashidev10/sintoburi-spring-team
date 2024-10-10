package com.kh.sintoburi.controller.ds;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.sintoburi.domain.ds.DsPointDto;
import com.kh.sintoburi.domain.ds.DsQuizVo;
import com.kh.sintoburi.service.ds.DsGameService;
import com.kh.sintoburi.service.ds.DsUserService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/ds/game/*")
public class DsGameController {
	
	@Autowired
	private DsGameService gameService;
	
	@Autowired
	private DsUserService userService;
	
		// 퀴즈게임 점수기록
		@PostMapping("/quizRecord")
		@ResponseBody
		public Integer quizRecordPost(@RequestBody DsQuizVo vo) {
			
			System.out.println("vo:"+vo.toString());
			boolean result =gameService.recoardQuiz(vo);
			
			// 유저 포인트 갱신
			gameService.getPointQuiz(vo);
			
			Integer point = userService.getUserPoint(vo.getUser_id());
			
			
			return point;
		}
		
		
		// 퀴즈게임 점수보기
		@PostMapping("/quizScore")
		@ResponseBody
		public List<DsQuizVo> quizScorePost() {

			List<DsQuizVo> result = gameService.getScore();

			return result; 
		}
		
		
		
		// 달리기 게임 결과
		@PutMapping("/runResult")
		@ResponseBody
		public Integer runScorePost(@RequestBody DsPointDto dto) {
			gameService.resultRunGame(dto);
			Integer result=	userService.getUserPoint(dto.getUser_id());
			
			System.out.println(result);

			return result;
		}


}
