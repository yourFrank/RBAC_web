<%--
  Created by IntelliJ IDEA.
  User: 71042
  Date: 2019/9/25
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-sm-3 col-md-2 sidebar">
    <div class="tree">
        <ul style="padding-left:0px;" class="list-group">

        <c:forEach items="${rootPermission.children}" var="permission">
            <li class="list-group-item tree-closed" >
                <c:if test="${empty permission.children}">

                <a href="${APP_PATH}${permission.url}"><i class="glyphicon glyphicon-dashboard"></i> ${permission.name}</a>
                </c:if>
                    <c:if test="${!empty permission.children}">
                        <span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理 <span class="badge" style="float:right">3</span></span>
                        <ul style="margin-top:10px;">
                        <c:forEach items="${permission.children}" var="permissionChild">
                            <li style="height:30px;">
                                <a href="${APP_PATH}${permissionChild.url}" style="color:red;"><i class="glyphicon glyphicon-user"></i> ${permissionChild.name}</a>
                            </li>
                        </c:forEach>
                        </ul>
                    </c:if>
                </li>
        </c:forEach>
        </ul>

    </div>
</div>

