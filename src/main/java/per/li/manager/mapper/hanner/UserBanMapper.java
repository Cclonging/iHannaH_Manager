package per.li.manager.mapper.hanner;

import org.apache.ibatis.annotations.Select;

public interface UserBanMapper {

    @Select(value = "select count(id) from user_ban")
    int count();


}
