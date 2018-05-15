﻿//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    // InstanceId
    var NeedInstanceId = getUrlParam("InstanceId");
    if (ContractNo != null && ContractNo != ""
        && NeedInstanceId != null && NeedInstanceId != "") {
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                $.MvcSheetUI.SetControlValue("ContractNo", ret.ContractNo);
                $.MvcSheetUI.SetControlValue("ContractName", ret.ContractName);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);
                $.MvcSheetUI.SetControlValue("TradeMethod", ret.TradeMethodName);
                $.MvcSheetUI.SetControlValue("FinalUser", ret.FinalUser);
                $.MvcSheetUI.SetControlValue("Salers", ret.Salers);
                $.MvcSheetUI.SetControlValue("BidNo", ret.BidNo);
                var ContractAmount = "";
                if (ret.CurrencyName == "") {
                    ContractAmount = ret.ContractTotalPrice + "人民币";
                } else {
                    ContractAmount = ret.ContractTotalPrice + " 人民币 " + ret.JKTotalAmount + " " + ret.CurrencyName;
                }
                $.MvcSheetUI.SetControlValue("ContractAmount", ContractAmount);
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
            }
        });
        // 设置数据
        $.MvcSheetUI.SetControlValue("NeedInstanceId", NeedInstanceId);
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='ContractType']").attr("disabled", "disabled");
    $("input[data-datafield='ContractProperty']").attr("disabled", "disabled");
    $("input[data-datafield='TradeMethod']").attr("disabled", "disabled");
    $("input[data-datafield='FinalUser']").attr("disabled", "disabled");
    $("input[data-datafield='Salers']").attr("disabled", "disabled");
    $("input[data-datafield='BidNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractAmount']").attr("disabled", "disabled");
}


// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYCompanyLeader" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCompanyLeader") {
            doCancel();
        }
    }
}

// 取消流程
function doCancel() {
    var NeedInstanceId = $.MvcSheetUI.GetControlValue("NeedInstanceId");
    // ------ 取消
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/InstanceDetail/CancelInstance",   //处理页的相对地址
        async: false,
        data: {
            InstanceID: NeedInstanceId,
        },
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.SUCCESS == true) {
                console.log("终止流程成功！");
            } else {
                layer.alert('终止流程失败！', { icon: 2 });
            }
        }
    });
}

