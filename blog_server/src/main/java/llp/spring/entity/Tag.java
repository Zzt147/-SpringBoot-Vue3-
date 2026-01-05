package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.io.Serializable;

@Data
@TableName("t_tag")
public class Tag implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String name;

    @TableField(exist = false) // 如果有 count 字段，记得加 exist=false 或者在 Mapper 里用别名
    private Integer count;
}