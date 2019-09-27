<%--
  Created by IntelliJ IDEA.
  role: 71042
  Date: 2019/9/21
  Time: 7:37
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
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li style="padding-top:8px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-role"></i> ${loginUser.username} <span class="caret"></span>
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
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="queryBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteroles()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/role/toAddPage'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="forDeleteForm">
                            <table class="table  table-bordered">
                                <thead>
                                <tr >
                                    <th width="30">#</th>
                                    <th width="30"><input type="checkbox" id="selectAll"></th>
                                    <th>名称</th>
                                    <th width="100">操作</th>
                                </tr>
                                </thead>
                                <tbody>


                                </tbody>
                                <tfoot>

                                <tr >

                                    <td colspan="6" align="center" >
                                        <ul class="pagination">

                                        </ul>
                                    </td>

                                </tr>

                                </tfoot>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
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
        getPageNo(1,3);
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });
    $("#queryBtn").click(function () {
        var queryFlag=true;
        if ($("#queryText").val()==null){
            queryFlag=false;
        }
        getPageNo(1,3,queryFlag);
    })
    function toEditPage(uid) {
        window.location.href='${APP_PATH}/role/toEditPage?id='+uid;
    }

    function deleteroles() {
        var roleData=$("#roleIds:checked")
        if (roleData.length==0){
            layer.msg("请选择你要删除的角色", {time:1000, icon:0, shift:6}, function () {});
            return;
        }
        layer.confirm("是否要删除选中角色",  {icon: 3, title:'提示'}, function(cindex){
            //确认回调函数
            $.ajax({
                url:"${APP_PATH}/role/deleteroles",
                data:$("#forDeleteForm").serialize(),
                method:'POST',
                success:function (result) {
                    if (result.success){
                        layer.msg("删除成功", {time:1000, icon:6}, function () {});

                        getPageNo(1,3);
                    }
                    else{
                        layer.msg("删除失败", {time:1000, icon:5, shift:6}, function () {});

                    }
                }
            })
            layer.close(cindex);
        }, function(cindex){

            layer.close(cindex);
        });
    }
    function deleterole(id,roleName) {


        if (id==''){
            layer.msg("请选择你要删除的角色", {time:1000, icon:0, shift:6}, function () {});
            return;
        }
        layer.confirm("是否要删除角色:"+roleName,  {icon: 3, title:'提示'}, function(cindex){
            //确认回调函数
            $.ajax({
                url:"${APP_PATH}/role/deleteRole",
                data:{id:id},
                method:'POST',
                success:function (result) {
                    if (result.success){
                        layer.msg("删除成功", {time:1000, icon:6}, function () {});

                        getPageNo(1,3);
                    }
                    else{
                        layer.msg("删除失败", {time:1000, icon:5, shift:6}, function () {});

                    }
                }
            })
            layer.close(cindex);
        }, function(cindex){

            layer.close(cindex);
        });
    }
    //全选按钮选中的检查
    $("#selectAll").click(function () {

        if (this.checked){
            $("input[name='roleIds']").prop("checked",true);
        }else{
            $("input[name='roleIds']").prop("checked",false);
        }
    })
    //如果单个按钮被选中检查
    function checkIsSelectedAll(pageSize){
        var checkedNum=0;
        $("input[name='roleIds']").each(function (i) {
            if (this.checked) {
                checkedNum++;
            }
        })

        if((checkedNum)==(pageSize)){
            $("#selectAll").prop("checked",true);
        }else {
            $("#selectAll").prop("checked",false);
        }
    }
    function toAssignPermissionPage(id) {
        window.location.href="${APP_PATH}/permission/toAssignPermissionPage?id="+id;
    }

    function getPageNo(page_no,page_size,queryFlag) {
        var jsonData={pageNo : page_no, pageSize : page_size};
        if (queryFlag){
            jsonData.queryText=$("#queryText").val();
        }
        $.ajax({
            url :'${APP_PATH}/role/getPageNo',
            data:jsonData ,
            method : 'POST',
            beforeSend : function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){


                    var  tbodyContent="";
                    var navigateInfo="";
                    $.each(result.data.list,function (i,role) {
                        tbodyContent+="  <tr>"
                        tbodyContent+="  <td>"+(i+1)+"</td>"
                        tbodyContent+="  <td><input type='checkbox' onclick='checkIsSelectedAll("+result.data.pageSize+")' id='roleIds' name='roleIds' value='"+role.id+"'></td>"
                        tbodyContent+="      <td>"+role.roleName+"</td>"
                        tbodyContent+="      <td>"
                        tbodyContent+="      <button type='button' class='btn btn-success btn-xs' onclick='toAssignPermissionPage("+role.id+")'><i class=' glyphicon glyphicon-check'></i></button>"
                        tbodyContent+="  <button type='button' class='btn btn-primary btn-xs' onclick='toEditPage("+role.id+")'><i class=' glyphicon glyphicon-pencil'></i></button>"
                        tbodyContent+="  <button type='button' class='btn btn-danger btn-xs' onclick=\"deleterole('"+role.id+"','"+role.roleName+"')\"><i class='glyphicon glyphicon-remove'></i></button>"
                        tbodyContent+="  </td>"
                        tbodyContent+="  </tr>"

                    })
                    if(result.data.hasPreviousPage){
                        navigateInfo+='<li ><a href="#" onclick="getPageNo('+(result.data.pageNum-1)+',3)">上一页</a></li>'
                    }
                    else{
                        navigateInfo+='<li class="disabled"><a href="#">上一页</a></li>'

                    }
                    $.each(result.data.navigatepageNums,function (i,page) {

                        if(result.data.pageNum==page){
                            navigateInfo+=  ' <li class="active"><a href="#">'+page+' <span class="sr-only">(current)</span></a></li>';
                        }else{
                            navigateInfo+=  ' <li ><a href="#" onclick="getPageNo('+page+',3)">'+page+ '<span class="sr-only">(current)</span></a></li>';

                        }

                    })
                    if(result.data.hasNextPage){
                        navigateInfo+='<li ><a href="#" onclick="getPageNo('+(result.data.pageNum+1)+',3)">下一页</a></li>'
                    }
                    else{
                        navigateInfo+='<li class="disabled"><a href="#">下一页</a></li>'

                    }
                    $(".table tbody").html(tbodyContent);
                    $(".pagination").html(navigateInfo);

                } else {
                    layer.msg("分页获取失败请刷新页面", {time:1000, icon:5, shift:6}, function () {
                    });
                }
            }
        })
    }
</script>
</body>
</html>

