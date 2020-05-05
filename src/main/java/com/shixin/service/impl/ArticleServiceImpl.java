package com.shixin.service.impl;

import com.shixin.dao.IArticleDao;
import com.shixin.entity.Article;
import com.shixin.service.IArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 今何许
 * @date 2020/4/30 11:49
 */
@Service("articleService")
public class ArticleServiceImpl implements IArticleService {
    @Autowired
    private IArticleDao iArticleDao;


    @Override
    public Article selectById(String id) {
        return iArticleDao.selectById(id);
    }

    @Override
    public void insert(Article article) {
        iArticleDao.insert(article);
    }

    @Override
    public void update(Article article) {
        iArticleDao.update(article);
    }

    @Override
    public List<Article> list(Map<String, Object> param) {
        return iArticleDao.list(param);
    }

    @Override
    public void batchUpdate(Map<String, Object> param) {
        iArticleDao.batchUpdate(param);
    }

    @Override
    public void batchDelete(String[] idArr) {
        iArticleDao.batchDelete(idArr);
    }

    @Override
    public int countByTypeId(String[] idArr, String s) {
        return iArticleDao.countByTypeId(idArr,s);
    }

    @Override
    public void batchDeleteByTypeId(String[] idArr) {
        iArticleDao.batchDeleteByTypeId(idArr);
    }


}
