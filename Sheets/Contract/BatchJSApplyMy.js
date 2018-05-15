﻿// 表单验证接口
$.MvcSheet.Validate = function () {
    
}

//数据加载后
$.MvcSheet.Loaded = function () {
    //$("input[data-datafield='BatchJSTbl.ContractNo']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.ContractName']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.PostAB']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.DKAmount']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.FKAmount']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.BankFY']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.AgencyFY']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.OtherFY']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchJSTbl.JSResult']").attr("disabled", "disabled");

    // 隐藏导航栏
    $("#main-navbar").hide();

    $("input[data-datafield='JSStatus']").attr("disabled", "disabled");
    $("input[data-datafield='JSResult']").attr("disabled", "disabled");
    $(".ContractContent div[data-title='征询意见']").parent().hide();

}

function SelectAll() {
    var IsSelectAll = $("#IsSelectAll").prop("checked");
    if (IsSelectAll) {
        $("[data-datafield='BatchJSTbl']").find("tr.rows").each(function () {
            $(this).find("td[data-field='BatchJSTbl.IsCheck'] :checkbox").prop("checked", false);
        });
    } else {
        $("[data-datafield='BatchJSTbl']").find("tr.rows").each(function () {
            $(this).find("td[data-field='BatchJSTbl.IsCheck'] :checkbox").prop("checked", true);
        });
    }
    $("[data-datafield='BatchJSTbl']").find("tr.rows").each(function () {
        $(this).find("td[data-field='BatchJSTbl.IsCheck'] :checkbox").click();
    });
}

function Search() {
    var JS_Target = $("[data-datafield='JS_Target']").find("option:selected").text(); // $.MvcSheetUI.GetControlValue("JS_Target");
    if (JS_Target != "请选择") {
        // 查询批量结算的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getJSLSData",   //处理页的相对地址
            data: {
                JS_Target: JS_Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BatchJSTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.ContractNo", ret[i].ContractNo, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.ContractNoHidden", ret[i].ContractNoHidden, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.ContractName", ret[i].ContractName, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.ContractProperty", ret[i].ContractProperty, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.PostAB", ret[i].PostAB, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.DKAmount", ret[i].DKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.FKAmount", ret[i].FKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.BankFY", ret[i].BankFY, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.AgencyFY", ret[i].AgencyFY, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.OtherFY", ret[i].OtherFY, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.JSResult", ret[i].JSResult, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.Cnt", ret[i].Cnt, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchJSTbl.JSObjectID", ret[i].JSObjectID, i + 1);
                    
                }

                $("input[data-datafield='BatchJSTbl.ContractNo']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.ContractNoHidden']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.ContractName']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.ContractProperty']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.PostAB']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.DKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.FKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.BankFY']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.AgencyFY']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.OtherFY']").attr("disabled", "disabled");
                $("input[data-datafield='BatchJSTbl.JSResult']").attr("disabled", "disabled");
            }
        });

        // 子表的合并单元格操作
        var dtl = $.MvcSheetUI.GetElement("BatchJSTbl").SheetGridView();
        var len = dtl.RowCount;
        var ContractNoHidden = "";
        if (len > 0) {
            for (var i = 0; i < len; i++) {

                if (ContractNoHidden == "" || ContractNoHidden != $.MvcSheetUI.GetControlValue("BatchJSTbl.ContractNoHidden", i + 1)) {
                    ContractNoHidden = $.MvcSheetUI.GetControlValue("BatchJSTbl.ContractNoHidden", i + 1);
                    var Cnt = $.MvcSheetUI.GetControlValue("BatchJSTbl.Cnt", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchJSTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchJSTbl.ContractNo']").attr("rowspan", Cnt);
                            $(this).find("td[data-field='BatchJSTbl.ContractName']").attr("rowspan", Cnt);
                        }
                        k++;
                    });
                } else {
                    ContractNoHidden = $.MvcSheetUI.GetControlValue("BatchJSTbl.ContractNoHidden", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchJSTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchJSTbl.ContractNo']").remove();
                            $(this).find("td[data-field='BatchJSTbl.ContractName']").remove();
                        }
                        k++;
                    });
                }
            }
        }
    } else {
        var dtl = $.MvcSheetUI.GetElement("BatchJSTbl").SheetGridView();
        dtl._Clear();
    }
}

// 点击下一步时
function BatchJSApply() {
    var IsCheckCnt = 0;
    var dtl_js = $.MvcSheetUI.GetElement("BatchJSTbl").SheetGridView();
    var JSObjectIDs = "";
    var ContractProperty = "";
    for (var i = 0; i < dtl_js.RowCount; i++) {
        var IsCheck = $.MvcSheetUI.GetControlValue("BatchJSTbl.IsCheck", i + 1);
        // 选中(选中为" " ,没选中没"")
        if (IsCheck == "是;") {
            JSObjectIDs += $.MvcSheetUI.GetControlValue("BatchJSTbl.JSObjectID", i + 1) + ",";
            IsCheckCnt++;

            if (ContractProperty != "" && ContractProperty != $.MvcSheetUI.GetControlValue("BatchJSTbl.ContractProperty", i + 1)) {
                layer.alert('您选择的批量数据中包含航油和非航油两种类型！！', { icon: 2 });
                return false;
            }
            ContractProperty = $.MvcSheetUI.GetControlValue("BatchJSTbl.ContractProperty", i + 1);
        }
    }
    var IsHYFlg = "false";
    if (ContractProperty == "航油合同") {
        IsHYFlg = "true";
    }
    var JSStatus = $.MvcSheetUI.GetControlValue("JSStatus");
    var JS_Target = $.MvcSheetUI.GetControlValue("JS_Target");
    var JSResult = $.MvcSheetUI.GetControlValue("JSResult");
    if (IsCheckCnt == 0) {
        layer.alert('你还没有选择结算记录！', { icon: 2 });
        return false;
    }
    else {
        if (JSStatus == "应收") {
            // 申请批量请款
            var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
            var WorkflowVersion_BatchQK = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchQK");
            window.location.href = "/Portal/Sheets/Contract/BatchJS_QKMy.aspx?Mode=Originate&WorkflowCode=BatchJS_QK&WorkflowVersion=" + WorkflowVersion_BatchQK + "&Target=" + JS_Target + "&Amount=" + JSResult + "&JSObjectIDs=" + JSObjectIDs + "&IsHYFlg=" + IsHYFlg;
        } else if (JSStatus == "应退") {
            // 申请批量付款
            var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
            var WorkflowVersion_BatchFK = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchFK");
            window.location.href = "/Portal/Sheets/Contract/BatchJS_FKMy.aspx?Mode=Originate&WorkflowCode=BatchJS_FK&WorkflowVersion=" + WorkflowVersion_BatchFK + "&Target=" + JS_Target + "&Amount=" + JSResult + "&JSObjectIDs=" + JSObjectIDs + "&IsHYFlg=" + IsHYFlg;
        } else if (JSStatus == "结清") {
            // 申请批量结清
            var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
            var WorkflowVersion_BatchJQ = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchJQ");
            window.location.href = "/Portal/Sheets/Contract/BatchJS_JQMy.aspx?Mode=Originate&WorkflowCode=BatchJS_JQ&WorkflowVersion=" + WorkflowVersion_BatchJQ + "&Target=" + JS_Target + "&JSObjectIDs=" + JSObjectIDs + "&IsHYFlg=" + IsHYFlg;
        }
    }
}

// 点击返回时
function ToBack() {
    window.history.back();
}

// 结算记录查看
function viewJS(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BatchJSTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 计算
function compute() {
    // 只有申请节点才计算
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var i = 0;
        // 应退
        var total_ytamount_rmb = 0.0;
        // 应收
        var total_ysamount_rmb = 0.0;
        var IsCheckCnt = 0;
        var dtl_js = $.MvcSheetUI.GetElement("BatchJSTbl").SheetGridView();
        for (var i = 0; i < dtl_js.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("BatchJSTbl.IsCheck", i + 1);
            var JSResult = $.MvcSheetUI.GetControlValue("BatchJSTbl.JSResult", i + 1);
            // 选中(选中为" " ,没选中没"")
            if (IsCheck == "是;") {
                if (JSResult.substring(0, 2) == "应退") {
                    total_ytamount_rmb += (parseFloat(JSResult.substring(2).replace("人民币","")));
                } else if (JSResult.substring(0, 2) == "应收") {
                    total_ysamount_rmb += (parseFloat(JSResult.substring(2).replace("人民币", "")));
                }
                IsCheckCnt++;
            }
        }

        var subs = total_ytamount_rmb - total_ysamount_rmb;
        if (subs > 0) {
            $.MvcSheetUI.SetControlValue("JSStatus", "应退");
        } else if (subs < 0) {
            $.MvcSheetUI.SetControlValue("JSStatus", "应收");
            subs = subs * (-1);
        } else {
            if (IsCheckCnt > 0) {
                $.MvcSheetUI.SetControlValue("JSStatus", "结清");
            } else {
                $.MvcSheetUI.SetControlValue("JSStatus", "");
            }
        }
        $.MvcSheetUI.SetControlValue("JSResult", subs.toFixed(2));

    }

}