package llp.spring.controller;

import llp.spring.entity.Comment; // 引入 Comment
import llp.spring.entity.Reply;
import llp.spring.mapper.CommentMapper; // 引入 CommentMapper
import llp.spring.mapper.ReplyMapper;
import llp.spring.tools.IpUtils;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

// 20251216新增功能 - 修改用户名为真实用户名
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;

import llp.spring.entity.User; // 【新增】
import llp.spring.service.IUserService; // 【新增】

@RestController
@RequestMapping("/api/reply")
public class ReplyController {

    @Autowired
    private ReplyMapper replyMapper;

    // === 👇👇👇 新增注入 CommentMapper 👇👇👇 ===
    @Autowired
    private CommentMapper commentMapper;

    // === 【新增】注入 UserService 用于查询用户ID ===
    @Autowired
    private IUserService userService;

    // 添加回复
    @PostMapping("/insert")
    public Result insert(@RequestBody Reply reply, HttpServletRequest request) {
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
            reply.setAuthor(username);

            reply.setCreated(LocalDateTime.now());

            // 设置IP和属地
            String ip = IpUtils.getIpAddr(request);
            reply.setIp(ip);
            reply.setLocation(IpUtils.getCityInfo(ip));

            // === 👇👇👇 核心补全逻辑 START 👇👇👇 ===
            // 为了让通知切面(Aspect)能拿到文章ID，如果前端没传，我们这里手动查一下
            if (reply.getArticleId() == null && reply.getCommentId() != null) {
                Comment comment = commentMapper.selectById(reply.getCommentId());
                if (comment != null) {
                    reply.setArticleId(comment.getArticleId());
                }
            }
            // === 核心补全逻辑 END ===

            replyMapper.insert(reply);
            result.getMap().put("reply", reply);
            result.setMsg("回复成功!");
        } catch (Exception e) {
            result.setErrorMessage("回复失败!");
            e.printStackTrace();
        }
        return result;
    }

    // 获取某评论的子评论（支持分页/加载更多）
    @GetMapping("/getReplies")
    public Result getReplies(Integer commentId, int page, int rows) {
        Result result = new Result();
        try {
            int offset = (page - 1) * rows;
            List<Reply> replies = replyMapper.getRepliesByCommentId(commentId, offset, rows);
            Integer total = replyMapper.countByCommentId(commentId);

            result.getMap().put("replies", replies);
            result.getMap().put("total", total);
        } catch (Exception e) {
            result.setErrorMessage("获取回复失败!");
            e.printStackTrace();
        }
        return result;
    }

    // 删除回复接口
    @PostMapping("/deleteById")
    public Result deleteById(Integer id) {
        Result result = new Result();
        try {
            int count = replyMapper.deleteById(id);
            if (count > 0) {
                result.setMsg("删除成功!");
            } else {
                result.setErrorMessage("删除失败: 回复不存在");
            }
        } catch (Exception e) {
            result.setErrorMessage("删除失败!");
            e.printStackTrace();
        }
        return result;
    }
}