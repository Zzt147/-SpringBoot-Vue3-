package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.entity.dto.UserDTO;
import llp.spring.mapper.UserMapper;
import llp.spring.service.IUserService;
import llp.spring.service.impl.MailService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import org.springframework.util.StringUtils; // 建议引入
import org.springframework.beans.BeanUtils; // 【新增】用于对象属性拷贝
import org.springframework.security.crypto.password.PasswordEncoder;
import java.util.concurrent.TimeUnit; // 【新增】解决找不到符号 TimeUnit


@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private UserMapper userMapper;

    // === 【新增】注入组件 ===
    @Autowired
    private MailService mailService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping("/checkUsername")
    public Result checkUsername(@RequestParam String username) {
        return userService.checkUsername(username);
    }

    // === 【新增】发送验证码接口 ===
    @PostMapping("/sendEmailCode")
    public Result sendEmailCode(@RequestParam String email) {
        if (!StringUtils.hasText(email)) {
            return new Result(false, "邮箱不能为空");
        }

        // 1. 检查 Redis 中是否已有验证码（防止频繁发送）
        String key = "verify_code:" + email;
        if (redisTemplate.hasKey(key)) {
            return new Result(false, "验证码已发送，请勿频繁操作");
        }

        // 2. 生成并发送
        String code = mailService.generateCode();
        try {
            mailService.sendCode(email, code);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "邮件发送失败，请检查邮箱是否正确");
        }

        // 3. 存入 Redis，5分钟有效
        redisTemplate.opsForValue().set(key, code, 5, TimeUnit.MINUTES);

        return new Result(true, "验证码发送成功");
    }

    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        // 1. 校验验证码
        String key = "verify_code:" + userDTO.getEmail();
        String cachedCode = redisTemplate.opsForValue().get(key);

        if (cachedCode == null) {
            return new Result(false, "验证码已过期或未发送");
        }
        if (!cachedCode.equals(userDTO.getCode())) {
            return new Result(false, "验证码错误");
        }

        // 2. 【核心修改】将 UserDTO 转换为 User 实体
        User user = new User();
        // 使用 Spring 的工具类将 userDTO 的属性（username, password, email）复制给 user
        BeanUtils.copyProperties(userDTO, user);

        // 3. 调用 Service 层注册
        Result res = userService.register(user);

        // 4. 注册成功后删除 Redis 中的验证码
        if (res.isSuccess()) {
            redisTemplate.delete(key);
        }
        return res;
    }

    // 替换原来的 updateInfo 方法
    @PostMapping("/updateInfo")
    public Result updateInfo(@RequestBody User user) {
        Result result = new Result();
        try {
            // 1. 获取当前登录用户
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String currentUsername = ((UserDetails) principal).getUsername();
            User currentUser = userService.selectByUsername(currentUsername);

            if (currentUser != null) {
                // 2. 检查用户名修改
                if (user.getUsername() != null && !user.getUsername().equals(currentUser.getUsername())) {
                    User checkUser = userService.selectByUsername(user.getUsername());
                    if (checkUser != null) {
                        result.setErrorMessage("该用户名已被占用，请更换！");
                        return result;
                    }
                    currentUser.setUsername(user.getUsername());
                }

                // 3. 更新其他信息
                if (user.getEmail() != null) {
                    currentUser.setEmail(user.getEmail());
                }

                // 【修复】添加头像更新逻辑
                if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
                    currentUser.setAvatar(user.getAvatar());
                }

                // 【建议】如果 UserDTO 有昵称 name 字段，这里也应该更新
                // if (user.getName() != null) currentUser.setName(user.getName());

                // 4. 执行更新
                userService.updateById(currentUser);

                // 重新封装 UserDTO 返回给前端更新 Store
                UserDTO userDTO = UserDTO.entityToDto(currentUser);
                // 补充权限信息(因为entity里没有)
                userDTO.setAuthorities(userMapper.findAuthorityByName(currentUser.getUsername()));

                result.getMap().put("user", userDTO); // 返回 DTO 更规范
                result.setMsg("修改成功");
                result.setSuccess(true);
            }
        } catch (Exception e) {
            result.setErrorMessage("修改失败");
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 【新增】获取当前登录用户信息（用于前端初始化检查登录状态）
     */
    @GetMapping("/currentUser")
    public Result currentUser() {
        Result result = new Result();
        try {
            // 1. 从 Spring Security 上下文中获取当前认证信息
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 2. 判断是否是已登录用户 (未登录时 principal 通常是字符串 "anonymousUser")
            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                User user = userService.selectByUsername(username);

                if (user != null) {
                    user.setPassword(null); // 安全起见，抹除密码
                    result.getMap().put("user", user);
                    result.setSuccess(true);
                    result.setMsg("已登录");
                    return result;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. 如果没取到用户，返回失败
        result.setSuccess(false);
        result.setErrorMessage("未登录或会话已过期");
        return result;
    }
}