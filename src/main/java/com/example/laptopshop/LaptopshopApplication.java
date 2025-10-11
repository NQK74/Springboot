package com.example.laptopshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

// @SpringBootApplication
//include >< exclude(ngoại trừ)
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class LaptopshopApplication {
	public static void main(String[] args) {

		// container
		ApplicationContext nqk74 = SpringApplication.run(LaptopshopApplication.class, args);
		for (String s : nqk74.getBeanDefinitionNames()) {
			System.out.println(s);
		}

	}
}
