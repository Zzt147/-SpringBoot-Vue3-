package llp.spring.aspect;

import llp.spring.entity.Article;
import llp.spring.entity.Comment;
import llp.spring.entity.Notification;
import llp.spring.entity.Reply;
import llp.spring.entity.User;
import llp.spring.service.ArticleService;
import llp.spring.service.INotificationService;
import llp.spring.service.IUserService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Aspect
@Component
public class NotificationAspect {

    @Autowired
    private INotificationService notificationService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private IUserService userService;

    // 1. 监听评论文章
    @AfterReturning(pointcut = "execution(* llp.spring.controller.CommentController.insert(..))", returning = "result")
    public void afterComment(JoinPoint joinPoint, Object result) {
        // 从参数中获取 Comment 对象
        Object[] args = joinPoint.getArgs();
        if (args.length > 0 && args[0] instanceof Comment) {
            Comment comment = (Comment) args[0];

            // 注意：因为是 AfterReturning，如果 comment 没有 ID (插入失败)，这里其实应该检查 result
            // 但通常 MyBatis-Plus 插入后回填 ID 到实体对象中，所以直接用 comment.getId() 是可以的

            // 获取当前登录用户 (发送者)
            User sender = getCurrentUser();
            if (sender == null) return;

            // 获取文章作者 (接收者)
            Article article = articleService.getById(comment.getArticleId());
            if (article == null) return;
            Integer receiverId = article.getUserId();

            // 自己评论自己不发通知
            if (sender.getId().equals(receiverId)) return;

            // 构建通知
            Notification notification = new Notification();
            notification.setSenderId(sender.getId());
            notification.setSenderName(sender.getUsername());
            notification.setReceiverId(receiverId);
            notification.setArticleId(article.getId());

            // ✅【新增】保存评论ID，用于前端跳转定位
            notification.setCommentId(comment.getId());

            notification.setType("COMMENT");
            notification.setContent("评论了你的文章: " + truncate(comment.getContent()));
            notification.setIsRead(false);
            notification.setCreated(LocalDateTime.now());

            notificationService.save(notification);
        }
    }

    // 2. 监听回复评论
    @AfterReturning(pointcut = "execution(* llp.spring.controller.ReplyController.insert(..))", returning = "result")
    public void afterReply(JoinPoint joinPoint, Object result) {
        Object[] args = joinPoint.getArgs();
        if (args.length > 0 && args[0] instanceof Reply) {
            Reply reply = (Reply) args[0];

            User sender = getCurrentUser();
            if (sender == null) return;

            // 接收者：reply.toUid (前端传过来的被回复人ID)
            Integer receiverId = reply.getToUid();
            if (receiverId == null) return;

            if (sender.getId().equals(receiverId)) return;

            Notification notification = new Notification();
            notification.setSenderId(sender.getId());
            notification.setSenderName(sender.getUsername());
            notification.setReceiverId(receiverId);

            // 【新增】如果是回复，我们通常跳转到它所属的“根评论”位置，让用户看到上下文
            // 假设 Reply 对象里有 commentId (根评论ID)。如果没有，你需要去 Reply 实体类确认一下
            if (reply.getCommentId() != null) {
                notification.setCommentId(reply.getCommentId());
                // 同时，为了让前端能跳转到文章页，这里最好也设置 ArticleId
                // 如果 Reply 实体里没有 articleId，建议在 ReplyController 里查一下并 set 进去
                // 这里暂时假设 notification 不需要 articleId 也能存，但在跳转时 articleId 是必须的
                // 建议：确保 Reply 插入时顺便把 articleId 查出来传给 notification，或者 Reply 实体本身就有 articleId
                notification.setArticleId(reply.getArticleId()); // 假设 Reply 有这个字段
            }

            notification.setType("REPLY");
            notification.setContent("回复了你的评论: " + truncate(reply.getContent()));
            notification.setIsRead(false);
            notification.setCreated(LocalDateTime.now());

            notificationService.save(notification);
        }
    }

    private User getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            return userService.selectByUsername(username);
        }
        return null;
    }

    private String truncate(String content) {
        if (content == null) return "";
        return content.length() > 20 ? content.substring(0, 20) + "..." : content;
    }
}