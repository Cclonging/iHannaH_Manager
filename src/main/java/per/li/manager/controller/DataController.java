package per.li.manager.controller;


import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import per.li.manager.entity.constant.ServerInfo;
import per.li.manager.entity.hanner.User;
import per.li.manager.entity.manager.Admin;
import per.li.manager.entity.mongo.IllegalRemarks;
import per.li.manager.entity.vo.AllUserData;
import per.li.manager.entity.vo.ManagePageData;
import per.li.manager.entity.vo.UserForDetail;
import per.li.manager.service.AdminService;
import per.li.manager.service.ManagerService;
import per.li.manager.com.utils.JSONResult;
import per.li.manager.service.MongoService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@RestController
@RequestMapping("/data")
@Slf4j
public class DataController {

    @Autowired
    private ManagerService managerService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private MongoService mongoService;

    /**
     * 获取allUsers的信息
     * @param curPage
     * @return
     */
    @GetMapping("/getAllUsers")
    public JSONResult getAllUsers(String curPage){
        int page = Integer.valueOf(curPage);
        AllUserData data = managerService.getAllUsers(page);
        return JSONResult.ok(data);
    }

    @GetMapping("/getUser")
    public JSONResult getUserById(String id, String curPage){
            AllUserData data = managerService.getUsersById(id, Integer.valueOf(curPage));
            if (Objects.isNull(data.getUsers()) || data.getUsers().size() == 0){
                return JSONResult.errorMsg("没有找到" + id);
            }
            return JSONResult.ok(data);
    }

    /**
     * 账户登录操作数据
     * @param account
     * @param pwd
     * @param session
     * @param request
     * @param response
     * @return null：不存在这样的数据 ok：存在这样的数据
     * @throws IOException
     * @throws ServletException
     */
    @GetMapping("/login")
    public JSONResult login(String account, String pwd, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if (!Objects.isNull(account) && !Objects.isNull(pwd)){
            Admin admin = adminService.selectByAdmin(account, pwd);
            if (!Objects.isNull(admin)){
                log.info(account + "登录成功");
                session.setAttribute("admin", account);
                return JSONResult.ok(account);
            }
            return JSONResult.errorMsg("账户或密码错误");
        }
        return JSONResult.errorMsg("请输入账户或密码");
    }


    @GetMapping("/getManagePageData")
    public JSONResult getManagePageData(){
        ManagePageData data = new ManagePageData();
        int banNums = managerService.countBans();
        int userNums = managerService.countUsers();
        data.setUserNums(userNums);
        data.setBanNums(banNums);
        data.setIllegalNums(banNums);
        data.setSMaxNums(ServerInfo.SEEVER_MAX);
        return JSONResult.ok(data);
    }

    @GetMapping("/getUserByid")
    public JSONResult getUserByid(String id){
        if (Objects.isNull(id)){
            return JSONResult.errorMsg("id 为空哦");
        }
        User user = managerService.getUserById(id);
        if (Objects.isNull(user)){
            return JSONResult.errorMsg("该用户不存在");
        }
        //TODO 封装前端所需的数据，而不仅仅是写死的数据
        UserForDetail userForDetail = new UserForDetail();
        userForDetail.setUser(user);
        userForDetail.setIllNums(mongoService.ircount(id));
        userForDetail.setServerName("BT-PANEL(上海)");
        userForDetail.setStatus("在线");
        return JSONResult.ok(userForDetail);
    }
}
