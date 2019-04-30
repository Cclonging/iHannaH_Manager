package per.li.manager.com.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class SpringUtils {

    public static boolean listIsBull(List<?> list){
        return Objects.isNull(list) && list.isEmpty();
    }

    public static String withDateFormat(Date date){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
        return simpleDateFormat.format(date);
    }
}
