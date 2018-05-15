// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    //if (!checkCurrency()) {
    //    return false;
    //}
}
// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Submit" || this.Action == "Save") {
            //var QKObjectIDs = $.MvcSheetUI.GetControlValue("QKObjectIDs");
            //// 设置请款中的累计到款值
            //// 获取客户信息数据
            //$.ajax({
            //    type: "POST",    //页面请求的类型
            //    url: "ContractHandler.ashx?Command=SetQKLJDK",   //处理页的相对地址
            //    data: {
            //        QKObjectIDs: QKObjectIDs,
            //    },
            //    async: false,
            //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            //        console.log("设置请款中的累计到款值成功");
            //    }
            //});
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        if (this.Action == "Submit") {
            //var QKObjectIDs = $.MvcSheetUI.GetControlValue("QKObjectIDs");
            // 设置请款中的累计到款值
            // 获取客户信息数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=SetQKLJDK",   //处理页的相对地址
                data: {
                    BatchDKObjectID: $.MvcSheetUI.SheetInfo.BizObjectID,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    console.log("设置请款中的累计到款值成功");
                }
            });
        }
    }
}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 请款对象
    var Target = getUrlParam("Target");
    var Amount = getUrlParam("Amount");
    var QKObjectIDs = getUrlParam("QKObjectIDs");
    var DK_Target = "";
    if (Target != null && Target != "") {
        $.MvcSheetUI.SetControlValue("QKObjectIDs", QKObjectIDs);
        var QKObjectIDArr = QKObjectIDs.split(",");
        // 获取客户信息数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getCustomerById",   //处理页的相对地址
            data: {
                ObjectID: Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                DK_Target = ret.CompanyName + '（' + ret.ModelOrDepartment + '）';
                
            }
        });
        $.MvcSheetUI.SetControlValue("DK_Target", DK_Target);
        // 获取所有的币种
        //var Currencys = new Array();
        //$.ajax({
        //    type: "POST",    //页面请求的类型
        //    url: "ContractHandler.ashx?Command=getCurrencys",   //处理页的相对地址
        //    data: {
        //    },
        //    async: false,
        //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
        //        for (var i = 0; i < ret.length; i++) {
        //            var amounts = Amount.split(",");
        //            for (var k = 0; k < amounts.length; k++) {
        //                var curr = amounts[k].split(" ")[1];
        //                if (ret[i].Code == curr) {
        //                    Amount = Amount.replace(curr, ret[i].Value);
        //                }
        //            }
        //        }
        //    }
        //});

        //$.MvcSheetUI.SetControlValue("Amount", Amount);
        
        // 表格数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKLSData",   //处理页的相对地址
            data: {
                DK_Target: DK_Target,
                QKObjectIDs: QKObjectIDs,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BatchDKTblOfDK").SheetGridView();
                dtl._Clear();
                var index = 0;
                for (var i = 0; i < ret.length; i++) {

                        dtl._AddRow();
                        index++;
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.ContractNo", ret[i].ContractNo, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKSeq", ret[i].QKSeq, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKObjectID", ret[i].QKObjectID, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKSeqHidden", ret[i].QKSeqHidden, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKType", ret[i].QKType, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKTypeCode", ret[i].QKTypeCode, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKTarget", ret[i].QKTarget, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKTargetCode", ret[i].QKTarget, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKDate", ret[i].QKDate, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.ZJKX", ret[i].ZJKX, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.ZJMS", ret[i].ZJMS, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKAmount", ret[i].QKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKRate", ret[i].QKRate, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKCurrencyCode", ret[i].QKCurrencyCode, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKCurrency", ret[i].QKCurrency, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKCurrencyCnt", ret[i].QKCurrencyCnt2, i + 1);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.QKConvertAmount", ret[i].QKConvertAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.SeqCnt", ret[i].SeqCnt, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.LJDKAmount", ret[i].LJDKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.LJDKAmountWB", ret[i].LJDKAmountWB, index);
                        //勾选的数据是否在所有批量数据中
                        var b = IsInArr(QKObjectIDArr, ret[i].QKObjectID, ret[i].QKTypeCode, ret[i].QKCurrencyCode);
                        if (b >= 0) {
                            var QKObjectID = QKObjectIDArr[b].split(":")[0];
                            var CurDKAmount = QKObjectIDArr[b].split(":")[3];
                            var CurDKCurrency = QKObjectIDArr[b].split(":")[4];
                            //var s = QKObjectIDArr[b].split(":")[3];
                            //var Status = "";
                            //if (s == "0") {
                            //    Status = "未到款";
                            //} else if (s == "1") {
                            //    Status = "部分到款";
                            //} else if (s == "2") {
                            //    Status = "全部到款";
                            //}
                            $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.CurDKAmount", CurDKAmount, index);
                            $.MvcSheetUI.SetControlValue("BatchDKTblOfDK.CurDKCurrency", CurDKCurrency, index);
                            //$.MvcSheetUI.SetControlValue("BatchDKTblOfDK.CurDKRate", ret[i].QKRate, index);
                            //$.MvcSheetUI.SetControlValue("BatchDKTblOfDK.Status", Status, index);
                        }
                }
            }
        });


    }

 
    // 请款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("BatchDKTblOfDK").SheetGridView();
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
            if (IsFirst2 || QKObjectID != $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1)) {
                IsFirst2 = false;
                QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1);
                var SeqCnt = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.SeqCnt", i + 1);
                var k = 0;
                $("[data-datafield='BatchDKTblOfDK']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='BatchDKTblOfDK.ContractNo']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.QKSeq']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.QKType']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.QKTarget']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.QKDate']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='BatchDKTblOfDK']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='BatchDKTblOfDK.ContractNo']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.QKSeq']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.QKType']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.QKTarget']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.QKDate']").remove();
                    }
                    k++;
                });
            }
        }


        for (var i = 0; i < len; i++) {
            // 折算金额
            if (IsFirst1 || QKObjectID + QKTypeCode + QKCurrencyCode != $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKTypeCode", i + 1) + $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCode", i + 1)) {
                QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1);
                QKTypeCode = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKTypeCode", i + 1);
                QKCurrencyCode = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCode", i + 1);
                IsFirst1 = false;
                var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCnt", i + 1);
                var k = 0;
                $("[data-datafield='BatchDKTblOfDK']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='BatchDKTblOfDK.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.LJDKAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.LJDKAmountWB']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKRate']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='BatchDKTblOfDK.Status']").attr("rowspan", QKCurrencyCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKObjectID", i + 1);
                QKTypeCode = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKTypeCode", i + 1);
                QKCurrencyCode = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCode", i + 1);
                var k = 0;
                $("[data-datafield='BatchDKTblOfDK']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='BatchDKTblOfDK.QKConvertAmount']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.LJDKAmount']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.LJDKAmountWB']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKAmount']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKRate']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.CurDKCurrency']").remove();
                        $(this).find("td[data-field='BatchDKTblOfDK.Status']").remove();
                    }
                    k++;
                });
            }

        }
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        //$(".BatchDKTblOfDK").hide();
        $("input[data-datafield='BatchDKTblOfDK.CurDKAmount']").addClass("DKInputAmount");
        $("input[data-datafield='BatchDKTblOfDK.CurDKRate']").addClass("DKInputAmount");
        compute2();
    }

    $("input[data-datafield='DK_Target']").attr("disabled", "disabled");
    $("input[data-datafield='Amount']").attr("disabled", "disabled");

    $("input[data-datafield='BatchDKTblOfDK.ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKSeq']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKType']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKTarget']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKDate']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.ZJKX']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.ZJMS']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKRate']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.QKConvertAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.LJDKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.LJDKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='BatchDKTblOfDK.Status']").attr("disabled", "disabled");
    //$("[data-datafield='BatchDKTblOfDK.CurDKCurrency']").attr("disabled", "disabled");
    //$("input[data-datafield='BatchDKTblOfDK.CurDKAmount']").attr("disabled", "disabled");

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackBatchDKTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
}

// 是否包含，包含返回序列号，不包含返回-1
function IsInArr(arr, paramQKObjectID, paramQKTypeCode, paramQKCurrencyCode) {
    for (var j = 0; j < arr.length; j++) {
        var QKObjectID = arr[j].split(":")[0];
        var QKTypeCode = arr[j].split(":")[1];
        var QKCurrencyCode = arr[j].split(":")[2];
        if (paramQKObjectID == QKObjectID && paramQKTypeCode == QKTypeCode && paramQKCurrencyCode == QKCurrencyCode) {
            return j;
        }
    }
    return -1;
}

function compute() {
    
    // 只有申请节点才计算
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var dtl = $.MvcSheetUI.GetElement("BatchDKTblOfDK").SheetGridView();
        var len = dtl.RowCount;
        var totalamount = 0.0;
        if (len > 0) {
            for (var i = 0; i < len; i++) {
                // 设置当前行本次到款金额为 请款金额 - 累计到款金额、状态为全部到款
                //var rowIndex = el.parentElement.parentElement.rowIndex;
                var CurDKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKCurrency", i+1);
                var QKCurrencyCode = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCode", i + 1);
                // 如果CurDKAmount为空，则跳过
                if ($.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKAmount", i + 1) == null) continue;
                // 状态显示
                var CurDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKAmount", i + 1);
                var CurDKRate = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKRate", i + 1);
                var LJDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.LJDKAmount", i + 1);
                var LJDKAmountWB = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.LJDKAmountWB", i + 1);
                var LJDKAmount = LJDKAmount == "" ? 0 : LJDKAmount;
                var LJDKAmountWB = LJDKAmountWB == "" ? 0 : LJDKAmountWB;
                var QKConvertAmount = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKConvertAmount", i + 1);
                // 获取按折算金额合计项的请款金额的数值
                var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKCurrencyCnt", i + 1);
                var dtl2 = $.MvcSheetUI.GetElement("BatchDKTblOfDK").SheetGridView();
                var len2 = dtl2.RowCount;
                var QKAmountTotal = 0;
                if (len2 > 0) {
                    for (var j = i; j < i + parseInt(QKCurrencyCnt); j++) {
                        var QKAmount = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKAmount", j + 1) == null ? "" : $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.QKAmount", j + 1);
                        QKAmount = QKAmount == "" ? 0 : QKAmount;
                        QKAmountTotal += parseFloat(QKAmount);
                    }
                }
                //if (QKCurrencyCode == CurDKCurrency) {
                //    // 如果请款和到款是RMB
                //    if (QKCurrencyCode == 'RMB') {
                //        if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) > parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) == parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                //        } else {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                //        }
                //        // 如果请款和到款是外币
                //    } else {
                //        var f = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(LJDKAmount) / parseFloat(CurDKRate));
                //        if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) > parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) == parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                //        } else {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                //        }
                //    }
                //} else {
                //    // 如果请款是RMB，到款为外币
                //    if (QKCurrencyCode == 'RMB') {
                //        if (((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB)) * parseFloat(CurDKRate) + parseFloat(LJDKAmount)) > parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                //        } else if (((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB)) * parseFloat(CurDKRate) + parseFloat(LJDKAmount)) == parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                //        } else {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                //        }
                //        // 如果请款是外币，到款为RMB
                //    } else if (CurDKCurrency == "RMB") {
                //        var f = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(CurDKAmount) + parseFloat(LJDKAmount)) / parseFloat(CurDKRate);
                //        if ((f + parseFloat(LJDKAmountWB)) > parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                //        } else if ((f + parseFloat(LJDKAmountWB)) == parseFloat(QKAmount)) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                //        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                //        } else {
                //            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                //        }
                //    }
                //}

                // 如果到款是RMB
                if (CurDKCurrency == 'RMB') {
                    // 如果折算金额不为空
                    if (QKConvertAmount != "") {
                        if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) > (parseFloat(QKConvertAmount))) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmount) + parseFloat(LJDKAmountWB) * parseFloat(CurDKRate)) == (parseFloat(QKConvertAmount))) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                        } else {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                        }
                    } else {
                        // 累计到款人民币折合外币+当前到款人民币折合外币+累计到款外币 与 请款外币 比较
                        var fLR = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(LJDKAmount) / parseFloat(CurDKRate));
                        var fCR = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(CurDKAmount) / parseFloat(CurDKRate));
                        if ((parseFloat(fLR) + parseFloat(LJDKAmountWB) + fCR) > parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                        } else if ((parseFloat(fLR) + parseFloat(LJDKAmountWB) + fCR) == parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                        } else {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                        }
                    }
                    // 如果到款是外币
                } else {
                    // 如果请款为外币
                    if (QKCurrencyCode != "RMB") {
                        var f = parseFloat(CurDKRate) == 0 ? 0 : (parseFloat(LJDKAmount) / parseFloat(CurDKRate));
                        if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) > parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + f) == parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                        } else {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                        }
                    } else {
                        // 累计到款人民币+当前到款外币*汇率+累计到款外币折合人民币 与 请款人民币 比较
                        var fLR = parseFloat(LJDKAmountWB) * parseFloat(CurDKRate);
                        var fCR = parseFloat(CurDKAmount) * parseFloat(CurDKRate);
                        if ((parseFloat(fCR) + parseFloat(fLR) + parseFloat(LJDKAmount)) > parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "超额到款", i + 1);
                        } else if ((parseFloat(fCR) + parseFloat(fLR) + parseFloat(LJDKAmount)) == parseFloat(QKAmountTotal)) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "全部到款", i + 1);
                        } else if ((parseFloat(CurDKAmount) + parseFloat(LJDKAmountWB) + parseFloat(LJDKAmount)) == 0) {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "未到款", i + 1);
                        } else {
                            $.MvcSheetUI.SetControlValue('BatchDKTblOfDK.Status', "部分到款", i + 1);
                        }
                    }

                }
            }
        }
        compute2();
    }
}

function compute2() {
    var i = 0;
    // 总计金额
    var total_amount = 0.0;
    var dtl_js = $.MvcSheetUI.GetElement("BatchDKTblOfDK").SheetGridView();
    var currencyArr = new Array();
    var totalamountArr = new Array();
    var index = 0;
    for (var i = 0; i < dtl_js.RowCount; i++) {
        var CurDKCurrency = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKCurrency", i + 1);
        var CurDKCurrencyName = getNameBykey("BatchDKTblOfDK.CurDKCurrency", index, CurDKCurrency);
        var CurDKAmount = $.MvcSheetUI.GetControlValue("BatchDKTblOfDK.CurDKAmount", i + 1);
        if (CurDKAmount == null) continue;
        CurDKAmount = CurDKAmount == "" ? 0 : CurDKAmount;
        var b = contains(currencyArr, CurDKCurrencyName);
        if (b >= 0) {
            totalamountArr[b] = parseFloat(totalamountArr[b]) + parseFloat(CurDKAmount);
        } else {
            currencyArr.push(CurDKCurrencyName);
            totalamountArr.push(CurDKAmount);
        }
        index++;
    }
    var DKResult = "";
    for (var i = 0; i < currencyArr.length; i++) {
        DKResult += totalamountArr[i] + " " + currencyArr[i] + ",";
    }
    $.MvcSheetUI.SetControlValue("Amount", DKResult);
}

// 通过key获取text
function getNameBykey(el, i, key) {
    var k = 0;
    var value = "";
    $("[data-datafield='" + el + "']").each(function () {
        if (k == i + 1) {
            value = $(this).find("option:selected").text();
            return false; // each退出循环
        }
        k++;
    });
    return value;
}
// 判断数组中是否包含key，如果包含，返回序列号，否则返回-1
function contains(arr, key) {
    for (var i = 0; i < arr.length; i++) {
        if (key == arr[i]) {
            return i;
        }
    }
    return -1;
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
                    GotoBackPage("BatchDK", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackBatchDKTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}