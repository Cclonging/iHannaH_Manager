package per.li.manager.entity.vo;

import lombok.Data;
import per.li.manager.entity.constant.Page;
import per.li.manager.entity.hanner.User;

import java.util.List;

@Data
public class AllUserData {

    private List<User> users;

    private String[] serverName;

    private Page page;
}
