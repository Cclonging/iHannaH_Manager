package per.li.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

@Controller
public class ManagerController {

    @RequestMapping("/to_login")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/hh_manager")
    public String manager(){
        return "hh_manager";
    }

    @RequestMapping("/quit")
    public String quit(HttpSession session){
        session.removeAttribute("admin");

        return "login";
    }
}
