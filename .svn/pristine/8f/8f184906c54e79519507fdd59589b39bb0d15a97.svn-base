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

    return true;
}

//}
//数据加载后
$.MvcSheet.Loaded = function () {

    $.MvcSheetUI.SetControlValue("FGManagerFlg", "false");
    $.MvcSheetUI.SetControlValue("OfficeCompeleteFlg", "false");
    $.MvcSheetUI.SetControlValue("LGFYFlg", "false");
    $.MvcSheetUI.SetControlValue("FGenManagerFlg", "false");
    $("input[data-datafield='BidBusiTbl.Resources']").attr("disabled", "disabled");
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {

        // 不显示提交按钮
        $("li[data-action='Submit']").hide();
        $("li[data-action='LGFYAction']").hide();
        $("li[data-action='FGenManagerAction']").hide();
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOfficeComplete") { 
        // 不显示提交按钮
        $("li[data-action='Submit']").hide();
        $("li[data-action='FGManagerAction']").hide();
        $("li[data-action='OfficeCompeleteAction']").hide();
    } else 
    {
        // 显示按钮
        $("li[data-action='LGFYAction']").hide();
        $("li[data-action='FGenManagerAction']").hide();
        $("li[data-action='FGManagerAction']").hide();
        $("li[data-action='OfficeCompeleteAction']").hide();
    } 

    
}

// 分管领导审批
$.MvcSheet.AddAction({
    Action: "FGManagerAction",
    Icon: "fa-check",           // 按钮图标
    Text: "分管领导审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('涉及用餐标准超过人均75元等费用，确认分管领导审批吗？', function (index) {
            $.MvcSheetUI.SetControlValue("FGManagerFlg", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 综合办公室办结
$.MvcSheet.AddAction({
    Action: "OfficeCompeleteAction",
    Icon: "fa-check",           // 按钮图标
    Text: "综合办公室办结审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('确认综合办公室办结审批吗？', function (index) {
            $.MvcSheetUI.SetControlValue("OfficeCompeleteFlg", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 力工费用登记审批
$.MvcSheet.AddAction({
    Action: "LGFYAction",
    Icon: "fa-check",           // 按钮图标
    Text: "力工费用登记审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('确认力工费用登记审批吗？', function (index) {
            $.MvcSheetUI.SetControlValue("LGFYFlg", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 分管行政副总经理阅示
$.MvcSheet.AddAction({
    Action: "FGenManagerAction",
    Icon: "fa-check",           // 按钮图标
    Text: "分管行政副总经理审批",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('确认分管行政副总经理吗？', function (index) {
            $.MvcSheetUI.SetControlValue("FGenManagerFlg", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});
