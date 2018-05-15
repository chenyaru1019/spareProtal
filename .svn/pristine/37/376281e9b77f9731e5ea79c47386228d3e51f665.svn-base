//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    var QKSubObjectIDs = getUrlParam("QKSubObjectIDs");
    if (ContractNo != null && ContractNo != "") {
        
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
                var amount = ret.ContractTotalPrice + "人民币 " + ret.JKTotalAmount + ret.CurrencyName;
                $.MvcSheetUI.SetControlValue("ContractTotalAmount", amount);
            }
        });

    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var amount = ret.ContractTotalPrice + "人民币 " + ret.JKTotalAmount + ret.CurrencyName;
                $.MvcSheetUI.SetControlValue("ContractTotalAmount", amount);
            }
        });
    }

    // TODO
    //if (QKSubObjectIDs != null && QKSubObjectIDs != "") {
    //}


    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='ContractTotalAmount']").attr("disabled", "disabled");
    $("[data-datafield='PlanTbl.QKDetail']").attr("disabled", "disabled");

    // 只显示保存按钮
    $("li[data-action='Submit']").hide();
    $("li[data-action='Print']").hide();
    $("li[data-action='Forward']").hide();
    //$("li[data-action='ViewInstance']").hide();
}


// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Save" || this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("PlanTbl").SheetGridView();
            for (var i = 0; i < dtl.RowCount; i++) {
                var ExpirationFrom = $.MvcSheetUI.GetControlValue("PlanTbl.ExpirationFrom", i + 1);
                var ExpirationTo = $.MvcSheetUI.GetControlValue("PlanTbl.ExpirationTo", i + 1);
                var IsAfterDK = $.MvcSheetUI.GetControlValue("PlanTbl.IsAfterDK", i + 1);
                // 选中(选中为" " ,没选中没"")
                if (ExpirationTo == "" && IsAfterDK == "") {
                    layer.alert('请填写有效期结束日或勾选是否到款后！', { icon: 2 });
                    return false;
                } 
            }

        }
    }
    return true;
}

function getQKDetailByCurrency(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var QKCurrency = $.MvcSheetUI.GetControlValue('PlanTbl.QKCurrency', rowIndex - 1);
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var QKSeq = QKCurrency.split(':')[0].replace("批次", "");
    var Currency = QKCurrency.split(':')[1];
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getQKDetailByCurrency",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            QKSeq: QKSeq,
            Currency: Currency,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.MvcSheetUI.SetControlValue('PlanTbl.QKDetail', ret , rowIndex - 1);
            $("[data-datafield='PlanTbl.QKDetail']").attr("disabled", "disabled");
        }
    });
}
