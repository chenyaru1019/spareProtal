// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
            
        }
        
    }
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Submit") {

        }
    }
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") {
        if (this.Action == "Submit") {

        }
    }
    return true;
}

//}
//数据加载后
$.MvcSheet.Loaded = function () {

    $.MvcSheetUI.SetControlValue("ToOtherDep", "false");
    $.MvcSheetUI.SetControlValue("ToGenManager", "false");
    // 不显示 按钮
    $("li[data-action='OtherDepAction']").hide();
    $("li[data-action='GenManagerAction']").hide();
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var ApplyNo = $.MvcSheetUI.GetControlValue("ApplyNo");
        if (ApplyNo == "") {
            // 获取生成收文编号相关数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "OAOfficeHandler.ashx?Command=generateNo",   //处理页的相对地址
                data: {
                    flg: "HTBS"
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("ApplyNo", ret);
                }
            });
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") { 
        // 显示相关部门审批按钮
        $("li[data-action='OtherDepAction']").show();
        $("[data-datafield='OtherDepComment']").hide();
        // 获取相关部门审批的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "OAOfficeHandler.ashx?Command=getCommentByFlg",   //处理页的相对地址
            data: {
                InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
                flg: "ActivityOtherDep"
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $("[data-datafield='OtherDepComment']").show();
                }
            }
        });
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFGManager") 
    {
        // 显示总经理审批按钮
        $("li[data-action='GenManagerAction']").show();
        $("[data-datafield='GeneralManagerComment']").hide();
        // 获取总经理审批的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "OAOfficeHandler.ashx?Command=getCommentByFlg",   //处理页的相对地址
            data: {
                InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
                flg: "ActivityGenManager"
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $("[data-datafield='GeneralManagerComment']").show();
                }
            }
        });
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") 
    {

    } 
    $("input[data-datafield='ApplyDate']").attr("disabled", "disabled");
    $("input[data-datafield='ApplyNo']").attr("disabled", "disabled");
    
}

// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "OtherDepAction",
    Icon: "fa-check",           // 按钮图标
    Text: "相关部门审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        var OtherDepApprover = $.MvcSheetUI.GetControlValue("OtherDepApprover");
        if (OtherDepApprover == "") {
            layer.alert('请选择相关部门审批人！', { icon: 2 });
            return false;
        }
        layer.confirm('确认相关部门审批吗？', function (index) {

            $.MvcSheetUI.SetControlValue("ToOtherDep", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "GenManagerAction",
    Icon: "fa-check",           // 按钮图标
    Text: "总经理审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('确认总经理审批吗？', function (index) {

            $.MvcSheetUI.SetControlValue("ToGenManager", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});
