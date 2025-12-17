package llp.spring.mapper;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.vo.UserCommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    // 1. 根据文章ID查评论 (前台用)
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC")
    List<Comment> selectByArticleId(Integer articleId);

    // 2. 根据文章ID分页查评论 (前台用)
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC limit #{offset} , #{size}")
    List<Comment> getAPageCommentByArticleId(
            @Param("articleId") Integer articleId,
            @Param("offset") Integer offset,
            @Param("size") Integer size
    );

    // 3. 【核心修复】管理员查询所有评论 + 回复
    // 修复重点：将查询结果别名改为 'articleId'，与前端 ManageComment.vue 需要的字段一致
    @Select("SELECT * FROM (" +
            // --- 查评论 ---
            "  SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "  c.article_id as articleId, " +  // 【修改】这里别名改为 articleId
            "  c.article_id as refId, " +      // (可选)保留 refId 兼容性
            "  (SELECT title FROM t_article WHERE id = c.article_id) as targetName " +
            "  FROM t_comment c " +
            " UNION ALL " +
            // --- 查回复 ---
            "  SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "  p.article_id as articleId, " +  // 【修改】这里别名改为 articleId
            "  r.comment_id as refId, " +      // (可选)refId 存 commentId
            "  (SELECT title FROM t_article WHERE id = p.article_id) as targetName " +
            "  FROM t_reply r " +
            "  LEFT JOIN t_comment p ON r.comment_id = p.id " +
            ") as tmp " +
            "ORDER BY created DESC " +
            "LIMIT #{offset}, #{size}")
    List<UserCommentVO> getAdminComments(@Param("offset") int offset, @Param("size") int size);

    // 4. 统计总数
    @Select("SELECT (SELECT COUNT(*) FROM t_comment) + (SELECT COUNT(*) FROM t_reply)")
    Integer countAllCommentsAndReplies();

    // 5. 个人中心逻辑 (保持不变)
    @Select("SELECT id, content, author, created, 'COMMENT' as type, article_id as refId, " +
            "(SELECT title FROM t_article WHERE id = t_comment.article_id) as targetName " +
            "FROM t_comment WHERE author = #{author} " +
            "UNION ALL " +
            "SELECT id, content, author, created, 'REPLY' as type, comment_id as refId, " +
            "(SELECT content FROM t_comment WHERE id = t_reply.comment_id) as targetName " +
            "FROM t_reply WHERE author = #{author} " +
            "ORDER BY created DESC")
    List<UserCommentVO> selectCommentsByAuthor(@Param("author") String author);
}