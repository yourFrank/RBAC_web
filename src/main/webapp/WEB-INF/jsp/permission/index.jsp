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
    <link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">

    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
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
                        <button type="button" class="btn btn-default btn-success dropdown-toggle"
                                data-toggle="dropdown">
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>数据列表 </h3>
                </div>
                <div class="panel-body">
                    <ul id="permissionTree" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
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
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    function deletePermission(id) {
        // if (treeNode.id==''){
        //     layer.msg("请选择你要删除的权限", {time:1000, icon:0, shift:6}, function () {});
        //     return;
        // }
        layer.confirm("是否要删除",  {icon: 3, title:'提示'}, function(cindex){
            //确认回调函数
            $.ajax({
                url:"${APP_PATH}/permission/deletePermission",
                data:{id:id},
                method:'POST',
                success:function (result) {
                    if (result.success){
                        layer.msg("删除成功", {time:1000, icon:6}, function () {});
                        var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
                        treeObj.reAsyncChildNodes(null,"refresh");
                    }
                    else{
                        layer.msg("删除失败", {time:1000, icon:5, shift:6}, function () {});

                    }
                }
            });
            layer.close(cindex);
        }, function(cindex){

            layer.close(cindex);
        });
    }
    function toEditPermissionPage(id) {
        window.location.href="${APP_PATH}/permission/toEditPage?id="+id;
    }
    function toAddPermissionPage(id) {
        window.location.href="${APP_PATH}/permission/toAddPage?pid="+id;
    }
    var setting = {
        view: {
            selectedMulti: false,
            addDiyDom: function(treeId, treeNode){
                var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                if ( treeNode.icon ) {
                    icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                }

            },
            addHoverDom: function(treeId, treeNode){
                //   <a><span></span></a>
                var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                aObj.attr("href", "javascript:;");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="toAddPermissionPage('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" onclick="toEditPermissionPage('+treeNode.id+')"  title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children.length == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deletePermission('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="toAddPermissionPage('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" onclick="toEditPermissionPage('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deletePermission('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom: function(treeId, treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            }
        },
        async: {
            enable: true,
            url:"${APP_PATH}/permission/loadData",
            autoParam:["id", "name=n", "level=lv"]
        },
        callback: {
            onClick : function(event, treeId, json) {

            }
        }
    };

    <%--var setting = {async:{--%>
    <%--    enable:true,--%>
    <%--        url:"${APP_PATH}/permission/loadData",--%>
    <%--        autoParam:["id","name=n","level=lv"]--%>
    <%--    }};--%>

    // var zNodes = [
    //     {
    //         name: "父节点1", children: [
    //             {name: "子节点1"},
    //             {name: "子节点2"}
    //         ]
    //     }
    // ];
    $.fn.zTree.init($("#permissionTree"), setting);
</script>
</body>
</html>

