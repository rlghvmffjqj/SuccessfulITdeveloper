package com.certificate.pass.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.service.CategoryService;
import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.vo.Category;
import com.certificate.pass.vo.ConnectUser;
import com.certificate.pass.vo.Favorites;
import com.certificate.pass.vo.MainComments;
import com.certificate.pass.vo.MainContents;

@Controller
public class CategoryController {
	@Autowired CategoryService categoryService;
	@Autowired EmployeeService employeeService;
	
	@ResponseBody
	@PostMapping(value = "/category/topItems")
	public List<String> topItems() {
		return categoryService.topItems();
	}
	
	@ResponseBody
	@PostMapping(value = "/category/middleItems")
	public List<String> middleItems(String topItemsName) {
		return categoryService.middleItems(topItemsName);
	}
	
	@GetMapping("/category/{topItemsName}")
	public String topItemsMove(@PathVariable String topItemsName, Model model) {
		List<String> middleItemsNameList = categoryService.middleItems(topItemsName);
		
		model.addAttribute("topItemsName", topItemsName);
		if(middleItemsNameList.size() > 0) {
			model.addAttribute("middleItemsName", middleItemsNameList.get(0));
		} else {
			model.addAttribute("middleItemsName", "");
		}
		model.addAttribute("middleItemsNameList", middleItemsNameList);
		
		return "/category/CategoryList";
	}
	
	@ResponseBody
	@PostMapping(value = "/category")
	public Map<String, Object> Category(@ModelAttribute("search") MainContents search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<MainContents> list = new ArrayList<>(categoryService.getCategoryList(search));
		int totalCount = categoryService.getCategoryListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping("/category/{topItemsName}/{middleItemsName}")
	public String middleItemsMove(@PathVariable String topItemsName, @PathVariable String middleItemsName, Model model) {
		List<String> middleItemsNameList = categoryService.middleItems(topItemsName);
		model.addAttribute("middleItemsNameList", middleItemsNameList);
		model.addAttribute("middleItemsName", middleItemsName);
		model.addAttribute("topItemsName", topItemsName);
		return "/category/CategoryList";
	}
	
	@GetMapping("/category/categorySetting")
	public String categorySetting(Model model) {
		List<String> topMenu = categoryService.getTopMenuCategoryList();
		List<String> middleTopName = categoryService.getMiddleTopNameList();
		List<Category> middleMenu = categoryService.getMiddleMenuCategoryList();
		model.addAttribute("topMenu", topMenu);
		model.addAttribute("middleMenu", middleMenu);
		model.addAttribute("middleTopName",middleTopName);
		return "/category/CategorySetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/category/categorySettingSave")
	public String categorySetting(Category category, Principal principal) {
		category.setRegistrant(principal.getName());
		category.setRegistrationDate(categoryService.nowDate());
		
		categoryService.insertCategorySetting(category, principal);
		return "OK";
	}
	
	@PostMapping(value = "/category/categoryWrite")
	public String categoryWrite(String topItemsName, String middleItemsName, Model model) {
		model.addAttribute("viewType", "insert");
		model.addAttribute("topItemsName",topItemsName);
		model.addAttribute("middleItemsName",middleItemsName);
		
		return "/category/CategoryWrite";
	}
	
	@PostMapping(value = "/category/categoryUpdate")
	public String categoryUpdate(String topItemsName, String middleItemsName, int mainContentsKeyNum, Model model) {
		MainContents mainContents = categoryService.getMainContentsOne(mainContentsKeyNum);
		
		model.addAttribute("mainContents", mainContents);
		model.addAttribute("viewType", "update");
		model.addAttribute("topItemsName",topItemsName);
		model.addAttribute("middleItemsName",middleItemsName);
		return "/category/CategoryWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainContentsWrite")
	public Map<String, Object> mainContentsWrite(MainContents mainContents, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(principal.getName() != "admin" && !principal.getName().equals("admin")) {
			map.put("resault", "FALSE");
			return map;
		}
		mainContents.setMainContentsRegistrant(principal.getName());
		mainContents.setMainContentsRegistrationDate(categoryService.nowDate());
		map.put("mainContentsKeyNum", categoryService.insertMainContents(mainContents, principal));
		map.put("resault", categoryService.validation(mainContents));
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainContentsUpdate")
	public Map<String, Object> mainContentsUpdate(MainContents mainContents, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(principal.getName() != "admin" && !principal.getName().equals("admin")) {
			map.put("resault", "FALSE");
			return map;
		}
		mainContents.setMainContentsModifiedDate(principal.getName());
		mainContents.setMainContentsModifiedDate(categoryService.nowDate());
		
		map.put("mainContentsKeyNum", categoryService.updateMainContents(mainContents, principal));
		map.put("resault", categoryService.validation(mainContents));
		return map;
	}
	
	@GetMapping(value = "/category/mainContentsView")
	public String mainContentsView(int contentNumber, Principal principal, Model model, HttpServletRequest req) {
		ConnectUser connectUser = new ConnectUser();
		connectUser.setConnectUserIp(req.getRemoteAddr());
		connectUser.setConnectUserPort(req.getRemotePort());
		connectUser.setConnectUserDate(categoryService.nowDate());
		categoryService.insertConnectUser(connectUser);
		MainContents mainContents = categoryService.getMainContentsOne(contentNumber);
		List<MainComments> mainCommentsList = categoryService.getMainCommentsList(contentNumber, principal);
		int favoritesCount = categoryService.getFavoritesCount(contentNumber);
		Favorites favorites = new Favorites(); 
		favorites.setFavoritesIp(categoryService.getIpAddress(req));
		favorites.setMainContentsKeyNum(contentNumber);
		try {
			favorites.setUsersId(principal.getName());
		} catch (Exception e) {
			favorites.setUsersId("Guest");
		}
		boolean favoritesUsers = categoryService.getFavoritesUsers(favorites);
		
		categoryService.countPlus(contentNumber);
		model.addAttribute("mainContents", mainContents);
		model.addAttribute("mainContentsKeyNum", contentNumber);
		model.addAttribute("mainCommentsList", mainCommentsList);
		model.addAttribute("favoritesCount", favoritesCount);
		model.addAttribute("favoritesUsers", favoritesUsers);
		return "/category/CategoryView";
	}
	
	@ResponseBody
	@PostMapping(value = "/category/delete")
	public String mainContentsDelete(@RequestParam int[] chkList, Principal principal) {
		if(principal.getName() != "admin" && !principal.getName().equals("admin"))
			return "FALSE";
		return categoryService.delMainContents(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainComments")
	public String mainComments(MainComments mainComments, Principal principal) {
		try {
			mainComments.setMainCommentsRegistrant(principal.getName());
			mainComments.setMainCommentsRegistrationDate(categoryService.nowDate());
			mainComments.setMainCommentsId(principal.getName());
		} catch (Exception e) {}
		mainComments.setMainCommentsDate(categoryService.nowDate());
		return categoryService.insertMainComments(mainComments);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainCommentsReply")
	public String mainCommentsReply(MainComments mainComments, Integer mainCommentsKeyNum, Principal principal) {
		MainComments parentComment = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		mainComments.setMainCommentsParentKeyNum(parentComment.getMainCommentsKeyNum());
		mainComments.setMainContentsKeyNum(parentComment.getMainContentsKeyNum());
		mainComments.setMainCommentsDepth(parentComment.getMainCommentsDepth()+1);
		mainComments.setMainCommentsDate(categoryService.nowDate());
		mainComments.setMainCommentsFullPath(parentComment.getMainCommentsFullPath());
		
		try {
			mainComments.setMainCommentsRegistrant(principal.getName());
			mainComments.setMainCommentsRegistrationDate(categoryService.nowDate());
			mainComments.setMainCommentsIdDialog(principal.getName());
		} catch (Exception e) {}
		return categoryService.insertMainCommentsReply(mainComments);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainCommentsDelete")
	public String mainCommentsDelete(MainComments mainComments, Integer mainCommentsKeyNum, Principal principal) {
		MainComments parentComment = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		return categoryService.mainCommentsDelete(mainComments,parentComment, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainCommentsUpdateCheck")
	public String mainCommentsUpdateCheck(MainComments mainComments, Integer mainCommentsKeyNum, Principal principal) {
		MainComments parentComment = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		return categoryService.mainCommentsUpdateCheck(mainComments,parentComment, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainCommentsUserCheck")
	public String mainCommentsUpdateUserCheck(MainComments mainComments, Integer mainCommentsKeyNum, Principal principal) {
		MainComments parentComment = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		return categoryService.mainCommentsUserCheck(mainComments,parentComment, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/mainCommentsUpdate")
	public String mainCommentsUpdate(MainComments mainComments, Integer mainCommentsKeyNum) {
		MainComments parentComment = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		mainComments.setMainCommentsDate(categoryService.nowDate());
		return categoryService.mainCommentsUpdate(mainComments,parentComment);
	}
	
	@GetMapping(value = "/category/beforePageMove")
	public String beforePageMove(int contentNumber, Model model) {
		int mainContentsKeyNum;
		try {
			mainContentsKeyNum  = categoryService.beforePageMove(contentNumber);
		} catch (Exception e) {
			String loc = "/category/mainContentsView?contentNumber="+contentNumber;
			String msg = "이전 페이지가 존재 하지 않습니다.";

			model.addAttribute("loc", loc).addAttribute("msg", msg);
			return "common/msg";
		}
		return "redirect:/category/mainContentsView?contentNumber="+mainContentsKeyNum ;
	}
	
	@GetMapping(value = "/category/nextPageMove")
	public String nextPageMove(int contentNumber, Model model) {
		int mainContentsKeyNum;
		try {
			mainContentsKeyNum  = categoryService.nextPageMove(contentNumber);
		} catch (Exception e) {
			String loc = "/category/mainContentsView?contentNumber="+contentNumber;
			String msg = "다음 페이지가 존재 하지 않습니다.";

			model.addAttribute("loc", loc).addAttribute("msg", msg);
			return "common/msg";
		}
		return "redirect:/category/mainContentsView?contentNumber="+mainContentsKeyNum ;
	}
	
	@ResponseBody
	@PostMapping(value = "/category/favoritesPlus")
	public void favoritesPlus(int mainContentsKeyNum, Principal principal, HttpServletRequest req) {
		Favorites favorites = new Favorites();
		favorites.setFavoritesIp(categoryService.getIpAddress(req));
		favorites.setMainContentsKeyNum(mainContentsKeyNum);
		favorites.setFavoritesRegistrationDate(categoryService.nowDate());
		try {
			favorites.setUsersId(principal.getName());
			favorites.setFavoritesRegistrant(principal.getName());
		} catch (Exception e) {
			favorites.setUsersId("Guest");
			favorites.setFavoritesRegistrant("Guest");
		}
		categoryService.favoritesPlus(favorites);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/favoritesMinus")
	public void favoritesMinus(int mainContentsKeyNum, Principal principal, HttpServletRequest req) {
		Favorites favorites = new Favorites();
		favorites.setFavoritesIp(categoryService.getIpAddress(req));
		favorites.setMainContentsKeyNum(mainContentsKeyNum);
		try {
			favorites.setUsersId(principal.getName());
		} catch (Exception e) {
			favorites.setUsersId("Guest");
		}
		categoryService.favoritesMinus(favorites);
	}
	
	
	@GetMapping("/category/mainComments/{mainCommentsId}/{mainCommentsKeyNum}")
	public void  mainCommentsImg(HttpServletRequest request, HttpServletResponse response, Principal principal, @PathVariable String mainCommentsId, @PathVariable int mainCommentsKeyNum) throws ServletException, IOException {
		String imagePath = "";
		MainComments mainComments = categoryService.getMainCommentsOne(mainCommentsKeyNum);
		mainCommentsId = mainCommentsId.substring(3);
		EmployeeEntity employee = employeeService.getEmployeeOne(mainCommentsId);
		try {
			if(principal.getName().equals("admin")) {
				imagePath = categoryService.customImg(employee.getEmployeeId(), employee.getEmployeeImg());
			} else {
				if(mainComments.isMainCommentsSecret()) {
					if(mainCommentsId.equals(principal.getName()) || categoryService.getMainCommentsOne(mainComments.getMainCommentsParentKeyNum()).getMainCommentsRegistrant().equals(principal.getName())) {
						imagePath = categoryService.customImg(employee.getEmployeeId(), employee.getEmployeeImg());
					} else {
						imagePath = categoryService.basicImg();
					}
				} else {
					imagePath = categoryService.customImg(employee.getEmployeeId(), employee.getEmployeeImg());
				}
				if(employee.getEmployeeImg().isEmpty()) {
					imagePath = categoryService.basicImg();
				}
			}
		} catch (Exception e) {
			if(mainComments.isMainCommentsSecret() || employee == null) {
				imagePath = categoryService.basicImg();
			} else {
				imagePath = categoryService.customImg(employee.getEmployeeId(), employee.getEmployeeImg());
			}
		}
		File imageFile = new File(imagePath);
		
        byte[] imageBytes = Files.readAllBytes(imageFile.toPath());
        response.setContentType("image/jpeg"); 
        response.setContentLength(imageBytes.length);
        response.getOutputStream().write(imageBytes);
	}
	
	
	
	

}
