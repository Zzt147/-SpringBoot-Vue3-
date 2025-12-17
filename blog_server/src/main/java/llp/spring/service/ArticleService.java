package llp.spring.service;

import llp.spring.entity.Article;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import org.springframework.web.multipart.MultipartFile;

import java.lang.reflect.Parameter;

public interface ArticleService {
    public void publish(Article article);
    public String upload(MultipartFile file);
    public Result getArticleAndFirstPageCommentByArticleId (Integer articleId, PageParams pageParams);
    public Result getAPageOfArticleVO( PageParams pageParams, String type);
    public void update(Article article);
    public Article selectById(Integer id);
    public void deleteById(Integer id);
    public Result getIndexData();
    public Result getIndexData(PageParams pageParams);
    public Result getAPageOfArticle(PageParams pageParams);
    public Result articleSearch(ArticleSearch articleSearch);
}