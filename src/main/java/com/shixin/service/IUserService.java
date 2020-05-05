package com.shixin.service;

import com.shixin.entity.User;

/**
 * @author 今何许
 * @date 2020/4/30 11:47
 */
public interface IUserService {
    User checkUser(String loginName, String passWord);
}
