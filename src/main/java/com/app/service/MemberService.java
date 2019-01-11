package com.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.app.dao.MemberDAO;
import com.app.dto.Member;

@Service
public class MemberService {
	@Autowired
	MemberDAO dao;

	public Member login(Member member) {
		Member mem = dao.login(member);
		return mem;
	}

	public void memberInsert(Member member) {
		dao.memberInsert(member);		
	}

	public int idCheck(String userid) {
		int n = dao.idCheck(userid);
		return n;
	}

	public void memberUpdate(Member member) {
		dao.memberUpdate(member);		
	}

	public int nameCheck(String username) {
		int n = dao.nameCheck(username);
		return n;
	}
}
