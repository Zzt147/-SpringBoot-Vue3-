package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Comment;
import llp.spring.mapper.CommentMapper;
import llp.spring.service.ICommentService;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Autowired
    private CommentMapper commentMapper;

    public Comment insert(Comment comment){
        commentMapper.insert(comment);
        return comment;
    }

    /***
    public Result getAPageCommentByArticleId(Integer articleId, PageParams pageParams){
        //查询条件构造器QueryWrapper    Java代码方式设置查询条件
        QueryWrapper wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId); //eq表示相等，字段名是表的字段名，不是实体类的属性名
        wrapper.orderBy(true, false, "id"); //排序，false表示降序
        // 创建分页对象（1表示第一页；2表示每页大小为2）
        Page<Comment> page = new Page<>(pageParams.getPage(), pageParams.getRows());
        Page<Comment> aPage = commentMapper.selectPage(page, wrapper);   //按条件进行分页查询
        Result result=new Result();    //selectPage是继承的方法，可直接使用
        result.getMap().put("comments", aPage.getRecords());

        // === 【修复】放入总条数 ===
        result.getMap().put("total", aPage.getTotal());
        // aPage.getTotal() 是 MyBatis Plus 分页插件自动查询出来的总数，直接用即可
        
        return result;
    }
    ***/
    // 【修改】使用自定义 SQL 获取评论（含头像）
    public Result getAPageCommentByArticleId(Integer articleId, PageParams pageParams){
        Result result = new Result();

        // 1. 计算分页参数
        int pageNo = (int) pageParams.getPage();
        int pageSize = (int) pageParams.getRows();
        int offset = (pageNo - 1) * pageSize;

        // 2. 调用 Mapper 自定义方法 (关联查询)
        List<Comment> comments = commentMapper.getAPageCommentByArticleId(articleId, offset, pageSize);

        // 3. 查询总条数 (用于分页)
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        Long total = commentMapper.selectCount(wrapper);

        // 4. 封装结果
        result.getMap().put("comments", comments);
        result.getMap().put("total", total);

        return result;
    }

    // 评论管理功能
    // --- 新增实现：管理员获取评论列表 ---
    public Result getAdminPage(PageParams pageParams) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        // 按时间倒序或ID倒序排列
        wrapper.orderBy(true, false, "id");

        Page<Comment> page = new Page<>(pageParams.getPage(), pageParams.getRows());
        Page<Comment> aPage = commentMapper.selectPage(page, wrapper);

        Result result = new Result();
        // 将分页记录和总数都放入结果
        result.getMap().put("comments", aPage.getRecords());
        // 关键：返回总条数给前端分页组件
        pageParams.setTotal(aPage.getTotal());
        result.getMap().put("pageParams", pageParams);

        return result;
    }

    // --- 新增实现：删除评论 ---
    public void deleteById(Integer id) {
        commentMapper.deleteById(id);
    }
}
