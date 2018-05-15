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

    $("input[data-datafield='DKResult']").attr("disabled", "disabled");
    $(".ContractContent div[data-title='征询意见']").parent().hide();

}

function Search() {
    var DK_Target = $("[data-datafield='DK_Target']").find("option:selected").text(); // $.MvcSheetUI.GetControlValue("JS_Target");
    if (DK_Target != "请选择") {
        // 查询批量到款的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKLSData",   //处理页的相对地址
            data: {
                DK_Target: DK_Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BatchDKTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.ContractNo", ret[i].ContractNo, i+1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKSeq", ret[i].QKSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKObjectID", ret[i].QKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKSeqHidden", ret[i].QKSeqHidden, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKType", ret[i].QKType, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKTypeCode", ret[i].QKTypeCode, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKTarget", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKTargetCode", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKDate", ret[i].QKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.ZJKX", ret[i].ZJKX, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.ZJMS", ret[i].ZJMS, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKCurrencyCode", ret[i].QKCurrencyCode, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt2, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKCurrency", ret[i].QKCurrency, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.QKConvertAmount", ret[i].QKConvertAmount2 == "0" ? "" : ret[i].QKConvertAmount2, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.SeqCnt", ret[i].SeqCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.LJDKAmount", ret[i].LJDKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.LJDKAmountWB", ret[i].LJDKAmountWB, i + 1);
                    //if (parseFloat(ret[i].LJDKAmount) >= parseFloat(ret[i].QKAmount)) {
                    //    Status = "全部到款";
                    //} else if (parseFloat(ret[i].LJDKAmount) > 0 && parseFloat(ret[i].LJDKAmount) < parseFloat(ret[i].QKAmount)) {
                    //    Status = "部分到款";
                    //} else if (parseFloat(ret[i].LJDKAmount) == 0) {
                    //    Status = "未到款";
                    //}
                    $.MvcSheetUI.SetControlValue("BatchDKTbl.Status", ret[i].DKStatus, i + 1);
                }

                
            }
        });
        // 请款子表的合并单元格操作
        var dtl = $.MvcSheetUI.GetElement("BatchDKTbl").SheetGridView();
        var len = dtl.RowCount;
        var IsFirst1 = true;
        var IsFirst2 = true;
        var QKCurrencyCode = "";
        var QKObjectID = "";
        var QKTypeCode = "";
        var QKCurrencyCnt = 0;
        if (len > 0) {
            for (var i = 0; i < len; i++) {
                // 对需要合并的项目进行合并
                if (IsFirst2 || QKObjectID != $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1)) {
                    IsFirst2 = false;
                    QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1);
                    var SeqCnt = $.MvcSheetUI.GetControlValue("BatchDKTbl.SeqCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchDKTbl.ContractNo']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='BatchDKTbl.QKSeq']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='BatchDKTbl.QKType']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='BatchDKTbl.QKTarget']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='BatchDKTbl.QKDate']").attr("rowspan", SeqCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchDKTbl.ContractNo']").remove();
                            $(this).find("td[data-field='BatchDKTbl.QKSeq']").remove();
                            $(this).find("td[data-field='BatchDKTbl.QKType']").remove();
                            $(this).find("td[data-field='BatchDKTbl.QKTarget']").remove();
                            $(this).find("td[data-field='BatchDKTbl.QKDate']").remove();
                        }
                        k++;
                    });
                }
                // 币种初始化
                var QKConvertAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKConvertAmount", i + 1);
                if (QKConvertAmount != "") {
                    DKCurrency = "RMB";
                } else {
                    DKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCode", i + 1);
                }
                $.MvcSheetUI.SetControlValue("BatchDKTbl.CurDKCurrency", DKCurrency, i + 1);
            }


            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || QKObjectID + QKTypeCode + QKCurrencyCode != $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("BatchDKTbl.QKTypeCode", i + 1) + $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCode", i + 1)) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1);
                    QKTypeCode = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKTypeCode", i + 1);
                    QKCurrencyCode = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCode", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchDKTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.LJDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.LJDKAmountWB']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.Status']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='BatchDKTbl.IsCheck']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1);
                    QKTypeCode = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKTypeCode", i + 1);
                    QKCurrencyCode = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCode", i + 1);
                    var k = 0;
                    $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='BatchDKTbl.QKConvertAmount']").remove();
                            $(this).find("td[data-field='BatchDKTbl.LJDKAmount']").remove();
                            $(this).find("td[data-field='BatchDKTbl.LJDKAmountWB']").remove();
                            $(this).find("td[data-field='BatchDKTbl.CurDKAmount']").remove();
                            $(this).find("td[data-field='BatchDKTbl.CurDKCurrency']").remove();
                            $(this).find("td[data-field='BatchDKTbl.Status']").remove();
                            $(this).find("td[data-field='BatchDKTbl.IsCheck']").remove();
                        }
                        k++;
                    });
                }

            }
        }
        $("input[data-datafield='BatchDKTbl.ContractNo']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKSeq']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKType']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKTarget']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKDate']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.ZJKX']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.ZJMS']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKAmount']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKCurrency']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.QKConvertAmount']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.LJDKAmount']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.LJDKAmountWB']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.Status']").attr("disabled", "disabled");
        //$("[data-datafield='BatchDKTbl.CurDKCurrency']").attr("disabled", "disabled");
        $("input[data-datafield='BatchDKTbl.CurDKAmount']").attr("disabled", "disabled");
        
    } else {
        var dtl = $.MvcSheetUI.GetElement("BatchDKTbl").SheetGridView();
        dtl._Clear();
    }
}

// 点击下一步时
function BatchDKApply() {
    var IsCheckCnt = 0;
    var dtl_js = $.MvcSheetUI.GetElement("BatchDKTbl").SheetGridView();
    var QKObjectIDs = "";
    for (var i = 0; i < dtl_js.RowCount; i++) {
        var IsCheck = $.MvcSheetUI.GetControlValue("BatchDKTbl.IsCheck", i + 1);
        // 选中(选中为" " ,没选中没"")
        if (IsCheck == "是;") {
            // 内容为（QKObjectID:Amount:Cuurency，QKObjectID:Amount:Cuurency...）
            //var Status = "";
            //if ($.MvcSheetUI.GetControlValue("BatchDKTbl.Status", i + 1) == "未到款") {
            //    Status = "0";
            //} else if ($.MvcSheetUI.GetControlValue("BatchDKTbl.Status", i + 1) == "部分到款") {
            //    Status = "1";
            //} else if ($.MvcSheetUI.GetControlValue("BatchDKTbl.Status", i + 1) == "全部到款") {
            //    Status = "2";
            //}
            QKObjectIDs += $.MvcSheetUI.GetControlValue("BatchDKTbl.QKObjectID", i + 1) + ":" +
                $.MvcSheetUI.GetControlValue("BatchDKTbl.QKTypeCode", i + 1) + ":" +
                $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrencyCode", i + 1) + ":" +
                $.MvcSheetUI.GetControlValue("BatchDKTbl.CurDKAmount", i + 1) + ":" +
                $.MvcSheetUI.GetControlValue("BatchDKTbl.CurDKCurrency", i + 1) + ",";
                //Status + ",";
            IsCheckCnt++;
        }
    }
    var DK_Target = $.MvcSheetUI.GetControlValue("DK_Target");
    var DKResultCode = $.MvcSheetUI.GetControlValue("DKResultCode");
    if (IsCheckCnt == 0) {
        layer.alert('你还没有选择请款记录！', { icon: 2 });
        return false;
    }
    else {
        // 申请批量到款
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var WorkflowVersion_BatchDK = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchDK");
        window.location.href = "/Portal/Sheets/Contract/BatchDK_DKMy.aspx?Mode=Originate&WorkflowCode=BatchDK_DK&WorkflowVersion=" + WorkflowVersion_BatchDK + "&Target=" + DK_Target + "&Amount=" + DKResultCode + "&QKObjectIDs=" + QKObjectIDs ;

    }
}

// 点击返回时
function ToBack() {
    window.history.back();
}


// 计算
function compute(el) {
    // 只有申请节点才计算
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        // 设置当前行本次到款金额为 请款金额 - 累计到款金额、状态为全部到款
        var rowIndex = el.parentElement.parentElement.rowIndex;
        var IsCheck = $.MvcSheetUI.GetControlValue("BatchDKTbl.IsCheck", rowIndex - 1);
        if (IsCheck == "是;") {
            var QKAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKAmount", rowIndex - 1);
            var LJDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.LJDKAmount", rowIndex - 1);
            var LJDKAmountWB = $.MvcSheetUI.GetControlValue("BatchDKTbl.LJDKAmountWB", rowIndex - 1);
            var QKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrency", rowIndex - 1);
            var CurDKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTbl.CurDKCurrency", rowIndex - 1);
            var CurDKAmount = 0;
            if (QKCurrency == "人民币") {
                if (CurDKCurrency == "RMB") {
                    CurDKAmount = (parseFloat(QKAmount) - parseFloat(LJDKAmount)).toFixed(2);
                } else {
                    CurDKAmount = 0;
                }
            } else {
                if (CurDKCurrency == "RMB") {
                    CurDKAmount = 0;
                } else  {
                    CurDKAmount = (parseFloat(QKAmount) - parseFloat(LJDKAmountWB)).toFixed(2);
                } 
            }
            
            //$.MvcSheetUI.SetControlValue("BatchDKTbl.CurDKAmount", CurDKAmount, rowIndex - 1);
            //$.MvcSheetUI.SetControlValue("BatchDKTbl.Status", "全部到款", rowIndex - 1);
            var k = 0;
            $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                if (k == rowIndex - 2) {
                    $(this).find("input[data-datafield='BatchDKTbl.CurDKAmount']").attr("disabled", false);
                    $(this).find("input[data-datafield='BatchDKTbl.CurDKAmount']").addClass("DKInputAmount");
                }
                k++;
            });
        } else {
            var QKAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKAmount", rowIndex - 1);
            var LJDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.LJDKAmount", rowIndex - 1);
            //var Status = "";
            //if (parseFloat(LJDKAmount) >= parseFloat(QKAmount)) {
            //    Status = "全部到款";
            //} else if (parseFloat(LJDKAmount) > 0 && parseFloat(LJDKAmount) < parseFloat(QKAmount)) {
            //    Status = "部分到款";
            //} else if (parseFloat(LJDKAmount) == 0 ) {
            //    Status = "未到款";
            //}
            $.MvcSheetUI.SetControlValue("BatchDKTbl.CurDKAmount", "", rowIndex - 1);
            //$.MvcSheetUI.SetControlValue("BatchDKTbl.Status", Status, rowIndex - 1);
            var k = 0;
            $("[data-datafield='BatchDKTbl']").find("tr.rows").each(function () {
                if (k == rowIndex - 2) {
                    $(this).find("input[data-datafield='BatchDKTbl.CurDKAmount']").attr("disabled", "disabled");
                    $(this).find("input[data-datafield='BatchDKTbl.CurDKAmount']").removeClass("DKInputAmount");
                }
                k++;
            });
        }
        
        compute2();
    }
}

function compute2() {
    var i = 0;
    // 总计金额
    var total_amount = 0.0;
    var IsCheckCnt = 0;
    var dtl_js = $.MvcSheetUI.GetElement("BatchDKTbl").SheetGridView();
    var currencyArr = new Array();
    var currencyCodeArr = new Array();
    var totalamountArr = new Array();
    for (var i = 0; i < dtl_js.RowCount; i++) {
        var IsCheck = $.MvcSheetUI.GetControlValue("BatchDKTbl.IsCheck", i + 1);
        var DKResult = $.MvcSheetUI.GetControlValue("BatchDKTbl.DKResult", i + 1);
        // 选中(选中为" " ,没选中没"")
        if (IsCheck == "是;") {
            //var QKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTbl.QKCurrency", i + 1);
            var CurDKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTbl.CurDKCurrency", i + 1);
            var CurDKCurrencyName = getNameBykey("BatchDKTbl.CurDKCurrency", IsCheckCnt,CurDKCurrency);
            var CurDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTbl.CurDKAmount", i + 1);
            CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
            var b = contains(currencyArr, CurDKCurrencyName);
            if (b >= 0) {
                totalamountArr[b] = parseFloat(totalamountArr[b]) + parseFloat(CurDKAmount);
            } else {
                currencyArr.push(CurDKCurrencyName);
                currencyCodeArr.push(CurDKCurrency);
                totalamountArr.push(CurDKAmount);
            }
            IsCheckCnt++;
        }
    }
    var DKResult = "";
    var DKResultCode = "";
    for (var i = 0; i < currencyArr.length; i++) {
        DKResult += totalamountArr[i] + " " + currencyArr[i] + ",";
        DKResultCode += totalamountArr[i] + " " + currencyCodeArr[i] + ",";
    }
    $.MvcSheetUI.SetControlValue("DKResult", DKResult);
    $.MvcSheetUI.SetControlValue("DKResultCode", DKResultCode);
}

// 通过key获取text
function getNameBykey(el, i, key) {
    var k = 0;
    var value = "";
    $("[data-datafield='" + el + "']").each(function () {
        if (k == i+1) {
            value = $(this).find("option:selected").text();
            return false; // each退出循环
        }
        k++;
    });
    return value;
}
// 判断数组中是否包含key，如果包含，返回序列号，否则返回-1
function contains(arr, key) {
    for (var i = 0; i < arr.length;i++) {
        if (key == arr[i]) {
            return i;
        }
    }
    return -1;
}