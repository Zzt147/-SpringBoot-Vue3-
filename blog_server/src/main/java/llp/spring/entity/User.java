package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.security.core.GrantedAuthority; // 引入
import org.springframework.security.core.userdetails.UserDetails; // 引入
import java.util.Collection; // 引入
import java.util.Collections; // 引入
/**
 * <p>
 * 
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Getter
@Setter
@TableName("t_user")
public class User implements Serializable, UserDetails {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    private String email;

    // 20251217新增功能 - 修改DATE为DATETIME
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created;

    private Boolean valid;

    private String avatar;

    // === 【新增】权限ID字段 ===
    // exist = false 表示该字段不是 t_user 表的列，MyBatis-Plus 会忽略它
    @TableField(exist = false)
    private Integer authorityId;

    // 返回权限列表 (你可以暂时返回空，或者把之前的权限逻辑搬进来，这里简单处理)
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.emptyList(); // 暂时返回空，如果不影响鉴权的话
    }

    @Override
    public boolean isAccountNonExpired() { return true; }

    @Override
    public boolean isAccountNonLocked() { return true; }

    @Override
    public boolean isCredentialsNonExpired() { return true; }

    @Override
    public boolean isEnabled() { return true; } // 这里应该关联你的 valid 字段
}
