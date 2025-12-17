package llp.spring.controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Comment;
// 20251217新增功能
import llp.spring.mapper.CommentMapper;
import llp.spring.tools.PageParams;
import llp.spring.tools.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import llp.spring.tools.Result;
import llp.spring.service.ICommentService;

import java.time.LocalDateTime;
import java.util.Date;
// 引入 HttpSession 和 UserDTO
import javax.servlet.http.HttpSession;
import llp.spring.entity.dto.UserDTO;

// 20251216新增功能 - 修改用户名为真实用户名
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

// 20251217新增功能
import llp.spring.entity.vo.UserCommentVO;
import java.util.List;

// 20251217新增功能 - 个人中心与浏览足迹
import llp.spring.entity.User;
import llp.spring.service.IOpLogService;
import llp.spring.service.IUserService;

@RestController
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private ICommentService commentService;

    // 20251217新增功能 - 个人中心与浏览足迹
    @Autowired
    private IUserService userService;
    @Autowired
    private IOpLogService opLogService;

    @PostMapping("/getAPageCommentByArticleId")
    public Result getAPageCommentByArticleId(Integer articleId, @RequestBody PageParams pageParams){
        Result result = new Result(); // 接收查询字符串中的数据    接收axios请求的data数据
        try {
            result = commentService.getAPageCommentByArticleId(articleId, pageParams);
        } catch (Exception e) {
            result.setErrorMessage("查询评论失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/insert")
    public Result insert(@RequestBody Comment comment){
        Result result = new Result();
        try {
            // 20251216新增功能 - 修改用户名为真实用户名
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username;
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = principal.toString();
            }
            comment.setAuthor(username);

            comment.setCreated(LocalDateTime.now()); // 之前修改的时间
            Comment comment1 = commentService.insert(comment);

            // 20251217新增功能 - 个人中心与浏览足迹
            User user = userService.selectByUsername(username);
            if (user != null) {
                // 记录日志：用户ID, 类型, 内容描述(截取前20个字), 关联文章ID
                String contentSummary = comment.getContent().length() > 20 ? comment.getContent().substring(0, 20) + "..." : comment.getContent();
                opLogService.record(user.getId(), "COMMENT", "评论了文章: " + contentSummary, comment.getArticleId());
            }

            result.getMap().put("Comment", comment1);
            result.setMsg("评论成功!");
        } catch (Exception e) {
            result.setErrorMessage("评论失败!");
            e.printStackTrace();
        }
        return result;
    }

    // 评论管理功能
    // --- 新增接口：获取所有评论（管理员） ---
    @PostMapping("/getAdminPage")
    public Result getAdminPage(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = commentService.getAdminPage(pageParams);
        } catch (Exception e) {
            result.setErrorMessage("获取评论列表失败！");
            e.printStackTrace();
        }
        return result;
    }

    // --- 新增接口：删除评论 ---
    @PostMapping("/deleteById")
    public Result deleteById(Integer id) {
        Result result = new Result();
        try {
            commentService.deleteById(id);
            result.setMsg("删除成功");
        } catch (Exception e) {
            result.setErrorMessage("删除失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 20251217新增功能

    @Autowired
    private CommentMapper commentMapper; // 确保注入了 Mapper

    @PostMapping("/getUserComments")
    public Result getUserComments(String author) {
        Result result = new Result();
        try {
            List<UserCommentVO> list = commentMapper.selectCommentsByAuthor(author);
            result.getMap().put("comments", list);
        } catch (Exception e) {
            result.setErrorMessage("查询失败");
            e.printStackTrace();
        }
        return result;
    }

    // 在 CommentController 中添加
    @PostMapping("/getMyComments")
    public Result getMyComments(String username) { // 直接传用户名查
        Result result = new Result();
        try {
            QueryWrapper<Comment> wrapper = new QueryWrapper<>();
            wrapper.eq("author", username).orderByDesc("created");
            List<Comment> list = commentService.list(wrapper);
            result.getMap().put("comments", list);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取评论失败");
        }
        return result;
    }
}