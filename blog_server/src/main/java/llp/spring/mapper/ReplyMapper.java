package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.Reply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReplyMapper extends BaseMapper<Reply> {
    // 分页查询子评论
    @Select("SELECT * FROM t_reply WHERE comment_id = #{commentId} ORDER BY id ASC LIMIT #{offset}, #{size}")
    List<Reply> getRepliesByCommentId(@Param("commentId") Integer commentId, @Param("offset") int offset, @Param("size") int size);

    // 统计某评论下的子评论数量
    @Select("SELECT COUNT(*) FROM t_reply WHERE comment_id = #{commentId}")
    Integer countByCommentId(@Param("commentId") Integer commentId);
}