
$.MvcSheet.Loaded = function () {
    // 协议号码
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    var agency_type = getUrlParam("agency_type");
   
    //console.log(AgreeMent_number);
    // 根据合同号码获取对应合同相关数据
    if (AgreeMent_number != null && AgreeMent_number != "") {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "AgreeMent_change.ashx?Command=getAgreement",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
                agency_type: agency_type,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                console.log(ret);
                $.MvcSheetUI.SetControlValue("Agreement_name", ret.Agreement_name);
                $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreeMent_number);
                $.MvcSheetUI.SetControlValue("Agreement_entrust", ret.Agreement_entrust);
                $.MvcSheetUI.SetControlValue("PayConditionOld", ret.PayConditionOld);
            }
        });
    }
    $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_name']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_entrust']").attr("disabled", "disabled");
    $("input[data-datafield='signing_time']").attr("disabled", "disabled");
    $("[data-datafield='PayConditionOld']").attr("disabled", "disabled");
    $("input[data-datafield='Old_agency_rates.agency_money']").attr("disabled", "disabled");
    $("input[data-datafield='Old_agency_rates.agency_type']").attr("disabled", "disabled");
    $("input[data-datafield='Old_agency_rates.up_limit']").attr("disabled", "disabled");
    $("input[data-datafield='Old_agency_rates.lower_limit']").attr("disabled", "disabled");
    $("[data-datafield='New_agency_rates.agency_type']").attr("disabled", "disabled");

    // 子表的显示判断
    var rowp = 0;
    $("[data-datafield='New_agency_rates']").find("tr.rows").each(function () {
        rowp++;
        var agency_type = $.MvcSheetUI.GetControlValue("New_agency_rates.agency_type", rowp);

        if (agency_type != "AgencyRate_Sec") {
            $("input[data-datafield='New_agency_rates.up_limit']").attr("disabled", "disabled");
            $("input[data-datafield='New_agency_rates.lower_limit']").attr("disabled", "disabled");
        }
    });

    RatesChange();
    PayConditionChange();

    AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    // 自定义文件格式 代理协议变更书
    $("#Agent_agreenment_change").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\ptc\\" + AgreeMent_number+"\\变更");
    var Agent_agreenment_change = $.MvcSheetUI.GetControlValue("Agent_agreenment_change");
    if (Agent_agreenment_change != "") {
        var arr = Agent_agreenment_change.split(",");
        $("#Agent_agreenment_change").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Agent_agreenment_change");
    } else {
        setFileReadOnly("Agent_agreenment_change");
    }
    
}

function RatesChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangeRates");

    if (v == "是") {
        var rowp = 0;
        $("[data-datafield='New_agency_rates']").find("tr.rows").each(function () {
            rowp++;
            var agency_type = $.MvcSheetUI.GetControlValue("New_agency_rates.agency_type", rowp);
            $("input[data-datafield='New_agency_rates.agency_money']").attr("disabled", false);
            if (agency_type != "AgencyRate_Sec") {
                $("input[data-datafield='New_agency_rates.up_limit']").attr("disabled", true);
                $("input[data-datafield='New_agency_rates.lower_limit']").attr("disabled", true);
            }
        });
    } else {
        var rowp = 0;
        $("[data-datafield='New_agency_rates']").find("tr.rows").each(function () {
            rowp++;
            var agency_type = $.MvcSheetUI.GetControlValue("New_agency_rates.agency_type", rowp);
            $("input[data-datafield='New_agency_rates.agency_money']").attr("disabled", true);
            if (agency_type != "AgencyRate_Sec") {
                $("input[data-datafield='New_agency_rates.up_limit']").attr("disabled", true);
                $("input[data-datafield='New_agency_rates.lower_limit']").attr("disabled", true);
            }
        });
    }

}

function PayConditionChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangePayCondition");

    if (v == "是") {
        $("[data-datafield='PayConditionNew']").attr("disabled", false);
    } else {
        $("[data-datafield='PayConditionNew']").attr("disabled", true);
    }

}

// 表单验证接口
$.MvcSheet.Validate = function () {

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Agent_agreenment_change = $("#Agent_agreenment_change").xnfile("value");
        $.MvcSheetUI.SetControlValue("Agent_agreenment_change", Agent_agreenment_change);
    }

    return true;
}
