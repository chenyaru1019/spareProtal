﻿// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    //if (!checkCurrency()) {
    //    return false;
    //}
}
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        if (this.Action == "Submit") {
            var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
            if (IsHYFlg = "true") {
                var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
                var HKAmount = $.MvcSheetUI.GetControlValue("HKAmount").replace(/,/g, '');
                HKAmount = HKAmount == "" ? 0 : HKAmount;
                // 航油合同时，如果没有填合同金额，则在请款中用贷款金额（美元）设置合同金额，多条请款累加；
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "ContractHandler.ashx?Command=setJKTotalAmount",   //处理页的相对地址
                    data: {
                        ContractNo: ContractNo,
                        HKAmount: HKAmount,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        console.log("设置合同金额成功");
                    }
                });
            }
        }
    }
}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    var QKType = getUrlParam("QKType");
    var JSObjectID = getUrlParam("JSObjectID");
    var JSResultNum = getUrlParam("JSResultNum");
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
                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("Country", ret.Country);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
                $.MvcSheetUI.SetControlValue("QKRMBCurrency", "人民币");
                $.MvcSheetUI.SetControlValue("QKWBCurrency", ret.CurrencyName);
                $.MvcSheetUI.SetControlValue("QKWBCurrencyCode", ret.Currency);
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
                var ImportHYCompany = ret.FinalUser.substring(0,ret.FinalUser.indexOf("（"));
                $.MvcSheetUI.SetControlValue("ImportHYCompany", ImportHYCompany);

                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "ContractHandler.ashx?Command=getContactsByCompany",   //处理页的相对地址
                    data: {
                        Company: ImportHYCompany,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        var ContactNames = "";
                        var Telephones = "";
                        var Faxs = "";
                        for (var i = 0; i < ret.length; i++) {
                            ContactNames += ret[i].ContactName+",";
                            Telephones += ret[i].Telephone + ",";
                            Faxs += ret[i].Fax + ",";
                        }
                        $.MvcSheetUI.SetControlValue("Contacter", ContactNames.length > 0 ? ContactNames.substring(0, ContactNames.length-1) : ContactNames);
                        $.MvcSheetUI.SetControlValue("Fax", Faxs.length > 0 ? Faxs.substring(0, Faxs.length - 1) : Faxs);
                        $.MvcSheetUI.SetControlValue("Tel", Telephones.length > 0 ? Telephones.substring(0, Telephones.length - 1) : Telephones);
                    }
                });
                $.MvcSheetUI.SetControlValue("PageNumber", "1");
                $.MvcSheetUI.SetControlValue("ValuationType", ret.ValuationType);
                $.MvcSheetUI.SetControlValue("Agio", ret.Agio);
                $.MvcSheetUI.SetControlValue("AgencyComputerNum", ret.AgencyComputerNum);
            }
        });
        // 根据合同号码获取请款批次
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getMaxQKSeqByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                // 设置请款批次
                if (ret != null && ret != "") {
                    $.MvcSheetUI.SetControlValue("QKSeq", parseInt(ret)+1);
                } else {
                    $.MvcSheetUI.SetControlValue("QKSeq", 1);
                }
            }
        });
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }

    if (JSObjectID != null && JSObjectID != "") {
        $.MvcSheetUI.SetControlValue("JSObjectID", JSObjectID);
        $("[data-datafield='QKSubTbl.QKType']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.Currency']").attr("disabled", "disabled");
        compute();
    } else {
        JSObjectID = $.MvcSheetUI.GetControlValue("JSObjectID");
        if (JSObjectID != null && JSObjectID != "") {
            $("[data-datafield='QKSubTbl.QKType']").attr("disabled", "disabled");
            $("[data-datafield='QKSubTbl.Currency']").attr("disabled", "disabled");
            compute();
        } else {
            $("[data-datafield='QKSubTbl.QKType']").find("option").each(function () {
                if ($(this)[0].value == 'JS') {
                    $(this).attr("disabled", "disabled");
                }
            });
        }
    }

    var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
    if (IsHYFlg == "true") {
        $(".HYDiv").show();
        $(".NoHYDiv").hide();
        $("[data-datafield='QKSubTbl.QKType']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.ZJKX']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.ZJMS']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.Amount']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.Currency']").attr("disabled", "disabled");
        $("[data-datafield='QKSubTbl.Rate']").attr("disabled", "disabled");
    } else {
        $(".HYDiv").hide();
        $(".NoHYDiv").show();
    }

    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='ContractType']").attr("disabled", "disabled");
    $("input[data-datafield='Country']").attr("disabled", "disabled");
    $("input[data-datafield='ContractProperty']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='QKSeq']").attr("disabled", "disabled");
    $("input[data-datafield='QKTotalAmoutRMB']").attr("disabled", "disabled");
    $("input[data-datafield='QKTotalAmoutWB']").attr("disabled", "disabled");
    $("input[data-datafield='QKRMBCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='QKWBCurrency']").attr("disabled", "disabled");

    $("input[data-datafield='ImportHYCompany']").attr("disabled", "disabled");
    $("input[data-datafield='Contacter']").attr("disabled", "disabled");
    $("input[data-datafield='Fax']").attr("disabled", "disabled");
    $("input[data-datafield='Tel']").attr("disabled", "disabled");
    $("input[data-datafield='PageNumber']").attr("disabled", "disabled");
    $("input[data-datafield='CurDate']").attr("disabled", "disabled");
    $("input[data-datafield='ValuationType']").attr("disabled", "disabled");
    $("input[data-datafield='Agio']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyComputerNum']").attr("disabled", "disabled");
    $("input[data-datafield='Price']").attr("disabled", "disabled");
    $("input[data-datafield='HKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyAmount']").attr("disabled", "disabled");
    $("input[data-datafield='HKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='HKAndAgencyAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='DelayAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='TotalAmount']").attr("disabled", "disabled");

    $(".CurrencyRMB").text($.MvcSheetUI.GetControlValue("QKWBCurrency"));

    // 自定义文件格式 请款上传文件
    $("#QKUploadFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\请款");
    var QKUploadFile = $.MvcSheetUI.GetControlValue("QKUploadFile");
    if (QKUploadFile != "") {
        var arr = QKUploadFile.split(",");
        $("#QKUploadFile").xnfile("value", arr);
    }
    // 自定义文件格式 请款文件签字版
    $("#SignFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\请款");
    var SignFile = $.MvcSheetUI.GetControlValue("SignFile");
    if (SignFile != "") {
        var arr = SignFile.split(",");
        $("#SignFile").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("QKUploadFile");
        setFileHide("SignFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        setFileReadOnly("QKUploadFile");
        setFileWriteable("SignFile");
    } else {
        setFileReadOnly("QKUploadFile");
        setFileHide("SignFile");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackQKTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();

    $('.AmountFormat').blur();
    $('.AmountFormat3').blur();
    $('.AmountFormat4').blur();
}

function computerHY() {
    // 单价（美元/桶） = 基准油价（美元/桶） + 贴水+运费等（美元/桶）
    var BaseOilPrice = $.MvcSheetUI.GetControlValue('BaseOilPrice').replace(/,/g, '');
    BaseOilPrice = BaseOilPrice == "" ? 0 : BaseOilPrice;
    var Agio = $.MvcSheetUI.GetControlValue('Agio').replace(/,/g, '');
    Agio = Agio == "" ? 0 : Agio;
    var Price = parseFloat(BaseOilPrice) + parseFloat(Agio);
    $.MvcSheetUI.SetControlValue('Price', Price);
    // 货款金额（美元） = 单价（美元/桶） * 提单量（桶）
    var Tong = $.MvcSheetUI.GetControlValue('Tong').replace(/,/g, '');
    Tong = Tong == "" ? 0 : Tong;
    var HKAmount = Price * parseFloat(Tong);
    $.MvcSheetUI.SetControlValue('HKAmount', HKAmount);
    // 代理费（美元） = 单位代理费（美元/桶） * 提单量（桶）
    var AgencyComputerNum = $.MvcSheetUI.GetControlValue('AgencyComputerNum').replace(/,/g, '');
    AgencyComputerNum = AgencyComputerNum == "" ? 0 : AgencyComputerNum;
    var AgencyAmount = parseFloat(AgencyComputerNum) * parseFloat(Tong);
    $.MvcSheetUI.SetControlValue('AgencyAmount', AgencyAmount);
    // 货款金额（人民币元） = 货款金额（美元） * 汇率（暂按代理协议约定）
    var Rate = $.MvcSheetUI.GetControlValue('Rate').replace(/,/g, '');
    Rate = Rate == "" ? 0 : Rate;
    var HKAmountRMB = HKAmount * parseFloat(Rate);
    $.MvcSheetUI.SetControlValue('HKAmountRMB', HKAmountRMB);
    // 代理费（人民币元） = 代理费（美元） * 汇率（暂按代理协议约定）
    var AgencyAmountRMB = AgencyAmount * parseFloat(Rate);
    $.MvcSheetUI.SetControlValue('AgencyAmountRMB', AgencyAmountRMB);
    // 合计（人民币元） = 货款金额（人民币元） + 代理费（人民币元）
    var HKAndAgencyAmountRMB = HKAmountRMB + AgencyAmountRMB;
    $.MvcSheetUI.SetControlValue('HKAndAgencyAmountRMB', HKAndAgencyAmountRMB);
    // 滞期费折合人民币（元） = 滞期费（美元） * 汇率（暂按代理协议约定）
    var DelayAmount = $.MvcSheetUI.GetControlValue('DelayAmount').replace(/,/g, '');
    DelayAmount = DelayAmount == "" ? 0 : DelayAmount;
    var DelayAmountRMB = parseFloat(DelayAmount) * parseFloat(Rate);
    $.MvcSheetUI.SetControlValue('DelayAmountRMB', DelayAmountRMB);
    // 总计（人民币元） = 合计（人民币元） + 滞期费折合人民币（元） + 银行费（人民币元） + 其他所有费合计（人民币折算）
    var dtl = $.MvcSheetUI.GetElement("OtherFee").SheetGridView();
    var AmountRMBTotal = 0.0;
    for (var i = 0; i < dtl.RowCount; i++) {
        var AmountRMB = $.MvcSheetUI.GetControlValue("OtherFee.AmountRMB", i + 1).replace(/,/g, '');
        AmountRMB = AmountRMB == "" ? 0 : AmountRMB;
        AmountRMBTotal += parseFloat(AmountRMB);
    }
    var OtherBankFee = $.MvcSheetUI.GetControlValue('OtherBankFee').replace(/,/g, '');
    OtherBankFee = OtherBankFee == "" ? 0 : OtherBankFee;
    var TotalAmount = HKAndAgencyAmountRMB + HKAmountRMB + parseFloat(OtherBankFee) + AmountRMBTotal;
    $.MvcSheetUI.SetControlValue('TotalAmount', TotalAmount);

    var QKWBCurrencyCode = $.MvcSheetUI.GetControlValue('QKWBCurrencyCode');
    //// 设置请款明细表的数据
    //$("[data-datafield='QKSubTbl']").find("tr.rows").each(function () {
    //    var ZJMS = $(this).find("input[data-datafield='QKSubTbl.ZJMS']").val();
    //    if (ZJMS == "货款") {
    //        $(this).find("input[data-datafield='QKSubTbl.Amount']").val(HKAmount);
    //        $(this).find("input[data-datafield='QKSubTbl.Rate']").val(Rate);
    //        $(this).find("input[data-datafield='QKSubTbl.Currency']").val(QKWBCurrencyCode);
    //        $(this).find("input[data-datafield='QKSubTbl.QKType']").val("HT");
    //        $(this).find("input[data-datafield='QKSubTbl.ZJKX']").val("ZJKX_HTK_HT");
    //    } else if (ZJMS == "代理费") {
    //        $(this).find("input[data-datafield='QKSubTbl.Amount']").val(AgencyAmount);
    //        $(this).find("input[data-datafield='QKSubTbl.Rate']").val(Rate);
    //        $(this).find("input[data-datafield='QKSubTbl.Currency']").val(QKWBCurrencyCode);
    //        $(this).find("input[data-datafield='QKSubTbl.QKType']").val("FY");
    //        $(this).find("input[data-datafield='QKSubTbl.ZJKX']").val("ZJKX_QT_FY");
    //    } else if (ZJMS == "银行费") {
    //        $(this).find("input[data-datafield='QKSubTbl.Amount']").val(OtherBankFee);
    //        $(this).find("input[data-datafield='QKSubTbl.Rate']").val(1);
    //        $(this).find("input[data-datafield='QKSubTbl.Currency']").val("RMB");
    //        $(this).find("input[data-datafield='QKSubTbl.QKType']").val("FY");
    //        $(this).find("input[data-datafield='QKSubTbl.ZJKX']").val("ZJKX_QT_FY");
    //    } 
    //});
    var dtl2 = $.MvcSheetUI.GetElement("QKSubTbl").SheetGridView();
    dtl2._Clear();
    var arr = ["货款", "代理费","银行费"];
    for (var i = 0; i < arr.length; i++) {
        dtl2._AddRow();
        $.MvcSheetUI.SetControlValue("QKSubTbl.ZJMS", arr[i], i + 1);
        if (arr[i] == "货款") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.Amount", HKAmount, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Rate", Rate, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Currency", QKWBCurrencyCode, i + 1);
        } else if (arr[i] == "代理费") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.Amount", AgencyAmount, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Rate", Rate, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Currency", QKWBCurrencyCode, i + 1);
        } else if (arr[i] == "银行费") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.Amount", OtherBankFee, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Rate", 1, i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.Currency", "RMB", i + 1);
        }
    }
    var cnt = arr.length;
    for (var i = 0; i < dtl.RowCount; i++) {
        dtl2._AddRow();
        $.MvcSheetUI.SetControlValue("QKSubTbl.ZJMS", $.MvcSheetUI.GetControlValue("OtherFee.FeeName", i + 1), cnt + 1);
        $.MvcSheetUI.SetControlValue("QKSubTbl.Currency", QKWBCurrencyCode, cnt + 1);
        $.MvcSheetUI.SetControlValue("QKSubTbl.Amount", $.MvcSheetUI.GetControlValue("OtherFee.Amount", i + 1), cnt + 1);
        $.MvcSheetUI.SetControlValue("QKSubTbl.Rate", Rate, cnt + 1);
        cnt++;
    }
    $("[data-datafield='QKSubTbl.QKType']").attr("disabled", "disabled");
    $("[data-datafield='QKSubTbl.ZJKX']").attr("disabled", "disabled");
    $("[data-datafield='QKSubTbl.ZJMS']").attr("disabled", "disabled");
    $("[data-datafield='QKSubTbl.Amount']").attr("disabled", "disabled");
    $("[data-datafield='QKSubTbl.Currency']").attr("disabled", "disabled");
    $("[data-datafield='QKSubTbl.Rate']").attr("disabled", "disabled");

    $('.AmountFormat').blur();
    $('.AmountFormat3').blur();
    $('.AmountFormat4').blur();

    $.MvcSheetUI.SetControlValue("DemoSelect", new Date().getTime());
}

function DemoSelectChange() {
    var dtl2 = $.MvcSheetUI.GetElement("QKSubTbl").SheetGridView();
    for (var i = 0; i < dtl2.RowCount; i++) {
        var ZJMS = $.MvcSheetUI.GetControlValue("QKSubTbl.ZJMS",  i + 1);
        if (ZJMS == "货款") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.QKType", "HT", i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.ZJKX", "ZJKX_HTK_HT", i + 1);
        } else if (ZJMS == "代理费") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.QKType", "FY", i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.ZJKX", "ZJKX_QT_FY", i + 1);
        } else if (ZJMS == "银行费") {
            $.MvcSheetUI.SetControlValue("QKSubTbl.QKType", "FY", i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.ZJKX", "ZJKX_QT_FY", i + 1);
        } else {
            $.MvcSheetUI.SetControlValue("QKSubTbl.QKType", "FY", i + 1);
            $.MvcSheetUI.SetControlValue("QKSubTbl.ZJKX", "ZJKX_QT_FY", i + 1);
        } 
    }
}

function CurrencyChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;

    if ($.MvcSheetUI.GetControlValue('QKSubTbl.Currency', rowIndex - 1) == "RMB") {
        var k = 1;
        $("[data-datafield='QKSubTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='QKSubTbl.Rate']").attr("disabled", "disabled");
            }
            k++;
        });
        $.MvcSheetUI.SetControlValue('QKSubTbl.Rate', 1, rowIndex - 1);
    } else {
        var k = 1;
        $("[data-datafield='QKSubTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='QKSubTbl.Rate']").attr("disabled", false);
            }
            k++;
        });
    }

    var JSObjectID = $.MvcSheetUI.GetControlValue("JSObjectID");
    // 如果是结算过来的，那就设为结算
    if (JSObjectID != null && JSObjectID != "") {
        $.MvcSheetUI.SetControlValue('QKSubTbl.QKType', rowIndex - 1, "JS")
    }

}

function ZJKXChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var QKType = $.MvcSheetUI.GetControlValue('QKSubTbl.QKType', rowIndex - 1);
    var ZJMS = "";
    var k = 1;
    var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
    if (IsHYFlg != "true") {
        $("[data-datafield='QKSubTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                ZJMS = $(this).find("[data-datafield='QKSubTbl.ZJKX']").find("option:selected").text();
            }
            k++;
        });
        if (QKType == "FY") {
            $.MvcSheetUI.SetControlValue('QKSubTbl.ZJMS', ZJMS, rowIndex - 1);
        } else {
            $.MvcSheetUI.SetControlValue('QKSubTbl.ZJMS', "", rowIndex - 1);
        }
    }

}

function compute() {
    var i = 0;
    var totalamount_rmb = 0.0;
    var totalamount_wb = 0.0;
    var count = $("[data-datafield='QKSubTbl']").find('tr.rows').length;
    var CurrencyName = $.MvcSheetUI.GetControlValue("QKWBCurrency");
    $("[data-datafield='QKSubTbl']").find('tr.rows').each(function () {
        if ($(this).find("[data-datafield='QKSubTbl.Currency']")[0].value == "RMB") {
            var amount = $(this).find("input[data-datafield='QKSubTbl.Amount']")[0].value.replace(/,/g, '');
            amount = amount == "" ? 0 : amount;
            var rate = $(this).find("input[data-datafield='QKSubTbl.Rate']")[0].value;
            rate = rate == "" ? 0 : rate;
            var ConvertAmount = parseFloat(amount) * parseFloat(rate);
            $(this).find("input[data-datafield='QKSubTbl.ConvertAmount']").val(ConvertAmount);
            totalamount_rmb += parseFloat(amount);
        } else if ($(this).find("[data-datafield='QKSubTbl.Currency']").find("option:selected").text() == CurrencyName){
            var amount = $(this).find("input[data-datafield='QKSubTbl.Amount']")[0].value.replace(/,/g, '');
            amount = amount == "" ? 0 : amount;
            var rate = $(this).find("input[data-datafield='QKSubTbl.Rate']")[0].value;
            rate = rate == "" ? 0 : rate;
            var ConvertAmount = parseFloat(amount) * parseFloat(rate);
            $(this).find("input[data-datafield='QKSubTbl.ConvertAmount']").val(ConvertAmount);
            totalamount_wb += parseFloat(amount);
        }
        
    });
    $.MvcSheetUI.SetControlValue('QKTotalAmoutRMB', totalamount_rmb.toFixed(2));
    $.MvcSheetUI.SetControlValue('QKTotalAmoutWB', totalamount_wb.toFixed(2));
    $('.AmountFormat').blur();
}

function checkCurrency() {
    var curVar = new Array();
    var count = $("[data-datafield='QKSubTbl']").find('tr.rows').length;
    $("[data-datafield='QKSubTbl']").find('tr.rows').each(function () {
        if (!containArra(curVar,
            $(this).find("[data-datafield='QKSubTbl.Currency']")[0].value)) {
            curVar.push($(this).find("[data-datafield='QKSubTbl.Currency']")[0].value);
        }
    });
    if (curVar.length > 2) {
        layer.alert('除了人民币，外币不能选择多种！', { icon: 2 });
        return false;
    }
    return true;
}

function containArra(curVar,value) {
    for (var i = 0; i < curVar.length; i++) {
        if (curVar[i] == value) {
            return true;
        }
    }
    return false;
}

// 给添加后的行进行处理（把请款类型中的结算给disabled掉）
function AddedRender() {
    $("[data-datafield='QKSubTbl.QKType']").find("option").each(function () {
        if ($(this)[0].value == 'JS') {
            $(this).attr("disabled", "disabled");
        }
    });
    $('.AmountFormat').blur();
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var QKUploadFile = $("#QKUploadFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("QKUploadFile", QKUploadFile);
        if (this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("QKSubTbl").SheetGridView();
            for (var i = 0; i < dtl.RowCount; i++) {
                var Amount = $.MvcSheetUI.GetControlValue("QKSubTbl.Amount", i + 1);
                
                // Amount < 0 check
                if (parseFloat(Amount) < 0) {
                    layer.alert('输入的金额不能小于0！', { icon: 2 });
                    return false;
                } 
            }
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        var SignFile = $("#SignFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("SignFile", SignFile);
    }
    return true;
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
                    for (var i = 0; i < ret.InstanceActivity.length; i++) {
                        if (CurActivity == "ActivityHYManager" || CurActivity == "ActivityManager") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
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
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
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
                    GotoBackPage("QK", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackQKTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

