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

    $.MvcSheetUI.SetControlValue("YesNoFlg", "Yes");
    // 不显示不同意按钮
    $("li[data-action='NoAction']").hide();

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var FWNo = $.MvcSheetUI.GetControlValue("FWNo");
        if (FWNo == "") {
            // 获取生成收文编号相关数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "OAOfficeHandler.ashx?Command=generateNo",   //处理页的相对地址
                data: {
                    flg: "FW"
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("FWNo", ret);
                }
            });
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") { 

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFGenManager") 
    {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") 
    {
        // 显示不同意按钮
        $("li[data-action='NoAction']").show();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") 
    {
        
    }
    $("input[data-datafield='FWDate']").attr("disabled", "disabled");
    $("input[data-datafield='FWNo']").attr("disabled", "disabled");
    
}

// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "NoAction",
    Icon: "fa-check",           // 按钮图标
    Text: "不同意",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        layer.confirm('确认不同意吗？', function (index) {

            $.MvcSheetUI.SetControlValue("YesNoFlg", "No");
            // 提交
            $.MvcSheet.Submit2(this);
        });


    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

