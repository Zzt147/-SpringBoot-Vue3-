package llp.spring.service;

import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.entity.Statistic;

/**
 * 统计服务接口
 * 继承 IService<Statistic> 后，自动拥有了 save, remove, update, get, list, page, count 等通用方法
 */
public interface IStatisticService extends IService<Statistic> {

}