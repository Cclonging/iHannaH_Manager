package per.li.manager.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import per.li.manager.entity.manager.Admin;
import per.li.manager.mapper.manager.AdminMapper;
import per.li.manager.service.AdminService;
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin selectByAdmin(String account, String pwd) {
        return adminMapper.selectBy(account, pwd);
    }
}
