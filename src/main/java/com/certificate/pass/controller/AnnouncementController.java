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
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.AnnouncementService;
import com.certificate.pass.vo.Announcement;

@Controller
public class AnnouncementController {
	@Autowired AnnouncementService announcementService;
	
	@GetMapping("/announcementList")
	public String announcementList() {
		return "/announcement/AnnouncementList";
	}
	
	@ResponseBody
	@PostMapping(value = "/announcement")
	public Map<String, Object> announcement(@ModelAttribute("search") Announcement search, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<Announcement> list = new ArrayList<>(announcementService.getAnnouncementList(search));
		int totalCount = announcementService.getAnnouncementListCount();
		
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping("/announcementWrite")
	public String announcementWrite() {
		return "/announcement/AnnouncementWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/announcementWrite")
	public int insertAnnouncement(Announcement announcement,Principal principal) {
		announcement.setAnnouncementRegistrant(principal.getName());
		announcement.setAnnouncementRegistrationDate(announcementService.nowDate());
		announcement.setAnnouncementCount(0);
		return announcementService.insertAnnouncement(announcement);
	}
	
	@PostMapping("/announcementView")
	public String announcementView(Model model, int announcementKeyNum ) {
		announcementService.announcementCountPlus(announcementKeyNum);
		Announcement announcement = announcementService.getAnnouncementOne(announcementKeyNum );
		model.addAttribute("announcement", announcement);
		return "/announcement/AnnouncementView";
	}
	
	
	
}
