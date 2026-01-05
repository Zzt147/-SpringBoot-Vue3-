package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.Tag;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TagMapper extends BaseMapper<Tag> {

    // 获取热门标签 (关联查询 t_article_tag 并统计)
    @Select("SELECT t.id, t.name, COUNT(at.tag_id) as count " +
            "FROM t_tag t " +
            "LEFT JOIN t_article_tag at ON t.id = at.tag_id " +
            "GROUP BY t.id " +
            "ORDER BY count DESC " +
            "LIMIT #{limit}")
    List<Tag> getHotTags(int limit);

    // 根据名字查 ID
    @Select("SELECT id FROM t_tag WHERE name = #{name}")
    Integer selectIdByName(String name);

    // 关联表操作
    // 2. 修改 insertRelation 方法，添加 @Param 注解
    @Insert("INSERT INTO t_article_tag (article_id, tag_id) VALUES (#{articleId}, #{tagId})")
    void insertRelation(@Param("articleId") Integer articleId, @Param("tagId") Integer tagId);

    @Delete("DELETE FROM t_article_tag WHERE article_id = #{articleId}")
    void deleteRelationByArticleId(Integer articleId);


}