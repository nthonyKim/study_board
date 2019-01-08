package com.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.app.dto.Member;

@Repository
public class MemberDAO {
	@Autowired
	SqlSessionTemplate template;

	public Member login(Member member) {
		Member mem = template.selectOne("MemberMapper.login", member);
		return mem;
	}

	public void memberInsert(Member member) {
		int n = template.insert("MemberMapper.memberInsert", member);		
	}

	public int idCheck(String userid) {
		int n = template.selectOne("MemberMapper.idCheck", userid);
		return n;
	}

	public void memberUpdate(Member member) {
		int n = template.update("MemberMapper.memberUpdate", member);		
	}

}
