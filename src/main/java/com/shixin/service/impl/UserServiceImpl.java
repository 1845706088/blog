package com.shixin.service.impl;

import com.shixin.dao.IUserDao;
import com.shixin.entity.User;
import com.shixin.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 今何许
 * @date 2020/4/30 11:49
 */
@Service("userService")
public class UserServiceImpl implements IUserService {
    @Autowired
    private IUserDao iUserDao;

    @Override
    public User checkUser(String loginName, String passWord) {

        return iUserDao.checkUser(loginName, passWord);
    }
}
