// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
            var InsObjectID = $.MvcSheetUI.SheetInfo.InstanceId;
            var WorkflowVersion_FKReceipt = $.MvcSheetUI.GetControlValue("WorkflowVersion_FKReceipt");
            window.open("/Portal/Sheets/Contract/FKReceiptMy.aspx?Mode=Originate&WorkflowCode=FKReceipt&WorkflowVersion=" + WorkflowVersion_FKReceipt + "&InsObjectID=" + InsObjectID);
            //window.location.href = "/Portal/Sheets/Contract/FKReceiptMy.aspx?Mode=Originate&WorkflowCode=FKReceipt&WorkflowVersion=" + WorkflowVersion_FKReceipt + "&InsObjectID=" + InsObjectID;
        }
    }
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var ZJAttachment = $("#ZJAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("ZJAttachment", ZJAttachment);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        if (this.Action == "Submit") {
            
            var IsOperateFK = $.MvcSheetUI.GetControlValue("IsOperateFK");
            if (IsOperateFK != "是;") {
                layer.alert('请勾选执行付款！', { icon: 2 });
                return false;
            }
        }
    }
    return true;
}
var fromZFGL = "";
var fromJS = "";
//}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    var FKType = getUrlParam("FKType");
    var JSObjectID = getUrlParam("JSObjectID");
    var JSResultNum = getUrlParam("JSResultNum");
    var Currency = "";
    // 从支付管理迁移过来 后台处理
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
                $.MvcSheetUI.SetControlValue("FinalUser", ret.FinalUser);
                $.MvcSheetUI.SetControlValue("CurrencyRMB", "人民币");
                $.MvcSheetUI.SetControlValue("CurrencyWB", ret.CurrencyName);
                $.MvcSheetUI.SetControlValue("ContractTotalPrice", parseFloat(ret.ContractTotalPrice).toFixed(2));
                $.MvcSheetUI.SetControlValue("JKTotalAmount", parseFloat(ret.JKTotalAmount).toFixed(2));
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
            }
        });
        
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        // 获取当前付款的货币
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getFKById",   //处理页的相对地址
            data: {
                BizObjectID: $.MvcSheetUI.SheetInfo.BizObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                Currency = ret.Currency;
            }
        });
    }

    if (QKSubObjectIDs != null && QKSubObjectIDs != "") {
        fromZFGL = "true";

        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKStatusData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
                QKSubObjectIDs: QKSubObjectIDs,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("DKRemarkTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKSeq", ret[i].QKSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.SeqCnt", ret[i].SeqCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.ZJKX", ret[i].ZJKX, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.ZJMS", ret[i].ZJMS, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKCurrency", ret[i].QKCurrency, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKConvertAmount", ret[i].QKConvertAmount == "0" ? "" : ret[i].QKConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKTarget", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.LJDKTotalAmount", ret[i].LJDKTotalAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKObjectID", ret[i].QKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRemarkTbl.QKType", ret[i].QKType, i + 1);

                }
                // 子表不能编辑
                $("input[data-datafield='DKRemarkTbl.QKSeq']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.SeqCnt']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.ZJKX']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.ZJMS']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.QKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.QKCurrency']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.QKConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.QKTarget']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.LJDKTotalAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.Status']").attr("disabled", "disabled");
                $("input[data-datafield='DKRemarkTbl.DisplayName']").attr("disabled", "disabled");
            }
        });


    } else {
        fromZFGL = "false";
    }

    if (JSObjectID != null && JSObjectID != "") {
        fromJS = "true";
        $("[data-datafield='ZKType']").attr("disabled", "disabled");
        $("[data-datafield='Currency']").attr("disabled", "disabled");
    } else {
        fromJS = "false";
        JSObjectID = $.MvcSheetUI.GetControlValue("JSObjectID");
        if (JSObjectID != null && JSObjectID != "") {
            //$.MvcSheetUI.SetControlValue("JSObjectID", JSObjectID);
            //$.MvcSheetUI.SetControlValue("CurZJAmount", JSResultNum);
            $("[data-datafield='ZKType']").attr("disabled", "disabled");
            $("[data-datafield='Currency']").attr("disabled", "disabled");
        } else {
            $("[data-datafield='ZKType']").find("option").each(function () {
                if ($(this)[0].value == 'ZKType_JS') {
                    $(this).attr("disabled", "disabled");
                }
            });
        }
    }

    var ContractTotalPrice = $.MvcSheetUI.GetControlValue("ContractTotalPrice").replace(/,/g, '');
    ContractTotalPrice = ContractTotalPrice == "" ? 0 : ContractTotalPrice;
    var JKTotalAmount = $.MvcSheetUI.GetControlValue("JKTotalAmount").replace(/,/g, '');
    JKTotalAmount = JKTotalAmount == "" ? 0 : JKTotalAmount;
    // 获取已申请付款的相关数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getApplyZJAmount",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.MvcSheetUI.SetControlValue("ApplyZJAmountRMB", parseFloat(ret.RMB).toFixed(2));
            $.MvcSheetUI.SetControlValue("ApplyZJAmountWB", parseFloat(ret.WB).toFixed(2));
            var ApplyZJPercentRMB = "";
            var ApplyZJPercentWB = "";
            var CurZJPercent = "";
            var CurZJPercentWB = "";
            if (parseFloat(ContractTotalPrice) == 0) {
                ApplyZJPercentRMB = "0%";
                CurZJPercent = "0%";
            } else {
                ApplyZJPercentRMB = (parseFloat(ret.RMB) / parseFloat(ContractTotalPrice) * 100).toFixed(2) + "%";
                CurZJPercent = (parseFloat(ret.RMB) / parseFloat(ContractTotalPrice) * 100).toFixed(2) + "%";
            }
            if (parseFloat(JKTotalAmount) == 0) {
                ApplyZJPercentWB = "0%";
                CurZJPercentWB = "0%";
            } else {
                ApplyZJPercentWB = (parseFloat(ret.WB) / parseFloat(JKTotalAmount) * 100).toFixed(2) + "%";
                CurZJPercentWB = (parseFloat(ret.WB) / parseFloat(JKTotalAmount) * 100).toFixed(2) + "%";
            }
            $.MvcSheetUI.SetControlValue("ApplyZJPercentRMB", ApplyZJPercentRMB);
            $.MvcSheetUI.SetControlValue("ApplyZJPercentWB", ApplyZJPercentWB);
            $.MvcSheetUI.SetControlValue("CurZJPercent", CurZJPercent);
            $.MvcSheetUI.SetControlValue("CurZJPercentWB", CurZJPercentWB);
        }
    });

    $(".CurrencyRMB").text($.MvcSheetUI.GetControlValue("CurrencyRMB"));
    $(".CurrencyWB").text($.MvcSheetUI.GetControlValue("CurrencyWB"));
    
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='FinalUser']").attr("disabled", "disabled");
    $("input[data-datafield='ContractTotalPrice']").attr("disabled", "disabled");
    $("input[data-datafield='JKTotalAmount']").attr("disabled", "disabled");
    $("input[data-datafield='ApplyZJAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='ApplyZJAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='CurZJAmount']").attr("disabled", "disabled");
    $("input[data-datafield='ApplyZJPercentRMB']").attr("disabled", "disabled");
    $("input[data-datafield='ApplyZJPercentWB']").attr("disabled", "disabled");
    $("input[data-datafield='CurZJPercent']").attr("disabled", "disabled");
    $("input[data-datafield='CurZJPercentWB']").attr("disabled", "disabled");
    $("input[data-datafield='Rate']").attr("disabled", "disabled");

    // 到款状态子表的显示判断
    var rowp = 0;
    var dtl = $.MvcSheetUI.GetElement("DKRemarkTbl").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var IsFirst2 = true;
    var QKObjectID = "";
    var QKType = "";
    var QKCurrency = "";

    if (len > 0) {
        for (var i = 0; i < len; i++) {
            if (IsFirst2 || QKObjectID != $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1)) {
                IsFirst2 = false;
                QKObjectID = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1);
                var SeqCnt = $.MvcSheetUI.GetControlValue("DKRemarkTbl.SeqCnt", i + 1);
                var k = 0;
                $("[data-datafield='DKRemarkTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRemarkTbl.QKSeq']").attr("rowspan", SeqCnt);
                        //$(this).find("td[data-field='DKRemarkTbl.QKConvertAmount']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKRemarkTbl.QKTarget']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='DKRemarkTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRemarkTbl.QKSeq']").remove();
                        //$(this).find("td[data-field='DKRemarkTbl.QKConvertAmount']").remove();
                        $(this).find("td[data-field='DKRemarkTbl.QKTarget']").remove();
                    }
                    k++;
                });
            }
        }

        for (var i = 0; i < len; i++) {
            if (IsFirst1 || QKObjectID + QKType + QKCurrency != $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKType", i + 1) + $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKCurrency", i + 1)) {
                QKObjectID = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1);
                QKType = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKType", i + 1);
                QKCurrency = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKCurrency", i + 1);
                IsFirst1 = false;
                var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKCurrencyCnt", i + 1);
                var k = 0;
                $("[data-datafield='DKRemarkTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRemarkTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='DKRemarkTbl.LJDKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='DKRemarkTbl.DisplayName']").attr("rowspan", QKCurrencyCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKObjectID", i + 1);
                QKType = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKType", i + 1);
                QKCurrency = $.MvcSheetUI.GetControlValue("DKRemarkTbl.QKCurrency", i + 1);
                var k = 0;
                $("[data-datafield='DKRemarkTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRemarkTbl.QKConvertAmount']").remove();
                        $(this).find("td[data-field='DKRemarkTbl.LJDKTotalAmount']").remove();
                        $(this).find("td[data-field='DKRemarkTbl.DisplayName']").remove();
                    }
                    k++;
                });
            }
        }
    }

    // 子表的显示判断
    var rowp = 0;
    $("[data-datafield='DKRemarkTbl']").find("tr.rows").each(function () {
        rowp++;
        var DisplayName = $.MvcSheetUI.GetControlValue("DKRemarkTbl.DisplayName", rowp);
        if (DisplayName == "全部到款") {
            $(this).find("td[data-field='DKRemarkTbl.DisplayName']").addClass("settled");//绿色
        } else if (DisplayName == "超额到款") {
            $(this).find("td[data-field='DKRemarkTbl.DisplayName']").addClass("nonSettlement");// 红色
        } else {
            $(this).find("td[data-field='DKRemarkTbl.DisplayName']").addClass("unsettled");// 橙色
        }
    });

    $(".ZFRMB").hide();
    $(".ZFOperate").hide();
    $(".OtherReceiver").hide();
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm"){
        if (Currency != "RMB" && Currency != "") {
            $(".ZFRMB").show();
        }
    }

    FKCheckBoxChange();

    // 自定义文件格式 支付凭证
    $("#ZJAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\付款");
    var ZJAttachment = $.MvcSheetUI.GetControlValue("ZJAttachment");
    if (ZJAttachment != "") {
        var arr = ZJAttachment.split(",");
        $("#ZJAttachment").xnfile("value", arr);
    }
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("ZJAttachment");
    } else {
        setFileReadOnly("ZJAttachment");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackFKTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();

    $('.AmountFormat').blur();
}

function ZKTypeHiddenChange() {
    if (fromJS == "true") {
        $.MvcSheetUI.SetControlValue("ZKType", "ZKType_JS");
    }
    if (fromZFGL == "true") {
        $.MvcSheetUI.SetControlValue("ZKType", $.MvcSheetUI.GetControlValue("ZKTypeHidden"));
    }
}

function CurrencyHiddenChange() {
    if (fromZFGL == "true") {
        $.MvcSheetUI.SetControlValue("Currency", $.MvcSheetUI.GetControlValue("CurrencyHidden"));
    }
}

function GetPayTypeChange() {
    var PayType = $.MvcSheetUI.GetControlValue("PayType");
    // 选择的为汇款、支票时
    if (PayType == "PayType_HK" || PayType == "PayType_ZP") {
        $.MvcSheetUI.SetControlValue("ZFOperate", "");
        $(".ZFOperate").hide();
        $("[data-datafield='Currency']").attr("disabled", false);
        // 选择的为信用证付款时，显示支付操作
    } else {
        $(".ZFOperate").show();
        var CurrencyWBCode = "";
        $("[data-datafield='Currency']").find("option").each(function () {
            if ($(this)[0].value != 'RMB' && $(this)[0].value != '') {
                CurrencyWBCode = $(this)[0].value;
            }
        });
        $.MvcSheetUI.SetControlValue("Currency", CurrencyWBCode);
        $("[data-datafield='Currency']").attr("disabled", "disabled");
    }
}

function CurrencyChange() {
    $(".CurrencyCur").text($("select[data-datafield='Currency']").find("option:selected").text());
    var JSObjectID = $.MvcSheetUI.GetControlValue("JSObjectID");
    // 如果是结算过来的，那就设为结算
    if (JSObjectID != null && JSObjectID != "") {
        //$.MvcSheetUI.SetControlValue("ZKType", "ZKType_JS");
    } else {
        $("[data-datafield='ZKType']").find("option").each(function () {
            if ($(this)[0].value == 'ZKType_JS') {
                $(this).attr("disabled", "disabled");
            }
        });
    }
    var Currency = $.MvcSheetUI.GetControlValue("Currency");
    $("[data-datafield='FKTbl']").find("tr.rows").each(function () {
        if (Currency != "RMB") {
            $(this).find("[data-datafield='FKTbl.OutTaxAmount']").attr("disabled", false);
        } else {
            $(this).find("[data-datafield='FKTbl.OutTaxAmount']").val(0);
            $(this).find("[data-datafield='FKTbl.OutTaxAmount']").attr("disabled", true);
        }
    });
}

function FKCheckBoxChange() {
    var FKCheckBox = $.MvcSheetUI.GetControlValue("FKCheckBox");
    if (FKCheckBox.indexOf("其他")>=0) {
        $(".OtherContent").show();
    } else {
        $(".OtherContent").hide();
        $.MvcSheetUI.SetControlValue("FKCheckBox","");
    }
    if (FKCheckBox.indexOf("代理费") >= 0) {
        $(".AgencyFee").show();
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var AgencyReturnType = "";
        var AgencyReturnNumber = "";
        var SignDayExchangeRate = "";
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                AgencyReturnType = ret.AgencyReturnType != "" ? ret.AgencyReturnType : "";
                AgencyReturnNumber = ret.AgencyReturnNumber != "" ? ret.AgencyReturnNumber:"";
                SignDayExchangeRate = ret.SignDayExchangeRate != "" ? ret.SignDayExchangeRate : "";
            }
        });
        var CurZJAmount = $.MvcSheetUI.GetControlValue("CurZJAmount").replace(/,/g, '');
        CurZJAmount = CurZJAmount == "" ? 0 : CurZJAmount;
        var Currency = $.MvcSheetUI.GetControlValue("Currency");
        var AgencyFee = 0;
        
        // 代理费类型：固定金额
        if (AgencyReturnType == "人民币") {
            AgencyFee = parseFloat(AgencyReturnNumber);
        // 代理费类型：百分比
        } else if (AgencyReturnType == "百分比"){
            // 支付人民币
            if (Currency == "RMB") {
                AgencyFee = parseFloat(CurZJAmount) * parseFloat(AgencyReturnNumber) / 100;
            } else {
                AgencyFee = parseFloat(CurZJAmount) * parseFloat(SignDayExchangeRate) * parseFloat(AgencyReturnNumber) / 100;
            }
        }

        $.MvcSheetUI.SetControlValue("AgencyFee", AgencyFee.toFixed(2));
    } else {
        $(".AgencyFee").hide();
        $.MvcSheetUI.SetControlValue("AgencyFee", "0");
    }
    if (FKCheckBox.indexOf("银行费") >= 0) {
        $(".BankFee").show();
    } else {
        $(".BankFee").hide();
    }
}

// 受款人change事件
function ChangeReceiver() {
    var Receiver = $.MvcSheetUI.GetControlValue("Receiver");
    if (Receiver == "其他") {
        $(".OtherReceiver").show();
    } else {
        $.MvcSheetUI.SetControlValue("OtherReceiver", "");
        $(".OtherReceiver").hide();
    }
}

function ConvertAmountChange() {
    var ConvertAmount = $.MvcSheetUI.GetControlValue("ConvertAmount").replace(/,/g, '');
    ConvertAmount = ConvertAmount == "" ? 0 : ConvertAmount;
    if (ConvertAmount == "" || parseFloat(ConvertAmount) == 0) {
        $.MvcSheetUI.SetControlValue("Rate", "");
    } else {
        var CurZJAmount = $.MvcSheetUI.GetControlValue("CurZJAmount").replace(/,/g, '');
        CurZJAmount = CurZJAmount == "" ? 0 : CurZJAmount;
        var Rate = parseFloat(ConvertAmount) / parseFloat(CurZJAmount);
        $.MvcSheetUI.SetControlValue("Rate", Rate);
    }
    
}

function ZJRMBTypeChange() {
    if ($("select[data-datafield='ZJRMBType']").find("option:selected").text() == "购汇") {
        $(".GHDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("ConvertAmount", 0);
        $.MvcSheetUI.SetControlValue("Rate", "");
        $(".GHDiv").hide();
    }
}

function ZJKXChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var Currency = $.MvcSheetUI.GetControlValue('Currency', rowIndex - 1);
    var k = 1;
    $("[data-datafield='FKTbl']").find("tr.rows").each(function () {
        if (k == rowIndex - 1) {
            if (Currency != "RMB") {
                $(this).find("[data-datafield='FKTbl.OutTaxAmount']").attr("disabled", false);
            } else {
                $.MvcSheetUI.SetControlValue('FKTbl.OutTaxAmount', 0, rowIndex - 1);
                $(this).find("[data-datafield='FKTbl.OutTaxAmount']").attr("disabled", true);
            }
        }
        k++;
    });
}

function compute() {
    // 只有申请节点才计算
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var i = 0;
        var totalamount = 0.0;
        $("[data-datafield='FKTbl']").find('tr.rows').each(function () {
            var amount = $(this).find("input[data-datafield='FKTbl.Amount']")[0].value.replace(/,/g, '');
            amount = amount == "" ? 0 : amount;
            var OutTaxAmount = $(this).find("input[data-datafield='FKTbl.OutTaxAmount']")[0].value.replace(/,/g, '');
            OutTaxAmount = OutTaxAmount == "" ? 0 : OutTaxAmount;
            totalamount += (parseFloat(amount) + parseFloat(OutTaxAmount));
        });
        // 本次支付金额
        $.MvcSheetUI.SetControlValue('CurZJAmount', totalamount.toFixed(2));

        // 本次支付后比例
        var ApplyZJAmountRMB = $.MvcSheetUI.GetControlValue("ApplyZJAmountRMB").replace(/,/g, '');
        ApplyZJAmountRMB = ApplyZJAmountRMB == "" ? 0 : ApplyZJAmountRMB;
        var ApplyZJAmountWB = $.MvcSheetUI.GetControlValue("ApplyZJAmountWB").replace(/,/g, '');
        ApplyZJAmountWB = ApplyZJAmountWB == "" ? 0 : ApplyZJAmountWB;
        var ContractTotalPrice = $.MvcSheetUI.GetControlValue("ContractTotalPrice").replace(/,/g, '');
        ContractTotalPrice = ContractTotalPrice == "" ? 0 : ContractTotalPrice;
        var JKTotalAmount = $.MvcSheetUI.GetControlValue("JKTotalAmount").replace(/,/g, '');
        JKTotalAmount = JKTotalAmount == "" ? 0 : JKTotalAmount;
        var totalamount_RMB = 0.0;
        var totalamount_WB = 0.0;
        if ($.MvcSheetUI.GetControlValue("ZKType") == "ZKType_FY") {
            totalamount_RMB = 0;
            totalamount_WB = 0;
        } else {
            if ($.MvcSheetUI.GetControlValue("Currency") == "RMB") {
                totalamount_RMB = totalamount;
            } else {
                totalamount_WB = totalamount;
            }
        }
        var CurZJPercent = "";
        var CurZJPercentWB = "";
        if (parseFloat(ContractTotalPrice) == 0) {
            CurZJPercent = "0%";
        } else {
            CurZJPercent = ((parseFloat(ApplyZJAmountRMB) + totalamount_RMB) / parseFloat(ContractTotalPrice) * 100).toFixed(2) + "%";
        }
        if (parseFloat(JKTotalAmount) == 0) {
            CurZJPercentWB = "0%";
        } else {
            CurZJPercentWB = ((parseFloat(ApplyZJAmountWB) + totalamount_WB) / parseFloat(JKTotalAmount) * 100).toFixed(2) + "%";
        }
        $.MvcSheetUI.SetControlValue("CurZJPercent", CurZJPercent);
        $.MvcSheetUI.SetControlValue("CurZJPercentWB", CurZJPercentWB);
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
                        if (CurActivity == "ActivityHYManager" || CurActivity == "ActivityManager") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyManager") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyManager") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油领导审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油领导审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "请款送达确认") {
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
                    GotoBackPage("FK", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackFKTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}