package per.li.manager.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import per.li.manager.entity.constant.Page;
import per.li.manager.entity.mongo.IllegalRemarks;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RemarksData {

    private List<IllegalRemarks> remarks;

    private Page page;


}
