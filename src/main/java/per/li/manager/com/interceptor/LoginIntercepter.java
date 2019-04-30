package per.li.manager.com.interceptor;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import per.li.manager.entity.constant.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Objects;

@Component
@Slf4j
public class LoginIntercepter implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI().toLowerCase();
        if (url.contains("data") || url.contains("mg") || url.contains("login") || url.contains("quit")
                || url.contains("js") || url.contains("imgs")
                || url.contains("css") || url.contains("vendor")){
            return true;
        }
        System.err.println(url);
        HttpSession session = request.getSession();
        if (Constant.urls.contains(url)){
            if (Objects.isNull(session.getAttribute("admin"))) {
                log.info("拦截url<" + url + ">, 跳转至/to_login");
                response.sendRedirect("/to_login");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
