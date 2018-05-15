//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
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
                $.MvcSheetUI.SetControlValue("Attachment", "");
                $.MvcSheetUI.SetControlValue("PostA", ret.PostACode);
                $.MvcSheetUI.SetControlValue("PostB", ret.PostBCode);
            }
        });
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }
    
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.ReceiptNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.PayTarget']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Amount']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Currency']").attr("disabled", "disabled");

    BHTypeChange();

    // 自定义文件格式 附件
    $("#Attachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\保函");
    var Attachment = $.MvcSheetUI.GetControlValue("Attachment");
    if (Attachment != "") {
        var arr = Attachment.split(",");
        $("#Attachment").xnfile("value", arr);
    }
    
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Attachment");
    } else {
        setFileReadOnly("Attachment");
    }

}

function BHTypeChange() {
    var BHType = $.MvcSheetUI.GetControlValue("BHType");
    // 如果是保证金，则保函固定期限、保函到期日等不显示
    if (BHType == "BH_BZJ") {
        $("[data-datafield='BHGDQX']").hide();
        $("[data-datafield='ExpirationDate']").hide();
        $("[data-datafield='RemindDate']").hide();
        $("[data-datafield='LoadRept']").parent().show();
        $("[data-datafield='BHReceiptTbl']").show();
        $.MvcSheetUI.SetControlValue("BHNo","");
        $(".BHNo").hide();
    } else if (BHType == "BH_BH") {
        $("[data-datafield='BHGDQX']").show();
        $("[data-datafield='ExpirationDate']").show();
        $("[data-datafield='RemindDate']").show();
        $("[data-datafield='LoadRept']").parent().hide();
        $("[data-datafield='BHReceiptTbl']").hide();
        var BHNo = "";
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getBHNo",   //处理页的相对地址
            data: {
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                BHNo = ret;
            }
        });
        $.MvcSheetUI.SetControlValue("BHNo", BHNo);
        $(".BHNo").show();
    }
}

function ExpirationDateChange() {
    var ExpirationDate = $("input[data-datafield='ExpirationDate']").val();
    var RemindDate = lastMonthDate(ExpirationDate);
    $("input[data-datafield='RemindDate']").val(RemindDate);
}


function CurrencyHiddenChange() {
    var dtl = $.MvcSheetUI.GetElement('BHReceiptTbl').SheetGridView();
    var len = dtl.RowCount;
    dtl._AddRow();
    var ReceiptNoHidden = $.MvcSheetUI.GetControlValue('ReceiptNoHidden');
    var PayTargetHidden = $.MvcSheetUI.GetControlValue('PayTargetHidden');
    var AmountHidden = $.MvcSheetUI.GetControlValue('AmountHidden');
    var CurrencyHidden = $.MvcSheetUI.GetControlValue('CurrencyHidden');
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.ReceiptNo", ReceiptNoHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.PayTarget", PayTargetHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.Amount", AmountHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.Currency", CurrencyHidden, len + 1);
    $("input[data-datafield='BHReceiptTbl.ReceiptNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.PayTarget']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Amount']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Currency']").attr("disabled", "disabled");
    var BHAmount = $.MvcSheetUI.GetControlValue('BHAmount');
    $.MvcSheetUI.SetControlValue('BHAmount', parseFloat(BHAmount) + parseFloat(AmountHidden));
}


// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Attachment = $("#Attachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("Attachment", Attachment);
        if (this.Action == "Submit") {
            var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
            var BHFlg = $.MvcSheetUI.GetControlValue("BHFlg");
            if (BHFlg == "New") {
                var Currency = $.MvcSheetUI.GetControlValue("Currency");
                var Contract = getContract(ContractNo);
                if (Contract.Currency != Currency && Currency != "RMB") {
                    layer.alert('币种只能选择人民币和合同外币！', { icon: 2 });
                    return false;
                }

                //收据总金额小于保函金额则不可以提交
                var BHAmount = $.MvcSheetUI.GetControlValue("BHAmount");
                var amount2 = $("[data-datafield='BHReceiptTbl']").find("tr.footer").find("[data-datafield='BHReceiptTbl.Amount']").text();
                if (parseFloat(amount2) < parseFloat(BHAmount)) {
                    layer.alert('收据总金额小于保函金额！', { icon: 2 });
                    return false;
                }
            }
        }
    }
    return true;
}

/*
    子表删除行事件
    参数：row -> 被删除的行
*/
var rowPreRemoved = function (row) {
    var rownum = row.attr("data-row");
    var Amount = $.MvcSheetUI.GetControlValue("BHReceiptTbl.Amount", rownum);
    var BHAmount = $.MvcSheetUI.GetControlValue('BHAmount');
    if ((parseFloat(BHAmount) - parseFloat(Amount)) >= 0) {
        $.MvcSheetUI.SetControlValue('BHAmount', parseFloat(BHAmount) - parseFloat(Amount));
    } else {
        $.MvcSheetUI.SetControlValue('BHAmount', 0);
    }

}
