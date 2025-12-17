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

    @PostMapping("/updateInfo")
    public Result updateInfo(@RequestBody User user) {
        Result result = new Result();
        try {
            // 获取当前登录用户，防止越权修改他人信息
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = ((UserDetails) principal).getUsername();
            User currentUser = userService.selectByUsername(username);

            if (currentUser != null) {
                // 只允许修改昵称和邮箱，不改密码
                currentUser.setUsername(user.getUsername()); // 昵称
                currentUser.setEmail(user.getEmail()); // 邮箱
                // MybatisPlus 更新
                userService.updateById(currentUser);

                // 更新成功后，返回最新的用户信息给前端更新 Store
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