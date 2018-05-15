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
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") { 

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFGenManager") 
    {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") 
    {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") 
    {
        
    }
    $("input[data-datafield='Updator']").attr("disabled", "disabled");
    $("input[data-datafield='UpdateTime']").attr("disabled", "disabled");
    $("input[data-datafield='CreateTime']").attr("disabled", "disabled");
}


