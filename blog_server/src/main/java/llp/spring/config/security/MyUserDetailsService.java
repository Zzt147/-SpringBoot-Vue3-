package llp.spring.config.security;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import llp.spring.entity.User;
import llp.spring.mapper.UserMapper;
import java.util.ArrayList;
import java.util.List;
import llp.spring.entity.UserAuthority; // 引入 UserAuthority 实体
import llp.spring.mapper.UserAuthorityMapper; // 引入 Mapper

import org.springframework.security.core.GrantedAuthority; // 新增引入
import org.springframework.security.core.authority.SimpleGrantedAuthority; // 新增引入

import javax.annotation.Resource;

@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Resource
    private UserAuthorityMapper userAuthorityMapper; // 【新增】注入 UserAuthorityMapper

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. 查找数据库中的用户
        User user = userMapper.findByNameWithValid(username);
        if (null == user) {
            throw new UsernameNotFoundException("用户不存在或已被禁用: " + username);
        }

        // === 【新增核心代码 START】 ===
        // 2. 查询用户角色名称 (例如: "admin", "common")
        List<String> roleNames = userMapper.findAuthorityByName(username);

        // 3. 将角色转换为 GrantedAuthority 列表
        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        for (String role : roleNames) {
            // Spring Security 的 hasRole 默认检查 "ROLE_" 前缀
            // 如果数据库存的是 "admin"，必须转为 "ROLE_admin"
            if (role != null && !role.startsWith("ROLE_")) {
                role = "ROLE_" + role;
            }
            grantedAuthorities.add(new SimpleGrantedAuthority(role));
        }

        // 4. 将权限列表设置到 User 对象中
        user.setAuthorities(grantedAuthorities);
        // === 【新增核心代码 END】 ===

        // ... 原有的 authorityId 设置逻辑保持不变 ...
        UserAuthority userAuth = userAuthorityMapper.selectOne(
                new QueryWrapper<UserAuthority>()
                        .eq("user_id", user.getId())
                        .last("LIMIT 1")
        );
        if (userAuth != null) {
            user.setAuthorityId(userAuth.getAuthorityId());
        } else {
            user.setAuthorityId(2);
        }

        return user;
    }
}