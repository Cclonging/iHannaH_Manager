package per.li.manager.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import per.li.manager.entity.constant.Constant;
import per.li.manager.entity.constant.Page;
import per.li.manager.entity.constant.ServerInfo;
import per.li.manager.entity.hanner.User;
import per.li.manager.entity.vo.AllUserData;
import per.li.manager.mapper.hanner.UserBanMapper;
import per.li.manager.mapper.hanner.UserMapper;
import per.li.manager.service.ManagerService;

import java.util.List;
import java.util.Objects;

@Service
@Slf4j
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserBanMapper userBanMapper;

    @Autowired
    RedisTemplate<String, String> redisTemplate;

    @Override
    public AllUserData getAllUsers(int page) {
        if (page < 0)
            page = 0;
        log.info("查询hannah数据库中表user的数据，page=" + page);
        AllUserData allUserData = new AllUserData();
        int totalPage = (userMapper.count() - 1) / Constant.PAGE_SIZE;
        Page p = new Page(page, totalPage, Constant.PAGE_SIZE);
        allUserData.setUsers(userMapper.selectAll(page * Constant.PAGE_SIZE, Constant.PAGE_SIZE));
        allUserData.setServerName(ServerInfo.SEEVER_NAME);
        allUserData.setPage(p);
        return allUserData;

    }

    @Override
    public int countUsers() {
        return userMapper.count();
    }

    @Override
    public int countBans() {
        return Integer.valueOf(redisTemplate.opsForValue().get("hannah_user_count"));
    }

    @Override
    public AllUserData getUsersById(String id, int page) {
        if (Objects.isNull(id))
            return null;
        int totalPage = (userMapper.countByid(id, id, id) - 1) / Constant.PAGE_SIZE;
        Page p = new Page(page, totalPage, Constant.PAGE_SIZE);
        log.info("查询hannah数据库中表user的数据，id=?,page" + page);
        List<User> users = userMapper.selectById(id, id, id, page*Constant.PAGE_SIZE, Constant.PAGE_SIZE);
        AllUserData data = new AllUserData();
        data.setUsers(users);
        data.setServerName(ServerInfo.SEEVER_NAME);
        data.setPage(p);
        return data;
    }

    @Override
    public User getUserById(String id) {
        return userMapper.selectOne(id);
    }


}
