package llp.spring.controller;
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

@RestController
@RequestMapping("/article")  // 为控制器指定访问路径
public class ArticleController {

    @Autowired  // 注入系统自动创建的Service对象，注意下面的对象名（首字母小写的类名）
    private ArticleService articleService;


    // 20251217新增功能 - 个人中心与浏览足迹
    // 1. 注入
    @Autowired
    private IOpLogService opLogService;


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

    @PostMapping("/getArticleAndFirstPageCommentByArticleId")
    public Result getArticleAndFirstPageCommentByArticleId(Integer articleId, @RequestBody PageParams pageParams ){
        Result result=new Result();
        try{
            result=articleService.getArticleAndFirstPageCommentByArticleId(articleId, pageParams);
        }catch (Exception e){
            result.setErrorMessage("查询文章失败！");
            e.printStackTrace();
        }

        // 20251217新增功能 - 个人中心与浏览足迹
        // 2. 在 getArticleAndFirstPageCommentByArticleId 方法内部，return 之前：
        // ... 获取 article 逻辑 ...

        // --- 新增：记录浏览日志 ---
        // 先获取当前登录用户 (如果已登录)
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            // 这里需要根据你的 UserService 获取用户ID，或者简单点，让前端传userId
            // 假设这里能获取到 userId，或者你通过用户名查一下数据库
            // 为了演示方便，这里先略过获取ID的复杂逻辑，假设你通过用户名查到了 user
            // 你可以在 UserServiceImpl 里加一个 getByUsername 方法
        }
        // -----------------------
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

}