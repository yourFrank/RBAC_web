package com.ty.crowdfunding.web;

import com.ty.crowdfunding.bean.Permission;
import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.service.PermissionService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @Description 用户权限页面的访问拦截
 * @Author 71042
 * @Date 2019/9/27 10:37
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private PermissionService permissionService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String contextPath = request.getContextPath();
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        //查出该用户已经分配的权限
        String requestURI = request.getRequestURI();
        Set<String> allurl=new HashSet<String>();
        List<Permission> userPermissions = permissionService.getPermissionByUser(loginUser);
        //获取到所有需要权限的路径
        List<Permission> allPermissions = permissionService.getAllPermissions();
        for (Permission permission : allPermissions) {
            //        可能有重复的集合，将url放入set集合中
            if (StringUtils.isNotBlank(permission.getUrl()))
                allurl.add(permission.getUrl());
        }

        //如果需要权限的路径包括了访问的路径
        if (allurl.contains(requestURI)){
            //如果用户有该权限
            if (userPermissions.contains(requestURI)){
                return true;
            }else{
                response.sendRedirect(contextPath+"/error");
                return false;
            }
        }
            return true;
    }
}
