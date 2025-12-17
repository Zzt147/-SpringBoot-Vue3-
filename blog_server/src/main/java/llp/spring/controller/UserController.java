package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

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
}