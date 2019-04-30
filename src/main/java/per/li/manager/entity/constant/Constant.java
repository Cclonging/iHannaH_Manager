package per.li.manager.entity.constant;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Constant {

    public static List<String> urls;

    //页面大小
    public static final int PAGE_SIZE = 7;

    static {

        String[] urlarray = { "/hh_manager", "/to_login", "/quit"};
        urls = Arrays.asList(urlarray);

    }
}
