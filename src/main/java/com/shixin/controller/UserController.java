package com.shixin.controller;

import com.shixin.entity.Result;
import com.shixin.entity.User;
import com.shixin.exception.SysException;
import com.shixin.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author 今何许
 * @date 2020/4/30 11:57
 */
@Controller
@RequestMapping("/admin")
public class UserController {
    @Autowired
    private IUserService iUserService;

    @RequestMapping("/index")
    public String index() {

        return "admin/index";
    }

    @RequestMapping("/login")
    public String login() {

        return "admin/login";
    }

    @RequestMapping("/login_out")
    public String loginOut(HttpSession session) {
        session.invalidate();
        return "admin/login";
    }

    @RequestMapping("/login.json")
    public @ResponseBody
    Result login(HttpServletRequest request) throws SysException {
        String loginName = request.getParameter("loginName");
        String password = request.getParameter("password");
        if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(password)) {
            throw new SysException("用户名或密码不能为空");
        }
        User user = iUserService.checkUser(loginName, password);
        if (user == null) {
            throw new SysException("用户名或密码不正确");
        }
        request.getSession().setAttribute("user", user);
        return Result.success();
    }
}
