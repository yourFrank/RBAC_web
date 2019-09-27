package com.ty.crowdfunding.web;

import org.springframework.web.context.ContextLoaderListener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @Description 监听器实现服务器启动时赋值app变量
 * @Author 71042
 * @Date 2019/9/21 7:38
 */
public class LoadStartListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();
//        获取当前项目名，赋值给APP_PATH
        servletContext.setAttribute("APP_PATH",servletContext.getContextPath());

    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
