package llp.spring.config.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true) // 启用方法级别的权限认证
public class SecurityConfig extends WebSecurityConfigurerAdapter { // 权限配置

    @Autowired
    private MyUserDetailsService myUserDetailsService;

    @Autowired
    private MyAuthenticationFailureHandler myAuthenticationFailureHandler;

    @Autowired
    private MyAuthenticationSuccessHandler myAuthenticationSuccessHandler;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .cors() // 开启跨域支持
                .and()
                .csrf().disable() // 禁用CSRF，否则POST请求会被拦截
                .headers().frameOptions().disable() // 防止H2控制台或iframe报错
                .and()

                .authorizeRequests()
                // ==========================================
                // 1. 公开接口 (允许匿名访问，无需登录)
                // ==========================================
                .antMatchers(
                        "/",
                        "/index.html",
                        "/assets/**",
                        "/favicon.ico",
                        "/api/images/**",      // 图片
                        "/api/article_img/**", // 文章图片
                        "/images/**",
                        "/file/images/**",

                        // 文章公开接口
                        "/api/article/articleSearch",
                        "/api/article/getIndexData1",
                        "/api/article/getAPageOfArticle",
                        "/api/article/getIndexData",
                        "/api/article/getArticleAndFirstPageCommentByArticleId",
                        "/api/article/selectById",

                        // --- 修复开始：添加标签云和点赞榜接口 ---
                        "/api/article/getAllTags",      // ✅ 标签云接口
                        "/api/article/getLikeRanking",  // ✅ 点赞榜接口
                        // --- 修复结束 ---

                        // 评论公开接口
                        "/api/comment/getAPageCommentByArticleId",
                        // 评论公开接口
                        "/api/reply/getReplies",
                        // 分类公开接口
                        "/api/category/**",

                        // 用户注册与验证
                        "/api/user/register",      // 注册接口
                        "/api/user/checkUsername", // 检查用户名
                        "/api/user/sendEmailCode",  // 发送验证码接口

                        // 【👇👇👇 新增下面这两行 👇👇👇】
                        "/api/user/captcha",       // 放行图形验证码
                        "/api/user/resetPassword"  // 放行重置密码
                )
                .permitAll()

                // ==========================================
                // 2. 管理员权限
                // ==========================================
                .antMatchers(
                        "/api/article/deleteById",
                        "/api/article/getAPageOfArticleVO"
                )
                .hasRole("admin")

                // ==========================================
                // 3. 登录用户权限 (普通用户 + 管理员)
                // ==========================================
                .antMatchers(
                        "/comment/insert",
                        "/oplog/**",
                        "/reply/**",
                        "/comment/getUserComments",
                        "/user/updateInfo",
                        "/api/article/upload",
                        "/api/article/publishArticle"
                )
                .hasAnyRole("common", "admin")

                // ==========================================
                // 4. 其他所有请求都需要认证
                // ==========================================
                .anyRequest().authenticated()

                .and()

                // ==========================================
                // 5. 登录配置
                // ==========================================
                .formLogin()
                .loginProcessingUrl("/api/login")
                .failureHandler(myAuthenticationFailureHandler)
                .successHandler(myAuthenticationSuccessHandler)
                .permitAll()

                .and()

                // ==========================================
                // 6. 登出配置
                // ==========================================
                .logout()
                .logoutUrl("/api/logout")
                .logoutSuccessHandler(new LogoutSuccessHandler() {
                    @Override
                    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
                                                Authentication authentication) throws IOException {
                        request.getSession().removeAttribute("user");
                        response.setContentType("application/json;charset=utf-8");
                        response.getWriter().write(objectMapper.writeValueAsString(
                                new Result(true, "登出成功")));
                    }
                })
                .permitAll();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(myUserDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // 密码加密策略
    }
}