package llp.spring.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface ArticleMapper extends BaseMapper<Article> {

    @Select("SELECT t_article.id, t_article.title, t_article.created, t_article.categories, t_statistic.hits " +
            " FROM t_article LEFT JOIN t_statistic ON t_article.id = t_statistic.article_id " +
            " ${ew.customSqlSegment} ")
    IPage<ArticleVO> getAPageOfArticleVO(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    public List<Article> getAPage(@Param("offset")long offset, @Param("size")long size);

    @Select("SELECT a.id, a.title, a.content, a.created, a.categories, a.thumbnail, u.username AS authorName, s.hits " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "LEFT JOIN t_user u ON a.user_id = u.id " +
            "${ew.customSqlSegment}")
    IPage<ArticleVO> articleSearch(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    @Select("SELECT t_article.id, t_article.user_id, t_article.title, t_article.content, " +
            "t_article.created, t_article.modified, t_article.categories, t_article.tags, " +
            "t_article.thumbnail, t_article.allow_comment, " +
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
}