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
    

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var YYSQNo = $.MvcSheetUI.GetControlValue("YYSQNo");
        if (YYSQNo == "") {
            // 获取生成收文编号相关数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "OAOfficeHandler.ashx?Command=generateNo",   //处理页的相对地址
                data: {
                    flg: "YYSQ"
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("YYSQNo", ret);
                }
            });
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") { 

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFGManager") 
    {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") 
    {
        
    }
    $("input[data-datafield='ApplyDate']").attr("disabled", "disabled");
    $("input[data-datafield='YYSQNo']").attr("disabled", "disabled");
    
}


