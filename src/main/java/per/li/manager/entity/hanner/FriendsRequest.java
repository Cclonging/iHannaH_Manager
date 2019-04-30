package per.li.manager.entity.hanner;


import lombok.Data;

import java.util.Date;

@Data
public class FriendsRequest {

    private String id;

    private String sendUserId;

    private String acceptUserId;

    private Date requestDateTime;

    private String status;


}