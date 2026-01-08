package llp.spring.controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.*;
import llp.spring.mapper.ArticleMapper;
import llp.spring.mapper.StatisticMapper;
import llp.spring.mapper.TagMapper;
import llp.spring.service.*;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import llp.spring.tools.Result;
import org.springframework.web.multipart.MultipartFile;

// 20251217新增功能 - 个人中心与浏览足迹
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

// 20251217新增功能 - 完善个人中心与浏览足迹
import llp.spring.entity.Article;
import llp.spring.entity.User;
import llp.spring.service.IOpLogService;
import llp.spring.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;


import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import llp.spring.entity.vo.ArticleVO;

@RestController
@RequestMapping("/api/article")  // 为控制器指定访问路径
public class ArticleController {

    @Autowired  // 注入系统自动创建的Service对象，注意下面的对象名（首字母小写的类名）
    private ArticleService articleService;

    // 20251217新增功能 - 个人中心与浏览足迹
    // 1. 注入
    @Autowired
    private IOpLogService opLogService;

    // 20251217新增功能 - 完善个人中心与浏览足迹
    @Autowired
    private IUserService userService;

    // === 👇👇👇 添加这部分代码 👇👇👇 ===
    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private TagMapper tagMapper; // 注入

    @Autowired
    private StatisticMapper statisticMapper; // 需注入

    @Autowired  // 注入系统自动创建的Service对象，注意下面的对象名（首字母小写的类名）
    private IStatisticService statisticService;

    // 方法1：主页打开时或从文章返回主页时调用
    @PostMapping("/getIndexData1")
    public Result getIndexData1(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getIndexData(pageParams);
        } catch (Exception e) {
            result.setErrorMessage("获取数据失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 方法2：主页通过分页组件分页查询时调用
    @PostMapping("/getAPageOfArticle")
    public Result getAPageOfArticle(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getAPageOfArticle(pageParams);
        } catch (Exception e) {
            result.setErrorMessage("查询文章失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/getIndexData")
    public Result getIndexData (){
        Result result = new Result();
        try{
            result = articleService.getIndexData();
        }catch (Exception e){
            result.setErrorMessage("获取数据失败!");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/getAPageOfArticleVO")
    public Result getAPageOfArticleVO(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getAPageOfArticleVO(pageParams, "id");
        } catch (Exception e) {
            result.setErrorMessage("查询变量失败！原因：" + e.getMessage());
            e.printStackTrace();
            // 打印更详细的错误信息
            System.err.println("=== 查询文章详细错误 ===");
            e.printStackTrace();
            System.err.println("=== 请求参数 ===");
            System.err.println("page: " + pageParams.getPage());
            System.err.println("rows: " + pageParams.getRows());
        }
        return result;
    }

    // 20251217新增功能 - 完善个人中心与浏览足迹
    @PostMapping("/getArticleAndFirstPageCommentByArticleId")
    // 【修改】给 Integer articleId 加上 @RequestParam 注解
    public Result getArticleAndFirstPageCommentByArticleId(@RequestParam Integer articleId, @RequestBody PageParams pageParams) {
        // 1. 原有逻辑：获取文章
        Result result = articleService.getArticleAndFirstPageCommentByArticleId(articleId, pageParams);
        // 2. --- 新增：浏览埋点逻辑 ---
        try {
            // 尝试获取当前登录用户
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 只有登录用户才记录浏览足迹
            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                User user = userService.selectByUsername(username);

                if (user != null) {
                    // 从 result 中尝试取出文章标题
                    Object articleObj = result.getMap().get("article");
                    String title = "未知文章";
                    if (articleObj instanceof Article) {
                        title = ((Article) articleObj).getTitle();
                    }

                    // 记录日志：用户ID, 类型BROWSE, 内容, 关联文章ID
                    opLogService.record(user.getId(), "BROWSE", "浏览了文章: " + title, articleId);
                }
            }
        } catch (Exception e) {
            // 埋点报错不应影响文章正常展示，仅后台打印即可
            System.err.println("浏览日志埋点失败: " + e.getMessage());
        }
        // ---------------------------

        return result;
    }

// ... 其他引用保持不变

    @RequestMapping("/publishArticle")
    public String publishArticle(String type, @RequestBody Article article) {
        try {
            // === 【新增核心代码 START】 ===
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                User user = userService.selectByUsername(username);

                if (user != null) {
                    article.setUserId(user.getId());      // 保存用户ID
                    article.setAuthorName(user.getUsername());

                    // 【👇👇👇 请务必加上这一行 👇👇👇】
                    article.setAuthor(user.getUsername()); // 将用户名存入数据库 author 字段
                }
            }
            // === 【新增核心代码 END】 ===

            if(article.getThumbnail() == null || !article.getThumbnail().startsWith("/api")) {
                article.setThumbnail("/api/images/6.png"); // 设置默认缩略图
            }

            if ("add".equals(type)) {
                articleService.publish(article);
            } else if ("edit".equals(type)) {
                // 如果是编辑，这里会将最后修改人设置为当前登录用户
                // 如果需要限制“只能编辑自己的文章”，需要额外加判断逻辑
                articleService.update(article);
            }
            return "操作成功！";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "操作失败！";
    }
    @PostMapping("/upload")
    public Result upload(MultipartFile file) {
        Result result = new Result();
        try {
            String url = articleService.upload(file);
            result.getMap().put("url", url); // 保存返回结果
        } catch (Exception e) {
            result.setErrorMessage("上传失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/selectById")
    public Result selectById(@RequestParam("id") Integer id) {
        Result result = new Result();
        try {
            // 1. 获取文章基本信息
            Article article = articleService.getById(id);
            if (article == null) {
                return new Result(false, "文章不存在");
            }

            // 2. 增加点击量 (保持原有逻辑)
            Statistic statistic = statisticService.getOne(new QueryWrapper<Statistic>().eq("article_id", id));
            if (statistic != null) {
                statistic.setHits(statistic.getHits() + 1);
                statisticService.updateById(statistic);
            }

            // 3. 【关键修改】构造 ArticleVO 并填充作者信息
            ArticleVO articleVO = new ArticleVO();
            BeanUtils.copyProperties(article, articleVO); // 复制基本属性

            // 确保作者姓名被正确设置
            articleVO.setAuthorName(article.getAuthor());

            // 查询作者信息获取头像
            if (article.getAuthor() != null) {
                User authorUser = userService.selectByUsername(article.getAuthor());
                if (authorUser != null) {
                    articleVO.setAuthorAvatar(authorUser.getAvatar()); // ✅ 设置头像
                } else {
                    // 如果查不到用户，设置默认头像
                    articleVO.setAuthorAvatar("/api/images/default-avatar.png");
                }
            } else if (article.getUserId() != null) {
                // 如果作者姓名为空，尝试通过userId查询
                User authorUser = userService.getById(article.getUserId());
                if (authorUser != null) {
                    articleVO.setAuthorName(authorUser.getUsername());
                    articleVO.setAuthorAvatar(authorUser.getAvatar());
                } else {
                    articleVO.setAuthorAvatar("/api/images/default-avatar.png");
                }
            }

            result.getMap().put("article", articleVO); // 注意：这里放入的是 VO 而不是原始 entity
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("查询失败");
        }
        return result;
    }

    @PostMapping("/deleteById")
    public Result deleteById(Integer id) {
        Result result = new Result();
        try {
            articleService.deleteById(id);
        } catch (Exception e) {
            result.setErrorMessage("删除文章失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/articleSearch")
    public Result articleSearch(@RequestBody ArticleSearch articleSearch) {
        Result result = new Result();
        try {
            // 确保pageParams存在
            if (articleSearch.getPageParams() == null) {
                PageParams pageParams = new PageParams();
                pageParams.setPage(1L);
                pageParams.setRows(10L);
                articleSearch.setPageParams(pageParams);
            }

            result = articleService.articleSearch(articleSearch);
        } catch (Exception e) {
            result.setErrorMessage("获取数据失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 【修改】获取我的文章接口 - 现在直接用 ID 查，效率起飞！
    @PostMapping("/getMyArticles")
    public Result getMyArticles(Integer userId) {
        Result result = new Result();
        try {
            // 直接使用 MyBatis Plus 的 QueryWrapper 查 user_id
            QueryWrapper<Article> wrapper = new QueryWrapper<>();

            // 以前是查 author，现在改成查 user_id
            wrapper.eq("user_id", userId).orderByDesc("created");

            List<Article> list = articleService.list(wrapper);
            result.getMap().put("articles", list);
            result.setSuccess(true); // 显式设置成功
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取文章失败");
        }
        return result;
    }

    // 【新增】获取所有标签（用于标签云）
// 【修改】获取所有标签 (改为获取 Top 20 热门标签)
    @GetMapping("/getAllTags")
    public Result getAllTags() {
        Result result = new Result();
        // 直接从 t_tag 和 t_article_tag 统计
        List<Tag> hotTags = tagMapper.getHotTags(20);

        // 为了兼容前端，转换成 List<String>
        List<String> tagNames = hotTags.stream().map(Tag::getName).collect(Collectors.toList());

        result.getMap().put("tags", tagNames);

        // 也可以返回带数量的对象给前端 (仪表盘用)
        result.getMap().put("tagObjs", hotTags);

        result.setSuccess(true);
        return result;
    }

    // 【新增】获取点赞排行榜数据
    @GetMapping("/getLikeRanking")
    public Result getLikeRanking() {
        Result result = new Result();
        List<ArticleVO> list = articleMapper.getLikeRanking();
        result.getMap().put("articleVOs", list);
        result.setSuccess(true);
        return result;
    }

    // 【新增】文章点赞/取消点赞
    @PostMapping("/likeArticle")
    public Result likeArticle(Integer articleId) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof UserDetails)) {
            return new Result(false, "请先登录");
        }
        String username = ((UserDetails) principal).getUsername();
        User user = userService.selectByUsername(username);

        Integer count = articleMapper.countArticleLike(user.getId(), articleId);
        Statistic statistic = statisticMapper.selectByArticleId(articleId);
        if (statistic == null) {
            // 如果统计表没数据，初始化一条
            statistic = new Statistic();
            statistic.setArticleId(articleId);
            statistic.setLikes(0);
            statistic.setHits(0);
            statistic.setCommentsNum(0);
            statisticMapper.insert(statistic);
        }

        if (count > 0) {
            // 取消点赞
            articleMapper.deleteArticleLike(user.getId(), articleId);
            statistic.setLikes(Math.max(0, statistic.getLikes() - 1));
            statisticMapper.updateById(statistic);
            return new Result(true, "取消点赞");
        } else {
            // 点赞
            articleMapper.insertArticleLike(user.getId(), articleId);
            statistic.setLikes(statistic.getLikes() + 1);
            statisticMapper.updateById(statistic);
            return new Result(true, "点赞成功");
        }
    }

    // 【新增】获取我点赞的文章
    @PostMapping("/getMyLikedArticles")
    public Result getMyLikedArticles(Integer userId) {
        Result result = new Result();
        try {
            List<ArticleVO> list = articleMapper.getMyLikedArticles(userId);
            result.getMap().put("articles", list);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取失败");
        }
        return result;
    }

    @PostMapping("/testUserAvatar")
    public Result testUserAvatar(@RequestParam String username) {
        Result result = new Result();
        try {
            User user = userService.selectByUsername(username);
            if (user != null) {
                result.getMap().put("user", user);
                result.getMap().put("avatar", user.getAvatar());
                result.setSuccess(true);
            } else {
                result.setErrorMessage("用户不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("查询失败");
        }
        return result;
    }
}