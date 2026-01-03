package llp.spring.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Category;
import llp.spring.service.ICategoryService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    private ICategoryService categoryService;

    // 获取分类树
    @GetMapping("/getTree")
    public Result getTree() {
        Result result = new Result(true, "获取成功");
        result.getMap().put("data", categoryService.getTree());
        return result;
    }

    // 新增分类
    @PostMapping("/add")
    public Result add(@RequestBody Category category) {
        // 默认放到最后
        if (category.getParentId() == null) category.setParentId(0);
        if (category.getSort() == null) category.setSort(99);

        boolean success = categoryService.save(category);
        return new Result(success, success ? "添加成功" : "添加失败");
    }

    // 修改分类（重命名）
    @PostMapping("/update")
    public Result update(@RequestBody Category category) {
        boolean success = categoryService.updateById(category);
        return new Result(success, success ? "修改成功" : "修改失败");
    }

    // 删除分类
    @PostMapping("/delete")
    public Result delete(Integer id) {
        // 检查是否有子分类
        long count = categoryService.count(new QueryWrapper<Category>().eq("parent_id", id));
        if (count > 0) {
            return new Result(false, "请先删除子分类！");
        }
        boolean success = categoryService.removeById(id);
        return new Result(success, success ? "删除成功" : "删除失败");
    }

    // 【关键】批量更新分类（用于拖拽排序后保存）
    // 前端会把受影响的节点列表传过来（包含新的 parentId 和 sort）
    @PostMapping("/updateBatch")
    public Result updateBatch(@RequestBody List<Category> categories) {
        boolean success = categoryService.updateBatchById(categories);
        return new Result(success, success ? "排序保存成功" : "保存失败");
    }
}