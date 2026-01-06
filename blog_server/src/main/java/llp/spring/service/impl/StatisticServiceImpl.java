package llp.spring.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Statistic;
import llp.spring.mapper.StatisticMapper;
import llp.spring.service.IStatisticService;
import org.springframework.stereotype.Service;

/**
 * 统计服务实现类
 * 继承 ServiceImpl<Mapper, Entity> 并实现接口
 */
@Service
public class StatisticServiceImpl extends ServiceImpl<StatisticMapper, Statistic> implements IStatisticService {

}