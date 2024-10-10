package com.kh.sintoburi.controller.hn;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sintoburi.domain.common.UserVo;
import com.kh.sintoburi.domain.hn.EnquiryFormDto;
import com.kh.sintoburi.domain.hn.EnquiryImageVo;
import com.kh.sintoburi.domain.hn.EnquiryReplyVo;
import com.kh.sintoburi.domain.hn.EnquiryVo;
import com.kh.sintoburi.domain.hn.FaqVo;
import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.HnPageDto;
import com.kh.sintoburi.domain.hn.HnUserDto;
import com.kh.sintoburi.domain.hn.NoticeVo;
import com.kh.sintoburi.service.hn.EnquiryReplyService;
import com.kh.sintoburi.service.hn.EnquiryService;
import com.kh.sintoburi.service.hn.FaqService;
import com.kh.sintoburi.service.hn.HnUserService;
import com.kh.sintoburi.service.hn.NoticeService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hn/mypage/*")
@Log4j
public class MypageController {

	@Autowired
	private EnquiryService enquiryService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private EnquiryReplyService replyService;

	@Autowired
	private FaqService faqService;

	@Autowired
	private HnUserService userService;


	// 1:1 문의사항
	@GetMapping("/enqList")
	public String getEnquiryList(HttpSession session, Model model, HnCriteria criteria) {
		// 세션에서 로그인한 사용자 정보 가져오기
		UserVo login = (UserVo) session.getAttribute("login");
		
		String user_id = login.getUser_id();
		criteria.setUser_id(user_id);

		List<EnquiryVo> list = enquiryService.getList(criteria);

		model.addAttribute("list", list);

		int total = enquiryService.getTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
		// 답변
		List<EnquiryReplyVo> replyLisy = replyService.replyList();
		model.addAttribute("replyList", replyLisy);

		return "hn/mypage/enqList";
	}

	@GetMapping("/enqRegisterForm")
	public void enqRegisterForm() {

	}

	// 문의사항 작성
	@PostMapping("/enqRegister")
	public String enqRegister(EnquiryFormDto dto, RedirectAttributes rttr) throws IOException {
		log.info("dto:" + dto);
		List<MultipartFile> imageFiles = dto.getImage();

		String uploadPath = "D:/upload/sintoburi/enquiry";

		File folder = new File(uploadPath);
		if (!folder.exists()) {
			folder.mkdirs();
		}

		List<EnquiryImageVo> imageList = new ArrayList<>();

		for (MultipartFile multi : imageFiles) {
			// UUID를 이용해 파일 이름 생성
			String uuid = UUID.randomUUID().toString();
			String originalFileName = multi.getOriginalFilename(); // 이미지이름
			if (originalFileName == null || originalFileName.trim().isEmpty()) {
				continue; // 이미지 이름이 없으면 처리하지 않음
			}
			String savedFileName = uuid + "_" + multi.getOriginalFilename();
			File savedFile = new File(uploadPath, savedFileName);

			multi.transferTo(savedFile);

			EnquiryImageVo imageVo = EnquiryImageVo.builder().uuid(uuid).upload_path(uploadPath)
					.image_name(originalFileName).build();
			imageList.add(imageVo);
			System.out.println("imageVo: " + imageVo);

		}

		EnquiryVo enquiryVo = EnquiryVo.builder().content(dto.getContent()).enquiry_type(dto.getEnquiry_type())
				.user_id(dto.getUser_id()).imageList(imageList).build();

		System.out.println("enquiryVo...:" + enquiryVo);
		int eno = enquiryService.register(enquiryVo);
		rttr.addFlashAttribute("enqRegister", eno);
		return "redirect:/hn/mypage/enqList";
	}

	// 문의사항 데이터 1개
	@GetMapping("/enqRead")
	public String enqRead(@RequestParam("eno") int eno, Model model) {
		EnquiryVo enquiryVo = enquiryService.selectByEno(eno);
		model.addAttribute("enquiryVo", enquiryVo);
		return "hn/mypage/enqRead";
	}

	// 수정
	@PostMapping("/enqMod")
	public String enqMod(EnquiryFormDto dto, RedirectAttributes rttr) throws IOException {
		log.info("dto:" + dto);
		List<MultipartFile> imageFiles = dto.getImage();
		String uploadPath = "D:/upload/sintoburi/enquiry";

		List<String> imageDel = dto.getImageDel();
		System.out.println("imageDel:" + imageDel);

		List<EnquiryImageVo> imageList = new ArrayList<>();

		if (imageFiles != null && !imageFiles.isEmpty()) {
			for (MultipartFile multi : imageFiles) {
				if (multi.isEmpty()) {
					continue; // 빈 파일은 무시
				}
				// UUID를 이용해 고유한 파일 이름 생성
				String uuid = UUID.randomUUID().toString();
				String originalFileName = multi.getOriginalFilename(); // 이미지이름
				String savedFileName = uuid + "_" + multi.getOriginalFilename();
				File savedFile = new File(uploadPath, savedFileName);

				multi.transferTo(savedFile);

				EnquiryImageVo imageVo = EnquiryImageVo.builder().uuid(uuid).upload_path(uploadPath)
						.image_name(originalFileName).eno(dto.getEno()).build();
				imageList.add(imageVo);
				System.out.println("imageVo: " + imageVo);
			}
		}
		EnquiryVo enquiryVo = EnquiryVo.builder().content(dto.getContent()).enquiry_type(dto.getEnquiry_type())
				.user_id(dto.getUser_id()).imageDel(imageDel).imageList(imageList).eno(dto.getEno()).build();
		System.out.println("after imageList, enquiryVo...:" + enquiryVo);

		int eno = enquiryService.modify(enquiryVo);
		rttr.addFlashAttribute("resultMod", eno);
		return "redirect:/hn/mypage/enqList";
	}

	// 삭제
	@PostMapping("/enqDel")
	public String enqDel(@RequestParam("eno") int eno, RedirectAttributes rttr) {
		boolean result = enquiryService.remove(eno);
		rttr.addFlashAttribute("resultDel", result);
		return "redirect:/hn/mypage/enqList";
	}

	// 선택 이미지 삭제
	@PostMapping("/deleteImage")
	public ResponseEntity<String> deleteImage(@RequestParam("uuid") String uuid) {
		boolean success = enquiryService.choiceImageDelete(uuid);
		if (success) {
			return ResponseEntity.ok("이미지가 성공적으로 삭제되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이미지 삭제 실패. 다시 시도해 주세요.");
		}
	}

	// 공지사항
	@GetMapping("/noticeList")
	public void noticeList(Model model, HnCriteria criteria) {
		List<NoticeVo> list = noticeService.getListNotice(criteria);
		model.addAttribute("noticeList", list);

		int total = noticeService.getTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		System.out.println("Criteria: " + criteria);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);

	}

	// 공지사항 상세보기
	@GetMapping("/noticeRead")
	public String notiveRead(@RequestParam("n_no") int n_no, Model model) {
		// 상세
		NoticeVo noticeVo = noticeService.selectByNno(n_no);
		model.addAttribute("noticeVo", noticeVo);
		// 이전게시글
		NoticeVo previousNotice = noticeService.getPreviousNotice(n_no);
		model.addAttribute("previousNotice", previousNotice);
		// 다음게시글
		NoticeVo nextNotice = noticeService.getNextNotice(n_no);
		model.addAttribute("nextNotice", nextNotice);

		return "hn/mypage/noticeRead";
	}

	// 자주하는질문
	@GetMapping("/faqList")
	public void questionList(Model model, HnCriteria criteria) {
		List<FaqVo> list = faqService.faqList(criteria);
		model.addAttribute("faqList", list);

		int total = faqService.getTotalCount(criteria);
		HnPageDto pageMaker = new HnPageDto(criteria, total);
		System.out.println("Criteria: " + criteria);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
	}

	// 회원정보 수정 전 비밀번호 체크 폼
	@GetMapping("/checkPw")
	public void checkPwForm() {

	}

	// 비밀번호 체크처리
	@PostMapping("/checkPw")
	public String checkPw(@RequestParam("user_pw") String user_pw, HttpSession session, RedirectAttributes rttr) {
		UserVo login = (UserVo) session.getAttribute("login");
		String user_id = login.getUser_id();

		HnUserDto dto = userService.checkPw(user_id);

		String sessionPw = dto != null ? dto.getUser_pw() : null;
		if (sessionPw != null && sessionPw.equals(user_pw)) {
			return "redirect:/hn/mypage/updateInfo";
		} else {
			rttr.addFlashAttribute("pwMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/hn/mypage/checkPw";
		}

	}

	// 회원정보수정폼
	@GetMapping("/updateInfo")
	public void updateInfo(Model model, HttpSession session) {
		UserVo login = (UserVo) session.getAttribute("login");
		String user_id = login.getUser_id();

		UserVo userVo = userService.userInfo(user_id);
		model.addAttribute("userInfo", userVo);
	}

	// 회원정보수정
	@PostMapping("/userInfoMod")
	public String userInfoMod(UserVo userVo, RedirectAttributes rttr) {
		boolean result = userService.userInfoMod(userVo);
		rttr.addFlashAttribute("infoMod", result);
		return "redirect:/hn/mypage/enqList";
	}

	// 회원정보 수정 전 비밀번호 체크
	@GetMapping("/loginConfirm")
	public void loginConfirm() {

	}

	// 회원탈퇴 전 로그인 인증
	@PostMapping("/loginConfirm")
	public String loginConfirm(@RequestParam("user_pw") String user_pw, HttpSession session, RedirectAttributes rttr) {
		UserVo login = (UserVo) session.getAttribute("login");
		String user_id = login.getUser_id();

		HnUserDto dto = userService.checkPw(user_id);

		String sessionPw = dto != null ? dto.getUser_pw() : null;
		if (sessionPw != null && sessionPw.equals(user_pw)) {
			return "redirect:/hn/mypage/unRegister";
		} else {
			rttr.addFlashAttribute("pwMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/hn/mypage/loginConfirm";
		}

	}
	
	// 회원탈퇴폼
	@GetMapping("/unRegister")
	public void unRegisterForm() {
	
	}
	
	// 회원탈퇴
	@PostMapping("/unRegister")
	public String unRegister(HttpSession session, RedirectAttributes rttr ) {
		UserVo login = (UserVo)session.getAttribute("login");
		String user_id = login.getUser_id();
		boolean result = userService.unRegister(user_id);
		session.invalidate();
		rttr.addFlashAttribute("unRegister",result);
		return "redirect:/ds/board/login";
	}

}
