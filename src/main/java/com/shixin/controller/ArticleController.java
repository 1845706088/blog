package com.shixin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shixin.entity.Article;
import com.shixin.entity.Result;
import com.shixin.service.IArticleService;
import com.shixin.service.ITypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 今何许
 * @date 2020/4/30 11:57
 */
@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private IArticleService iArticleService;
    @Autowired
    private ITypeService iTypeService;

    @RequestMapping("/articles")
    public String articles(ModelMap map,
                           @RequestParam(required = false, value = "typeId") String typeId,
                           @RequestParam(required = false, value = "startDate") String startDate,
                           @RequestParam(required = false, value = "endDate") String endDate,
                           @RequestParam(required = false, value = "title") String title,
                           @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                           @RequestParam(value = "pageSize", defaultValue = "3") int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("typeId", typeId);
        param.put("startDate", startDate);
        param.put("endDate", endDate);
        if (!StringUtils.isEmpty(title)) {
            title = "%" + title.trim() + "%";
        }
        param.put("title", title);
        param.put("status", "1");
        List<Article> list = iArticleService.list(param);
        PageInfo<Article> pageInfo = new PageInfo<>(list);
        map.put("pageInfo", pageInfo);
        map.put("list", iTypeService.lists());
        return "admin/article/articles";
    }

    @RequestMapping("/recycle")
    public String recycle(ModelMap map,
                          @RequestParam(required = false, value = "typeId") String typeId,
                          @RequestParam(required = false, value = "startDate") String startDate,
                          @RequestParam(required = false, value = "endDate") String endDate,
                          @RequestParam(required = false, value = "title") String title,
                          @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                          @RequestParam(value = "pageSize", defaultValue = "3") int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("typeId", typeId);
        param.put("startDate", startDate);
        param.put("endDate", endDate);
        if (!StringUtils.isEmpty(title)) {
            title = "%" + title.trim() + "%";
        }
        param.put("title", title);
        param.put("status", "0");
        List<Article> list = iArticleService.list(param);
        PageInfo<Article> pageInfo = new PageInfo<>(list);
        map.put("pageInfo", pageInfo);
        map.put("list", iTypeService.lists());
        return "admin/article/recycle";
    }

    @RequestMapping("/edit")
    public String edit(ModelMap map, @RequestParam(required = false, value = "id") String id) {
        if (!StringUtils.isEmpty(id)) {
            Article article = iArticleService.selectById(id);
            map.put("article", article);
        }
        map.put("list", iTypeService.lists());
        map.put("id", id);
        return "admin/article/edit";
    }

    @RequestMapping("/upload.json")
    @ResponseBody
    public Result upload(HttpServletRequest request, MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String newFileName = "";
        String filePath = "";
        if (file != null && originalFilename != null && originalFilename.length() > 0) {
            filePath = "D:\\upload\\";
            File f = new File(filePath);
            if (!f.exists()) {
                f.mkdirs();
            }
            newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
            File file1 = new File(filePath + newFileName);
            file.transferTo(file1);
        }
        return Result.success().add("imgUrl", "/upload/" + newFileName);
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public Result save(Article article) {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = format.format(date);
        if (StringUtils.isEmpty(article.getId())) {
            article.setStatus(1);
            article.setUpdateTime(dateString);
            article.setViewCount(1);
            iArticleService.insert(article);
        } else {
            article.setUpdateTime(dateString);
            Article a = iArticleService.selectById(article.getId());
            article.setStatus(a.getStatus());
            if (article.getCover() == "") {
                article.setCover(a.getCover());
            }
            article.setViewCount(a.getViewCount());
            iArticleService.update(article);
        }
        return Result.success();
    }

    @RequestMapping("/move.json")
    @ResponseBody
    public Result updateTypeId(@RequestParam(value = "idArr") String[] idArr,
                               @RequestParam(value = "typeId") String typeId) {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("typeId", typeId);
        param.put("idArr", idArr);
        iArticleService.batchUpdate(param);
        return Result.success();
    }

    /*回收站*/
    @RequestMapping("/update_status.json")
    @ResponseBody
    public Result recycle(@RequestParam(value = "idArr") String[] idArr,
                          @RequestParam(value = "status") String status) {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("status", status);
        param.put("idArr", idArr);
        iArticleService.batchUpdate(param);
        return Result.success();
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public Result delete(@RequestParam(value = "idArr") String[] idArr) {
        iArticleService.batchDelete(idArr);
        return Result.success();
    }

}
