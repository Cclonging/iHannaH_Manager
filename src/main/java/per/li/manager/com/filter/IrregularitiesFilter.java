package per.li.manager.com.filter;

import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.stereotype.Component;
import per.li.manager.entity.mongo.IllegalRemarks;

import java.util.*;

/**
 * 违规文字过滤器
 */
@Component
@Slf4j
public class IrregularitiesFilter {
    private String BAN_WORDS = null;

    private  MongoClient mongoClient = null;

    private  MongoDatabase mongodb = null;

    private MongoCollection<Document> illegalRemarks = null;

    private MongoCollection<Document> illegalUrlArgs = null;

    private  List<Document> banWords= null;
    public IrregularitiesFilter() {
        //TODO 从数据里面拿出数据
        BAN_WORDS = "毛泽东胡锦涛江泽民邓小平习近平fuck";

        banWords= new ArrayList<>(2);

        //连接MongoDB
        try {
            // 无密码登陆
            mongoClient = new MongoClient("localhost", 27017);
            mongodb = mongoClient.getDatabase("runoob");
            illegalRemarks = mongodb.getCollection("illegalRemarks");
            illegalUrlArgs = mongodb.getCollection("illegalUrlArgs");
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    public List<IllegalRemarks> getAllIllegalRemarks(){
        FindIterable<Document> iterable = illegalRemarks.find();
        List<IllegalRemarks> list = new ArrayList<>();
        MongoCursor<Document> mongoCursor = iterable.iterator();
        while(mongoCursor.hasNext()){
            Document document = mongoCursor.next();
            //document.
        }
        return list;
    }
}
