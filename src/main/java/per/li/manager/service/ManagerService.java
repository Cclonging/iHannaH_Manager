package per.li.manager.service;

import per.li.manager.entity.hanner.User;
import per.li.manager.entity.vo.AllUserData;

import java.util.List;

public interface ManagerService {

    //获取所有用户信息
    AllUserData getAllUsers(int page);

    //获取所有用户数量
    int countUsers();

    //获取所有被禁用户数量
    int countBans();

    AllUserData getUsersById(String id, int page);

    User getUserById(String id);
}
