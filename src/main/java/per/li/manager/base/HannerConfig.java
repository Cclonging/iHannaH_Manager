package per.li.manager.base;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = "per.li.manager.mapper.hanner",sqlSessionFactoryRef = "hannerSqlSessionFactory")
public class HannerConfig {

    @Primary
    @Bean(name = "hannerDataSource")
    @ConfigurationProperties("spring.datasource.hanner")
    public DataSource masterDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "hannerSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Qualifier("hannerDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver()
                .getResources("classpath:per/li/manager/mapper/hanner/*.xml"));
        return sessionFactoryBean.getObject();
    }

}
