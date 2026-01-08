package llp.spring.entity.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ArticleVO {
    private Integer id; // 文章id
    private String title; // 文章标题
    private String content; // 文章内容 - 添加这个字段
    private Date created; // 文章创建时间
    private String categories; // 文章分类
    private Integer hits; // 点击量
    private Integer likes; // 点赞量
    // === 新增字段 ===
    private Integer readRankChange; // 阅读排名变化值
    private Integer likeRankChange; // 点赞排名变化值
    // ✅【新增】作者头像
    private String authorAvatar;
    private String authorName;  // 作者姓名
    // === 【新增修复】补充缺失字段，解决标签筛选时信息丢失问题 ===
    private String thumbnail;   // 文章缩略图
    private String author;      // 兼容前端显示的作者字段
    private String location;    // 发布位置
}