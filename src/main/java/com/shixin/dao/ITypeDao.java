package com.shixin.dao;

import com.shixin.entity.Type;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author 今何许
 * @date 2020/5/1 17:12
 */
@Repository
public interface ITypeDao {
    /*查询所有文章分类*/
    @Select("select * from type order by sort")
    List<Type> lists();

    @Insert("insert into type(sort,typename)  values(#{sort},#{name})")
    void insert(@Param("sort") String sort, @Param("name") String name);

    @Update("update type set sort=#{sort},typename=#{name} where id=#{id}")
    void update(@Param("id") String id, @Param("sort") String sort, @Param("name") String name);

    @Delete("<script>" +
            " delete from type where id in " +
            "<foreach collection='idArr' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script> ")
    void delete(@Param("idArr") String[] idArr);
}
