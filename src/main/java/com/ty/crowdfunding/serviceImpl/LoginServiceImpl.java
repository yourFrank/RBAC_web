package com.ty.crowdfunding.serviceImpl;

import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.dao.LoginDao;
import com.ty.crowdfunding.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/20 8:37
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginDao loginDao;

    public User getUserByUsername(User user) {
       return loginDao.getUserByUsername(user);
    }
}
