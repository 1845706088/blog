package com.shixin.service;

import com.shixin.entity.Article;

import java.util.List;
import java.util.Map;

/**
 * @author 今何许
 * @date 2020/4/30 11:47
 */
public interface IArticleService {

    Article selectById(String id);

    void insert(Article article);

    void update(Article article);

    List<Article> list(Map<String, Object> param);


    void batchUpdate(Map<String, Object> param);

    void batchDelete(String[] idArr);


    int countByTypeId(String[] idArr, String s);

    void batchDeleteByTypeId(String[] idArr);
}
