package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        return userService.register(user);
    }

    @GetMapping("/checkUsername")
    public Result checkUsername(@RequestParam String username) {
        return userService.checkUsername(username);
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
                // 2. 【修复】如果修改了用户名，必须检查新用户名是否已存在
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

                // 4. 执行更新
                userService.updateById(currentUser);

                result.getMap().put("user", currentUser);
                result.setMsg("修改成功");
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