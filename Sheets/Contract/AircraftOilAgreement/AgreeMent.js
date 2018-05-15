
//收退款
function st_money() {
    var row = $("#table_project").bootstrapTable('getSelections');
    //console.log(row);
    var project_num = "";
    for (var i = 0; i < row.length; i++) {       
        //project_num.push(',' + row[i].Project_Number + ',');
        project_num += row[i].Project_Number+ ",";
        //console.log(row[i].Project_Number);
        //console.log(00000);
    }
    project_num = project_num.substring(0, project_num.length - 1);
    //project_num.join(',');
    //console.log(project_num);
    //return false;
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");//协议号
    var st_money = $.MvcSheetUI.GetControlValue("st_money");//收退款版本号
    window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=Originate&WorkflowCode=Charge_back&WorkflowVersion=" + st_money + "&AgreeMent_number=" + AgreeMent_number + "&project_num=" + project_num;
}
//提交前事件
//$.MvcSheet.SubmitAction.OnActionPreDo= function () {
//    if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_sign") {
//        var dtl = $.MvcSheetUI.GetElement("Agreement_signTbl").SheetGridView();
//        if (dtl.RowCount <= 0) {
//            layer.alert('当前还没有审签过，不能提交到下一步！', { icon: 2 });
//            return false;
//        }
//    }
//}
//页面加载事件
$.MvcSheet.Loaded = function () {

    //$.MvcSheetUI.SetControlValue("agreement_sign", "");
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
   
    //var aa = $.MvcSheetUI.SheetInfo.UserID;
        //console.log(aa);
    //console.log(AgreeMent_number);
    //创建协议节点
   // if ($.MvcSheetUI.SheetInfo.ActivityCode == "cre_agreement") {
       
        if ($.MvcSheetUI.GetControlValue("Project_head_A") == "") {
            $.MvcSheetUI.SetControlValue("Project_head_A", $.MvcSheetUI.SheetInfo.UserID);
        }
        setSpeMoney();
        //$("#xs").hide();
        //$("#sqjl").hide();
        //$("#xyzx").hide();
        //$(".bannerTitleApprove").click();
        //$(".bannerTitleOperate").click();
        //如果当前协议号申请修改正在审批就不显示申请修改按钮

        //查询协议号审批记录
        //$.ajax({
        //    type: "POST",    //页面请求的类型
        //    url: "AgreeMent_main.ashx?Command=getAgreementNumber",   //处理页的相对地址
        //    data: {
        //        AgreeMent_number: AgreeMent_number,
        //    },
        //    async: false,
        //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
        //        var dtl = $.MvcSheetUI.GetElement("Examine_records").SheetGridView();
        //        dtl._Clear();
        //        for (var i = 0; i < ret.length; i++) {
        //            dtl._AddRow();
        //            $.MvcSheetUI.SetControlValue("Examine_records.Apply_people", ret[i].Apply_people, i + 1);
        //            $.MvcSheetUI.SetControlValue("Examine_records.Apply_time", ret[i].Apply_time, i + 1);
        //            $.MvcSheetUI.SetControlValue("Examine_records.States", ret[i].State, i + 1);
        //        }
        //    }
        //});
        //$("input[data-datafield='Examine_records.Apply_people']").attr("disabled", "disabled");
        //$("input[data-datafield='Examine_records.Apply_time']").attr("disabled", "disabled");
        //$("input[data-datafield='Examine_records.States']").attr("disabled", "disabled");
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "AircraftOilAgreement.ashx?Command=getAgreementInfo",   //处理页的相对地址
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
                    $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreeMent_number);
                    
                    
                }
                
                
               // $.MvcSheet.Save(this);
            }
        });
        $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "AircraftOilAgreement.ashx?Command=agency_rates",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    var dtl = $.MvcSheetUI.GetElement("agency_rates_hy").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {
                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("agency_rates_hy.agency_money", ret[i].agency_money, i + 1);
                        $.MvcSheetUI.SetControlValue("agency_rates_hy.agency_type", ret[i].agency_type, i + 1);
                        $.MvcSheetUI.SetControlValue("agency_rates_hy.up_limit", ret[i].up_limit, i + 1);
                        $.MvcSheetUI.SetControlValue("agency_rates_hy.lower_limit", ret[i].lower_limit, i + 1);
                    }
                   
                   
                }

            }
        });
   // }
    //协议审签节点
    //if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_sign") {
    //    $("#zdsc").hide();
    //    $("#xgsq").hide();
    //    $("#xyzx").hide();
    //    var dtl_signs = $.MvcSheetUI.GetElement("Agreement_signTbl").SheetGridView();
    //    if (dtl_signs.RowCount !=0 ) {
    //        $("#xs").hide();
    //    }
    //    $(".bannerTitleCreate").click();
    //    $(".bannerTitleOperate").click();
    //}
    //协议执行节点
    //if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_excu") {
        //$("#xs").hide();
        //$("#zdsc").hide();
        //$("#xgsq").hide();
        $(".bannerTitleCreate").click();
        //$(".bannerTitleApprove").click();
        var dtl = $.MvcSheetUI.GetElement("agency_rates_hy").SheetGridView();
        var len = dtl.RowCount;
        //var hasRMB = false;
        //var hasPercent = false;
        //var hasUSD = false;
        //// 代理费判断页面显示
        //for (var i = 0; i < len; i++) {
        //    var agency_type = $.MvcSheetUI.GetControlValue("agency_rates_hy.agency_type", i + 1);
        //    if (agency_type == "AgencyRate_RMB") {
        //        hasRMB = true;
        //    } else if (agency_type == "AgencyRate_Percent") {
        //        hasPercent = true;
        //    } else if (agency_type == "AgencyRate_USD") {
        //        hasUSD = true;
        //    }
        //}
        //$(".Content_Tab").find("li.tabRMB").hide();
        //$(".Content_Tab").find("li.tabPercent").hide();
        //if (hasRMB) {
           // $(".Content_Tab").find("li.tabRMB").show();
            //执行情况---应收代理费列表 RMB
            //$.ajax({
            //    type: "POST",    //页面请求的类型
            //    url: "AircraftOilAgreement.ashx?Command=getYSListRMB",   //处理页的相对地址
            //    data: {
            //        AgreeMent_number: AgreeMent_number,
            //        //ReceiveAgencyFee: ReceiveAgencyFeeHidden,
            //    },
            //    async: false,
            //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            //        var dtl = $.MvcSheetUI.GetElement("YSListRMB").SheetGridView();
            //        dtl._Clear();
            //        for (var i = 0; i < ret.length; i++) {
            //            dtl._AddRow();
            //            $.MvcSheetUI.SetControlValue("YSListRMB.Type", ret[i].Type, i + 1);
            //            $.MvcSheetUI.SetControlValue("YSListRMB.ProjectNo", ret[i].ProjectNo, i + 1);
            //            $.MvcSheetUI.SetControlValue("YSListRMB.ProjectName", ret[i].ProjectName, i + 1);
            //            $.MvcSheetUI.SetControlValue("YSListRMB.YSAgencyFee", ret[i].YSAgencyFee, i + 1);
            //            $.MvcSheetUI.SetControlValue("YSListRMB.ReceiveAgencyFee", ret[i].ReceiveAgencyFee, i + 1);
            //            $.MvcSheetUI.SetControlValue("YSListRMB.AgencyFeeRemain", ret[i].AgencyFeeRemain, i + 1);
            //        }
            //    }
            //});
            //var dtl = $.MvcSheetUI.GetElement("YSListRMB").SheetGridView();
            //var len = dtl.RowCount;
            //// 合并单元格操作
            //if (len > 0) {
            //    var AgencyFeeRemain = $.MvcSheetUI.GetControlValue("YSListRMB.AgencyFeeRemain", 1);
            //    if (parseFloat(AgencyFeeRemain) > 0) {
            //        $("#ApproveSKRMBId").show();
            //    } else {
            //        $("#ApproveSKRMBId").hide();
            //    }
            //    for (var i = 0; i < len; i++) {
            //        var k = 0;
            //        $("[data-datafield='YSListRMB']").find("tr.rows").each(function () {
            //            if (k == 0) {
            //                $(this).find("td[data-field='YSListRMB.YSAgencyFee']").attr("rowspan", len);
            //                $(this).find("td[data-field='YSListRMB.ReceiveAgencyFee']").attr("rowspan", len);
            //                $(this).find("td[data-field='YSListRMB.AgencyFeeRemain']").attr("rowspan", len);
            //            } else if (k > 0) {
            //                $(this).find("td[data-field='YSListRMB.YSAgencyFee']").remove();
            //                $(this).find("td[data-field='YSListRMB.ReceiveAgencyFee']").remove();
            //                $(this).find("td[data-field='YSListRMB.AgencyFeeRemain']").remove();
            //            }
            //            k++;
            //        });
            //    }
            //} else {
            //    $("#ApproveSKRMBId").hide();
            //}
        //}

            //if (hasRMB) {
            // $(".Content_Tab").find("li.tabRMB").show();
            //执行情况---应收代理费列表 USD
        var agency_money = $.MvcSheetUI.GetControlValue("agency_rates_hy.agency_money", 1);
        
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "AircraftOilAgreement.ashx?Command=getYSListUSD",   //处理页的相对地址
                data: {
                    AgreeMent_number: AgreeMent_number,
                    agency_money: agency_money,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var dtl = $.MvcSheetUI.GetElement("YSListUSD").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {
                        
                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("YSListUSD.Type", ret[i].Type, i + 1);
                        $.MvcSheetUI.SetControlValue("YSListUSD.ProjectNo", ret[i].ProjectNo, i + 1);
                        $.MvcSheetUI.SetControlValue("YSListUSD.ProjectName", ret[i].ProjectName, i + 1);
                        $.MvcSheetUI.SetControlValue("YSListUSD.YSAgencyFee", ret[i].YSAgencyFee, i + 1);
                        $.MvcSheetUI.SetControlValue("YSListUSD.ReceiveAgencyFee", ret[i].ReceiveAgencyFeeWB, i + 1);
                        $.MvcSheetUI.SetControlValue("YSListUSD.AgencyFeeRemain", ret[i].AgencyFeeRemain, i + 1);
                    }
                }
        });
           
           
            var dtl = $.MvcSheetUI.GetElement("YSListUSD").SheetGridView();
            var len = dtl.RowCount;
            var YSAgencyFee = "";
            // 合并单元格操作
            if (len > 0) {
                var AgencyFeeRemain = $.MvcSheetUI.GetControlValue("YSListUSD.AgencyFeeRemain", 1);
                if (parseFloat(AgencyFeeRemain) > 0) {
                    $("#ApproveSKUSDId").show();
                } else {
                    $("#ApproveSKUSDId").hide();
                }
               
               
            } else {
                $("#ApproveSKUSDId").hide();
            }
        //}
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "AircraftOilAgreement.ashx?Command=getSKRecordsUSD",   //处理页的相对地址
                data: {
                    AgreeMent_number: AgreeMent_number,
                    agency_money: agency_money,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var dtl = $.MvcSheetUI.GetElement("SKRecordsUSD").SheetGridView();
                    dtl._Clear();
                    for (var i = 0; i < ret.length; i++) {

                        dtl._AddRow();
                        $.MvcSheetUI.SetControlValue("SKRecordsUSD.ApplyDate", ret[i].ApplyDate, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecordsUSD.SKAmount", ret[i].SKAmount, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecordsUSD.DKDate", ret[i].DKDate, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecordsUSD.Status", ret[i].Status, i + 1);
                        $.MvcSheetUI.SetControlValue("SKRecordsUSD.WorkItemId", ret[i].WorkItemId, i + 1);
                        
                    }
                }
            });

        //if (hasPercent) {
        //    $(".Content_Tab").find("li.tabPercent").show();
        //    //执行情况---应收代理费列表 百分比
        //    $.ajax({
        //        type: "POST",    //页面请求的类型
        //        url: "AircraftOilAgreement.ashx?Command=getYSListPercent",   //处理页的相对地址
        //        data: {
        //            AgreeMent_number: AgreeMent_number,
        //        },
        //        async: false,
        //        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
        //            var dtl = $.MvcSheetUI.GetElement("YSList_Percent").SheetGridView();
        //            dtl._Clear();
        //            for (var i = 0; i < ret.length; i++) {
        //                dtl._AddRow();
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.Type", ret[i].Type, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.ProjectNo", ret[i].ProjectNo, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.ProjectName", ret[i].ProjectName, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.YSAgencyFeeRMB", ret[i].YSAgencyFeeRMB, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.YSAgencyFeeWB", ret[i].YSAgencyFeeWB, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.Currency", ret[i].Currency, i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.ReceiveAgencyFee", parseFloat(ret[i].ReceiveAgencyFee).toFixed(2), i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.ReceiveAgencyFeeWB", parseFloat(ret[i].ReceiveAgencyFeeWB).toFixed(2), i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.ReceiveTotalRMB", parseFloat(ret[i].ReceiveTotalRMB).toFixed(2), i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.AgencyFeeRemainRMB", parseFloat(ret[i].AgencyFeeRemainRMB).toFixed(2), i + 1);
        //                $.MvcSheetUI.SetControlValue("YSList_Percent.AgencyFeeRemainWB", parseFloat(ret[i].AgencyFeeRemainWB).toFixed(2), i + 1);
        //            }
        //            // 保存表单
        //            $.MvcSheet.Save(this);
        //        }
        //    });
        //    var dtl = $.MvcSheetUI.GetElement("YSList_Percent").SheetGridView();
        //    var len = dtl.RowCount;
        //    if (len > 0) {
        //        $("#ApproveSKPercentId").show();
        //    } else {
        //        $("#ApproveSKPercentId").hide();
        //    }
        //}

        //if (!hasRMB && !hasPercent && hasUSD) {
        //    $(".Content_Tab").find("li.tabGL").hide();
        //}
        
    //}

    $("input[data-datafield='SKRecordsUSD.ApplyDate']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecordsUSD.SKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecordsUSD.DKDate']").attr("disabled", "disabled");
    $("input[data-datafield='SKRecordsUSD.Status']").attr("disabled", "disabled");

    //$("input[data-datafield='SKRecordsRMB.ApplyDate']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsRMB.SKAmount']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsRMB.DKDate']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsRMB.Status']").attr("disabled", "disabled");

    //$("input[data-datafield='SKRecordsPercent.ApplyDate']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsPercent.SKAmount']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsPercent.DKDate']").attr("disabled", "disabled");
    //$("input[data-datafield='SKRecordsPercent.Status']").attr("disabled", "disabled");

    $("input[data-datafield='YSListUSD.Type']").attr("disabled", "disabled");
    $("input[data-datafield='YSListUSD.ProjectNo']").attr("disabled", "disabled");
    $("input[data-datafield='YSListUSD.ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='YSListUSD.YSAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='YSListUSD.ReceiveAgencyFee']").attr("disabled", "disabled");
    $("input[data-datafield='YSListUSD.AgencyFeeRemain']").attr("disabled", "disabled");

    //$("input[data-datafield='YSListRMB.Type']").attr("disabled", "disabled");
    //$("input[data-datafield='YSListRMB.ProjectNo']").attr("disabled", "disabled");
    //$("input[data-datafield='YSListRMB.ProjectName']").attr("disabled", "disabled");
    //$("input[data-datafield='YSListRMB.YSAgencyFee']").attr("disabled", "disabled");
    //$("input[data-datafield='YSListRMB.ReceiveAgencyFee']").attr("disabled", "disabled");
    //$("input[data-datafield='YSListRMB.AgencyFeeRemain']").attr("disabled", "disabled");

    //$("input[data-datafield='YSList_Percent.Type']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.ProjectNo']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.ProjectName']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.YSAgencyFeeRMB']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.YSAgencyFeeWB']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.Currency']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.ReceiveAgencyFee']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.ReceiveAgencyFeeWB']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.ReceiveTotalRMB']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.AgencyFeeRemainRMB']").attr("disabled", "disabled");
    //$("input[data-datafield='YSList_Percent.AgencyFeeRemainWB']").attr("disabled", "disabled");

    
 
    //协议审签不可以编辑的字段
    //$("input[data-datafield='Agreement_signTbl.Approver']").attr("disabled", "disabled");
    //$("input[data-datafield='Agreement_signTbl.ApproveDate']").attr("disabled", "disabled");
    //$("input[data-datafield='Agreement_signTbl.Status']").attr("disabled", "disabled");


    //协议变更不可以编辑的字段
    $("input[data-datafield='Agreement_bg_hy.old_agency']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_bg_hy.new_agency']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_bg_hy.PayConditionOld']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_bg_hy.PayConditionNew']").attr("disabled", "disabled");
    $("input[data-datafield='Agreement_bg_hy.Status']").attr("disabled", "disabled");


    $("input[data-datafield='Project_contracts_hy.project_names']").attr("disabled", "disabled");
    $("input[data-datafield='Project_contracts_hy.tender_number']").attr("disabled", "disabled");
    $("input[data-datafield='Project_contracts_hy.contact_no']").attr("disabled", "disabled");
    $("input[data-datafield='Project_contracts_hy.contact_name']").attr("disabled", "disabled");
    $("input[data-datafield='Project_contracts_hy.contract_type']").attr("disabled", "disabled");


    $("input[data-datafield='AgreementFileRecordhy.Applyer']").attr("disabled", "disabled");
    $("input[data-datafield='AgreementFileRecordhy.ApplyDate']").attr("disabled", "disabled");
    $("input[data-datafield='AgreementFileRecordhy.Status']").attr("disabled", "disabled");
    $("input[data-datafield='FileSignVersion']").attr("disabled", "disabled");
    $("input[data-datafield='BGFileSignVersion']").attr("disabled", "disabled");

    $("#divSheet div[data-title='征询意见']").parent().hide();
    
    $.MvcSheet.Save(this);
}


/**
 * 自动生成协议号
 */
//function Create_number() {
//    $.ajax({
//        type: "POST",    //页面请求的类型
//        url: "AgreeMent_main.ashx?Command=AgreementNo",   //处理页的相对地址
//        data: {
            
//        },
//        async: false,
//        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            
//            $.MvcSheetUI.SetControlValue("AgreeMent_number", ret.AgreementNo);

//        }
//    });
   
//}
/**
*协议号修改申请
*/

//function update_muber(el) {
//    var AgreeMent_name = $.MvcSheetUI.GetControlValue("AgreeMent_name");
//    var Project_head_A = $.MvcSheetUI.GetControlValue("Project_head_A");
//    var Project_head_B = $.MvcSheetUI.GetControlValue("Project_head_B");
//    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
//    var canUpdateFlg = true;
//    //判断当前协议号是否有数据（是否进行保存过）
//    $.ajax({
//        type: "POST",    //页面请求的类型
//        url: "AgreeMent_main.ashx?Command=AgreeMent_number",   //处理页的相对地址
//        data: {
//            AgreeMent_number: AgreeMent_number,
//        },
//        async: false,
//        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//            if (ret == 2 ) {
//                canUpdateFlg = false;

//            }
//        }
//    });
//    if (!canUpdateFlg) {
//        layer.alert('协议号还不存在，无法申请修改（请先进行保存）！', { icon: 2 });
//        return false;
//    }
//    /**
//     * 有任何一个值为空都不能通过
//     */
//    if (AgreeMent_name == '') {
//        layer.alert('请填写协议名称！', { icon: 2 });
//        return false;
//    }
//    if (Project_head_A == '') {
//        layer.alert('请填写项目负责人A！', { icon: 2 });
//        return false;
//    }
//    if (Project_head_B == '') {
//        layer.alert('请填写项目负责人B！', { icon: 2 });
//        return false;
//    }
//    if (AgreeMent_number == '') {
//        layer.alert('请生成协议号！', { icon: 2 });
//        return false;
//    }


//    //获取子流程的版本号
//    var Process_version = $.MvcSheetUI.GetControlValue("Process_version");
//    console.log(Process_version);
//    //alert(Process_version);
//    window.location.href = "/Portal/Sheets/Agreement/Update_AgreementNumber/Update_AgreementNumber.aspx?Mode=Originate&WorkflowCode=Update_agreement_number&WorkflowVersion=" + Process_version
//        + "&AgreeMent_number=" + AgreeMent_number;

    
//}
//协议审签
//function agreement_apply() {
//    $.MvcSheetUI.SetControlValue("agreement_sign", "true");
//    $.MvcSheet.Submit2(this);
//}


//协议变更
function Agreement_change() {

    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");//协议号
    var agency_type = "USD";
    var Agreenment_changeNo = $.MvcSheetUI.GetControlValue("Agreement_changeNumber");//协议变更的版本号
    //console.log(AgreeMent_number);
    //console.log(Agreenment_changeNo);
    //return false;
    //var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");//协议号目前没有连接起来写假数据
    window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_change/AgreeMent_change.aspx?Mode=Originate&WorkflowCode=Agreenment_change&WorkflowVersion=" + Agreenment_changeNo + "&AgreeMent_number=" + AgreeMent_number + "&agency_type=" + agency_type ;
}


// 申请文件归档
function ApplyFileGD() {
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    var agency_type="USD"
    var AgreementGD_file = $.MvcSheetUI.GetControlValue("AgreementGD_file");
    window.location.href = "/Portal/Sheets/AgreeMent/Agreement_pigeonhole/Agreement_pigeonhole.aspx?Mode=Originate&WorkflowCode=Agreement_file&WorkflowVersion=" + AgreementGD_file + "&AgreeMent_number=" + AgreeMent_number + "&agency_type=" + agency_type ;
}

// 变更归档查看
function viewGDChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('AgreementFileRecordhy.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/AgreeMent/Agreement_pigeonhole/Agreement_pigeonhole.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 变更查看
function viewBG(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('Agreement_bg_hy.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/AgreeMent/Agreement_change/Agreement_change.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 收款查看
function viewSKRMB(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('SKRecordsRMB.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=View&WorkItemID=" + WorkItemId;
}
function viewSKUSD(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('SKRecordsUSD.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=View&WorkItemID=" + WorkItemId;
}
function viewSKPercent(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('SKRecordsPercent.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 申请收款
function ApproveSK(agency_type) {
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    var st_money = $.MvcSheetUI.GetControlValue("st_money");
    var agency_money = $.MvcSheetUI.GetControlValue("agency_rates_hy.agency_money", 1);
    if (agency_type == "USD") {
        window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=Originate&WorkflowCode=Charge_back&WorkflowVersion=" + st_money + "&AgreeMent_number=" + AgreeMent_number + "&agency_type=" + agency_type + "&agency_money=" + agency_money;
    } else {
        var IsCheckCnt = 0;
        var dtl_js = $.MvcSheetUI.GetElement("YSList_Percent").SheetGridView();
        var ProjectNos = "";
        for (var i = 0; i < dtl_js.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("YSList_Percent.IsCheck", i + 1);
            var ProjectNo = $.MvcSheetUI.GetControlValue("YSList_Percent.ProjectNo", i + 1);
            var AgencyFeeRemainRMB = $.MvcSheetUI.GetControlValue("YSList_Percent.AgencyFeeRemainRMB", i + 1);
            var AgencyFeeRemainWB = $.MvcSheetUI.GetControlValue("YSList_Percent.AgencyFeeRemainWB", i + 1);
            // 选中(选中为" " ,没选中没"")
            if (IsCheck == "是;") {
                if (parseFloat(AgencyFeeRemainRMB) == 0 && parseFloat(AgencyFeeRemainWB) == 0) {
                    layer.alert('选择的数据(' + ProjectNo+')代理费为0，不能进行收款！！', { icon: 2 });
                    return false;
                }
                ProjectNos += $.MvcSheetUI.GetControlValue("YSList_Percent.ProjectNo", i + 1) + ",";
                IsCheckCnt++;
            }
        }
        if (IsCheckCnt == 0) {
            layer.alert('你还没有选择数据！', { icon: 2 });
            return false;
        }
        else {
            window.location.href = "/Portal/Sheets/AgreeMent/Receipt/Receipt.aspx?Mode=Originate&WorkflowCode=Charge_back&WorkflowVersion=" + st_money + "&AgreeMent_number=" + AgreeMent_number + "&agency_type=" + agency_type + "&ProjectNos=" + ProjectNos;
        }
    }

   
    
}

////协议归档查看
//function check_see(el) {
//    var rowIndex = el.parentElement.parentElement.rowIndex;
//    var WorkItemId = $.MvcSheetUI.GetControlValue('agreement_filesnew.workItemId', rowIndex - 1);
//    //window.location.href = "/Portal/Sheets/Contract/GDMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
//    console.log(WorkItemId);
//    //return false;
//    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");//协议号
//    window.location.href = "/Portal/Sheets/AgreeMent/Agreement_pigeonhole/Agreement_pigeonhole.aspx?Mode=View&WorkItemID="+WorkItemId+"&AgreeMent_number=" + AgreeMent_number;
//}
//判断上限和下限输入框是否出现
function agency_typeChange(ins) {
    var rowIndex = ins.parentElement.parentElement.rowIndex;
    //var agency_rates = $.MvcSheetUI.GetControlValue('agency_rates.agency_type', rowIndex - 1);
    //if (agency_rates != "" && agency_rates == "AgencyRate_Sec") {
    //    //console.log($(agency_rates).next());
    //    //console.log($(agency_rates).parent().siblings().eq(0).children().eq(0));
    //    $(this).find("td[data-field='agency_rates.agency_money']").attr("disabled", "disabled");
    //    //$("target").parent().siblings().eq(0).children().eq(0)
    //    //$.MvcSheetUI.GetControlValue('agency_rates.agency_money', rowIndex - 1).attr("disabled", "disabled",);
    //    //$(this).find("input[data-field='agency_rates.agency_money']").attr("disabled", "disabled");
    //}
    //console.log(agency_rates);
    //return false;
    var rowp = 0;
    var agency_rates_hy = $.MvcSheetUI.GetElement("agency_rates_hy").SheetGridView();
    $("[data-datafield='agency_rates_hy']").find("tr.rows").each(function () {
        rowp++;
        console.log(rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("agency_rates_hy.agency_type", rowp);
        if (DisplayName != "" && DisplayName == "AgencyRate_Sec") {
            $(this).find("td[data-field='agency_rates_hy.agency_money']").children().attr("disabled", "disabled");
            $(this).find("td[data-field='agency_rates_hy.up_limit']").children().removeAttr("disabled");
            $(this).find("td[data-field='agency_rates_hy.lower_limit']").children().removeAttr("disabled");

        } else {
            $.MvcSheetUI.SetControlValue('agency_rates_hy.up_limit', '', rowIndex - 1);
            $.MvcSheetUI.SetControlValue('agency_rates_hy.lower_limit', '', rowIndex - 1);
            $(this).find("td[data-field='agency_rates_hy.agency_money']").children().removeAttr("disabled");
            $(this).find("td[data-field='agency_rates_hy.up_limit']").children().attr("disabled", "disabled");
            $(this).find("td[data-field='agency_rates_hy.lower_limit']").children().attr("disabled", "disabled");
        }
        
    });

}

var rowAdd = function (row) {
    var rownum = row.attr("data-row");
    var rowp = 0;
    $("[data-datafield='agency_rates_hy']").find("tr.rows").each(function () {
        rowp++;
        if (rowp == rownum) {
            $(this).find("td[data-field='agency_rates_hy.up_limit']").children().attr("disabled", "disabled");
            $(this).find("td[data-field='agency_rates_hy.lower_limit']").children().attr("disabled", "disabled");
        }

    });
}
// 增加自定义工具栏按钮方法，触发后台事件
//$.MvcSheet.AddAction({
//    //Action: "GetBackAction",       // 执行后台方法名称
//    Icon: "fa-sign-in",           // 按钮图标
//    Text: "取回",           // 按钮名称
//    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
//    OnAction: function () {
//        /*
//        自定义按钮执行事件，如果为 null 则调用$.MvcSheet.Action 执行后台方法
//        如果不为 null，那么会执行这里的方法，需要自己Post到后台或写前端逻辑
//        */
//        $.ajax({
//            type: "POST",    //页面请求的类型
//            url: "/Portal/InstanceDetail/GetAdjustActivityInfo",   //处理页的相对地址
//            data: {
//                InstanceID: $.MvcSheetUI.SheetInfo.InstanceId,
//            },
//            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//                var options = "";
//                if (ret.SUCCESS == true) {
//                    console.log("GetAdjustActivityInfo=" + ret);
//                    for (var i = 0; i < ret.InstanceActivity.length; i++) {
//                        if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_sign") {
//                            if (ret.InstanceActivity[i].ActivityName == "创建协议") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                        }
//                        if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_excu") {
//                            if (ret.InstanceActivity[i].ActivityName == "创建协议") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                            if (ret.InstanceActivity[i].ActivityName == "协议审签") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                        }
//                        if ($.MvcSheetUI.GetControlValue('IsComplete') == "True") {
//                            if (ret.InstanceActivity[i].ActivityName == "创建协议") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                            if (ret.InstanceActivity[i].ActivityName == "协议审签") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                            if (ret.InstanceActivity[i].ActivityName == "协议执行") {
//                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
//                            }
//                        }

//                    }
//                }
//                //让弹出框显示的操作方法
//                $('#message-module').find('.modal-body').html(
//                    '<div style="text-align: center;padding: 50px;line-height: 25px">' +
//                    '<form class="bs-example form-horizontal" name="form" >' +
//                    '<div class="row">' +
//                    '    <h5 class="col-md-4" style="padding-top: 14px;">选择活动: </h5><div class="col-md-6 input-group">' +
//                    '        <select class="form-control" id="ActivityCodes" ><option value="">请选择</option>' + options +
//                    '                 </select > ' +
//                    '    </div>' +
//                    '</div > ' +
//                    '</form > ' +
//                    '</div > '
//                );
//                var moduleFooter = $('#message-module').find('.modal-footer');
//                var cancleButton = $('<button type="button" class="btn " data-dismiss="modal" style=" border-radius: 0px;border: 0px;margin-left: 0px;width: 50%;background-color:white;float: left;border-bottom-left-radius: 5px;border-color: #ff993b;line-height: 25px;color:black">取消</button>');
//                var confirmButton = $('<button type="button" class="btn btn-default" style="border-radius: 0px;border: 0px;background-color: #FF993B;width: 50%;float: right;border-bottom-right-radius: 6px;line-height: 25px;margin-left: 0px;">确定</button>');

//                if (moduleFooter.find('button').length === 0) {
//                    cancleButton.appendTo(moduleFooter);
//                    confirmButton.appendTo(moduleFooter);
//                }
//                $('#message-module').modal({ keyboard: true, show: true, backdrop: true });
//                $('#message-module').on('shown.bs.modal', function () {
//                    $.LoadingMask.Hide();
//                });
//                confirmButton.click(function () {
//                    $.MvcSheetUI.SetControlValue("NeedActivityCode", $("#ActivityCodes").val());
//                    $.MvcSheetUI.SetControlValue("NeedActivityName", $("#ActivityCodes").find("option:selected").text());
//                    $.MvcSheetUI.SetControlValue("GetBackFlg", "1");

//                    //doGoBack($("#ActivityCodes").val());
//                    var InstanceActivity = $("#ActivityCodes").val();
//                    if (InstanceActivity == "") {
//                        layer.alert('请选择取回的节点！', { icon: 2 });
//                    } else {
//                        $('#message-module').modal('hide');
//                        GotoBackPage();
//                    }

//                });
//            }
//        });
//    },
//    //OnActionDone: function (ret) {


//    //},
//    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
//});

//function GotoBackPage() {
//    var WorkflowVersion_Back = $.MvcSheetUI.GetControlValue("WorkflowVersion_Back");
//    var InstanceActivity = $("#ActivityCodes").val();
//    //InstanceActivity = "节点";
//    var InstanceId = $.MvcSheetUI.SheetInfo.InstanceId;
//    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
//    if (InstanceActivity != "") {
//        window.location.href = "/Portal/Sheets/Agreement/Agreement_goback/GetBackMy.aspx?Mode=Originate&WorkflowCode=GetBackAgreement&WorkflowVersion=" + WorkflowVersion_Back + "&InstanceId=" + InstanceId + "&InstanceActivity=" + InstanceActivity + "&AgreeMent_number=" + AgreeMent_number;
//    } else {
//        layer.alert('请选择取回的节点！', { icon: 2 });
//        return false;
//    }
//}

// 根据协议委托方获取相关数据
function SetDatasByAgreement_client() {
    var Agreement_client = $.MvcSheetUI.GetControlValue("Agreement_client");
    //Agreement_client.split("(");
   
    Agreement_client = Agreement_client.split("（")[0];
   
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "AircraftOilAgreement.ashx?Command=GetDatasByAgreement_client",   //处理页的相对地址
        data: {
            Agreement_client: Agreement_client,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret != "") {
                $.MvcSheetUI.SetControlValue("Contacts", ret.Contacts);
                $.MvcSheetUI.SetControlValue("Con_phone", ret.Con_phone);
                $.MvcSheetUI.SetControlValue("Mobile_phone", ret.Mobile_phone);
                $.MvcSheetUI.SetControlValue("Fax", ret.Fax);
                $.MvcSheetUI.SetControlValue("Email", ret.Email);
                $.MvcSheetUI.SetControlValue("Contact_address", ret.Contact_address);
            }
            
            
        }
    });
}

function setSpeMoney() {
    var Is_specialist_money = $.MvcSheetUI.GetControlValue("Is_specialist_money");
    if (Is_specialist_money == "专家费支出预估;") {
        $("input[data-datafield='specialist_money']").attr("readonly", false);
    } else {
        $.MvcSheetUI.SetControlValue("specialist_money", 0);
        $("input[data-datafield='specialist_money']").attr("readonly", true);
    }
}

//function viewApprove(el) {
//    var rowIndex = el.parentElement.parentElement.rowIndex;
//    var WorkItemId = $.MvcSheetUI.GetControlValue('Agreement_signTbl.WorkItemId', rowIndex - 1);
//    window.location.href = "/Portal/Sheets/Agreement/Agreement_sign/Agreement_sign.aspx?Mode=View&WorkItemID=" + WorkItemId;
//}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 当前节点是创建节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "cre_agreement") {
        if (this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("agency_rates_hy").SheetGridView();
            var len = dtl.RowCount;
            if (len == 0) {
                layer.alert('代理费不能为空！', { icon: 2 });
                return false;
            } else if (len > 0) {
                var str = "";
                for (var i = 0; i < len; i++) {
                    var agency_type = $.MvcSheetUI.GetControlValue("agency_rates_hy.agency_type", i + 1);
                    if (str.indexOf(agency_type) >= 0) {
                        layer.alert('代理费不能重复！', { icon: 2 });
                        return false;
                    }
                    str += agency_type + ",";
                }
            }
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "agreement_sign") {
        if (this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("Agreement_signTbl").SheetGridView();
            if (dtl.RowCount <= 0) {
                layer.alert('当前还没有审签过，不能提交到下一步！', { icon: 2 });
                return false;
            } else if (dtl.RowCount > 0) {
                var Status = $.MvcSheetUI.GetControlValue("Agreement_signTbl.Status", 1);
                if (Status != "审批完了") {
                    layer.alert('当前还没有审签通过，不能提交到下一步！', { icon: 2 });
                    return false;
                }
            }
        }
    } 
    return true;
}