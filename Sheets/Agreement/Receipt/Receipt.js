//页面提交
$.MvcSheet.SubmitAction.OnActionPreDo = function () {

}

// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFinanceConfirm") {
        if (this.Action == "Submit") {
            var agency_type = $.MvcSheetUI.GetControlValue("agency_type");
            if (agency_type == "RMB") {
                var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
                var CurrentSKTotalRMB = $.MvcSheetUI.GetControlValue("CurrentSKTotalRMB");
                // 设置协议中的已收款金额（累计）
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "Receipt.ashx?Command=SetSKTotalRMB",   //处理页的相对地址
                    data: {
                        AgreeMent_number: AgreeMent_number,
                        CurrentSKTotalRMB: CurrentSKTotalRMB,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        console.log("设置已收款金额成功");
                    }
                });
            } else if (agency_type == "USD") {
                var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
                var CurrentSKTotalRMB = $.MvcSheetUI.GetControlValue("CurrentSKTotalRMB");
                var CurrentSKTotalUSD = $.MvcSheetUI.GetControlValue("CurrentSKTotalUSD");
                // 设置协议中的已收款金额（累计）
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "Receipt.ashx?Command=SetSKTotalUSD",   //处理页的相对地址
                    data: {
                        AgreeMent_number: AgreeMent_number,
                        CurrentSKTotalRMB: CurrentSKTotalRMB,
                        CurrentSKTotalUSD: CurrentSKTotalUSD,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        console.log("设置已收款金额成功");
                    }
                });
            } else {
                var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
                // 设置协议中的已收款金额（累计）
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "Receipt.ashx?Command=SetSKTotalPercent",   //处理页的相对地址
                    data: {
                        AgreeMent_number: AgreeMent_number,
                        ObjectID: $.MvcSheetUI.SheetInfo.BizObjectID,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        console.log("设置已收款金额成功");
                    }
                });
            }

            
            
        }
    }
}
$.MvcSheet.Loaded = function () {
    // 协议号码
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    var agency_type = getUrlParam("agency_type");
    var ProjectNos = getUrlParam("ProjectNos");
    //console.log(AgreeMent_number);
    // 根据合同号码获取对应合同相关数据
    if (AgreeMent_number != null && AgreeMent_number != "") {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "Receipt.ashx?Command=getAgreement",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
                agency_type:agency_type,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                console.log(ret);
                $.MvcSheetUI.SetControlValue("Agreement_name", ret.Agreement_name);
                $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreeMent_number);
                $.MvcSheetUI.SetControlValue("Project_head_AB", ret.Project_head_AB);
                $.MvcSheetUI.SetControlValue("SKTarget", ret.SKTarget);
            }
        });
    }
    if (agency_type != null && agency_type != "") {
        $.MvcSheetUI.SetControlValue("agency_type", agency_type);
    }

    agency_type = $.MvcSheetUI.GetControlValue("agency_type");
    if (agency_type == "RMB") {
        $(".SKRecords_RMB").show();
        $(".SKRecords_USD").hide();
        $(".SKRecords_Percent").hide();

        //执行情况---应收代理费列表 RMB
        if (AgreeMent_number != null && AgreeMent_number != "") {
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "../AgreeMent_main/AgreeMent_main.ashx?Command=getYSListRMB",   //处理页的相对地址
                data: {
                    AgreeMent_number: AgreeMent_number,
                    //ReceiveAgencyFee: 0,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var dtl = $.MvcSheetUI.GetElement("SKRecords_RMB").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {
                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.Type", ret[i].Type, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.ProjectNo", ret[i].ProjectNo, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.ProjectName", ret[i].ProjectName, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.YSAgencyFee", ret[i].YSAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.ReceiveAgencyFee", ret[i].ReceiveAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_RMB.AgencyFeeRemain", ret[i].AgencyFeeRemain, i + 1);
                    }
                }
            });
            //RMBCurrentShowHide();
        }
        var dtl = $.MvcSheetUI.GetElement("SKRecords_RMB").SheetGridView();
        var len = dtl.RowCount;
        // 合并单元格操作
        for (var i = 0; i < len; i++) {
            var k = 0;
            $("[data-datafield='SKRecords_RMB']").find("tr.rows").each(function () {
                if (k == 0) {
                    $(this).find("td[data-field='SKRecords_RMB.YSAgencyFee']").attr("rowspan", len);
                    $(this).find("td[data-field='SKRecords_RMB.ReceiveAgencyFee']").attr("rowspan", len);
                    $(this).find("td[data-field='SKRecords_RMB.AgencyFeeRemain']").attr("rowspan", len);
                    $(this).find("td[data-field='SKRecords_RMB.CurrentSKTotalRMB']").attr("rowspan", len);
                } else if (k > 0) {
                    $(this).find("td[data-field='SKRecords_RMB.YSAgencyFee']").remove();
                    $(this).find("td[data-field='SKRecords_RMB.ReceiveAgencyFee']").remove();
                    $(this).find("td[data-field='SKRecords_RMB.AgencyFeeRemain']").remove();
                    $(this).find("td[data-field='SKRecords_RMB.CurrentSKTotalRMB']").remove();
                }
                k++;
            });
        }
    } else if (agency_type == "USD") {
        $(".SKRecords_RMB").hide();
        $(".SKRecords_USD").show();
        $(".SKRecords_Percent").hide();

        //执行情况---应收代理费列表 USD
        var agency_money = $.MvcSheetUI.GetControlValue("agency_money");
        if (AgreeMent_number != null && AgreeMent_number != "") {
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.ashx?Command=getYSListUSD",   //处理页的相对地址
                data: {
                    AgreeMent_number: AgreeMent_number,
                    agency_money: agency_money,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var dtl = $.MvcSheetUI.GetElement("SKRecords_USD").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {
                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.Type", ret[i].Type, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.ProjectNo", ret[i].ProjectNo, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.ProjectName", ret[i].ProjectName, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.YSAgencyFee", ret[i].YSAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.ReceiveAgencyFee", ret[i].ReceiveAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.ReceiveAgencyFeeWB", ret[i].ReceiveAgencyFeeWB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_USD.AgencyFeeRemain", ret[i].AgencyFeeRemain, i + 1);
                    }
                }
            });
            //RMBCurrentShowHide();
        }
        
    }else {
        $(".SKRecords_RMB").hide();
        $(".SKRecords_USD").hide();
        $(".SKRecords_Percent").show();

        //执行情况---应收代理费列表 百分比
        if (AgreeMent_number != null && AgreeMent_number != "" && ProjectNos != null && ProjectNos != "") {
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "../AgreeMent_main/AgreeMent_main.ashx?Command=getYSListPercent",   //处理页的相对地址
                data: {
                    AgreeMent_number: AgreeMent_number,
                    ProjectNos: ProjectNos,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var dtl = $.MvcSheetUI.GetElement("SKRecords_Percent").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {
                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.Type", ret[i].Type, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.ProjectNo", ret[i].ProjectNo, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.ProjectName", ret[i].ProjectName, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.YSAgencyFeeRMB", ret[i].YSAgencyFeeRMB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.YSAgencyFeeWB", ret[i].YSAgencyFeeWB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.Currency", ret[i].Currency, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.ReceiveAgencyFee", ret[i].ReceiveAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.ReceiveAgencyFeeWB", ret[i].ReceiveAgencyFeeWB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.ReceiveTotalRMB", ret[i].ReceiveTotalRMB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.AgencyFeeRemainRMB", ret[i].AgencyFeeRemainRMB, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecords_Percent.AgencyFeeRemainWB", ret[i].AgencyFeeRemainWB, i + 1);
                    }
                }
            });
            PercentCurrentShowHide();
        }
    }

    $("input[data-datafield='Agreement_name']").attr("disabled", "disabled");
    $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
    $("input[data-datafield='Project_head_AB']").attr("disabled", "disabled");

    $("input[data-datafield='SKRecords_RMB.Type']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_RMB.ProjectNo']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_RMB.ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_RMB.YSAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_RMB.ReceiveAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_RMB.AgencyFeeRemain']").attr("disabled", "disabled");

    $("input[data-datafield='SKRecords_USD.Type']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.ProjectNo']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.YSAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.ReceiveAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.ReceiveAgencyFeeUSD']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.ReceiveAgencyFeeRMB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_USD.AgencyFeeRemain']").attr("disabled", "disabled");

    $("input[data-datafield='SKRecords_Percent.Type']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.ProjectNo']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.YSAgencyFeeRMB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.YSAgencyFeeWB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.Currency']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.ReceiveAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.ReceiveAgencyFeeWB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.ReceiveTotalRMB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.AgencyFeeRemainRMB']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecords_Percent.AgencyFeeRemainWB']").attr("disabled", "disabled");

    // 自定义文件格式 发票 []
    $("#Recipt").xnfile();
    var Recipt = $.MvcSheetUI.GetControlValue("Recipt");
    if (Recipt != "") {
        var arr = Recipt.split(",");
        $("#Recipt").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Recipt");
    } else {
        setFileReadOnly("Recipt");
    }
}

//function RMBCurrentShowHide() {
//    var rowp = 0;
//    $("[data-datafield='SKRecords_RMB']").find("tr.rows").each(function () {
//        rowp++;
//        var AgencyFeeRemain = $.MvcSheetUI.GetControlValue("SKRecords_RMB.AgencyFeeRemain", rowp);
//        if (parseFloat(AgencyFeeRemain) > 0) {
//            $(this).find("input[data-datafield='SKRecords_RMB.CurrentSKTotalRMB']").attr("disabled", false);
//        } else {
//            $(this).find("input[data-datafield='SKRecords_RMB.CurrentSKTotalRMB']").attr("disabled", true);
//        }
//    });
//}

function PercentCurrentShowHide() {
    var rowp = 0;
    $("[data-datafield='SKRecords_Percent']").find("tr.rows").each(function () {
        rowp++;
        var AgencyFeeRemainRMB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.AgencyFeeRemainRMB", rowp);
        var AgencyFeeRemainWB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.AgencyFeeRemainWB", rowp);
        if (parseFloat(AgencyFeeRemainRMB) > 0) {
            $(this).find("input[data-datafield='SKRecords_Percent.CurrentSKRMB']").attr("disabled", false);
        } else {
            $(this).find("input[data-datafield='SKRecords_Percent.CurrentSKRMB']").attr("disabled", true);
        }
        if (parseFloat(AgencyFeeRemainWB) > 0) {
            $(this).find("input[data-datafield='SKRecords_Percent.CurrentSKWB']").attr("disabled", false);
            $(this).find("input[data-datafield='SKRecords_Percent.WBRate']").attr("disabled", false);
        } else {
            $(this).find("input[data-datafield='SKRecords_Percent.CurrentSKWB']").attr("disabled", true);
            $(this).find("input[data-datafield='SKRecords_Percent.WBRate']").attr("disabled", true);
        }
    });
}

function SetCurrentSKTotalRMB(el) {
    $.MvcSheetUI.SetControlValue("CurrentSKTotalRMB", el.value);
}
function SetCurrentSKTotalUSD(el) {
    var dtl = $.MvcSheetUI.GetElement("SKRecords_USD").SheetGridView();
    var total = 0.0;
    for (var i = 0; i < dtl.RowCount; i++) {
        
        var CurrentSKWB = $.MvcSheetUI.GetControlValue("SKRecords_USD.CurrentSKWB", i + 1);
        var WBRate = $.MvcSheetUI.GetControlValue("SKRecords_USD.WBRate", i + 1);
        if (CurrentSKWB == '') {
            CurrentSKWB = 0;
        }
        if (WBRate == '') {
            WBRate = 0;
        }
        
        total += parseFloat(CurrentSKWB) * parseFloat(WBRate);
    }
    $.MvcSheetUI.SetControlValue("CurrentSKTotalRMB", total);
    $.MvcSheetUI.SetControlValue("CurrentSKTotalUSD", CurrentSKWB);
}
function SetCurrentSKTotalPercent() {
    var dtl = $.MvcSheetUI.GetElement("SKRecords_Percent").SheetGridView();
    var total = 0.0;
    for (var i = 0; i < dtl.RowCount; i++) {
        var Currency = $.MvcSheetUI.GetControlValue("SKRecords_Percent.Currency", i + 1);
        var CurrentSKRMB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.CurrentSKRMB", i + 1);
        var CurrentSKWB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.CurrentSKWB", i + 1);
        var WBRate = $.MvcSheetUI.GetControlValue("SKRecords_Percent.WBRate", i + 1);
        var CurLength = Currency.split(",").length;
        var wbarr = CurrentSKWB.split(",");
        var ratearr = WBRate.split(",");
        var d = 0;
        for (var j = 0; j < wbarr.length;j++) {
            d += parseFloat(wbarr[j]) * parseFloat(ratearr[j]);
        }
        total += parseFloat(CurrentSKRMB) + d;
    }
    $.MvcSheetUI.SetControlValue("CurrentSKTotalRMB", total);
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Recipt = $("#Recipt").xnfile("value");
        $.MvcSheetUI.SetControlValue("Recipt", Recipt);
        if (this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("SKRecords_Percent").SheetGridView();
            for (var i = 0; i < dtl.RowCount; i++) {
                var Currency = $.MvcSheetUI.GetControlValue("SKRecords_Percent.Currency", i + 1);
                var CurrentSKRMB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.CurrentSKRMB", i + 1);
                var CurrentSKWB = $.MvcSheetUI.GetControlValue("SKRecords_Percent.CurrentSKWB", i + 1);
                var WBRate = $.MvcSheetUI.GetControlValue("SKRecords_Percent.WBRate", i + 1);
                var CurLength = Currency.split(",").length;
                var wbarr = CurrentSKWB.split(",");
                var ratearr = WBRate.split(",");
                if (isNaN(CurrentSKRMB)) {
                    layer.alert('本次收款RMB中输入不对！', { icon: 2 });
                    return false;
                }
                if (CurLength != wbarr.length) {
                    layer.alert('本次收款外币个数不对！', { icon: 2 });
                    return false;
                }

                if (CurLength != ratearr.length) {
                    layer.alert('外币汇率个数不对！', { icon: 2 });
                    return false;
                }
                for (var j = 0; j < wbarr.length; j++) {
                    if (isNaN(wbarr[j])) {
                        layer.alert('本次收款外币中输入不对！', { icon: 2 });
                        return false;
                    }
                }
                for (var j = 0; j < ratearr.length; j++) {
                    if (isNaN(ratearr[j])) {
                        layer.alert('外币汇率中输入不对！', { icon: 2 });
                        return false;
                    }
                }
            }
        }
        
    }

    return true;
}
