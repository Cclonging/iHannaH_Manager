package per.li.manager.service;

import per.li.manager.entity.manager.Admin;

public interface AdminService {

    //通过账号和密码查询Admin
    Admin selectByAdmin(String account, String pwd);
}
