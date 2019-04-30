package per.li.manager.mapper.manager;

import org.apache.ibatis.annotations.Select;
import per.li.manager.entity.manager.Admin;

public interface AdminMapper {

    @Select(value = "select account, pwd from admin where account=#{param1} and pwd=#{param2}")
    Admin selectBy(String account, String pwd);

}
