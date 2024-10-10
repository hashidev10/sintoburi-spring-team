package com.kh.sintoburi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.sintoburi.domain.common.UserVo;


public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override //로그인 체크 -- 체크후에 로그인을 요청한 페이지를 등록후 
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();

		UserVo login_user = (UserVo)session.getAttribute("login");

		System.out.println("동기컷팅작용");
		if(login_user == null) {
			System.out.println("로그인 감지");
			String uri = request.getRequestURI(); // ? 앞에 문자열
			String query = request.getQueryString(); // ? 뒤에 문자열
			if(query != null && !query.equals("")) {
				query = "?" + query;
				System.out.println("합쳐진 쿼리는" + query);
			} else {
				query = "";
			}
			String realPath = uri + query;
			// AJAX 요청인지 확인
	        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
	        	System.out.println("비동기 확인 401헤드 삽입");
	            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            response.getWriter().write("Login required");
	            return false; // 요청을 더 이상 처리하지 않음
	        } else {
	        	session.setAttribute("targetLocation", realPath);
	        	System.out.println("지금 바라보고있는 패스는?" + realPath);
	        	if(realPath.startsWith("/hn/manager") || realPath.startsWith("/hn/mypage")) {
	        		response.sendRedirect("/hn/main/login");
	        	}else {
	        		response.sendRedirect("/ds/board/login");
	        	}
	            return false; // 요청을 더 이상 처리하지 않음
	        }
		} 
		
		return true;
	}
	
	

}
