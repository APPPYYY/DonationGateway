package com.razorpay.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {

	@RequestMapping("/donation")
	public String getDonation() {
		return "donation";
	}
}
