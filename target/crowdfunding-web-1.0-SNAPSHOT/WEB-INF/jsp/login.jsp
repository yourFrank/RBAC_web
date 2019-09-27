<%--
  Created by IntelliJ IDEA.
  User: 71042
  Date: 2019/9/19
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">
    <form class="form-signin" action="login" method="post" role="form" id="login-form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="username" name="loginAccount"
    value="${flag==true?loginUser.loginAccount:''}"
    placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="password" name="password"
                   value="${flag==true?loginUser.password:''}"
                   placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option value="member">会员</option>
                <option value="user">管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" id="remember-me" value="remember-me" > 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="layer/layer.js"></script>
<script>


    function dologin() {
         if ($("#loginAccount").val()==""){
             layer.msg("请填写用户名", {time:1000, icon:5, shift:6}, function () {

             });
             return;
         }
        if ($("#password").val()==''){
            layer.msg("请填写密码", {time:1000, icon:5, shift:6}, function () {
            });
            return;
        }
       $.ajax({
            url : 'AjaxLogin',
            method : 'POST' ,
            data :  $("#login-form").serialize(),
            beforeSend :function () {
                 loadingIndex = layer.msg('处理中', {icon: 16});

            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    if ($("#remember-me").is(':checked')) {
                        window.location.href='main?flag=true';
                    }else{
                        window.location.href='main?flag=false';
                    }

                } else {
                    layer.msg("用户名密码错误请重新输入", {time:1000, icon:5, shift:6}, function () {
                    });
                }
            }
        })

    }
</script>
</body>
</html>
