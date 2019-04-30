package per.li.manager.service;

import per.li.manager.entity.mongo.IllegalRemarks;
import per.li.manager.entity.vo.RemarksData;


public interface MongoService {

    RemarksData findAll(Integer curPage);

    int ircount(String id);

    void saveOne(IllegalRemarks illegalRemark);
}
