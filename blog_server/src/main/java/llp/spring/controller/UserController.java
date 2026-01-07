package llp.spring.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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

import com.wf.captcha.SpecCaptcha; // EasyCaptcha
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    // 【修改】参数改为 UserDTO 以接收 code，并增强安全性
    @PostMapping("/updateInfo")
    public Result updateInfo(@RequestBody UserDTO userDTO) {
        Result result = new Result();
        try {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String currentUsername = ((UserDetails) principal).getUsername();
            User currentUser = userService.selectByUsername(currentUsername);

            if (currentUser != null) {
                // 1. 修改用户名 (原名不一致且新名未被占用)
                if (StringUtils.hasText(userDTO.getUsername()) && !userDTO.getUsername().equals(currentUser.getUsername())) {
                    User checkUser = userService.selectByUsername(userDTO.getUsername());
                    if (checkUser != null) {
                        return new Result(false, "该用户名已被占用，请更换！");
                    }
                    currentUser.setUsername(userDTO.getUsername());
                }

                // 2. 【新增】修改邮箱 (需验证码)
                if (StringUtils.hasText(userDTO.getEmail()) && !userDTO.getEmail().equals(currentUser.getEmail())) {
                    // 检查验证码
                    String key = "verify_code:" + userDTO.getEmail();
                    String cachedCode = redisTemplate.opsForValue().get(key);
                    if (cachedCode == null || !cachedCode.equals(userDTO.getCode())) {
                        return new Result(false, "修改邮箱需要正确的验证码！");
                    }
                    currentUser.setEmail(userDTO.getEmail());
                    redisTemplate.delete(key); // 使用后删除
                }

                // 3. 修改头像
                if (StringUtils.hasText(userDTO.getAvatar())) {
                    currentUser.setAvatar(userDTO.getAvatar());
                }

                // 4. 执行更新
                userService.updateById(currentUser);

                // 返回更新后的 DTO
                UserDTO responseDTO = UserDTO.entityToDto(currentUser);
                responseDTO.setAuthorities(userMapper.findAuthorityByName(currentUser.getUsername()));

                result.getMap().put("user", responseDTO);
                result.setMsg("修改成功");
                result.setSuccess(true);
            } else {
                result.setErrorMessage("用户未登录或不存在");
            }
        } catch (Exception e) {
            result.setErrorMessage("修改失败: " + e.getMessage());
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

    // 1. 【新增】图形验证码接口
    @RequestMapping("/captcha")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SpecCaptcha specCaptcha = new SpecCaptcha(130, 48, 4);
        String verCode = specCaptcha.text().toLowerCase();
        String key = request.getParameter("key"); // 前端生成的唯一标识
        if (StringUtils.hasText(key)) {
            // 存入 Redis，5分钟有效
            redisTemplate.opsForValue().set("captcha:" + key, verCode, 5, TimeUnit.MINUTES);
        }
        specCaptcha.out(response.getOutputStream());
    }

    // 2. 【新增】忘记密码 - 重置密码
    @PostMapping("/resetPassword")
    public Result resetPassword(@RequestBody UserDTO userDTO) {
        // 1. 校验邮箱验证码
        String key = "verify_code:" + userDTO.getEmail();
        String cachedCode = redisTemplate.opsForValue().get(key);
        if (cachedCode == null || !cachedCode.equals(userDTO.getCode())) {
            return new Result(false, "验证码错误或已过期");
        }

        // 2. 查询用户
        User user = userService.selectByUsername(userDTO.getUsername()); // 这里也可以用 email 查，看前端传什么
        if (user == null) {
            // 尝试用邮箱查
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("email", userDTO.getEmail());
            user = userMapper.selectOne(wrapper);
        }

        if (user == null) {
            return new Result(false, "用户不存在");
        }

        // 3. 重置密码 (这里简单处理，实际项目应加密)
        // user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        user.setPassword(userDTO.getPassword());

        userService.updateById(user);
        redisTemplate.delete(key);

        return new Result(true, "密码重置成功");
    }
}