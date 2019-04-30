package per.li.manager.entity.hanner;

import lombok.Data;

import java.util.Date;

@Data
public class UserBan {

    private int id;

    private User user;

    private Date date;
}
