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

        // --- 【删除】下面这段旧代码，因为它阻断了后续逻辑，且返回的不是我们定制的User ---
        /*
        List<String> authorityNames = userMapper.findAuthorityByName(username);
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        for (String authorityName : authorityNames) {
            authorities.add(new SimpleGrantedAuthority(authorityName));
        }
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                authorities
        );
        */
        // ---------------------------------------------------------------------

        // 2. 【新增】查询用户权限 (t_user_authority)
        UserAuthority userAuth = userAuthorityMapper.selectOne(
                new QueryWrapper<UserAuthority>()
                        .eq("user_id", user.getId())
                        .last("LIMIT 1")
        );

        // 3. 【新增】将权限ID设置到 User 对象中
        if (userAuth != null) {
            user.setAuthorityId(userAuth.getAuthorityId());
        } else {
            user.setAuthorityId(2); // 默认普通用户
        }

        // 4. 返回自定义的 user 对象
        // 因为 User 类现在实现了 UserDetails 接口，所以这里不会报错了
        return user;
    }
}