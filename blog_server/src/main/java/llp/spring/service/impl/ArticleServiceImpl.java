package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Article;
import llp.spring.entity.Comment;
import llp.spring.entity.Statistic;
import llp.spring.entity.User;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.mapper.ArticleMapper;
import llp.spring.mapper.CommentMapper;
import llp.spring.mapper.StatisticMapper;
import llp.spring.mapper.UserMapper;
import llp.spring.service.ArticleService;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import lombok.SneakyThrows;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import llp.spring.entity.Tag;
import llp.spring.mapper.TagMapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Comment;

@Service
@Transactional
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService {

    @Value("${file.upload-images-dir}")
    private String uploadImagesDir;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private StatisticMapper statisticMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private TagMapper tagMapper;

    // === 核心辅助方法：根据 user_id 填充作者真名 ===
    private void fillArticleAuthor(Article article) {
        if (article != null && article.getUserId() != null) {
            User user = userMapper.selectById(article.getUserId());
            if (user != null) {
                // 覆盖作者名，确保前端显示的是最新的用户昵称
                article.setAuthor(user.getUsername());
                article.setAuthorName(user.getUsername());
            }
        }
    }

    // === 核心修改：标签处理方法 ===
    private void handleTags(Integer articleId, String tagsStr) {
        if (tagsStr == null) return;

        // 1. 清理旧关系
        try {
            tagMapper.deleteRelationByArticleId(articleId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 2. 解析标签
        Set<String> tagSet = new HashSet<>();

        // 【修改点】 改进解析逻辑
        if (tagsStr.contains("#")) {
            // 旧正则: "#([^#\\s]+)" -> 遇到空格就停止
            // 新正则: "#([^#]+)"    -> 匹配 # 后面的所有内容（允许空格），直到遇到下一个 #
            Pattern p = Pattern.compile("#([^#]+)");
            Matcher m = p.matcher(tagsStr);
            while (m.find()) {
                // group(1) 是 # 后面的内容
                String temp = m.group(1).trim();
                // 去掉可能误输入的末尾逗号（例如 #Tag1, #Tag2）
                temp = temp.replaceAll("[,，]+$", "");
                if (!temp.isEmpty()) {
                    tagSet.add(temp);
                }
            }
        } else {
            // 兼容旧格式 (无#，空格或逗号分隔)
            String[] split = tagsStr.split("[,，]+"); // 去掉空格分隔，仅逗号分隔，或者保留空格分隔看你需求
            // 如果你想纯空格分隔也支持，可以用 "[,，\\s]+"；但如果标签本身含空格，建议仅用逗号分隔
            for (String s : split) {
                if (!s.trim().isEmpty()) tagSet.add(s.trim());
            }
        }

        System.out.println("解析出的标签集合: " + tagSet);

        // 3. 循环处理每个标签 (保持不变，但移除了多余的 replace("#"))
        for (String tagName : tagSet) {
            // 再次确保没有 # (正则已经保证了，但为了保险)
            tagName = tagName.replace("#", "").trim();

            if(tagName.isEmpty()) continue;

            // 查找标签是否存在
            Integer tagId = tagMapper.selectIdByName(tagName);
            if (tagId == null) {
                Tag newTag = new Tag();
                newTag.setName(tagName);
                tagMapper.insert(newTag);
                tagId = newTag.getId();
            }
            // 建立关联
            try {
                if (tagId != null) {
                    tagMapper.insertRelation(articleId, tagId);
                }
            } catch (Exception e) {
                // 忽略重复关联
            }
        }
        System.out.println("=== 标签处理结束 ===");
    }

    // 1. 文章搜索
    public Result articleSearch(ArticleSearch articleSearch) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();
        wrapper.orderBy(true, false, "a.id");

        if (articleSearch.getArticleCondition().getTitle() != null &&
                !articleSearch.getArticleCondition().getTitle().trim().isEmpty()) {
            wrapper.like("a.title", articleSearch.getArticleCondition().getTitle());
        }

        if (articleSearch.getArticleCondition().getStartDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.ge("a.created", sdf.format(articleSearch.getArticleCondition().getStartDate()) + " 00:00:00");
        }

        if (articleSearch.getArticleCondition().getEndDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.le("a.created", sdf.format(articleSearch.getArticleCondition().getEndDate()) + " 23:59:59");
        }

        // 【修改】如果是标签搜索，优先匹配 t_article_tag 关联表
        // 这里暂时保持原有的模糊查询逻辑，或者你可以修改 ArticleMapper.xml 的 articleSearch 进行多表关联
        // 为了兼容旧数据，这里继续保留对 a.tags 的模糊查询
        if (articleSearch.getArticleCondition().getTag() != null &&
                !articleSearch.getArticleCondition().getTag().trim().isEmpty()) {
            wrapper.like("a.tags", articleSearch.getArticleCondition().getTag());
        }

        Page<ArticleVO> page = new Page<>(articleSearch.getPageParams().getPage(),
                articleSearch.getPageParams().getRows());
        IPage<ArticleVO> aPage = articleMapper.articleSearch(page, wrapper);

        Result result = new Result();
        articleSearch.getPageParams().setTotal(aPage.getTotal());
        result.getMap().put("articleVOs", aPage.getRecords());
        result.getMap().put("pageParams", articleSearch.getPageParams());
        result.setSuccess(true);

        return result;
    }

    // 2. 分页获取文章列表
    public Result getAPageOfArticle(PageParams pageParams) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();

        // 支持排序逻辑
        if ("hot".equals(pageParams.getSort())) {
            // 按点赞数倒序
            wrapper.orderByDesc("s.likes");
        } else {
            // 默认按 ID 倒序 (最新)
            wrapper.orderBy(true, false, "t_article.id");
        }

        Page<Article> page = new Page<Article>(pageParams.getPage(), pageParams.getRows());
        IPage<Article> aPage = articleMapper.getAPageOfArticle(page, wrapper);

        Result result = new Result();
        pageParams.setTotal(aPage.getTotal());

        if (aPage.getRecords() != null && aPage.getRecords().size() > 0) {
            for (Article article : aPage.getRecords()) {
                // 处理摘要
                if (article.getContent() != null) {
                    Document doc = Jsoup.parse(article.getContent());
                    String content = doc.text();
                    if (content.length() > 100) {
                        content = content.substring(0, 99) + "......";
                    }
                    article.setContent(content);
                }
                // 填充作者信息
                fillArticleAuthor(article);
            }
        }
        result.getMap().put("articles", aPage.getRecords());
        result.getMap().put("pageParams", pageParams);

        return result;
    }

    // 3. 获取首页数据
    public Result getIndexData(PageParams pageParams) {
        // 重载方法1
        return getIndexData();
    }

    public Result getIndexData() {
        Result result = new Result();

        // 轮播图数据 (取前5条)
        List<Article> articles = articleMapper.getAPage(0L, 5L);
        if (articles != null) {
            for (Article article : articles) {
                fillArticleAuthor(article);
            }
        }
        result.getMap().put("articles", articles);

        // 排行榜数据 (阅读排行)
        PageParams pageParams = new PageParams();
        pageParams.setPage(1L);
        pageParams.setRows(10L);
        Result result1 = getAPageOfArticleVO(pageParams, "hits");
        result.getMap().put("articleVOs", result1.getMap().get("articleVOs"));

        return result;
    }

    public Result getAPageOfArticleVO(PageParams pageParams, String type) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<ArticleVO>();
        if ("id".equals(type)) {
            wrapper.orderBy(true, false, "t_article.id");
        } else if ("hits".equals(type)) {
            wrapper.orderBy(true, false, "t_statistic.hits");
        }

        Page<ArticleVO> page = new Page<ArticleVO>(pageParams.getPage(), pageParams.getRows());
        IPage<ArticleVO> aPage = articleMapper.getAPageOfArticleVO(page, wrapper);

        Result result = new Result();
        pageParams.setTotal(aPage.getTotal());
        result.getMap().put("articleVOs", aPage.getRecords());
        result.getMap().put("pageParams", pageParams);
        return result;
    }

    // 4. 获取文章详情及评论
    public Result getArticleAndFirstPageCommentByArticleId(Integer articleId, PageParams pageParams) {
        Result result = new Result();

        // 使用 this.selectById(articleId) 以触发缓存和作者填充逻辑
        result.getMap().put("article", this.selectById(articleId));

        result.getMap().put("comments",
                commentMapper.getAPageCommentByArticleId(
                        articleId, (int) ((pageParams.getPage() - 1) * pageParams.getRows()), (int) pageParams.getRows()));

        Long total = commentMapper.selectCount(new QueryWrapper<Comment>().eq("article_id", articleId));
        result.getMap().put("total", total);

        // 更新点击量
        Statistic statistic = statisticMapper.selectByArticleId(articleId);
        if (statistic == null) {
            statistic = new Statistic();
            statistic.setArticleId(articleId);
            statistic.setHits(1);
            statistic.setCommentsNum(0);
            statisticMapper.insert(statistic);
        } else {
            statistic.setHits(statistic.getHits() + 1);
            statisticMapper.updateById(statistic);
        }

        return result;
    }

    // 5. 更新文章
    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    public Article update(Article article) {
        // 先查原文章
        Article newArticle = articleMapper.selectById(article.getId());

        newArticle.setModified(LocalDateTime.now());
        newArticle.setTags(article.getTags());
        newArticle.setContent(article.getContent());
        newArticle.setTitle(article.getTitle());
        newArticle.setThumbnail(article.getThumbnail());
        newArticle.setCategories(article.getCategories()); // 确保分类也能更新
        newArticle.setUserId(article.getUserId());
        newArticle.setLocation(article.getLocation()); // 更新位置

        articleMapper.updateById(newArticle);

        // 【新增】处理标签关联
        handleTags(newArticle.getId(), newArticle.getTags());

        fillArticleAuthor(newArticle);
        return newArticle;
    }

    // 6. 发布文章
    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    @Transactional
    public Article publish(Article article) {
        article.setCreated(LocalDateTime.now());
        articleMapper.insert(article); // 插入后 article.id 会有值

        Statistic statistic = new Statistic();
        statistic.setArticleId(article.getId());
        statistic.setHits(0);
        statistic.setCommentsNum(0);
        statisticMapper.insert(statistic);

        // 【新增】处理标签关联
        handleTags(article.getId(), article.getTags());

        fillArticleAuthor(article);
        return article;
    }

    // 7. 图片上传
    @SneakyThrows
    @Override
    public String upload(MultipartFile file) {
        final File folder = new File(uploadImagesDir);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        String type = file.getOriginalFilename().substring(
                file.getOriginalFilename().lastIndexOf(".")
        );
        final String newName = UUID.randomUUID() + type;
        file.transferTo(new File(folder, newName));
        String url = "/api/images/" + newName;
        return url;
    }

    // 8. 单个文章查询
    @Override
    @Cacheable(value = "article", key = "#id")
    public Article selectById(Integer id) {
        // 1. 查询文章本体
        Article article = articleMapper.selectById(id);

        // 2. 填充作者信息
        fillArticleAuthor(article);

        // 填充点赞数
        if (article != null) {
            Statistic statistic = statisticMapper.selectOne(
                    new QueryWrapper<Statistic>().eq("article_id", id)
            );
            if (statistic != null) {
                article.setLikes(statistic.getLikes());
            } else {
                article.setLikes(0);
            }
        }

        return article;
    }

    // 9. 删除文章 (级联删除)
    @Override
    @CacheEvict(cacheNames = "article", key = "#id")
    @Transactional(rollbackFor = Exception.class)
    public void deleteById(Integer id) {
        // 1. 删除文章本体
        articleMapper.deleteById(id);

        // 2. 删除关联的评论数据
        QueryWrapper<Comment> commentWrapper = new QueryWrapper<>();
        commentWrapper.eq("article_id", id);
        commentMapper.delete(commentWrapper);

        // 3. 删除关联的统计数据
        QueryWrapper<Statistic> statWrapper = new QueryWrapper<>();
        statWrapper.eq("article_id", id);
        statisticMapper.delete(statWrapper);

        // 4. 【新增】删除文章标签关联
        try {
            tagMapper.deleteRelationByArticleId(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}