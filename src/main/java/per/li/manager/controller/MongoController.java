package per.li.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import per.li.manager.entity.vo.RemarksData;
import per.li.manager.service.MongoService;
import per.li.manager.com.utils.JSONResult;
import per.li.manager.com.utils.SpringUtils;

@RestController
@RequestMapping("/mg")
public class MongoController {

    @Autowired
    private MongoService mongoService;

    @GetMapping("/all")
    public JSONResult findAll(String curPage){
        if (curPage.matches("^-?\\d+$")) {
            int tmp = Integer.valueOf(curPage);
            int page = tmp < 0 ? 0 : tmp;
            RemarksData remarksData = mongoService.findAll(page);
            if (!SpringUtils.listIsBull(remarksData.getRemarks())) {
                return JSONResult.ok(remarksData);
            }
        }
        return JSONResult.errorMsg("暂无违规言论");
    }

//    @GetMapping("/addiR")
//    public void addIR(){
//        IllegalRemarks illegalRemark = new IllegalRemarks();
//        illegalRemark.setId("ss");
//        illegalRemark.setContent("sss");
//        mongoService.saveOne(illegalRemark);
//    }
}
