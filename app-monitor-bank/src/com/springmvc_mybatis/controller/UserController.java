package com.springmvc_mybatis.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.mapper.UserMapper;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserMapper usermapper;

	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		User user_login = usermapper.login(name, password);
		System.out.println(user_login);
		if (user_login == null) {
			System.out.println("Error login!");
			return "fail";
		} else {
			model.addAttribute("user", user_login);
			return "success";
		}
	}

	@RequestMapping("/list")
	public String getAllUsers(Model model) {
		List<User> users = usermapper.getAllUsers();
		model.addAttribute("users", users);
		System.out.println(users);
		return "list";

	}

}
