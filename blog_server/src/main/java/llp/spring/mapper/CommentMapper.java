package llp.spring.mapper;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.vo.UserCommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Mapper
public interface CommentMapper extends BaseMapper<Comment> {
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC")
    public List<Comment> selectByArticleId(Integer articleId);

    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC limit #{offset} , #{size}")
    public List<Comment> getAPageCommentByArticleId(
            @Param("articleId")Integer articleId,
            @Param("offset")Integer offset,
            @Param("size")Integer size
    );

    // 20251217新增功能
    // 获取某用户的所有评论（主评论+子评论）
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