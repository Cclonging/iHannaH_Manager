package per.li.manager.mapper.hanner;


import org.apache.ibatis.annotations.Select;
import per.li.manager.entity.hanner.User;

import java.util.List;

public interface UserMapper{

    @Select(value = "select * from user limit #{param1}, #{param2}")
    List<User> selectAll(int page, int pageSize);

    @Select(value = "select count(id) from user")
    int count();

    @Select(value = "select * from user where id = #{param1} or username = #{param2} or nickname like '%${param3}%' limit #{param4},#{param5}")
    List<User> selectById(String arg0, String arg1, String arg2, int arg3, int arg4);

    @Select(value = "select count(id) from user where id = #{arg0} or username = #{arg1} or nickname like '%${arg2}%'")
    int countByid(String arg0, String arg1, String arg2);

    @Select(value = "select id,username,nickname,face_image as faceImage, registeTime, isOnline from user where id=#{id}")
    User selectOne(String id);


}