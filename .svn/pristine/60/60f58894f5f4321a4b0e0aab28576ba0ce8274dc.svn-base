// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {


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


    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var GZBZNo = $.MvcSheetUI.GetControlValue("GZBZNo");
        if (GZBZNo == "") {
            // 获取生成收文编号相关数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "OAOfficeHandler.ashx?Command=generateNo",   //处理页的相对地址
                data: {
                    flg: "GZBZ"
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("GZBZNo", ret);
                }
            });
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") { 

    } 
    $("input[data-datafield='BZDate']").attr("disabled", "disabled");
    $("input[data-datafield='GZBZNo']").attr("disabled", "disabled");
}


