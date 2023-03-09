package com.certificate.pass.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.FreeBoardService;
import com.certificate.pass.vo.FreeBoard;
import com.certificate.pass.vo.FreeBoardComments;

@Controller
public class FreeBoardController {
	@Autowired FreeBoardService freeBoardService;

	@GetMapping("/freeBoard/freeBoardList")
	public String freeBoardList() {
		return "/freeBoard/FreeBoardList";
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard")
	public Map<String, Object> freeBoard(@ModelAttribute("search") FreeBoard search, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<FreeBoard> list = new ArrayList<>(freeBoardService.getFreeBoardList(search));
		int totalCount = freeBoardService.getFreeBoardListCount(search);
		
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping("/freeBoard/freeBoardWrite")
	public String freeBoardWrite(Model model) {
		model.addAttribute("viewType", "insert");
		return "/freeBoard/FreeBoardWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardWrite")
	public int insertFreeBoard(FreeBoard freeBoard, Principal principal) {
		freeBoard.setFreeBoardRegistrant(principal.getName());
		freeBoard.setFreeBoardRegistrationDate(freeBoardService.nowDate());
		freeBoard.setFreeBoardUserId(principal.getName());
		freeBoard.setFreeBoardDate(freeBoardService.nowDate());
		
		return freeBoardService.insertFreeBoard(freeBoard);
	}
	
	@GetMapping("/freeBoard/freeBoardView")
	public String freeBoardView(Model model, int contentNumber, Principal principal) {
		FreeBoard freeBoard = freeBoardService.getFreeBoardOne(contentNumber);
		ArrayList<FreeBoardComments> freeBoardCommentsList = new ArrayList<>(freeBoardService.getFreeBoardComments(contentNumber, principal));
		String certification = "notAllowed";
		try {
			if(freeBoard.getFreeBoardUserId().equals(principal.getName()) || principal.getName().equals("admin")) {
				certification = "allowed";
			}
		} catch (Exception e) {}
		freeBoardService.countPlus(contentNumber);
		
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("freeBoardKeyNum", contentNumber);
		model.addAttribute("certification", certification);
		model.addAttribute("freeBoardCommentsList", freeBoardCommentsList);
		return "/freeBoard/FreeBoardView";
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardComments")
	public String freeBoardComments(FreeBoardComments freeBoardComments, Principal principal) {
		try {
			freeBoardComments.setFreeBoardCommentsRegistrant(principal.getName());
			freeBoardComments.setFreeBoardCommentsRegistrationDate(freeBoardService.nowDate());
		} catch (Exception e) {}
		freeBoardComments.setFreeBoardCommentsDate(freeBoardService.nowDate());
		return freeBoardService.insertFreeBoardComments(freeBoardComments);
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardCommentsReply")
	public String freeBoardCommentsReply(FreeBoardComments freeBoardComments, Integer freeBoardCommentsKeyNum, Principal principal) {
		FreeBoardComments parentComment = freeBoardService.getFreeBoardCommentsOne(freeBoardCommentsKeyNum);
		freeBoardComments.setFreeBoardCommentsParentKeyNum(parentComment.getFreeBoardCommentsKeyNum());
		freeBoardComments.setFreeBoardKeyNum(parentComment.getFreeBoardKeyNum());
		freeBoardComments.setFreeBoardCommentsDepth(parentComment.getFreeBoardCommentsDepth()+1);
		freeBoardComments.setFreeBoardCommentsDate(freeBoardService.nowDate());
		
		try {
			freeBoardComments.setFreeBoardCommentsRegistrant(principal.getName());
			freeBoardComments.setFreeBoardCommentsRegistrationDate(freeBoardService.nowDate());
		}catch (Exception e) {}
		return freeBoardService.insertFreeBoardCommentsReply(freeBoardComments);
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardCommentsDelete")
	public String freeBoardCommentsDelete(FreeBoardComments freeBoardComments, Integer freeBoardCommentsKeyNum) {
		FreeBoardComments parentComment = freeBoardService.getFreeBoardCommentsOne(freeBoardCommentsKeyNum);
		return freeBoardService.freeBoardCommentsDelete(freeBoardComments,parentComment);
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardCommentsUpdateCheck")
	public String freeBoardCommentsUpdateCheck(FreeBoardComments freeBoardComments, Integer freeBoardCommentsKeyNum) {
		FreeBoardComments parentComment = freeBoardService.getFreeBoardCommentsOne(freeBoardCommentsKeyNum);
		return freeBoardService.freeBoardCommentsUpdateCheck(freeBoardComments,parentComment);
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardCommentsUpdate")
	public String freeBoardCommentsUpdate(FreeBoardComments freeBoardComments, Integer freeBoardCommentsKeyNum) {
		FreeBoardComments parentComment = freeBoardService.getFreeBoardCommentsOne(freeBoardCommentsKeyNum);
		freeBoardComments.setFreeBoardCommentsDate(freeBoardService.nowDate());
		return freeBoardService.freeBoardCommentsUpdate(freeBoardComments,parentComment);
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/delete")
	public String freeBoardDelete(@RequestParam int freeBoardKeyNum, Principal principal) {
		return freeBoardService.freeBoardDelete(freeBoardKeyNum);
	}
	
	@PostMapping(value = "/freeBoard/freeBoardUpdateWrite")
	public String freeBoardUpdate(int freeBoardKeyNum, Model model) {
		FreeBoard freeBoard = freeBoardService.getFreeBoardOne(freeBoardKeyNum);
		
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("viewType", "update");
		return "/freeBoard/FreeBoardWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/freeBoard/freeBoardUpdate")
	public int freeBoardUpdate(FreeBoard freeBoard, Principal principal) {
		freeBoard.setFreeBoardModifiedDate(principal.getName());
		freeBoard.setFreeBoardModifiedDate(freeBoardService.nowDate());
		
		return freeBoardService.updateFreeBoard(freeBoard, principal);
	}
	
}
