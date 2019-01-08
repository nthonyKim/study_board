package com.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.app.dto.Member;
import com.app.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@RequestMapping("/login")
	public String login(Member member, HttpSession session, RedirectAttributes red) {
		Member mem = service.login(member);
		System.out.println("login "+mem);
		
		if(mem == null) {
			red.addFlashAttribute("mesg","아이디 또는 비밀번호를 재확인 해주세요.");
			return "redirect:loginForm";
		}else {
			session.setAttribute("user", mem);
			System.out.println("세션에 login 저장 "+mem);
			return "redirect:/";
		}
	}
		
	@RequestMapping(value="/memberInsert", method=RequestMethod.POST)
	public String memberInsert(Member member, RedirectAttributes red) {
		System.out.println("회원가입 성공: "+member);		
		service.memberInsert(member);
		red.addFlashAttribute("mesg","회원가입에 성공했습니다.");		
		return "redirect:loginForm";
	}
	
	@RequestMapping(value="/idCheck", produces="application/text; charset=UTF-8")
	public @ResponseBody String idCheck(@RequestParam String userid) {
		String mesg = "아이디 사용가능";
		int n = service.idCheck(userid);
		if(n != 0) {
			mesg = "아이디 중복";
		}
		return mesg;		
	}	
	
	@RequestMapping("/loginCheck/mypage")
	public String mypage(HttpSession session) {
		Member mem = (Member) session.getAttribute("user");
		return "redirect:../myPage";
	}
	
	@RequestMapping("/loginCheck/memberUpdate")
	public String memberUpdate(Member member, RedirectAttributes red) {
		System.out.println(member);
		service.memberUpdate(member);		
		red.addFlashAttribute("mesg", "수정했습니다.");
		return "redirect:../loginForm";
	}
	
	@RequestMapping("/loginCheck/logout")
	public String logout(HttpSession session ) {							
		session.invalidate();		
		return "redirect:../boardList";
	}
	
}//
