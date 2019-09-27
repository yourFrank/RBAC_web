package com.ty.crowdfunding.controller;

import com.ty.crowdfunding.bean.AjaxResult;
import com.ty.crowdfunding.bean.Permission;
import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.service.LoginService;
import com.ty.crowdfunding.service.PermissionService;
import com.ty.crowdfunding.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description TODO
 * @Author 71042
 * @Date 2019/9/19 20:27
 */
@Controller
public class DispatcherController {

    @Autowired
    private LoginService loginService;
    @Autowired
    private PermissionService permissionService;



    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/error")
    public String toError(){
        return "error";
    }

    /*
    @RequestMapping(value = "/login")
    public String toLogin(User user,String flag, Model model,HttpSession session){
        User dbUser = loginService.getUserByUsername(user);
        if (dbUser!=null){
            session.setAttribute("loginUser",dbUser);
            return "main";
        }else{
            model.addAttribute("errorMsg","用户名或密码错误");
            return "redirect:toLogin";
        }

    }

     */

    @RequestMapping("/logOut")
    public String logOut(HttpSession session){
        session.invalidate();
        return "redirect:toLogin";
    }

    @RequestMapping("/AjaxLogin")
    @ResponseBody
    public Object AjaxLogin(User user, boolean flag, HttpSession session, HttpServletRequest request){
        AjaxResult ajaxResult=new AjaxResult();
        String contextPath = request.getContextPath();
        User dbUser = loginService.getUserByUsername(user);
        if (dbUser!=null){
            session.setAttribute("loginUser", dbUser);
            List<Permission> permissionList=permissionService.getPermissionByUser(dbUser);

            Map<Integer,Permission> permissionMap=new HashMap<Integer, Permission>();
            for (Permission permission : permissionList) {
                permissionMap.put(permission.getId(), permission);
            }
            Permission rootPermission=null;
            for (Permission permission : permissionList) {
                if (permission.getPid()==0){
                    rootPermission=permission;
                }
                else {
                    //如果该节点是子节点
                    //找到map中的父节点，将该节点添加到map中对应的父节点中
                    permissionMap.get(permission.getPid()).getChildren().add(permission);
                }
            }
            session.setAttribute("rootPermission",rootPermission);
            ajaxResult.setSuccess(true);

        }else{
            ajaxResult.setSuccess(false);
        }
        return ajaxResult;
    }

    @RequestMapping("/main")
    public String toMainPage(Boolean flag,HttpSession session){
        session.setAttribute("flag", flag);
        return "main";
    }
}
