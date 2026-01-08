package llp.spring.mapper;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.vo.UserCommentVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    // 1. 根据文章ID查评论 (前台用)
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC")
    List<Comment> selectByArticleId(Integer articleId);

    // 2. 根据文章ID分页查评论 (前台用)
    // 原 SQL: SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC limit #{offset} , #{size}
    // 修改为:
    @Select("SELECT c.*, u.avatar FROM t_comment c " +
            "LEFT JOIN t_user u ON c.user_id = u.id " +
            "WHERE c.article_id = #{articleId} " +
            "ORDER BY c.id DESC limit #{offset}, #{size}")
    List<Comment> getAPageCommentByArticleId(
            @Param("articleId") Integer articleId,
            @Param("offset") Integer offset,
            @Param("size") Integer size
    );

    /***
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

    ***/
    // 5. 个人中心/管理后台 - 根据作者查询 (修复后)
    // 关键修复：添加 'article_id as articleId' 和 关联查询回复所属的文章ID

    // 【修改点 3：根据 userId 查询评论与回复】
    // 原方法名: selectCommentsByAuthor(@Param("author") String author)
    // 修改为:
    @Select("SELECT id, content, author, created, 'COMMENT' as type, " +
            "article_id as articleId, " +
            "article_id as refId, " +
            "(SELECT title FROM t_article WHERE id = t_comment.article_id) as targetName " +
            "FROM t_comment " +
            "WHERE user_id = #{userId} " +  // 👈 关键：改为 user_id
            "UNION ALL " +
            "SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "c.article_id as articleId, " +
            "r.comment_id as refId, " +
            "c.content as targetName " +
            "FROM t_reply r " +
            "LEFT JOIN t_comment c ON r.comment_id = c.id " +
            "WHERE r.user_id = #{userId} " + // 👈 关键：改为 user_id (假设回复表也有 user_id)
            "ORDER BY created DESC")
    List<UserCommentVO> selectCommentsByUserId(@Param("userId") Integer userId);

    // 1. 【合并查询】支持按 author 筛选的动态 SQL
    @Select("<script>" +
            "SELECT * FROM (" +
            // --- 查评论 ---
            "  SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "  c.article_id as articleId, c.article_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = c.article_id) as targetName " +
            "  FROM t_comment c " +
            "  <where>" +
            "    <if test='author != null and author != \"\"'> c.author = #{author} </if>" +
            "  </where>" +
            " UNION ALL " +
            // --- 查回复 ---
            "  SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "  p.article_id as articleId, r.comment_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = p.article_id) as targetName " +
            "  FROM t_reply r " +
            "  LEFT JOIN t_comment p ON r.comment_id = p.id " +
            "  <where>" +
            "    <if test='author != null and author != \"\"'> r.author = #{author} </if>" +
            "  </where>" +
            ") as tmp " +
            "ORDER BY created DESC " +
            "LIMIT #{offset}, #{size}" +
            "</script>")
    List<UserCommentVO> getAdminComments(@Param("offset") int offset,
                                         @Param("size") int size,
                                         @Param("author") String author); // 【新增参数】


    // 2. 【合并统计】统计总数也需要支持筛选，否则分页计算会错
    @Select("<script>" +
            "SELECT " +
            "(SELECT COUNT(*) FROM t_comment <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>) + " +
            "(SELECT COUNT(*) FROM t_reply <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>)" +
            "</script>")
    Integer countAdminComments(@Param("author") String author);

    // 【新增】查询我点赞的评论 (联表查出文章标题，方便前端显示)
    // 【修改后】使用 LEFT JOIN 确保能查到 targetName (文章标题)
    @Select("SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "c.article_id as articleId, c.article_id as refId, " +
            "a.title as targetName " +  // 直接从关联的 article 表取 title 映射为 targetName
            "FROM t_comment c " +
            "INNER JOIN t_comment_like l ON c.id = l.comment_id " +
            "LEFT JOIN t_article a ON c.article_id = a.id " + // 关键：左连接文章表
            "WHERE l.user_id = #{userId} " +
            "ORDER BY l.id DESC") // 建议按点赞时间倒序 (l.id)，也可以按评论时间 (c.created)
    List<UserCommentVO> getMyLikedComments(@Param("userId") Integer userId);

    // 【新增】点赞相关操作
    @Insert("INSERT INTO t_comment_like (user_id, comment_id) VALUES (#{userId}, #{commentId})")
    void insertCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);

    @Delete("DELETE FROM t_comment_like WHERE user_id = #{userId} AND comment_id = #{commentId}")
    void deleteCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);

    @Select("SELECT COUNT(*) FROM t_comment_like WHERE user_id = #{userId} AND comment_id = #{commentId}")
    Integer countCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);

    @Update("UPDATE t_comment SET likes = IFNULL(likes, 0) + 1 WHERE id = #{commentId}")
    void increaseLikes(@Param("commentId") Integer commentId);

    @Update("UPDATE t_comment SET likes = GREATEST(IFNULL(likes, 0) - 1, 0) WHERE id = #{commentId}")
    void decreaseLikes(@Param("commentId") Integer commentId);
}