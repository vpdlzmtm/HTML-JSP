package com.hrd.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm(Locale locale, Model model) {		
		
		return "loginForm";
	}
	
	@RequestMapping(value = "/home", method = {RequestMethod.GET, RequestMethod.POST })
	public String home(Locale locale, Model model) {		
		
		return "index_home_menu_css";
	}
	
	
	
	@RequestMapping(value = "/login/login_home_menu", method = {RequestMethod.GET, RequestMethod.POST })
	public String login_home_menu(Locale locale, Model model) {		
		
		return "login_home_menu";
	}
	
	@RequestMapping(value = "/login/loginProcess", method = {RequestMethod.GET, RequestMethod.POST })
	public String loginProcess(Locale locale, Model model) {		
		
		return "loginProcess"; 
	}
	
	@RequestMapping(value = "/login/memList", method = {RequestMethod.GET, RequestMethod.POST })
	public String memList(Locale locale, Model model) {		
		
		return "memList"; 
	}
	
	@RequestMapping(value = "/login/login_home_menu_css", method = {RequestMethod.GET, RequestMethod.POST })
	public String home_menu(Locale locale, Model model) {		
		
		return "login_home_menu_css"; 
	}
	
	@RequestMapping(value = "/login/login_home", method = {RequestMethod.GET, RequestMethod.POST })
	public String login_home(Locale locale, Model model) {		
		
		return "login_home"; 
	}	
	
	@RequestMapping(value = "/login/writeplace", method = {RequestMethod.GET, RequestMethod.POST })
	public String writeplace(Locale locale, Model model) {		
		
		return "writeplace"; 
	}	
	
	
	
	
	
	

}
