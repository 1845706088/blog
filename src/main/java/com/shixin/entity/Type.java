package com.shixin.entity;

import java.io.Serializable;

/**
 * @author 今何许
 * @date 2020/5/1 17:09
 * 文章分类
 */
public class Type implements Serializable {
    private String id;
    private String typeName;
    private String sort;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }
}
