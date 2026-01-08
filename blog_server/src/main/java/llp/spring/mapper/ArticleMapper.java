package llp.spring.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.entity.Article;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface ArticleMapper extends BaseMapper<Article> {

    @Select("SELECT t_article.id, t_article.title, t_article.created, t_article.categories, t_statistic.hits " +
            " FROM t_article LEFT JOIN t_statistic ON t_article.id = t_statistic.article_id " +
            " ${ew.customSqlSegment} ")
    IPage<ArticleVO> getAPageOfArticleVO(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    public List<Article> getAPage(@Param("offset")long offset, @Param("size")long size);

    // 找到 articleSearch 方法，替换 @Select 注解的内容
    @Select("SELECT a.id, a.title, a.content, a.created, a.categories, " +
            "a.thumbnail, a.location, " +  // 1. 添加 thumbnail 和 location
            "u.username AS authorName, " +
            "u.username AS author, " +     // 2. 添加 author 别名，解决匿名问题
            "s.hits, IFNULL(s.likes, 0) AS likes " + // 3. 顺便补全 likes
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "LEFT JOIN t_user u ON a.user_id = u.id " +
            "${ew.customSqlSegment}")
    IPage<ArticleVO> articleSearch(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    @Select("SELECT t_article.id, t_article.user_id, t_article.title, t_article.content, " +
            "t_article.created, t_article.modified, t_article.categories, t_article.tags, " +
            "t_article.thumbnail, t_article.allow_comment, " +
            "t_article.location, " + // ✅ 【新增】添加这一行，查询定位字段
            "t_user.username AS authorName, " +
            "IFNULL(s.likes, 0) AS likes " +
            "FROM t_article " +
            "LEFT JOIN t_user ON t_article.user_id = t_user.id " +
            "LEFT JOIN t_statistic s ON t_article.id = s.article_id " +
            "${ew.customSqlSegment}")
    IPage<Article> getAPageOfArticle(IPage<Article> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // === 【新增】按分类统计文章数量 (用于仪表盘) ===
    @Select("SELECT categories AS name, COUNT(*) AS value FROM t_article GROUP BY categories")
    List<Map<String, Object>> getArticleCountByCategory();

    // === 【新增】获取所有文章的标签 (用于标签云/仪表盘) ===
    @Select("SELECT tags FROM t_article")
    List<String> getAllTags();

    // 【修改】获取点赞排行榜 (确保查询了 likes 字段)
    @Select("SELECT a.id, a.title, IFNULL(s.likes, 0) AS likes, IFNULL(s.hits, 0) AS hits " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "ORDER BY s.likes DESC LIMIT 10")
    List<ArticleVO> getLikeRanking();

    // 【新增】文章点赞相关
    @Select("SELECT COUNT(*) FROM t_article_like WHERE user_id = #{userId} AND article_id = #{articleId}")
    Integer countArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    @Insert("INSERT INTO t_article_like (user_id, article_id) VALUES (#{userId}, #{articleId})")
    void insertArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    @Delete("DELETE FROM t_article_like WHERE user_id = #{userId} AND article_id = #{articleId}")
    void deleteArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    // 【新增】获取我点赞的文章
    @Select("SELECT a.id, a.title, a.created, a.categories, IFNULL(s.hits, 0) AS hits, IFNULL(s.likes, 0) AS likes " +
            "FROM t_article a " +
            "JOIN t_article_like l ON a.id = l.article_id " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "WHERE l.user_id = #{userId} ORDER BY l.id DESC")
    List<ArticleVO> getMyLikedArticles(@Param("userId") Integer userId);
}