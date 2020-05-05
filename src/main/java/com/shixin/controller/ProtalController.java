package com.shixin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 今何许
 * @date 2020/5/4 下午9:20
 */
@Controller
@RequestMapping("/protal")
public class ProtalController {
    @RequestMapping("/index")
    public String index() {

        return "protal/index";
    }
}
