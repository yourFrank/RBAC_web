package com.ty.crowdfunding.web;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/27 10:31
 */
public class LoginInterceptor implements HandlerInterceptor {
    /*
     * @Author frank
     * @Description //前处理，执行方法前验证登录
     * @Date 2019/9/27
     * @Param
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return boolean
     **/
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        HttpSession session = httpServletRequest.getSession();
        String contextPath = httpServletRequest.getContextPath();
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser!=null){
            return true;
        }else{
            httpServletResponse.sendRedirect(contextPath+"/toLogin");
            return false;
        }

    }

    /*
     * @Author frank
     * @Description //执行完方法后处理
     * @Date 2019/9/27
     * @Param
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @return void
     **/
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    /*
     * @Author frank
     * @Description //返回视图渲染后处理
     * @Date 2019/9/27
     * @Param
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @return void
     **/
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
