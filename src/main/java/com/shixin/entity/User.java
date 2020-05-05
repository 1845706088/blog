package com.shixin.entity;

import java.io.Serializable;

/**
 * @author 今何许
 * @date 2020/4/30 11:08
 */
public class User implements Serializable {
    private Integer id;
    private String loginName;
    private String passWord;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }
}
