package com.ty.crowdfunding.service;

import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.dao.TestDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description
 * @Author 71042
 * @Date 2019/9/19 20:11
 */
public interface TestService {

    public List<User> getAllUser();
}
