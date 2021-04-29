package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.service.UserService;

@RestController
public class RestBoardController {
	
	@Autowired UserService us;
	
	
	
}
