﻿//$.MvcSheet.SaveAction.OnActionPreDo = function () {
//    var BusinessType = $.MvcSheetUI.GetControlValue("BusinessType");
//    var Title = $.MvcSheetUI.GetControlValue("Title");
//    var IntendToMakeComments = $.MvcSheetUI.GetControlValue("IntendToMakeComments");
//    var AttachmentUpload = $.MvcSheetUI.GetControlValue("AttachmentUpload");
//    var ApplicationNumber = $.MvcSheetUI.GetControlValue("ApplicationNumber");
//    if (BusinessType == '') {
//        layer.alert('业务类型不能为空！', { icon: 2 });
//        return false;
//    }
//    if (Title == '') {
//        alert("标题不能为空！");
//        return false;
//    }
//    if (IntendToMakeComments == '') {
//        alert("拟办意见不能为空！");
//        return false;
//    }
//    if (AttachmentUpload == '') {
//        alert("附件上传不能为空！");
//        return false;
//    }
//    if (ApplicationNumber == '') {
//        alert("申请编号不能为空！");
//        return false;
//    }

//}
function generateEmployeeHumanNo() {
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeHumanHandler.ashx?Command=generateEmployeeHumanNo",   //处理页的相对地址
        data: {
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.MvcSheetUI.SetControlValue("ApplicationNumber", ret);

        }
    });
}

$.MvcSheet.Loaded = function () {
    generateEmployeeHumanNo();
    $.MvcSheetUI.SetControlValue("DepartmentsJointlySignButton", "false");
    $("#generateEmployeeHumanNoId").hide();
    $(".DepartmentsJointlySign").hide();
    $(".FirstGradeCountersignedOpinion").hide();
    $.MvcSheetUI.SetControlValue("TwoLevelCountersignedButton", "false");
    $(".TwoLevelCountersignedPersonnel").hide();
    $(".TwoLevelCountersignedOpinion").hide();
    // 不显示相关部门审批按钮
    $("li[data-action='DepartmentsJointlyAction']").hide();
    $("li[data-action='TwoLevelCountersignedAction']").hide();
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApproval") {
        $("#generateEmployeeHumanNoId").show();
        $("li[data-action='DepartmentsJointlyAction']").show();
        $(".DepartmentsJointlySign").show();
        // 获取相关部门审批的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "EmployeeHumanHandler.ashx?Command=getCommentByFlg",   //处理页的相对地址
            data: {
                InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
                flg: "ActivityDepartmentsJointly"
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $(".FirstGradeCountersignedOpinion").show();
                }
            }
        });
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityDepartmentsJointly") {
        $("li[data-action='DepartmentsJointlyAction']").hide();
        $(".FirstGradeCountersignedOpinion").show();

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {
        $("li[data-action='TwoLevelCountersignedAction']").show();
        $(".TwoLevelCountersignedPersonnel").show();
        // 获取相关部门审批的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "EmployeeHumanHandler.ashx?Command=getCommentByFlg",   //处理页的相对地址
            data: {
                InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
                flg: "ActivityTwoLevelCountersigned"
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $(".TwoLevelCountersignedOpinion").show();
                }
            }
        });
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityTwoLevelCountersigned") {
        $(".TwoLevelCountersignedOpinion").show();
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOfficeComplete") {
        
    }
    $("input[data-datafield='ApplicationDate']").attr("disabled", "disabled");
    $("input[data-datafield='ApplicationNumber']").attr("disabled", "disabled");

}


// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "DepartmentsJointlyAction",
    Icon: "fa-check",           // 按钮图标
    Text: "相关部门会签",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        var BusinessType = $.MvcSheetUI.GetControlValue("BusinessType");
        var Title = $.MvcSheetUI.GetControlValue("Title");
        var IntendToMakeComments = $.MvcSheetUI.GetControlValue("IntendToMakeComments");
        var AttachmentUpload = $.MvcSheetUI.GetControlValue("AttachmentUpload");
       // var tr = document.getElementsByClassName('table table-striped')[0].getElementsByTagName('tbody')[0];
        var tr = document.getElementsByClassName('InvalidText')
        if (tr.length>0) {
            layer.alert('必填项不能为空！', { icon: 2 });
            return false;
        }
       
        var ApplicationNumber = $.MvcSheetUI.GetControlValue("ApplicationNumber");
        //if (BusinessType == '') {
        //    layer.alert('业务类型不能为空！', { icon: 2 });
        //    return false;
        //}
        //if (Title == '') {
        //    layer.alert('标题不能为空！', { icon: 2 });
        //    return false;
        //}
        //if (IntendToMakeComments == '') {
        //    layer.alert('拟办意见不能为空！', { icon: 2 });
        //    return false;
        //}
        //if (AttachmentUpload == '') {
        //    layer.alert('附件上传不能为空！', { icon: 2 });
        //    return false;
        //}
        //if (ApplicationNumber == '') {
        //    layer.alert('申请编号不能为空！', { icon: 2 });
        //    return false;
        //}
        var DepartmentsJointlySign = $.MvcSheetUI.GetControlValue("DepartmentsJointlySign");
        if (DepartmentsJointlySign == "") {
            layer.alert('请选择相关部门审批人！', { icon: 2 });
            return false;
        }
        layer.confirm('确认相关部门审批吗？', function (index) {

            $.MvcSheetUI.SetControlValue("DepartmentsJointlySignButton", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });


    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});
$.MvcSheet.AddAction({
    Action: "TwoLevelCountersignedAction",
    Icon: "fa-check",           // 按钮图标
    Text: "相关人员会签",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        var TwoLevelCountersignedPersonnel = $.MvcSheetUI.GetControlValue("TwoLevelCountersignedPersonnel");
        if (TwoLevelCountersignedPersonnel == "") {
            layer.alert('请选择相关人员审批！', { icon: 2 });
            return false;
        }
        layer.confirm('确认相关人员审批吗？', function (index) {

            $.MvcSheetUI.SetControlValue("TwoLevelCountersignedButton", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });


    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

