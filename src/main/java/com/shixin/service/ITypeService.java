package com.shixin.service;

import com.shixin.entity.Type;
import com.shixin.entity.User;
import com.shixin.exception.SysException;

import java.util.List;

/**
 * @author 今何许
 * @date 2020/4/30 11:47
 */
public interface ITypeService {
    List<Type> lists();


    void save(String[] idArr, String[] sortArr, String[] nameArr);

    void delete(String[] idArr) throws SysException;
}
