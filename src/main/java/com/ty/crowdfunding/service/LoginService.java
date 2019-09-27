package com.ty.crowdfunding.service;

import com.ty.crowdfunding.bean.User;
import org.springframework.stereotype.Service;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/20 8:36
 */


public interface LoginService {

    User getUserByUsername(User user);

}
