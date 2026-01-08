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
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

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
                .cors()
                .and()
                .csrf().disable()
                .headers().frameOptions().disable()
                .and()

                .authorizeRequests()
                // ==========================================
                // 1. 公开接口 (游客权限)
                // ==========================================
                .antMatchers(
                        // 静态资源
                        "/",
                        "/index.html",
                        "/assets/**",
                        "/favicon.ico",
                        "/api/images/**",
                        "/api/article_img/**",
                        "/images/**",
                        "/file/images/**",

                        // 文章查看
                        "/api/article/articleSearch",
                        "/api/article/getIndexData1",
                        "/api/article/getAPageOfArticle",
                        "/api/article/getIndexData",
                        "/api/article/getArticleAndFirstPageCommentByArticleId",
                        "/api/article/selectById",
                        "/api/article/getAllTags",      // 标签云
                        "/api/article/getLikeRanking",  // 点赞榜
                        "/api/article/getReadRanking",  // 阅读榜

                        // 评论查看
                        "/api/comment/getAPageCommentByArticleId",
                        "/api/comment/getRecentComments",

                        // 回复查看
                        "/api/reply/getReplies",

                        // 分类查看
                        "/api/category/**",

                        // 用户相关
                        "/api/user/register",
                        "/api/user/checkUsername",
                        "/api/user/sendEmailCode",
                        "/api/user/captcha",
                        "/api/user/resetPassword",
                        "/api/user/getUserInfo",
                        "/api/user/getPublicUserInfo"
                )
                .permitAll()

                // ==========================================
                // 2. 管理员专属接口
                // ==========================================
                .antMatchers(
                        // 后台管理接口
                        "/api/admin/**",
                        "/api/dashboard/**",

                        // 管理功能
                        "/api/article/deleteById",
                        "/api/article/getAPageOfArticleVO",
                        "/api/article/getAllArticlesForAdmin",
                        "/api/article/batchDelete",
                        "/api/article/updateStatus",

                        // 评论管理
                        "/api/comment/getAllCommentsForAdmin",
                        "/api/comment/deleteCommentByAdmin",
                        "/api/comment/batchDeleteComments",
                        "/api/comment/updateCommentStatus",

                        // 用户管理
                        "/api/user/getAllUsers",
                        "/api/user/updateUserStatus",
                        "/api/user/deleteUser",

                        // 分类标签管理
                        "/api/category/admin/**",
                        "/api/tag/admin/**"
                )
                .hasRole("admin")  // 只允许管理员访问

                // ==========================================
                // 3. 登录用户权限 (普通用户和管理员都可以)
                // ==========================================
                .antMatchers(
                        // 文章操作
                        "/api/article/publishArticle",
                        "/api/article/updateArticle",
                        "/api/article/deleteArticle",
                        "/api/article/like",
                        "/api/article/collect",
                        "/api/article/getMyArticles",
                        "/api/article/getMyDrafts",
                        "/api/article/upload",

                        // 评论操作
                        "/api/comment/insert",
                        "/api/comment/deleteMyComment",
                        "/api/comment/like",

                        // 回复操作
                        "/api/reply/insert",
                        "/api/reply/deleteMyReply",

                        // 用户操作
                        "/api/user/updateInfo",
                        "/api/user/updatePassword",
                        "/api/user/uploadAvatar",

                        // 消息通知
                        "/api/notification/**"
                )
                .hasAnyRole("common", "admin")  // 普通用户和管理员都可以

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
        return new BCryptPasswordEncoder();
    }
}