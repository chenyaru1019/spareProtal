$.MvcSheet.Loaded = function () {   
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    if (AgreeMent_number != null && AgreeMent_number != "") {
        // 根据协议号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "Agreement_sign.ashx?Command=Agreementcont",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $.MvcSheetUI.SetControlValue("Project_head_A", ret.Project_head_A);
                    $.MvcSheetUI.SetControlValue("Project_head_B", ret.Project_head_B);
                    $.MvcSheetUI.SetControlValue("Agreement_client", ret.Agreement_client);
                    $.MvcSheetUI.SetControlValue("AgreeMent_name", ret.AgreeMent_name);
                    $.MvcSheetUI.SetControlValue("apply_peo", ret.apply_peo);
                    $.MvcSheetUI.SetControlValue("apply_time", ret.CreatedTime);
                    $.MvcSheetUI.SetControlValue("Pay_conditions", ret.Pay_conditions);
                    $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreeMent_number);

                    $("#Agency_Pro_approval").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\ptc\\protocal");
                    var Agency_Pro_approval = ret.Agency_Pro_approval;
                    if (Agency_Pro_approval != "") {
                        var arr = Agency_Pro_approval.split(",");
                        $("#Agency_Pro_approval").xnfile("value", arr);
                    }

                }
            }
        });
        // 获取代理费表数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "Agreement_sign.ashx?Command=getAgency_ratesByANO",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    var dtl = $.MvcSheetUI.GetElement("agency_rates_inApprove").SheetGridView();
                    dtl._Clear();
                    var len = 0;
                    for (var i = 0; i < ret.agency_rate.length; i++) {
                        dtl._AddRow();
                        len += 1;
                        $.MvcSheetUI.SetControlValue("agency_rates_inApprove.agency_money", ret.agency_rate[i].agency_money, len);
                        $.MvcSheetUI.SetControlValue("agency_rates_inApprove.agency_type", ret.agency_rate[i].agency_type, len);
                        $.MvcSheetUI.SetControlValue("agency_rates_inApprove.up_limit", ""+ret.agency_rate[i].up_limit, len);
                        $.MvcSheetUI.SetControlValue("agency_rates_inApprove.lower_limit", ""+ret.agency_rate[i].lower_limit, len);
                    }
                }
            }
        });
    } else {
        // 自定义文件格式 合同文本
        $("#Agency_Pro_approval").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\ptc\\protocal");
        var Agency_Pro_approval = $.MvcSheetUI.GetControlValue("Agency_Pro_approval");
        if (Agency_Pro_approval != "") {
            var arr = Agency_Pro_approval.split(",");
            $("#Agency_Pro_approval").xnfile("value", arr);
        }
    }
    $("input[data-datafield='apply_peo']").attr("disabled", "disabled");
    $("input[data-datafield='apply_time']").attr("disabled", "disabled");
   //创建协议不可编辑的字段
    $("input[data-datafield='Project_head_A']").attr("disabled", "disabled");
    $("input[data-datafield='Project_head_B']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_client']").attr("disabled", "disabled");
    $("input[data-datafield='AgreeMent_name']").attr("disabled", "disabled");
    $("input[data-datafield='Pay_conditions']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rate']").attr("disabled", "disabled");
    $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
    // 不可以编辑的字段
    $("input[data-datafield='agency_rates_inApprove.agency_money']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_inApprove.agency_type']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_inApprove.up_limit']").attr("disabled", "disabled");
    $("input[data-datafield='agency_rates_inApprove.lower_limit']").attr("disabled", "disabled");

    setFileReadOnly("Agency_Pro_approval");
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Agency_Pro_approval = $("#Agency_Pro_approval").xnfile("value");
        $.MvcSheetUI.SetControlValue("Agency_Pro_approval", Agency_Pro_approval);
    }

    return true;
}
