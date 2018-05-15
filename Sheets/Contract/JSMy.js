// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Submit") {
            var total_dkamount_rmb = 0.0;
            var total_dkamount_wb = 0.0;
            var total_fkamount_rmb = 0.0;
            var total_fkamount_wb = 0.0;
            var IsCheckCnt = 0;
            var dtl_dk = $.MvcSheetUI.GetElement("DKTblOfJS").SheetGridView();
            for (var i = 0; i < dtl_dk.RowCount; i++) {
                var IsCheck = $.MvcSheetUI.GetControlValue("DKTblOfJS.IsCheck", i + 1);
                var CurDKCurrency = $.MvcSheetUI.GetControlValue("DKTblOfJS.CurDKCurrency", i + 1);
                // 选中(选中为" " ,没选中没"")
                if (IsCheck == "是;") {
                    if (CurDKCurrency != "人民币") {
                        total_dkamount_wb += (parseFloat($.MvcSheetUI.GetControlValue("DKTblOfJS.CurDKAmount", i + 1)));
                    }
                    IsCheckCnt++;
                }
            }
            var dtl_fk = $.MvcSheetUI.GetElement("FKTblOfJS").SheetGridView();
            for (var i = 0; i < dtl_fk.RowCount; i++) {
                var IsCheck = $.MvcSheetUI.GetControlValue("FKTblOfJS.IsCheck", i + 1);
                var FKCurrency = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKCurrency", i + 1);
                var ConvertAmount = $.MvcSheetUI.GetControlValue("FKTblOfJS.ConvertAmount", i + 1);
                var FKObjectID = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1);
                // 选中
                if (IsCheck == "是;") {
                    if (ConvertAmount == "") {
                        for (var j = 0; j < dtl_fk.RowCount; j++) {
                            var FKObjectID2 = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", j + 1);
                            if (FKObjectID == FKObjectID2) {
                                total_fkamount_wb += (parseFloat($.MvcSheetUI.GetControlValue("FKTblOfJS.FKAmount", j + 1)));
                            }
                        }
                    }
                    IsCheckCnt++;
                }
            }
            if (IsCheckCnt == 0) {
                layer.alert('没有选择要结算的到款或付款记录！', { icon: 2 });
                return false;
            }
            if (total_fkamount_wb != total_dkamount_wb) {
                layer.alert('外币到款必须与现汇付款结清！', { icon: 2 });
                return false;
            }

        }
    }
    return true;
}

//}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    var Currency = "";
    // 从支付管理迁移过来
    var DKObjectIDs = getUrlParam("DKObjectIDs");
    var FKObjectIDs = getUrlParam("FKObjectIDs");
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
                $.MvcSheetUI.SetControlValue("CurrencyRMB", "人民币");
                $.MvcSheetUI.SetControlValue("CurrencyWB", ret.CurrencyName);
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
            }
        });

        // 到款记录相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKTblOfJS",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("DKTblOfJS").SheetGridView();
                dtl._Clear();
                var len = dtl.RowCount;
                var j = 1;
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    len += 1;
                    //$.MvcSheetUI.SetControlValue("DKTblOfJS.TheNo", ret[i].TheNo, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKObjectID", ret[i].QKObjectID, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKTarget", ret[i].QKTarget, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKType", ret[i].QKType, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.ZJKX", ret[i].ZJKX, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.ZJMS", ret[i].ZJMS, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKAmount", ret[i].QKAmount, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKCurrencyName", ret[i].QKCurrencyName, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKConvertAmount", ret[i].QKConvertAmount, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.DKType", ret[i].DKType, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.CurDKAmount", ret[i].CurDKAmount, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.CurDKCurrency", ret[i].CurDKCurrency, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.DKDate", ret[i].DKDate, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.WorkItemId", ret[i].WorkItemId, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.DKObjectID", ret[i].DKObjectID, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.QKCurrencyCnt", ret[i].QKCurrencyCnt, len);
                    $.MvcSheetUI.SetControlValue("DKTblOfJS.SeqCnt", ret[i].SeqCnt, len);
                    if (DKObjectIDs != null && DKObjectIDs != "") {
                        var arr = DKObjectIDs.split(",");
                        for (var k = 0; k < arr.length; k++) {
                            if (arr[k] == ret[i].DKObjectID) {
                                $.MvcSheetUI.SetControlValue("DKTblOfJS.IsCheck", "是", len);
                            }
                        }
                    }
                }

            }
        });

        // 付款记录相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getFKTblOfJS",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("FKTblOfJS").SheetGridView();
                dtl._Clear();
                var len = dtl.RowCount;
                var j = 1;
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    len += 1;
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.TheNo", ret[i].TheNo, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.Cnt", ret[i].Cnt, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.Receiver", ret[i].Receiver, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.ZKMS", ret[i].ZKMS, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.FKAmount", ret[i].FKAmount, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.FKCurrency", ret[i].FKCurrency, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.ConvertAmount", ret[i].ConvertAmount, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.FKDate", ret[i].FKDate, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.WorkItemId", ret[i].WorkItemId, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.FKObjectID", ret[i].FKObjectID, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.BankFee", ret[i].BankFee, len);
                    $.MvcSheetUI.SetControlValue("FKTblOfJS.AgencyFee", ret[i].AgencyFee, len);
                    if (FKObjectIDs != null && FKObjectIDs != "") {
                        var arr = FKObjectIDs.split(",");
                        for (var k = 0; k < arr.length; k++) {
                            if (arr[k] == ret[i].FKObjectID) {
                                $.MvcSheetUI.SetControlValue("FKTblOfJS.IsCheck", "是", len);
                            }
                        }
                    }
                }

            }
        });
        FKRowChange();
    }
    // 到款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("DKTblOfJS").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var IsFirst2 = true;
    var DKObjectID = "";
    var QKCurrency = "";
    var QKObjectID = "";
    var QKType = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            // 对需要合并的项目进行合并
            if (IsFirst2 || DKObjectID + QKObjectID != $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1)) {
                var SeqCnt = $.MvcSheetUI.GetControlValue("DKTblOfJS.SeqCnt", i + 1);
                IsFirst2 = false;
                DKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1);
                QKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKTblOfJS.QKTarget']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKTblOfJS.DKDate']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKTblOfJS.Operate']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                var k = 0;
                $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKTblOfJS.QKTarget']").remove();
                        $(this).find("td[data-field='DKTblOfJS.DKDate']").remove();
                        $(this).find("td[data-field='DKTblOfJS.Operate']").remove();
                    }
                    k++;
                });
            }
        }
        var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
        if (IsHYFlg == "true") {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || DKObjectID + QKObjectID != $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1)) {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1);
                    var SeqCnt = $.MvcSheetUI.GetControlValue("DKTblOfJS.SeqCnt", i + 1);
                    IsFirst1 = false;
                    var k = 0;
                    $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTblOfJS.IsCheck']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKTblOfJS.QKConvertAmount']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKTblOfJS.CurDKAmount']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKTblOfJS.CurDKCurrency']").attr("rowspan", SeqCnt);
                        }
                        k++;
                    });
                } else {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTblOfJS.IsCheck']").remove();
                            $(this).find("td[data-field='DKTblOfJS.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKTblOfJS.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKTblOfJS.CurDKCurrency']").remove();
                        }
                        k++;
                    });
                }

            }
        } else {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || DKObjectID + QKObjectID + QKType + QKCurrency != $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKTblOfJS.QKType", i + 1) + $.MvcSheetUI.GetControlValue("DKTblOfJS.QKCurrency", i + 1)) {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKCurrency", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTblOfJS.IsCheck']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTblOfJS.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTblOfJS.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTblOfJS.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKTblOfJS.QKCurrency", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTblOfJS.IsCheck']").remove();
                            $(this).find("td[data-field='DKTblOfJS.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKTblOfJS.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKTblOfJS.CurDKCurrency']").remove();
                        }
                        k++;
                    });
                }

            }
        }

    }

    // 付款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("FKTblOfJS").SheetGridView();
    var len = dtl.RowCount;
    var FKObjectID = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {

            if (FKObjectID == "" || FKObjectID != $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1)) {
                FKObjectID = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1);
                var Cnt = $.MvcSheetUI.GetControlValue("FKTblOfJS.Cnt", i + 1);
                var k = 0;
                $("[data-datafield='FKTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKTblOfJS.IsCheck']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKTblOfJS.TheNo']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKTblOfJS.Receiver']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKTblOfJS.ConvertAmount']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKTblOfJS.FKDate']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKTblOfJS.Operate']").attr("rowspan", Cnt);
                    }
                    k++;
                });
            } else {
                FKObjectID = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='FKTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKTblOfJS.IsCheck']").remove();
                        $(this).find("td[data-field='FKTblOfJS.TheNo']").remove();
                        $(this).find("td[data-field='FKTblOfJS.Receiver']").remove();
                        $(this).find("td[data-field='FKTblOfJS.ConvertAmount']").remove();
                        $(this).find("td[data-field='FKTblOfJS.FKDate']").remove();
                        $(this).find("td[data-field='FKTblOfJS.Operate']").remove();
                    }
                    k++;
                });
            }
        }
    }

    $(".CurrencyRMB").text($.MvcSheetUI.GetControlValue("CurrencyRMB"));
    $(".CurrencyWB").text($.MvcSheetUI.GetControlValue("CurrencyWB"));
    
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='JSResult']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.TheNo']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.QKTarget']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.DKType']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.CurDKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.CurDKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.DKDate']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.QKType']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.ZJKX']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.ZJMS']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.QKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.QKCurrencyName']").attr("disabled", "disabled");
    $("input[data-datafield='DKTblOfJS.QKConvertAmount']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.TheNo']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.Receiver']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.ZKMS']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.FKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.FKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.ConvertAmount']").attr("disabled", "disabled");
    $("input[data-datafield='FKTblOfJS.FKDate']").attr("disabled", "disabled");
    $("input[data-datafield='JSStatus']").attr("disabled", "disabled");

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackJSTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
    $('.AmountFormat').blur();
}

// 到款查看
function viewDK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('DKTblOfJS.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/DKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 付款查看
function viewFK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('FKTblOfJS.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

function FKRowChange() {
    var dtl_fk = $.MvcSheetUI.GetElement("FKTblOfJS").SheetGridView();
    var total_BankFee = 0;
    var total_AgencyFee = 0;
    var FKObjectIDBak = "";
    for (var i = 0; i < dtl_fk.RowCount; i++) {
        var IsCheck = $.MvcSheetUI.GetControlValue("FKTblOfJS.IsCheck", i + 1);
        var FKCurrency = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKCurrency", i + 1);
        var ConvertAmount = $.MvcSheetUI.GetControlValue("FKTblOfJS.ConvertAmount", i + 1);
        var FKObjectID = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1);
        // 重复付款id的只算一次
        if (FKObjectID == FKObjectIDBak) {
            continue;
        } else {
            FKObjectIDBak = FKObjectID;
        }
        var BankFee = $.MvcSheetUI.GetControlValue("FKTblOfJS.BankFee", i + 1).replace(/,/g, '');
        BankFee = BankFee == "" ? 0 : BankFee;
        var AgencyFee = $.MvcSheetUI.GetControlValue("FKTblOfJS.AgencyFee", i + 1).replace(/,/g, '');
        AgencyFee = AgencyFee == "" ? 0 : AgencyFee;
        // 选中
        if (IsCheck == "是;") {
            if (ConvertAmount != "") {
                total_BankFee += (parseFloat(BankFee));
                total_AgencyFee += (parseFloat(AgencyFee));
            } 
        }
    }
    $.MvcSheetUI.SetControlValue("BankFY", total_BankFee);
    $.MvcSheetUI.SetControlValue("AgencyFY", total_AgencyFee);
    compute();
}
function compute() {
    // 只有申请节点才计算
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var i = 0;
        var total_dkamount_rmb = 0.0;
        var total_dkamount_wb = 0.0;
        var total_fkamount_rmb = 0.0;
        var total_fkamount_wb = 0.0;
        var BankFY = $.MvcSheetUI.GetControlValue("BankFY").replace(/,/g, '');
        BankFY = parseFloat(BankFY == "" ? 0 : BankFY);
        var AgencyFY = $.MvcSheetUI.GetControlValue("AgencyFY").replace(/,/g, '');
        AgencyFY = parseFloat(AgencyFY == "" ? 0 : AgencyFY);
        var OtherFY = $.MvcSheetUI.GetControlValue("OtherFY").replace(/,/g, '');
        OtherFY = parseFloat(OtherFY == "" ? 0 : OtherFY);
        var dtl_dk = $.MvcSheetUI.GetElement("DKTblOfJS").SheetGridView();
        for (var i = 0; i < dtl_dk.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("DKTblOfJS.IsCheck", i + 1);
            var CurDKCurrency = $.MvcSheetUI.GetControlValue("DKTblOfJS.CurDKCurrency", i + 1);
            // 选中(选中为" " ,没选中没"")
            if (IsCheck == "是;") {
                var CurDKAmount = $.MvcSheetUI.GetControlValue("DKTblOfJS.CurDKAmount", i + 1).replace(/,/g, '');
                CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
                if (CurDKCurrency == "人民币") {
                    total_dkamount_rmb += (parseFloat(CurDKAmount));
                } else {
                    total_dkamount_wb += (parseFloat(CurDKAmount));
                }
            }
        }
        var dtl_fk = $.MvcSheetUI.GetElement("FKTblOfJS").SheetGridView();
        var FKObjectIDBak = "";
        for (var i = 0; i < dtl_fk.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("FKTblOfJS.IsCheck", i + 1);
            var FKCurrency = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKCurrency", i + 1);
            var ConvertAmount = $.MvcSheetUI.GetControlValue("FKTblOfJS.ConvertAmount", i + 1);
            var FKObjectID = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", i + 1);
            // 选中
            if (IsCheck == "是;") {
                if (ConvertAmount != "") {
                    // 重复付款id的只算一次
                    if (FKObjectID == FKObjectIDBak) {
                        continue;
                    } else {
                        FKObjectIDBak = FKObjectID;
                        var ConvertAmount = ConvertAmount.replace("人民币", "");
                        total_fkamount_rmb += (parseFloat(ConvertAmount));
                    }
                    
                } else {
                    for (var j = 0; j < dtl_fk.RowCount; j++) {
                        var FKObjectID2 = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKObjectID", j + 1);
                        if (FKObjectID == FKObjectID2) {
                            var FKAmount = $.MvcSheetUI.GetControlValue("FKTblOfJS.FKAmount", j + 1).replace(/,/g, '');
                            FKAmount = FKAmount == "" ? 0 : FKAmount;
                            total_fkamount_wb += (parseFloat(FKAmount));
                        }
                    }
                }
            }
        }

        $.MvcSheetUI.SetControlValue("LJDKAmountRMB", (total_dkamount_rmb).toFixed(2));
        $.MvcSheetUI.SetControlValue("LJDKAmountWB", (total_dkamount_wb).toFixed(2));
        $.MvcSheetUI.SetControlValue("LJFKAmountRMB", (total_fkamount_rmb).toFixed(2));
        $.MvcSheetUI.SetControlValue("LJFKAmountWB", (total_fkamount_wb).toFixed(2));
        

        var subs = total_dkamount_rmb - total_fkamount_rmb - BankFY - AgencyFY - OtherFY;
        if (subs > 0) {
            $.MvcSheetUI.SetControlValue("JSStatus", "应退");
        } else if (subs < 0) {
            $.MvcSheetUI.SetControlValue("JSStatus", "应收");
            subs = subs * (-1);
        } else {
            $.MvcSheetUI.SetControlValue("JSStatus", "");
        }
        $.MvcSheetUI.SetControlValue("JSResult", subs.toFixed(2));
        $('.AmountFormat').blur();
    }
}

// 增加自定义工具栏按钮方法，触发后台事件
$.MvcSheet.AddAction({
    //Action: "GetBackAction",       // 执行后台方法名称
    Icon: "fa-sign-in",           // 按钮图标
    Text: "回退",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        /*
        自定义按钮执行事件，如果为 null 则调用$.MvcSheet.Action 执行后台方法
        如果不为 null，那么会执行这里的方法，需要自己Post到后台或写前端逻辑
        */
        // 根据InstanceID获取当前流程的活动节点
        var CurActivity = "";
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getCurActivity",   //处理页的相对地址
            data: {
                InstanceID: $.MvcSheetUI.SheetInfo.InstanceId,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                // 设置请款批次
                if (ret != null && ret != "") {
                    CurActivity = ret.ActivityCode;
                }
            }
        });

        $.ajax({
            type: "POST",    //页面请求的类型
            url: "/Portal/InstanceDetail/GetAdjustActivityInfo",   //处理页的相对地址
            data: {
                InstanceID: $.MvcSheetUI.SheetInfo.InstanceId,
            },
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var options = "";
                if (ret.SUCCESS == true) {
                    console.log("GetAdjustActivityInfo=" + ret);
                    for (var i = 0; i < ret.InstanceActivity.length; i++) {
                        if (CurActivity == "ActivityHYConfirm" || CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门复核" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门复核" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            
                        }

                    }
                }
                //让弹出框显示的操作方法
                $('#message-module').find('.modal-body').html(
                    '<div style="text-align: center;padding: 50px;line-height: 25px">' +
                    '<form class="bs-example form-horizontal" name="form" >' +
                    '<div class="row">' +
                    '    <h5 class="col-md-4" style="padding-top: 14px;">选择活动: </h5><div class="col-md-6 input-group">' +
                    '        <select class="form-control" id="ActivityCodes" ><option value="">请选择</option>' + options +
                    '                 </select > ' +
                    '    </div>' +
                    '</div > ' +
                    '</form > ' +
                    '</div > '
                );
                var moduleFooter = $('#message-module').find('.modal-footer');
                var cancleButton = $('<button type="button" class="btn " data-dismiss="modal" style=" border-radius: 0px;border: 0px;margin-left: 0px;width: 50%;background-color:white;float: left;border-bottom-left-radius: 5px;border-color: #ff993b;line-height: 25px;color:black">取消</button>');
                var confirmButton = $('<button type="button" class="btn btn-default" style="border-radius: 0px;border: 0px;background-color: #FF993B;width: 50%;float: right;border-bottom-right-radius: 6px;line-height: 25px;margin-left: 0px;">确定</button>');

                if (moduleFooter.find('button').length === 0) {
                    cancleButton.appendTo(moduleFooter);
                    confirmButton.appendTo(moduleFooter);
                }
                $('#message-module').modal({ keyboard: true, show: true, backdrop: true });
                $('#message-module').on('shown.bs.modal', function () {
                    $.LoadingMask.Hide();
                });
                confirmButton.click(function () {
                    $('#message-module').modal('hide');
                    GotoBackPage("JS", CurActivity);

                });
            }
        });
    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 回退查看
function viewBack(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackJSTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}