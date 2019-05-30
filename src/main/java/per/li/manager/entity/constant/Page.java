package per.li.manager.entity.constant;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Page {

    //当前页
    private int curPage;

    //总页数
    private int totalPage;

    //页面大小
    private int pageSize;

}
