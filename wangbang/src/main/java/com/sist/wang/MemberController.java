package com.sist.wang;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.dao.MemberDAO;
import com.sist.manager.BeachManager;
import com.sist.vo.*;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private BeachManager bm;
	
	@RequestMapping("member/signup.do")
	public String member_signup(){
		return "signup";
	}
	
	@RequestMapping("member/logout_ok.do")
	public String member_logout_ok(HttpSession session){
		session.invalidate();
		return "redirect:../main/main.do";
	}
	
	@RequestMapping("member/member_over.do")
	public String member_over(String id, Model model){
		int res = 0;
		res = dao.overButton(id);
		model.addAttribute("res", res);
		return "over";
	}
	
	@RequestMapping("member/member_insert.do")
	public String member_insert(String id, String pwd, String name, Model model){
		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setPwd(pwd);
		vo.setName(name);
		
		dao.memberInsert(vo);
		return "redirect:../main/main.do";
	}
	
	@RequestMapping("member/fav_list.do")
	public String fav_list(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		List<FavVO> flist = dao.favList(id);
		for(FavVO vo : flist) {
			StringBuilder sb = new StringBuilder(vo.getLink());
			sb.append("?dataSid=");
			sb.append(vo.getDataSid());
			String link = sb.toString();
			vo.setLink(link);
		}
		model.addAttribute("flist", flist);
		return "member/fav_list";
	}
}
