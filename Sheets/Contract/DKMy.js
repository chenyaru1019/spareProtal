// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Submit") {
            // 验证是否有不同的请款对象同时提交数据
            var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
            var len = dtl.RowCount;
            if (len > 0) {
                var QKTargetArr = new Array();
                for (var i = 0; i < len ; i++) {
                    var CurDKAmount = $.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", i + 1)==null?"0":$.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", i + 1).replace(/,/g, '');
                    CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
                    if (parseFloat(CurDKAmount) > 0) {
                        QKTargetArr.push($.MvcSheetUI.GetControlValue("DKTbl.QKTargetCode", i + 1));
                    }
                }
                for (var j = 0; j < QKTargetArr.length-1;j++) {
                    if (QKTargetArr[j] != QKTargetArr[j+1]) {
                        layer.alert('请款对象必须一致！', { icon: 2 });
                        return false;
                    }
                }
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
    // 从支付管理迁移过来
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
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
                // 根据合同号码获取请款相关数据
                var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "ContractHandler.ashx?Command=getDKTbl",   //处理页的相对地址
                    data: {
                        ContractNo: ContractNo,
                        UserID: CurrentUser.ObjectID,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        var DKCurrency = "";
                        var QKType = "";
                        var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
                        dtl._Clear();
                        var len = dtl.RowCount;
                        var j = 1;
                        for (var i = 0; i < ret.length; i++) {
                            dtl._AddRow();
                            len += 1;
                            $.MvcSheetUI.SetControlValue("DKTbl.QKSeq", ret[i].QKSeq, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKObjectID", ret[i].QKObjectID, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKSubObjectID", ret[i].QKSubObjectID, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKSeqHidden", ret[i].QKSeq, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKType", ret[i].QKType, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKTypeCode", ret[i].QKTypeCode, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKTarget", ret[i].QKTarget, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKTargetCode", ret[i].QKTarget, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKDate", ret[i].QKDate, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.ZJKX", ret[i].ZJKX, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.ZJMS", ret[i].ZJMS, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKAmount", ret[i].QKAmount, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKCurrency", ret[i].QKCurrency, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKCurrencyName", ret[i].QKCurrencyName, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKRate", ret[i].QKRate, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.QKConvertAmount", ret[i].QKConvertAmount == "0" ? "" : ret[i].QKConvertAmount, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.SeqCnt", ret[i].SeqCnt, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.DKType", ret[i].QKType == "合同请款" ? "合同到款" : ret[i].QKType == "费用请款" ? "费用到款" : ret[i].QKType == "结算请款" ? "结算到款" : "", len);
                            $.MvcSheetUI.SetControlValue("DKTbl.LJDKAmount", ret[i].LJDKAmount, len);
                            $.MvcSheetUI.SetControlValue("DKTbl.LJDKAmountWB", ret[i].LJDKAmountWB, len);
                            if (QKSubObjectIDs != null && QKSubObjectIDs != "") {
                                var arr = QKSubObjectIDs.split(",");
                                for (var k= 0; k < arr.length; k++ ) {
                                    if (arr[k] == ret[i].QKSubObjectID) {
                                        var CurDKAmount = ret[i].QKConvertAmount != "" ? ret[i].QKConvertAmount : ret[i].QKAmount;
                                        $.MvcSheetUI.SetControlValue("DKTbl.CurDKAmount", CurDKAmount, len);
                                        if (ret[i].QKConvertAmount != "0") {
                                            DKCurrency = "RMB";
                                        } else {
                                            DKCurrency = ret[i].QKCurrency;
                                        }
                                        
                                        QKType = ret[i].QKTypeCode;
                                    }
                                }
                            }
                        }
                        if (DKCurrency != "") {
                            $.MvcSheetUI.SetControlValue("DKCurrencyTmp", DKCurrency);
                        }
                        if (QKType != "") {
                            $.MvcSheetUI.SetControlValue("QKTypeTmp", QKType);
                        }
                    }
                });

            }
        });
        
    }

    // 请款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var QKSeqHidden = "Start";
    var QKCurrency = "";
    var QKObjectID = "";
    var QKTypeCode = "";
    var QKCurrencyCnt = 0;
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            // 对需要合并的项目进行合并
            if (QKSeqHidden == "Start" || QKSeqHidden != $.MvcSheetUI.GetControlValue("DKTbl.QKSeqHidden", i + 1)) {
                var SeqCnt = $.MvcSheetUI.GetControlValue("DKTbl.SeqCnt", i + 1);
                var Status = $.MvcSheetUI.GetControlValue("DKTbl.Status", i + 1);
                var k = 0;
                $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKTbl.QKSeq']").attr("rowspan", SeqCnt);
                        //$(this).find("td[data-field='DKTbl.QKType']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKTbl.QKTarget']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKTbl.QKDate']").attr("rowspan", SeqCnt);
                        //$(this).find("td[data-field='DKTbl.QKConvertAmount']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                var k = 0;
                $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKTbl.QKSeq']").remove();
                        //$(this).find("td[data-field='DKTbl.QKType']").remove();
                        $(this).find("td[data-field='DKTbl.QKTarget']").remove();
                        $(this).find("td[data-field='DKTbl.QKDate']").remove();
                        //$(this).find("td[data-field='DKTbl.QKConvertAmount']").remove();
                    }
                    k++;
                });
            }
            QKSeqHidden = $.MvcSheetUI.GetControlValue("DKTbl.QKSeqHidden", i + 1);
            // 币种初始化
            var QKConvertAmount = $.MvcSheetUI.GetControlValue("DKTbl.QKConvertAmount", i + 1);
            // 有请款的折算金额
            if (QKConvertAmount != "") {
                // 设为人民币到款
                $.MvcSheetUI.SetControlValue("DKTbl.CurDKCurrency", "RMB", i + 1);
            } else {
                // 设为请款的币种
                $.MvcSheetUI.SetControlValue("DKTbl.CurDKCurrency", $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", i + 1), i + 1);
            }
        }
        var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
        if (IsHYFlg == "true") {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || QKObjectID != $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1) ) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.LJDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.LJDKAmountWB']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKRate']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.Status']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTbl.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKTbl.LJDKAmount']").remove();
                            $(this).find("td[data-field='DKTbl.LJDKAmountWB']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKCurrency']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKRate']").remove();
                            $(this).find("td[data-field='DKTbl.Status']").remove();
                        }
                        k++;
                    });
                }

            }
        } else {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || QKObjectID + QKTypeCode + QKCurrency != $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKTbl.QKTypeCode", i + 1) + $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", i + 1)) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                    QKTypeCode = $.MvcSheetUI.GetControlValue("DKTbl.QKTypeCode", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.LJDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.LJDKAmountWB']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.CurDKRate']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKTbl.Status']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                    QKTypeCode = $.MvcSheetUI.GetControlValue("DKTbl.QKTypeCode", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", i + 1);
                    var k = 0;
                    $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKTbl.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKTbl.LJDKAmount']").remove();
                            $(this).find("td[data-field='DKTbl.LJDKAmountWB']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKCurrency']").remove();
                            $(this).find("td[data-field='DKTbl.CurDKRate']").remove();
                            $(this).find("td[data-field='DKTbl.Status']").remove();
                        }
                        k++;
                    });
                }

            }
        }
        
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKSeq']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKType']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKTarget']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKDate']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.ZJKX']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.ZJMS']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKCurrencyName']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKRate']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.QKConvertAmount']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.DKType']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.LJDKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.LJDKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='DKTbl.Status']").attr("disabled", "disabled");
    //$("[data-datafield='DKTbl.CurDKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='DKAmount']").attr("disabled", "disabled");

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackDKTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();

    $('.AmountFormat').blur();
}
var IsSetCurrency = false;
function DKCurrencyChange() {
    var DKCurrencyTmp = $.MvcSheetUI.GetControlValue("DKCurrencyTmp");
    var QKTypeTmp = $.MvcSheetUI.GetControlValue("QKTypeTmp");
    if (!IsSetCurrency && DKCurrencyTmp != "" && QKTypeTmp != "") {
        IsSetCurrency = true;
        $.MvcSheetUI.SetControlValue("DKCurrency", DKCurrencyTmp);
        
    } else {
        setTbl();
    }

}

function setTbl() {
    var DKCurrency = $.MvcSheetUI.GetControlValue("DKCurrency");
    var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
    var len = dtl.RowCount;
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            var QKConvertAmount = $.MvcSheetUI.GetControlValue("DKTbl.QKConvertAmount", i + 1);
            var QKTypeCode = $.MvcSheetUI.GetControlValue("DKTbl.QKTypeCode", i + 1);
            var QKRate = $.MvcSheetUI.GetControlValue("DKTbl.QKRate", i + 1);
            
            // 当前币种和到款币种一致，可写
            if ((DKCurrency == "RMB" && QKConvertAmount != "") || (DKCurrency != "RMB" && QKConvertAmount == "") ) {
                var k = 0;
                $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("input[data-datafield='DKTbl.CurDKAmount']").attr("disabled", false);
                        $(this).find("input[data-datafield='DKTbl.CurDKAmount']").addClass("DKInputAmount");
                        $(this).find("input[data-datafield='DKTbl.CurDKRate']").attr("disabled", false);
                        $(this).find("input[data-datafield='DKTbl.CurDKRate']").addClass("DKInputAmount");
                    }
                    k++;
                });

                $.MvcSheetUI.SetControlValue("DKTbl.CurDKCurrency", DKCurrency, i + 1);
                $.MvcSheetUI.SetControlValue("DKTbl.CurDKRate", DKCurrency == "RMB"?"1":QKRate, i + 1);
            } else {
                // 否则，不可写
                var k = 0;
                $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("input[data-datafield='DKTbl.CurDKAmount']").attr("disabled", "disabled");
                        $(this).find("input[data-datafield='DKTbl.CurDKAmount']").removeClass("DKInputAmount");
                        $(this).find("input[data-datafield='DKTbl.CurDKRate']").attr("disabled", "disabled");
                        $(this).find("input[data-datafield='DKTbl.CurDKRate']").removeClass("DKInputAmount");
                    }
                    k++;
                });
                $.MvcSheetUI.SetControlValue('DKTbl.CurDKAmount', 0, i + 1);
            }
            
        }
    }
}

function setCurCurrency(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var DKCurrency = $.MvcSheetUI.GetControlValue("DKCurrency");
    var QKTypeCode = $.MvcSheetUI.GetControlValue("DKTbl.QKTypeCode", rowIndex - 1);
    var CurDKCurrency = $.MvcSheetUI.GetControlValue("DKTbl.CurDKCurrency", rowIndex - 1);
    //当前币种和到款币种一致，可写
    if (CurDKCurrency == DKCurrency) {
        var k = 0;
        $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 2) {
                $(this).find("input[data-datafield='DKTbl.CurDKAmount']").attr("disabled", false);
                $(this).find("input[data-datafield='DKTbl.CurDKAmount']").addClass("DKInputAmount");
                $(this).find("input[data-datafield='DKTbl.CurDKRate']").attr("disabled", false);
                $(this).find("input[data-datafield='DKTbl.CurDKRate']").addClass("DKInputAmount");
            }
            k++;
        });
    } else {
        var k = 0;
        $("[data-datafield='DKTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 2) {
                $(this).find("input[data-datafield='DKTbl.CurDKAmount']").attr("disabled", true);
                $(this).find("input[data-datafield='DKTbl.CurDKAmount']").removeClass("DKInputAmount");
                $(this).find("input[data-datafield='DKTbl.CurDKRate']").attr("disabled", true);
                $(this).find("input[data-datafield='DKTbl.CurDKRate']").removeClass("DKInputAmount");
            }
            k++;
        });
        
    }
}

function compute() {
    
    var DKCurrency = $.MvcSheetUI.GetControlValue("DKCurrency");
    var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
    var len = dtl.RowCount;
    var totalamount = 0.0;
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            var CurDKCurrency = $.MvcSheetUI.GetControlValue("DKTbl.CurDKCurrency", i + 1);
            var QKCurrencyName = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrencyName", i + 1);
            // 当前币种和到款币种一致，累计
            if (typeof (DKCurrency) == "undefined" || DKCurrency == CurDKCurrency) {
                var CurDKAmount = $.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", i + 1).replace(/,/g, '');
                CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
                totalamount += (parseFloat(CurDKAmount));
            } 
            // 状态显示
            // 如果CurDKAmount为空，则跳过
            if ($.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", i + 1) == null) continue;
            var CurDKAmount = $.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", i + 1).replace(/,/g, '');
            CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
            var CurDKRate = $.MvcSheetUI.GetControlValue("DKTbl.CurDKRate", i + 1).replace(/,/g, '');
            CurDKRate = CurDKRate == "" ? 0 : CurDKRate;
            var LJDKAmount = $.MvcSheetUI.GetControlValue("DKTbl.LJDKAmount", i + 1).replace(/,/g, '');
            LJDKAmount = LJDKAmount == "" ? 0 : LJDKAmount;
            var LJDKAmountWB = $.MvcSheetUI.GetControlValue("DKTbl.LJDKAmountWB", i + 1).replace(/,/g, '');
            LJDKAmountWB = LJDKAmountWB == "" ? 0 : LJDKAmountWB;
            var LJDKAmount = LJDKAmount == "" ? 0 : LJDKAmount;
            var LJDKAmountWB = LJDKAmountWB == "" ? 0 : LJDKAmountWB;
            var QKConvertAmount = $.MvcSheetUI.GetControlValue("DKTbl.QKConvertAmount", i + 1);
            // 获取按折算金额合计项的请款金额的数值
            var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrencyCnt", i + 1);
            var dtl2 = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
            var len2 = dtl2.RowCount;
            var QKAmountTotal = 0;
            if (len2 > 0) {
                for (var j = i; j < i + parseInt(QKCurrencyCnt); j++) {
                    var QKAmount = $.MvcSheetUI.GetControlValue("DKTbl.QKAmount", j + 1)==null?"":$.MvcSheetUI.GetControlValue("DKTbl.QKAmount", j + 1).replace(/,/g, '');
                    QKAmount = QKAmount == "" ? 0 : QKAmount;
                    QKAmountTotal += parseFloat(QKAmount);
                }
            }

            // 如果到款是RMB
            if (CurDKCurrency == 'RMB') {
                // 如果折算金额不为空
                if (QKConvertAmount != "") {
                    if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) > (parseFloat(QKConvertAmount))) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "超额到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) == (parseFloat(QKConvertAmount))) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "全部到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "未到款", i + 1);
                    } else {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "部分到款", i + 1);
                    }
                } else {
                    // 累计到款人民币折合外币+当前到款人民币折合外币+累计到款外币 与 请款外币 比较
                    var fLR = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(LJDKAmount) / parseFloat(CurDKRate));
                    var fCR = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(CurDKAmount) / parseFloat(CurDKRate));
                    if ((parseFloat(fLR) + parseFloat(LJDKAmountWB) + fCR) > parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "超额到款", i + 1);
                    } else if ((parseFloat(fLR) + parseFloat(LJDKAmountWB) + fCR) == parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "全部到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "未到款", i + 1);
                    } else {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "部分到款", i + 1);
                    }
                }
            // 如果到款是外币
            } else {
                // 如果请款为外币
                if (QKCurrencyName != "人民币") {
                    var f = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(LJDKAmount) / parseFloat(CurDKRate));
                    if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) > parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "超额到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) == parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "全部到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "未到款", i + 1);
                    } else {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "部分到款", i + 1);
                    }
                } else {
                    // 累计到款人民币+当前到款外币*汇率+累计到款外币折合人民币 与 请款人民币 比较
                    var fLR = parseFloat(LJDKAmountWB) * parseFloat(CurDKRate);
                    var fCR = parseFloat(CurDKAmount) * parseFloat(CurDKRate);
                    if ((parseFloat(fCR) + parseFloat(fLR) + parseFloat(LJDKAmount)) > parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "超额到款", i + 1);
                    } else if ((parseFloat(fCR) + parseFloat(fLR) + parseFloat(LJDKAmount)) == parseFloat(QKAmountTotal)) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "全部到款", i + 1);
                    } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "未到款", i + 1);
                    } else {
                        $.MvcSheetUI.SetControlValue('DKTbl.Status', "部分到款", i + 1);
                    }
                }
                
            }
            
            
        }
    }
    $.MvcSheetUI.SetControlValue('DKAmount', totalamount.toFixed(2));
    $('.AmountFormat').blur();
}

// 设置当前到款金额的隐藏项
function setCurDKAmountHidden(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var QKObjectID = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", rowIndex - 1);
    var QKType = $.MvcSheetUI.GetControlValue("DKTbl.QKType", rowIndex - 1);
    var QKCurrency = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", rowIndex - 1);
    var CurDKAmount = $.MvcSheetUI.GetControlValue("DKTbl.CurDKAmount", rowIndex - 1);
    if (CurDKAmount == null) return;
    CurDKAmount = CurDKAmount.replace(/,/g, '');
    CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
    var dtl = $.MvcSheetUI.GetElement("DKTbl").SheetGridView();
    var len = dtl.RowCount;
    if (len > 0) {
        var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
        if (IsHYFlg == "true") {
            for (var i = 0; i < len; i++) {
                var QKObjectID2 = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                if (QKObjectID == QKObjectID2) {
                    $.MvcSheetUI.SetControlValue("DKTbl.CurDKAmountHidden", CurDKAmount, i + 1);
                }
            }
        } else {
            for (var i = 0; i < len; i++) {
                var QKObjectID2 = $.MvcSheetUI.GetControlValue("DKTbl.QKObjectID", i + 1);
                var QKType2 = $.MvcSheetUI.GetControlValue("DKTbl.QKType", i + 1);
                var QKCurrency2 = $.MvcSheetUI.GetControlValue("DKTbl.QKCurrency", i + 1);
                if (QKObjectID == QKObjectID2 && QKType == QKType2 && QKCurrency == QKCurrency2) {
                    $.MvcSheetUI.SetControlValue("DKTbl.CurDKAmountHidden", CurDKAmount, i + 1);
                }
            }
        }
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
                        if (CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
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
                    GotoBackPage("DK", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackDKTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}