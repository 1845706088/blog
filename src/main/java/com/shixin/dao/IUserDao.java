package com.shixin.dao;

import com.shixin.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

/**
 * @author 今何许
 * @date 2020/4/30 11:10
 */
@Repository
public interface IUserDao {
    @Select("select * from user  where  login_name=#{loginName} and pass_word=#{passWord} ")
    @Results(value = {
            @Result(id = true, column = "id", property = "id"),
            @Result(column = "login_name", property = "loginName"),
            @Result(column = "pass_word", property = "passWord")
    })
    User checkUser(@Param("loginName") String loginName, @Param("passWord") String passWord);
}
