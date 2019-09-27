package com.ty.crowdfunding.dao;

import com.ty.crowdfunding.bean.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/19 20:07
 */

public interface TestDao {

    @Select("select * from test")
    List<User> getAllUser();
}
