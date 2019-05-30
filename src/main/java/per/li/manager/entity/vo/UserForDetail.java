package per.li.manager.entity.vo;

import lombok.Data;
import per.li.manager.entity.hanner.User;

@Data
public class UserForDetail {

    private User user;

    private String serverName;

    private int illNums;

}
