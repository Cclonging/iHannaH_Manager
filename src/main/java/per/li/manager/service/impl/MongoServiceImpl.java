package per.li.manager.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import per.li.manager.entity.constant.Constant;
import per.li.manager.entity.constant.Page;
import per.li.manager.entity.mongo.IllegalRemarks;
import per.li.manager.entity.vo.RemarksData;
import per.li.manager.service.MongoService;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service
@Slf4j
public class MongoServiceImpl implements MongoService {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public RemarksData findAll(Integer curPage) {

        Query query = new Query();
        int totalPage = (int) mongoTemplate.count(query, IllegalRemarks.class);
        curPage = curPage > totalPage ? totalPage : curPage;
        log.info("从mongodb中runoob数据库的illegalRemarks中查询记录，page=" + curPage);
        List<IllegalRemarks> list = mongoTemplate.find(query.skip(curPage * Constant.PAGE_SIZE).limit(Constant.PAGE_SIZE), IllegalRemarks.class);
        //List<IllegalRemarks> list = mongoTemplate.findAll(IllegalRemarks.class);
        log.info("illegalRemarks:" + list);
        Page page = new Page(curPage, (totalPage - 1)/Constant.PAGE_SIZE, Constant.PAGE_SIZE);
        RemarksData remarksData = new RemarksData(list, page);
        return remarksData;
    }

    @Override
    public int ircount(String id) {
        Query query = new Query(where("senderId").is(id));
        return (int) mongoTemplate.count(query, IllegalRemarks.class);
    }

    @Override
    public void saveOne(IllegalRemarks illegalRemark) {
        mongoTemplate.save(illegalRemark);
    }
}
