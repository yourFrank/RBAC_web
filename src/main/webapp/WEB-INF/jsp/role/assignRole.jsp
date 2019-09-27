<%--
  Created by IntelliJ IDEA.
  User: 71042
  Date: 2019/9/22
  Time: 15:41
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
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li style="padding-top:8px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-user"></i> ${loginUser.username} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                            <li class="divider"></li>
                            <li><a href="${APP_PATH}/logOut"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                        </ul>
                    </div>
                </li>
                <li style="margin-left:10px;padding-top:8px;">
                    <button type="button" class="btn btn-default btn-danger">
                        <span class="glyphicon glyphicon-question-sign"></span> 帮助
                    </button>
                </li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" id="roleForm" class="form-inline">
                        <input type="hidden" value="${uid}" name="uid">
                        <div class="form-group">
                            <label for="unassignedList">未分配角色列表</label><br>
                            <select class="form-control" name="unassignedList" multiple size="10" id="unassignedList" style="width:100px;overflow-y:auto;">

                            <c:forEach items="${unassignedRole}"  var="role">
                                <option value="${role.id}">${role.roleName}</option>
                            </c:forEach>

                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li class="btn btn-default glyphicon glyphicon-chevron-right" id="toAssignedList"></li>
                                <br>
                                <li class="btn btn-default glyphicon glyphicon-chevron-left" id="toUnAssignedList" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="assignedList">已分配角色列表</label><br>
                            <select class="form-control" id="assignedList" name="assignedList" multiple size="10" style="width:100px;overflow-y:auto;">

                                <c:forEach items="${assignedRole}"  var="role">
                                    <option value="${role.id}">${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/layer/layer.js"></script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    
    $("#toAssignedList").click(function () {

        var role_id=$("#unassignedList :selected");
        if (role_id.length==0) {
            layer.msg("请选择你要添加的角色", {time:1000, icon:0, shift:6}, function () {});
            return ;
        }
        $.ajax({
            url:'${APP_PATH}/role/assignedRole',
            data:
                $("#roleForm").serialize()
            ,
            contentType:false,
            processDate:false,
            method:'POST',
            success:function (result) {
                if (result.success){
                    role_id.appendTo("#assignedList");
                    layer.msg("添加角色成功", {time:1000, icon:6}, function () {});

                }
                else{
                    layer.msg("添加角色失败", {time:1000, icon:5, shift:6}, function () {});

                }
            }
        })
    })

    $("#toUnAssignedList").click(function () {
        var role_id=$("#assignedList :selected");
        if (role_id.length==0) {
            layer.msg("请选择你要移除的角色", {time:1000, icon:0, shift:6}, function () {});
            return ;
        }

        $.ajax({
            url:'${APP_PATH}/role/unassignedRole',
            data:$("#roleForm").serialize(),
            method:'POST',
            success:function (result) {
                if (result.success){
                    role_id.appendTo("#unassignedList");
                    layer.msg("移除角色成功", {time:1000, icon:6}, function () {});

                }
                else{
                    layer.msg("移除角色失败", {time:1000, icon:5, shift:6}, function () {});

                }
            }
        })
    })
</script>
</body>
</html>

