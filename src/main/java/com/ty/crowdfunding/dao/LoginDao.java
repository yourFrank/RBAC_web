package com.ty.crowdfunding.dao;

import com.ty.crowdfunding.bean.User;
import org.apache.ibatis.annotations.Select;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/20 8:37
 */

public interface LoginDao {
    @Select("select * from user where login_account=#{loginAccount} and password=#{password}")
    User getUserByUsername(User user);
}
