package llp.spring.task;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Statistic;
import llp.spring.service.IStatisticService; // 假设你有这个Service
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
public class RankingTask {

    @Autowired
    private IStatisticService statisticService;

    // 每5分钟执行一次: "0 0/5 * * * ?"
    // 为了测试方便，你可以先改成 "0/30 * * * * ?" (每30秒)
    @Scheduled(cron = "0/1 * * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void updateRanking() {
        System.out.println("=== 开始更新排行榜排名变化 ===");
        updateReadRanking();
        updateLikeRanking();
        System.out.println("=== 排行榜更新结束 ===");
    }

    // 更新阅读榜
    private void updateReadRanking() {
        // 1. 获取当前按点击量倒序的所有统计数据
        QueryWrapper<Statistic> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("hits");
        List<Statistic> list = statisticService.list(wrapper);

        for (int i = 0; i < list.size(); i++) {
            Statistic stat = list.get(i);
            int currentRank = i + 1; // 当前排名（从1开始）
            int prevRank = stat.getPrevReadRank() == null ? 0 : stat.getPrevReadRank();

            // 如果上次排名是0（新文章），变化暂记为0或者视为上升
            // 逻辑：变化 = 上次排名 - 当前排名。
            // 例如：上次第10，现在第5。 10 - 5 = 5 (正数，上升5位)
            // 例如：上次第1，现在第3。 1 - 3 = -2 (负数，下降2位)
            int change = 0;
            if (prevRank != 0) {
                change = prevRank - currentRank;
            }

            // 更新数据库
            stat.setReadRankChange(change);
            stat.setPrevReadRank(currentRank); // 记录当前排名供下次对比
        }
        // 批量更新 (MyBatis Plus ServiceImpl 自带 updateBatchById，或者循环更新)
        statisticService.updateBatchById(list);
    }

    // 更新点赞榜
    private void updateLikeRanking() {
        QueryWrapper<Statistic> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("likes");
        List<Statistic> list = statisticService.list(wrapper);

        for (int i = 0; i < list.size(); i++) {
            Statistic stat = list.get(i);
            int currentRank = i + 1;
            int prevRank = stat.getPrevLikeRank() == null ? 0 : stat.getPrevLikeRank();

            int change = 0;
            if (prevRank != 0) {
                change = prevRank - currentRank;
            }

            stat.setLikeRankChange(change);
            stat.setPrevLikeRank(currentRank);
        }
        statisticService.updateBatchById(list);
    }
}