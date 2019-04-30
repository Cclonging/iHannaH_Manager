package per.li.manager.entity.mongo;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
public class IllegalRemarks {


    private String id;

    private String title;

    private String senderId;

    private String receiverId;

    private String content;

    private String date;
}
