package llp.spring.controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import llp.spring.service.ArticleService;
import llp.spring.entity.Article;
import llp.spring.tools.Result;
import org.springframework.web.multipart.MultipartFile;

// 20251217新增功能 - 个人中心与浏览足迹
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import llp.spring.entity.User; // 引入你的 User 实体
import llp.spring.service.IUserService; // 引入 UserService
import llp.spring.service.IOpLogService;

// 20251217新增功能 - 完善个人中心与浏览足迹
import llp.spring.entity.Article;
import llp.spring.entity.User;
import llp.spring.service.IOpLogService;
import llp.spring.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

@RestController
@RequestMapping("/article")  // 为控制器指定访问路径
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
    // 获取文章详情接口
    @PostMapping("/getArticleAndFirstPageCommentByArticleId")
    public Result getArticleAndFirstPageCommentByArticleId(Integer articleId, @RequestBody PageParams pageParams) {
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

    // 此时它的完整访问路径是：/article/publishArticle
    @RequestMapping("/publishArticle") // 添加和修改文章功能整合在一块，用type来区分
    public String publishArticle(String type, @RequestBody Article article) {
        try {
            if(article.getThumbnail() == null || !article.getThumbnail().startsWith("/api")) {
                article.setThumbnail("/api/images/6.png"); // 设置默认缩略图
            }
            if ("add".equals(type))
                articleService.publish(article);
            else if ("edit".equals(type))
                articleService.update(article);
            return "添加成功！";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "添加失败！";
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

    @RequestMapping("/selectById")
    public Result selectById(Integer id) {
        Result result = new Result();
        try {
            Article article = articleService.selectById(id);
            result.getMap().put("article", article);
        } catch (Exception e) {
            result.setErrorMessage("查询失败！");
            e.printStackTrace();
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

    // 在 ArticleController 中添加
    @PostMapping("/getMyArticles")
    public Result getMyArticles(Integer userId) {
        Result result = new Result();
        try {
            // 使用 QueryWrapper 查询该用户的所有文章
            QueryWrapper<Article> wrapper = new QueryWrapper<>();
            // 注意：如果你的 article 表存的是 author(用户名) 而不是 userId，这里要对应修改
            // 假设 article 表里还没有 user_id 字段，暂时用 author 查（不推荐但可行）
            // 更好的做法是 t_article 表加 user_id。这里先演示用 author 查，你需要传入 author 名字
            // 如果你的文章表关联的是 user_id，请用 .eq("user_id", userId)

            // 假设我们之前用的是 author 存用户名
            User user = userService.getById(userId);
            if(user != null) {
                wrapper.eq("author", user.getUsername()).orderByDesc("created");
                List<Article> list = articleService.list(wrapper);
                result.getMap().put("articles", list);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取文章失败");
        }
        return result;
    }
}