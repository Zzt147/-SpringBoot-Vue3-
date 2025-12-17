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

@Mapper
public interface ArticleMapper extends BaseMapper<Article> {
    // 使用 LEFT JOIN 替代原来的逗号连接，更加安全
    @Select("SELECT t_article.id, t_article.title, t_article.created, t_article.categories, t_statistic.hits " +
            " FROM t_article LEFT JOIN t_statistic ON t_article.id = t_statistic.article_id " +
            " ${ew.customSqlSegment} ")
    IPage<ArticleVO> getAPageOfArticleVO(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // 具体的sql见xml包中的ArticleMapper.xml
    public List<Article> getAPage(
            @Param("offset")long offset,
            @Param("size")long size);

    @Select("SELECT * FROM t_article ${ew.customSqlSegment}")
    IPage<Article> getAPageOfArticle(IPage<Article> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    @Select("SELECT a.id, a.title, a.created, a.categories, s.hits " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "${ew.customSqlSegment}")
    IPage<ArticleVO> articleSearch(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);
}