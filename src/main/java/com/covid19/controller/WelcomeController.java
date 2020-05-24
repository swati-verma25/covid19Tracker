package com.covid19.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeController {

	
	@RequestMapping("/")
	public String welcome(Model model) {
		//model.put("message", this.message);
		return "welcome";
	}
}
