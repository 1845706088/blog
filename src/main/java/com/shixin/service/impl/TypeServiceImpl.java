package com.shixin.service.impl;

import com.shixin.dao.ITypeDao;
import com.shixin.dao.IUserDao;
import com.shixin.entity.Type;
import com.shixin.entity.User;
import com.shixin.exception.SysException;
import com.shixin.service.IArticleService;
import com.shixin.service.ITypeService;
import com.shixin.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @author 今何许
 * @date 2020/4/30 11:49
 */
@Service("typeService")
public class TypeServiceImpl implements ITypeService {
    @Autowired
    private ITypeDao typeDao;
    @Autowired
    private IArticleService iArticleService;


    @Override
    public List<Type> lists() {
        return typeDao.lists();
    }

    @Override
    public void save(String[] idArr, String[] sortArr, String[] nameArr) {
        for (int i = 0; i < idArr.length; i++) {
            if (StringUtils.isEmpty(idArr[i])) {
                typeDao.insert(sortArr[i], nameArr[i]);
            } else {
                typeDao.update(idArr[i], sortArr[i], nameArr[i]);
            }
        }

    }

    @Override
    public void delete(String[] idArr) throws SysException {
        int count = iArticleService.countByTypeId(idArr, "1");
        if (count > 0) {
            throw new SysException("该分类下有文章，无法删除");
        }
        iArticleService.batchDeleteByTypeId(idArr);
        typeDao.delete(idArr);
    }

}
