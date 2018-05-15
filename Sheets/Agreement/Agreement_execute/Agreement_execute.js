$.MvcSheet.Loaded = function () {
    // 协议号码
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    //alert(AgreeMent_number);

    // 根据合同号码获取对应合同相关数据

    $.ajax({
        type: "POST",    //页面请求的类型
        url: "Agreement_execute.ashx?Command=getAgreement",   //处理页的相对地址
        data: {
            AgreeMent_number: AgreeMent_number,
        },
        async: false,
        success: function (ret) {
            console.log(ret);//这是处理后执行的函数，msg是处理页返回的数据
            //console.log(88888);
            $("#Agreenment_changeNo").val(ret[0].Agreenment_change);//协议变更的版本号
            //$.MvcSheetUI.SetControlValue("Agreenment_changeNo", ret[0].Agreenment_change);
            var dtl = $.MvcSheetUI.GetElement("Agreement_alteration").SheetGridView();
            dtl._Clear();
            for (var i = 0; i < ret.length; i++) {
                //console.log(ret[i].old_agency_money);
                dtl._AddRow();
                $.MvcSheetUI.SetControlValue("Agreement_alteration.old_agency_money", ret[i].old_agency_money, i + 1);
                $.MvcSheetUI.SetControlValue("Agreement_alteration.new_agency_money", ret[i].new_agency_money, i + 1);
                $.MvcSheetUI.SetControlValue("Agreement_alteration.old_pay_condition", ret[i].old_pay_condition, i + 1);
                $.MvcSheetUI.SetControlValue("Agreement_alteration.new_agency_conditon", ret[i].new_agency_conditon, i + 1);
                $.MvcSheetUI.SetControlValue("Agreement_alteration.ag_state", ret[i].ag_state, i + 1);
                $.MvcSheetUI.SetControlValue("Agreement_alteration.Agreement_operation", ret[i].Agreement_operation, i + 1);
            }
            $("input[data-datafield='Agreement_alteration.old_agency_money']").attr("disabled", "disabled");
            $("input[data-datafield='Agreement_alteration.new_agency_money']").attr("disabled", "disabled");
            $("input[data-datafield='Agreement_alteration.old_pay_condition']").attr("disabled", "disabled");
            $("input[data-datafield='Agreement_alteration.new_agency_conditon']").attr("disabled", "disabled");
            $("input[data-datafield='Agreement_alteration.ag_state']").attr("disabled", "disabled");
            $("input[data-datafield='Agreement_alteration.Agreement_operation']").attr("disabled", "disabled");
        }
    });
}
/**
 * 自动生成协议号
 */
function Create_number() {
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "AgreeMent_main.ashx?Command=AgreementNo",   //处理页的相对地址
        data: {
            
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            
            $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreementNo);
            $.MvcSheetUI.SetControlValue("Numberid", ret.Number);

        }
    });
}
/**
* 协议变更页面
**/
function Agreement_change() {
    
    var AgreeMent_number = getUrlParam("AgreeMent_number");//协议号
    var Agreenment_changeNo = $("#Agreenment_changeNo").val();//协议变更的版本号
    //var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");//协议号目前没有连接起来写假数据
    window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_change/AgreeMent_change.aspx?Mode=Originate&WorkflowCode=Agreenment_change&WorkflowVersion=" + Agreenment_changeNo + "&AgreeMent_number=" + AgreeMent_number;
}


