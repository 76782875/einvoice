<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {

        $('#organizationId').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
        });

        $('#roleIds').combotree({
            url: '${path }/role/tree',
            multiple: true,
            required: true,
            panelHeight : 'auto'
        });

        $('#userAddForm').form({
            url : '${path }/user/add',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="userAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>登录名</td>
                    <td><input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-validatebox" data-options="required:true" value=""></td>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入姓名" class="easyui-validatebox" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input name="password" type="password" placeholder="请输入密码" class="easyui-validatebox" data-options="required:true"></td>
                    <td>商户类型</td>
                    <td>
                        <select name="userType" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">管理员</option>
                            <option value="1" selected="selected">用户</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>客户</td>
                    <td><select id="organizationId" name="organizationId" style="width: 140px; height: 29px;" class="easyui-validatebox" data-options="required:true"></select></td>
                    <td>角色</td>
                    <td><select id="roleIds" name="roleIds" style="width: 140px; height: 29px;"></select></td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>
                        <input type="text" name="phone" class="easyui-numberbox" data-options="required:true"/>
                    </td>
                    <td>商户状态</td>
                    <td>
                        <select id="status" name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                                <option value="0">正常</option>
                                <option value="1">停用</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>商户编码</td>
                    <td><input name="merchant_code" type="text" placeholder="请输入商户编码" class="easyui-validatebox"  value="" data-options="required:true"></td>
                    <td>商户名称</td>
                    <td><input name="merchant_name" type="text" placeholder="请输入商户名称" class="easyui-validatebox"  value="" data-options="required:true"></td>
                </tr>
                <tr>
                    <td>邮箱</td>
                    <td><input name="email" type="text" placeholder="请输入邮箱" class="easyui-validatebox"  value=""></td>
                    <td>应用系统</td>
                    <td><input name="app_no" type="text" placeholder="请输入应用系统" class="easyui-validatebox"  value=""></td>
                </tr>
            </table>
        </form>
    </div>
</div>