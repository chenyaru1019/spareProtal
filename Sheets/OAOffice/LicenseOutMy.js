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

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") {
        if (this.Action == "Submit") {

        }
    }
    return true;
}

//}
//数据加载后
$.MvcSheet.Loaded = function () {

    $.MvcSheetUI.SetControlValue("OrigOrOuterFlg", "");
    // 不显示 按钮
    $("li[data-action='OrigAction']").hide();
    $("li[data-action='OuterAction']").hide();

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOfficeSign") 
    {
        // 显示 按钮
        $("li[data-action='OrigAction']").show();
        $("li[data-action='OuterAction']").show();
    }
    
}

// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "OrigAction",
    Icon: "fa-check",           // 按钮图标
    Text: "发起人确认",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {

        layer.confirm('确认要走发起人确认吗？', function (index) {

            $.MvcSheetUI.SetControlValue("OrigOrOuterFlg", "orig");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "OuterAction",
    Icon: "fa-check",           // 按钮图标
    Text: "携带印章外出",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        // 验证外出人员是否为空
        if ($.MvcSheetUI.GetControlValue("LOuter") == "") {
            layer.alert('走携带印章外出时，请选择外出人员！', { icon: 2 });
            return false;
        }
        layer.confirm('确认要走携带印章外出吗？', function (index) {

            $.MvcSheetUI.SetControlValue("OrigOrOuterFlg", "outer");
            // 提交
            $.MvcSheet.Submit2(this);
        });
    },
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

function LicenceTypeChange() {
    var dtl = $.MvcSheetUI.GetElement('OutDetails').SheetGridView();
    var len = dtl.RowCount;
    var LicenceNameHide = $.MvcSheetUI.GetControlValue('LicenceNameHide');
    var LicenceNoHide = $.MvcSheetUI.GetControlValue('LicenceNoHide');
    var LicenceTypeHide = $.MvcSheetUI.GetControlValue('LicenceTypeHide');
    dtl._AddRow();
    $.MvcSheetUI.SetControlValue("OutDetails.LicenseName", LicenceNameHide, len + 1);
    $.MvcSheetUI.SetControlValue("OutDetails.LicenseNo", LicenceNoHide, len + 1);
    $.MvcSheetUI.SetControlValue("OutDetails.LicenseType", LicenceTypeHide, len + 1);
    $("input[data-datafield='OutDetails.LicenseName']").attr("disabled", "disabled");
    $("input[data-datafield='OutDetails.LicenseNo']").attr("disabled", "disabled");
    $("input[data-datafield='OutDetails.LicenseType']").attr("disabled", "disabled");
    return;
}