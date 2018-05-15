
$.MvcSheet.Loaded = function () {
    // 协议号码
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    var agency_type = getUrlParam("agency_type");
    //console.log(AgreeMent_number);
    // 根据合同号码获取对应合同相关数据
    if (AgreeMent_number != null && AgreeMent_number != "") {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "Agreement_pigeonhole.ashx?Command=getGDCont",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
                agency_type: agency_type,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                console.log(ret);
                $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreeMent_number);
                $.MvcSheetUI.SetControlValue("Agreement_name", ret.Agreement_name);
                $.MvcSheetUI.SetControlValue("Project_man", ret.Project_man);
                $.MvcSheetUI.SetControlValue("Agreement_clint", ret.Agreement_clint);
                //$.MvcSheetUI.SetControlValue("Agency_rate", ret.Agency_rate);
                $.MvcSheetUI.SetControlValue("Pay_condition", ret.Pay_condition);

            }
        });
    }
   
    $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_name']").attr("disabled", "disabled");
    $("input[data-datafield='Project_man']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_clint']").attr("disabled", "disabled");
    $("input[data-datafield='Agency_rate']").attr("disabled", "disabled");
    $("input[data-datafield='Pay_condition']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_gd.agency_money']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_gd.agency_type']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_gd.up_limit']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_gd.lower_limit']").attr("disabled", "disabled");
    AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    // 自定义文件格式 代理协议正本 []
    $("#Agency_original").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\ptc\\" + AgreeMent_number + "\\归档");
    var Agency_original = $.MvcSheetUI.GetControlValue("Agency_original");
    if (Agency_original != "") {
        var arr = Agency_original.split(",");
        $("#Agency_original").xnfile("value", arr);
    }
    // 自定义文件格式 代理协议变更书 []
    $("#Agency_change").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\ptc\\" + AgreeMent_number + "\\归档");
    var Agency_change = $.MvcSheetUI.GetControlValue("Agency_change");
    if (Agency_change != "") {
        var arr = Agency_change.split(",");
        $("#Agency_change").xnfile("value", arr);
    }
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Agency_original");
        setFileWriteable("Agency_change");
    } else {
        setFileReadOnly("Agency_original");
        setFileReadOnly("Agency_change");
    }
}


// 表单验证接口
$.MvcSheet.Validate = function () {

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Agency_original = $("#Agency_original").xnfile("value");
        $.MvcSheetUI.SetControlValue("Agency_original", Agency_original);
        var Agency_change = $("#Agency_change").xnfile("value");
        $.MvcSheetUI.SetControlValue("Agency_change", Agency_change);
    }

    return true;
}
