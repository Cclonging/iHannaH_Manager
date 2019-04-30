package per.li.manager.base;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import per.li.manager.com.interceptor.LoginIntercepter;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Autowired
    private LoginIntercepter loginIntercepter;

    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(loginIntercepter)
                //addPathPatterns 用于添加拦截规则
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**","/templates/**");

    }


}
