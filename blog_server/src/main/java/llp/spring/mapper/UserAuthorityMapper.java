package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.UserAuthority; // 确保引入了你的实体类
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface UserAuthorityMapper extends BaseMapper<UserAuthority> {
    // 继承 BaseMapper 后，你自动拥有了基本的 CRUD 能力

    // 这里保留我们要写的自定义查询权限的方法
    List<String> selectAuthoritiesByUserId(Integer userId);
}