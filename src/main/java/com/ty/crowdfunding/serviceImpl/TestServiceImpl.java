package com.ty.crowdfunding.serviceImpl;

import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.dao.TestDao;
import com.ty.crowdfunding.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/20 8:37
 */
@Service
public class TestServiceImpl implements TestService {

    @Autowired
    private TestDao testDao;

    public List<User> getAllUser(){
        return testDao.getAllUser();

    }
}
