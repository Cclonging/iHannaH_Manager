package per.li.manager.entity.hanner;

import lombok.Data;

import java.util.Date;


@Data
public class User {
    private String id;

    private String username;

    private String password;


    private String faceImage;

    private String faceImageBig;

    private String nickname;

    private String qrcode;

    private String cid;

    private Date registeTime;

    private int isOnline;
}