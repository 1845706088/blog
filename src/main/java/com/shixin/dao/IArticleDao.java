package com.shixin.dao;

import com.shixin.entity.Article;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author 今何许
 * @date 2020/5/1 17:12
 */
@Repository
public interface IArticleDao {
    /*查询所有文章分类*/
    @Select(value = {"<script> " +
            "select a.id,t.typename,a.title,a.view_count,a.update_time from article a,type t" +
            " where  a.type_id=t.id " +
            "<if test='status!=null and status!=\"\"'>AND a.status=#{status}</if> " +
            "<if test = 'typeId!=null and typeId!=\"\"'> AND a.type_id =#{typeId}</if>" +
            "<if test = 'startDate!=null and startDate!=\"\"' > AND a.update_time between #{startDate}AND #{endDate}</if>" +
            "<if test = 'title!=null and title!=\"\"' > AND a.title like #{title}</if> " +
            "order by a.update_time DESC " +
            "</script>"})
    @Results(id = "resultMap", value = {
            @Result(id = true, column = "id", property = "id"),
            @Result(column = "title", property = "title"),
            @Result(column = "content", property = "content"),
            @Result(column = "content_text", property = "contentText"),
            @Result(column = "cover", property = "cover"),
            @Result(column = "view_count", property = "viewCount"),
            @Result(column = "update_time", property = "updateTime"),
            @Result(column = "status", property = "status"),
            @Result(column = "type_id", property = "typeId"),
            @Result(column = "typename", property = "typeName")
    })
    List<Article> list(Map<String, Object> param);

    @ResultMap("resultMap")
    @Select("SELECT * FROM article WHERE id=#{id}")
    Article selectById(String id);

    @Insert("insert into article(title,content,content_text,type_id,cover,view_count,update_time,status) values(#{title},#{content},#{contentText},#{typeId},#{cover},#{viewCount},#{updateTime},#{status})")
    void insert(Article article);

    @Update("update article set title=#{title},content=#{content},content_text=#{contentText},type_id=#{typeId},cover=#{cover},view_count=#{viewCount},update_time=#{updateTime},status=#{status} where id=#{id}")
    void update(Article article);


    @Update("<script>" +
            "update article set" +
            "<if test='typeId!=null and typeId!=\"\"'> type_id=#{typeId}</if>" +
            "<if test='status!=null and status!=\"\"'> status=#{status}</if>" +
            "where id in " +
            "<foreach collection='idArr' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script>")
    void batchUpdate(Map<String, Object> param);

    @Delete("<script>" +
            "delete from article where id in" +
            "<foreach collection='array' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script>")
    void batchDelete(String[] idArr);

    @Select("<script>" +
            "select count(*) from article where status=#{s} AND type_id in" +
            "<foreach collection='idArr' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script>")
    int countByTypeId(@Param("idArr") String[] idArr, @Param("s") String s);

    @Delete("<script>" +
            "delete from article where type_id in" +
            "<foreach collection='idArr' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script>")
    void batchDeleteByTypeId(@Param("idArr") String[] idArr);
}
