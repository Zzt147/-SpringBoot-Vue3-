package llp.spring.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.mapper.UserMapper;
import llp.spring.tools.Result;
import org.springframework.stereotype.Service;

public interface IUserService extends IService<User> {
    Result register(User user); // 添加注册方法

    Result checkUsername(String username); // 添加用户名检查方法

    // 20251217新增功能 - 个人中心与浏览足迹
    // 在 IUserService 接口中添加
    User selectByUsername(String username);
    
}