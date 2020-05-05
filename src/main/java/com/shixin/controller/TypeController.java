package com.shixin.controller;

import com.shixin.entity.Result;
import com.shixin.entity.Type;
import com.shixin.entity.User;
import com.shixin.exception.SysException;
import com.shixin.service.IArticleService;
import com.shixin.service.ITypeService;
import com.shixin.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author 今何许
 * @date 2020/4/30 11:57
 */
@Controller
@RequestMapping("/type")
public class TypeController {
    @Autowired
    private ITypeService iTypeService;

    @RequestMapping("/list")
    public String lists(ModelMap map) {
        List<Type> lists = iTypeService.lists();
        map.put("list", lists);
        return "admin/type/list";
    }

    @RequestMapping("/save.json")
    public @ResponseBody
    Result save(@RequestParam("idArr") String[] idArr,
                @RequestParam("sortArr") String[] sortArr,
                @RequestParam("nameArr") String[] nameArr) {
        iTypeService.save(idArr, sortArr, nameArr);
        return Result.success();
    }

    @RequestMapping("/delete.json")
    public @ResponseBody
    Result delete(@RequestParam("idArr") String[] idArr) throws SysException {
        iTypeService.delete(idArr);
        return Result.success();
    }

}
