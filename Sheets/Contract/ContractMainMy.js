﻿// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    //// 申请修改合同号状态
    //var UpdateNoFlg = $.MvcSheetUI.GetControlValue("UpdateNoFlg");
    //// 审签合同状态
    //var ApproveFlg = $.MvcSheetUI.GetControlValue("ApproveFlg");
    //// 执行合同状态
    //var OperateFlg = $.MvcSheetUI.GetControlValue("OperateFlg");
    //// 合同完成状态
    //var CompleteFlg = $.MvcSheetUI.GetControlValue("CompleteFlg");
    //if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
    //    var dtl = $.MvcSheetUI.GetElement("ContractApproveTbl").SheetGridView();
    //    if (dtl.RowCount <= 0) {
    //        layer.alert('当前还没有审签过，不能提交到下一步！', { icon: 2 });
    //        return false;
    //    }
    //}
}

// 表单验证接口
$.MvcSheet.Validate = function () {
    
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    // 当前节点是合同创建节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCreate") {
        if (this.Action == "Submit") {
            // AB角check
            var PostA = $.MvcSheetUI.GetControlValue("PostA");
            var PostB = $.MvcSheetUI.GetControlValue("PostB");
            if ("" == PostA || "" == PostB) {
                //layer.confirm('确认要XX吗？', function (index) {
                //    return false;
                //});
                layer.alert('请选择A角和B角！', { icon: 2 });
                return false;
            }
            if (PostA == PostB) {
                layer.alert('A角和B角不能是同一个用户！', { icon: 2 });
                return false;
            }
            if ($.MvcSheetUI.SheetInfo.Originator == PostB) {
                layer.alert('确认要把发起人设为B角吗？', { icon: 2 });
                //return false; 修改为 confirm 确认框
            }
            if ($.MvcSheetUI.SheetInfo.Originator != PostA && $.MvcSheetUI.SheetInfo.Originator != PostB) {
                layer.alert('发起人必须是A角或B角之一！', { icon: 2 });
                return false;
            }
        }
        if (this.Action == "Submit") {
            var el = $("table[data-datafield='UpdateNoTbl']").find("[data-datafield='UpdateNoTbl.Status']");
            var txt = el.length > 1 ? el[1].value : "";
            // 审批完了后才可以修改合同金额以下的数据
            if (txt == "审批中") {
                layer.alert('当前正在申请修改合同号，不能提交到下一步！', { icon: 2 });
                return false;
            }
            var BidType = $.MvcSheetUI.GetControlValue("BidType");
            var BidNo = $.MvcSheetUI.GetControlValue("BidNo");
            var dtl = $.MvcSheetUI.GetElement("BidTbl").SheetGridView();
            if (BidType == "1" && (BidNo == "" || dtl.RowCount == 0)) {
                layer.alert('请选择招标项目！', { icon: 2 });
                return false;
            }
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
        var ContractFile = $("#ContractFile").xnfile("value");        
        $.MvcSheetUI.SetControlValue("ContractFile", ContractFile);
        var TalkFile = $("#TalkFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("TalkFile", TalkFile);
        var AgencyFile = $("#AgencyFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("AgencyFile", AgencyFile);
        var SignDayERFile = $("#SignDayERFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("SignDayERFile", SignDayERFile);
        if (this.Action == "Submit") {
            var dtl = $.MvcSheetUI.GetElement("ContractApproveTbl").SheetGridView();
            if (dtl.RowCount <= 0) {
                layer.alert('当前还没有审签过，不能提交到下一步！', { icon: 2 });
                return false;
            } else if (dtl.RowCount > 0) {
                var Status = $.MvcSheetUI.GetControlValue("ContractApproveTbl.Status", 1);
                if (Status != "审批完了") {
                    layer.alert('当前还没有审签通过，不能提交到下一步！', { icon: 2 });
                    return false;
                }
            }
        }

        if (this.Action == "Submit") {
            var ContractTotalPrice = $.MvcSheetUI.GetControlValue("ContractTotalPrice");
            ContractTotalPrice = ContractTotalPrice == "" ? 0 : ContractTotalPrice;
            var JKTotalAmount = $.MvcSheetUI.GetControlValue("JKTotalAmount");
            JKTotalAmount = JKTotalAmount == "" ? 0 : JKTotalAmount;
            // 合同性质
            var ContractProperty = $.MvcSheetUI.GetControlValue("ContractProperty");
            if (ContractProperty == "ContractProperty_HKMY" &&
                (parseFloat(ContractTotalPrice) > 0 || parseFloat(JKTotalAmount) > 0)) {
                $.MvcSheetUI.SetControlValue("IsMakeHYAgency", "true");
            }
            
        }
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var OtherFile = $("#OtherFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("OtherFile", OtherFile);
        if (this.Action == "Submit") {
            // 1、未发起请款、到款、付款、结算流程
            var qkCnt = 0;
            var dkCnt = 0;
            var fkCnt = 0;
            var jsCnt = 0;
            var errstr = "";
            var errgdstr = "";
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=getCountByConId",   //处理页的相对地址
                data: {
                    ContractNo: ContractNo,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    if (ret.qkCnt == 0) {
                        errstr += "请款、";
                    }
                    if (ret.dkCnt == 0) {
                        errstr += "到款、";
                    }
                    if (ret.fkCnt == 0) {
                        errstr += "付款、";
                    }
                    if (ret.jsCnt == 0) {
                        errstr += "结算";
                    }
                    if (ret.gdCnt == 0) {
                        errgdstr = "合同正本签字版未完成归档";
                    }
                }
            });
            if (errstr != "") {
                layer.alert('未发起' + errstr + '流程！', { icon: 2 });
                return false;
            } else {
                // 2、XX流程未完成
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "ContractHandler.ashx?Command=getApplyingCountOfOper",   //处理页的相对地址
                    data: {
                        ContractNo: ContractNo,
                    },
                    async: false,
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        if (ret.qkCnt > 0) {
                            errstr += "请款流程未完成。\n";
                        }
                        if (ret.dkCnt > 0) {
                            errstr += "到款流程未完成。\n";
                        }
                        if (ret.fkCnt > 0) {
                            errstr += "付款流程未完成。\n";
                        }
                        if (ret.jsCnt > 0) {
                            errstr += "结算流程未完成。\n";
                        }
                        if (ret.psCnt > 0) {
                            errstr += "信用证流程未完成。\n";
                        }
                        if (ret.ilsCnt > 0) {
                            errstr += "进口许可证流程未完成。\n";
                        }
                        if (ret.dhCnt > 0) {
                            errstr += "到货流程未完成。\n";
                        }
                        if (ret.bgCnt > 0) {
                            errstr += "合同变更流程未完成。\n";
                        }
                        if (ret.bhCnt > 0) {
                            errstr += "保函流程未完成。\n";
                        }
                        if (ret.gdCnt > 0 || ret.gdcCnt > 0) {
                            errstr += "合同文件流程未完成。\n";
                        }
                    }
                });
                if (errstr != "") {
                    layer.alert(errstr, { icon: 2 });
                    return false;
                } else if (errgdstr != "") {
                    // 3、合同正本签字版未完成归档
                    layer.alert(errgdstr, { icon: 2 });
                    return false;
                } else {
                    // 4、合同人民币未能达到支付比例（100.00%）
                    var FKPercentRMB = $.MvcSheetUI.GetControlValue("FKPercentRMB");
                    if (FKPercentRMB != "100.00%") {
                        layer.alert('合同人民币未能达到支付比例（100.00%）！', { icon: 2 });
                        return false;
                    }
                }
            }
        }
    }

    return true;
}


// 事件触发后
$.MvcSheet.ActionDone = function (data) {

    // this.Action; // 获取当前按钮名称
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCreate") {
        // 保存时调整当前节点的参与者即可，提交时需要把下一个节点的参与者也做调整
        if (this.Action == "Save") {
            // 调整参与者
            AdjustActivity("ActivityCreate");
        }
        //else if (this.Action == "Submit") {
        //    var WorkItemId = $.MvcSheetUI.SheetInfo.WorkItemId;
        //    window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
        //    return false;
        //}
        //if (this.Action == "Submit") {
        //    // 调整参与者
        //    //AdjustActivity("ActivityCreate");
        //    AdjustActivity("ActivityApprove");
        //}
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
        //if (this.Action == "Save") {
        //    // 调整参与者
        //    AdjustActivity("ActivityApprove");
        //}
        //if (this.Action == "Submit") {
        //    // 调整参与者
        //    //AdjustActivity("ActivityApprove");
        //    AdjustActivity("ActivityOperate");
        //}
        // this.Action; // 获取当前按钮名称
        //if (this.Action == "Save") {
            var ToApproveSubFlg = $.MvcSheetUI.GetControlValue("ToApproveSubFlg");
            if (ToApproveSubFlg == "true") {
                var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
                var WorkflowVersion_Approve = $.MvcSheetUI.GetControlValue("WorkflowVersion_Approve");
                window.location.href = "/Portal/Sheets/Contract/ContractApproveMy.aspx?Mode=Originate&WorkflowCode=ContractApprove&WorkflowVersion=" + WorkflowVersion_Approve + "&ContractNo=" + ContractNo;
            }
        //}
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {

    }

}
//数据加载后
$.MvcSheet.Loaded = function () {
    $.MvcSheetUI.SetControlValue("IsFirstProperty", "true");
    $.MvcSheetUI.SetControlValue("CurrentUserId", $.MvcSheetUI.SheetInfo.UserID);
    $.MvcSheetUI.SetControlValue("ToApproveSubFlg", "");
    $.MvcSheetUI.SetControlValue("ToFileGDFlg", "");
    $.MvcSheetUI.SetControlValue("ToChangeGDFlg", "");
    $.MvcSheetUI.SetControlValue("IsMakeHYAgency", "");
    $("input[data-datafield='AgencyComment']").attr("disabled", "disabled");
    $("input[data-datafield='ContractFileNameSignVer']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyFileNameSignVer']").attr("disabled", "disabled");
    $("input[data-datafield='ContractChangeFileNameSignVer']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyChangeFileNameSignVer']").attr("disabled", "disabled");
    $("#getFinalUsers").hide();
    $("#getBidNo").hide();

    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    $(".ContractNoShow").text(ContractNo);
    // 自定义文件格式 写法1 合同文件
    $("#ContractFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo+"\\合同审签");
    var ContractFile = $.MvcSheetUI.GetControlValue("ContractFile");
    if (ContractFile != "") {
        var arr = ContractFile.split(",");
        $("#ContractFile").xnfile("value", arr);
    }
    // 写法2
    //$("#ContractFile").xnfile();
    //$("#ContractFile").xnfile("option", "multiple", true);
    //var ContractFile = $.MvcSheetUI.GetControlValue("ContractFile");
    //if (ContractFile != "") {
    //    var arr = ContractFile.split(",");
    //    $("#ContractFile").xnfile("value", arr);
    //}

    // 自定义文件格式 代理协议
    $("#AgencyFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同审签");
    var AgencyFile = $.MvcSheetUI.GetControlValue("AgencyFile");
    if (AgencyFile != "") {
        var arr = AgencyFile.split(",");
        $("#AgencyFile").xnfile("value", arr);
    }

    // 自定义文件格式 合同谈判小结
    $("#TalkFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同审签");
    var TalkFile = $.MvcSheetUI.GetControlValue("TalkFile");
    if (TalkFile != "") {
        var arr = TalkFile.split(",");
        $("#TalkFile").xnfile("value", arr);
    }

    // 自定义文件格式 截屏图
    $("#SignDayERFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同审签");
    var SignDayERFile = $.MvcSheetUI.GetControlValue("SignDayERFile");
    if (SignDayERFile != "") {
        var arr = SignDayERFile.split(",");
        $("#SignDayERFile").xnfile("value", arr);
    }  
    // 自定义文件格式 合同正本签字版
    $("#ContractFileNameSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
    var ContractFileNameSignVer = $.MvcSheetUI.GetControlValue("ContractFileNameSignVer");
    if (ContractFileNameSignVer != "") {
        var arr = ContractFileNameSignVer.split(",");
        $("#ContractFileNameSignVer").xnfile("value", arr);
    }
    // 自定义文件格式 协议正本签字版
    $("#AgencyFileNameSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
    var AgencyFileNameSignVer = $.MvcSheetUI.GetControlValue("AgencyFileNameSignVer");
    if (AgencyFileNameSignVer != "") {
        var arr = AgencyFileNameSignVer.split(",");
        $("#AgencyFileNameSignVer").xnfile("value", arr);
    }
    // 自定义文件格式 合同变更书签字版
    $("#ContractChangeFileNameSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
    var ContractChangeFileNameSignVer = $.MvcSheetUI.GetControlValue("ContractChangeFileNameSignVer");
    if (ContractChangeFileNameSignVer != "") {
        var arr = ContractChangeFileNameSignVer.split(",");
        $("#ContractChangeFileNameSignVer").xnfile("value", arr);
    }
    // 自定义文件格式 合同变更书签字版
    $("#AgencyChangeFileNameSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
    var AgencyChangeFileNameSignVer = $.MvcSheetUI.GetControlValue("AgencyChangeFileNameSignVer");
    if (AgencyChangeFileNameSignVer != "") {
        var arr = AgencyChangeFileNameSignVer.split(",");
        $("#AgencyChangeFileNameSignVer").xnfile("value", arr);
    }
    // 自定义文件格式 其他文件
    $("#OtherFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\其他");
    var OtherFile = $.MvcSheetUI.GetControlValue("OtherFile");
    if (OtherFile != "") {
        var arr = OtherFile.split(",");
        $("#OtherFile").xnfile("value", arr);
    }
    var IsComplete = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getWorkItemByOID",   //处理页的相对地址
        data: {
            InstanceId: $.MvcSheetUI.SheetInfo.InstanceId
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            IsComplete = ret.ActivityCode;
        }
    });
   //console.log($.MvcSheetUI.SheetInfo.ActivityCode);
    if (IsComplete == "End") {
       // 流程图
       $("#apDiv1 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
       $("#apDiv22 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
       $("#apDiv3 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
       $("#apDiv4 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
       $('.operateChild').removeClass("bt_progress_child_long2").addClass("bt_progress_child_long1");
       $('.operateChild').attr("disabled", "disabled");
        // 生成合同号、申请修改合同号按钮 不显示
        $("#generateContractNoId").hide();
        $("#ApplyContractNoId").hide();
        // 信用证
        $("#ApprovePaymentId").hide();
        // 进口许可证
        $("#ApproveImportLicenseId").hide();
        // 到货
        $("#ApproveDHId").hide();
        // 合同变更
        $("#ApproveBGId").hide();
        // 合同归档
        $("#GDContractFileId").hide();
        $("#GDChangeContractFileId").hide();
        // 保函
        $("#ApproveBHId").hide();
        // 资金计划
        $("#EditZJPlanId").hide();
        // 请款
        $("#ApproveQKId").hide();
        // 到款
        $("#ApproveDKId").hide();
        // 付款
        $("#ApproveFKId").hide();
        // 结算
        $("#ApproveJSId").hide();
        // 支付管理的新增
        $("#xzBtn").hide();
        setFileReadOnly("ContractFile");
        setFileReadOnly("AgencyFile");
        setFileReadOnly("TalkFile");
        setFileReadOnly("SignDayERFile");
        setFileReadOnly("ContractFileNameSignVer");
        setFileReadOnly("AgencyFileNameSignVer");
        setFileReadOnly("ContractChangeFileNameSignVer");
        setFileReadOnly("AgencyChangeFileNameSignVer");
        setFileReadOnly("OtherFile");
    } else {
        // 当前节点是合同创建节点
       if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCreate") {
           if ($.MvcSheetUI.GetControlValue("PostA") == "") {
               $.MvcSheetUI.SetControlValue("PostA", $.MvcSheetUI.SheetInfo.UserID);
           }
            // 申请修改合同号子表 不能编辑
            $("input[data-datafield='UpdateNoTbl.Approver']").attr("disabled", "disabled");
            $("input[data-datafield='UpdateNoTbl.ApproveDate']").attr("disabled", "disabled");
            $("input[data-datafield='UpdateNoTbl.ContractNoNew']").attr("disabled", "disabled");
            $("input[data-datafield='UpdateNoTbl.Status']").attr("disabled", "disabled");
            // 招标详情子表 不能编辑
            $("input[data-datafield='BidTbl.ProjectShortName']").attr("disabled", "disabled");
            $("input[data-datafield='BidTbl.BidPrice']").attr("disabled", "disabled");
            // 合同卖方详情子表 不能编辑
            $("input[data-datafield='SalerTbl.CompanyName']").attr("disabled", "disabled");
            $("input[data-datafield='SalerTbl.ContactName']").attr("disabled", "disabled");
            $("input[data-datafield='SalerTbl.Telephone']").attr("disabled", "disabled");
            $("input[data-datafield='SalerTbl.Mobile']").attr("disabled", "disabled");
            $("input[data-datafield='SalerTbl.Fax']").attr("disabled", "disabled");
            $("input[data-datafield='SalerTbl.Email']").attr("disabled", "disabled");
            // 流程图
            $("#apDiv1 input").removeClass("bt_project1").removeClass("bt_project3").addClass("bt_project2");
            $("#apDiv22 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            $("#apDiv3 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            $("#apDiv4 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            $('.operateChild').attr("disabled", "disabled");
            // 项目名称、子工程名称、招标编号不可写
            $("input[data-datafield='ProjectName']").attr("disabled", "disabled");
            $("input[data-datafield='SubProjectName']").attr("disabled", "disabled");
            $("input[data-datafield='BidNo']").attr("disabled", "disabled");

            // 审批申请按钮 不显示
            $("#ApplyApproveId").hide();
            // 信用证
            $("#ApprovePaymentId").hide();
            // 进口许可证
            $("#ApproveImportLicenseId").hide();
            // 到货
            $("#ApproveDHId").hide();
            // 合同变更
            $("#ApproveBGId").hide();
            // 合同归档
            $("#GDContractFileId").hide();
            $("#GDChangeContractFileId").hide();
            // 保函
            $("#ApproveBHId").hide();
            // 资金计划
            $("#EditZJPlanId").hide();
            // 请款
            $("#ApproveQKId").hide();
            // 到款
            $("#ApproveDKId").hide();
            // 付款
            $("#ApproveFKId").hide();
            // 结算
            $("#ApproveJSId").hide();

            //$(".bannerTitleCreate").click();
            $(".bannerTitleApprove").click();
            $(".bannerTitleOperate").click();

            $("#getFinalUsers").show();
            $("#getBidNo").show();
            
            // 审签节点不显示
            $(".ContractContentApprove").hide();
            // 执行节点不显示
            $(".ContractContentOperate").hide();
            // 完成节点不显示
            $(".ContractContentComplete").hide();
            setFileHide("ContractFile");
            setFileHide("AgencyFile");
            setFileHide("TalkFile");
            setFileHide("SignDayERFile");
            setFileHide("ContractFileNameSignVer");
            setFileHide("AgencyFileNameSignVer");
            setFileHide("ContractChangeFileNameSignVer");
            setFileHide("AgencyChangeFileNameSignVer");
            setFileHide("OtherFile");
        } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
            // 审签子表不能编辑
            $("input[data-datafield='ContractApproveTbl.Approver']").attr("disabled", "disabled");
            $("input[data-datafield='ContractApproveTbl.ApproveDate']").attr("disabled", "disabled");
            $("input[data-datafield='ContractApproveTbl.Status']").attr("disabled", "disabled");
            $("input[data-datafield='ContractApproveTbl.Operate']").attr("disabled", "disabled");
            // 流程图
            $("#apDiv1 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
            $("#apDiv22 input").removeClass("bt_project1").removeClass("bt_project3").addClass("bt_project2");
            $("#apDiv3 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            $("#apDiv4 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            $('.operateChild').attr("disabled", "disabled");
            // 生成合同号、申请修改合同号按钮 不显示
            $("#generateContractNoId").hide();
            $("#ApplyContractNoId").hide();
            // 信用证
            $("#ApprovePaymentId").hide();
            // 进口许可证
            $("#ApproveImportLicenseId").hide();
            // 到货
            $("#ApproveDHId").hide();
            // 合同变更
            $("#ApproveBGId").hide();
            // 合同归档
            $("#GDContractFileId").hide();
            $("#GDChangeContractFileId").hide();
            // 保函
            $("#ApproveBHId").hide();
            // 资金计划
            $("#EditZJPlanId").hide();
            // 请款
            $("#ApproveQKId").hide();
            // 到款
            $("#ApproveDKId").hide();
            // 付款
            $("#ApproveFKId").hide();
            // 结算
            $("#ApproveJSId").hide();

            var el = $("table[data-datafield='ContractApproveTbl']").find("[data-datafield='ContractApproveTbl.Status']");
            var txt = el.length > 1 ? el[1].value : "";
            // 审批完了后才可以修改合同金额以下的数据
            if (txt != "审批完了") {
                // 合同金额
                $("input[data-datafield='ContractTotalPrice']").attr("disabled", "disabled");
                // 代理协议签约日期
                $("input[data-datafield='AgencySignDate']").attr("disabled", "disabled");
                // 签约日期
                $("input[data-datafield='SignDate']").attr("disabled", "disabled");
                // 合同到货期
                $("[data-datafield='ContractDHDate']").attr("disabled", "disabled");
                //// 代理费费率／金额
                //$("[data-datafield='AgencyComputerNum']").attr("disabled", "disabled");
                //$("[data-datafield='AgencyComputerType']").attr("disabled", "disabled");
                //// 支付条件
                //$("[data-datafield='PayCondition']").attr("disabled", "disabled");
                // 总金额
                $("input[data-datafield='JKTotalAmount']").attr("disabled", "disabled");
                // 币种
                $("[data-datafield='Currency']").attr("disabled", "disabled");
                // 签约日汇率
                $("input[data-datafield='SignDayExchangeRate']").attr("disabled", "disabled");
                // 签约日汇率截屏文件
                //$("[data-datafield='SignDayERFile']").find("div").attr("disabled", "disabled");
                //$("[data-datafield='SignDayERFile']").find("table tr").each(function () {
                //    $(this).find("a.fa-minus").hide();
                //});
                setFileReadOnly("SignDayERFile");
            } else {
                setFileWriteable("SignDayERFile");
            }
            if (txt == '审批中' || txt == '审批完了') {
                // 计价方式
                $("input[data-datafield='ValuationType']").attr("disabled", "disabled");
                $("input[data-datafield='Agio']").attr("disabled", "disabled");
                // 到货日期
                $("input[data-datafield='DHDate']").attr("disabled", "disabled");
                // 代理费费率／金额
                $("[data-datafield='AgencyComputerNum']").attr("disabled", "disabled");
                $("[data-datafield='AgencyComputerType']").attr("disabled", "disabled");
                // 支付条件
                $("[data-datafield='PayCondition']").attr("disabled", "disabled");
                // 代理协议类型
                $("select[data-datafield='AgencyType']").attr("disabled", "disabled");
                // 代理协议选择
                $("input[data-datafield='AgencySelect']").attr("disabled", "disabled");
                $("input[data-datafield='AgencySelect']").next().next().hide();
                // 代理协议文件
                //$("[data-datafield='AgencyFile']").find("div").attr("disabled", "disabled");
                //$("[data-datafield='AgencyFile']").find("table tr").each(function () {
                //    $(this).find("a.fa-minus").hide();
                //});
                // 协议后审说明
                $("[data-datafield='AgencyAfterRemark']").attr("disabled", "disabled");
                // 合同文本
                //$("[data-datafield='ContractFile']").find("div").attr("disabled", "disabled");
                //$("[data-datafield='ContractFile']").find("table tr").each(function () {
                //    $(this).find("a.fa-minus").hide();
                //});
                $("#ContractFile button").prop("disabled", true);
                // 合同谈判小结
                //$("[data-datafield='TalkFile']").find("div").attr("disabled", "disabled");
                //$("[data-datafield='TalkFile']").find("table tr").each(function () {
                //    $(this).find("a.fa-minus").hide();
                //});
                setFileReadOnly("ContractFile");
                setFileReadOnly("AgencyFile");
                setFileReadOnly("TalkFile");
            } else {
                setFileWriteable("ContractFile");
                setFileWriteable("AgencyFile");
                setFileWriteable("TalkFile");
            }
            setFileHide("ContractFileNameSignVer");
            setFileHide("AgencyFileNameSignVer");
            setFileHide("ContractChangeFileNameSignVer");
            setFileHide("AgencyChangeFileNameSignVer");
            setFileHide("OtherFile");
            // 对应人民币总金额
            $("[data-datafield='RMBTotalAmount']").attr("disabled", "disabled");

            $(".bannerTitleCreate").click();
            //(".bannerTitleApprove").click();
            $(".bannerTitleOperate").click();

            // 执行节点不显示
            $(".ContractContentOperate").hide();
            // 完成节点不显示
            $(".ContractContentComplete").hide();
             
           
        } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
            var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
            // 根据合同号码获取对应合同相关数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=getDataOfOper",   //处理页的相对地址
                data: {
                    ContractNo: ContractNo,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    var LJQKAmountRMB = (ret.LJQKAmountRMB == undefined || ret.LJQKAmountRMB == "") ? "0" : ret.LJQKAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJQKAmountRMB", parseFloat(LJQKAmountRMB).toFixed(2));
                    var LJQKAmountWB = (ret.LJQKAmountWB == undefined || ret.LJQKAmountWB == "") ? "0" : ret.LJQKAmountWB;
                    $.MvcSheetUI.SetControlValue("LJQKAmountWB", parseFloat(LJQKAmountWB).toFixed(2));
                    var LJDKAmountRMB = (ret.LJDKAmountRMB == undefined || ret.LJDKAmountRMB == "") ? "0" : ret.LJDKAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJDKAmountRMB", parseFloat(LJDKAmountRMB).toFixed(2));
                    var LJDKAmountWB = (ret.LJDKAmountWB == undefined || ret.LJDKAmountWB == "") ? "0" : ret.LJDKAmountWB;
                    $.MvcSheetUI.SetControlValue("LJDKAmountWB", parseFloat(LJDKAmountWB).toFixed(2));
                    var LJFKAmountRMB = (ret.LJFKAmountRMB == undefined || ret.LJFKAmountRMB == "") ? "0" : ret.LJFKAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJFKAmountRMB", parseFloat(LJFKAmountRMB).toFixed(2));
                    var LJFKAmountWB = (ret.LJFKAmountWB == undefined || ret.LJFKAmountWB == "") ? "0" : ret.LJFKAmountWB;
                    $.MvcSheetUI.SetControlValue("LJFKAmountWB", parseFloat(LJFKAmountWB).toFixed(2));
                    $.MvcSheetUI.SetControlValue("FKPercentRMB", parseFloat(ret.FKPercentRMB).toFixed(2) + "%");
                    $.MvcSheetUI.SetControlValue("FKPercentWB", parseFloat(ret.FKPercentWB).toFixed(2) + "%");
                    var LJQKFYAmountRMB = (ret.LJQKFYAmountRMB == undefined || ret.LJQKFYAmountRMB == "") ? "0" : ret.LJQKFYAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJQKFYAmountRMB", parseFloat(LJQKFYAmountRMB).toFixed(2));
                    var LJQKFYAmountWB = (ret.LJQKFYAmountWB == undefined || ret.LJQKFYAmountWB == "") ? "0" : ret.LJQKFYAmountWB;
                    $.MvcSheetUI.SetControlValue("LJQKFYAmountWB", parseFloat(LJQKFYAmountWB).toFixed(2));
                    var LJDKFYAmountRMB = (ret.LJDKFYAmountRMB == undefined || ret.LJDKFYAmountRMB == "") ? "0" : ret.LJDKFYAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJDKFYAmountRMB", parseFloat(LJDKFYAmountRMB).toFixed(2));
                    var LJDKFYAmountWB = (ret.LJDKFYAmountWB == undefined || ret.LJDKFYAmountWB == "") ? "0" : ret.LJDKFYAmountWB;
                    $.MvcSheetUI.SetControlValue("LJDKFYAmountWB", parseFloat(LJDKFYAmountWB).toFixed(2));
                    var LJFKFYAmountRMB = (ret.LJFKFYAmountRMB == undefined || ret.LJFKFYAmountRMB == "") ? "0" : ret.LJFKFYAmountRMB;
                    $.MvcSheetUI.SetControlValue("LJFKFYAmountRMB", parseFloat(LJFKFYAmountRMB).toFixed(2));
                    var LJFKFYAmountWB = (ret.LJFKFYAmountWB == undefined || ret.LJFKFYAmountWB == "") ? "0" : ret.LJFKFYAmountWB;
                    $.MvcSheetUI.SetControlValue("LJFKFYAmountWB", parseFloat(LJFKFYAmountWB).toFixed(2));
                    $.MvcSheetUI.SetControlValue("CurrencyRMB", "人民币");
                    $.MvcSheetUI.SetControlValue("CurrencyWB", ret.CurrencyName);
                    var LJBGAmount = (ret.LJBGAmount == undefined || ret.LJBGAmount == "") ? "0" : ret.LJBGAmount;
                    $.MvcSheetUI.SetControlValue("LJBGAmount", parseFloat(LJBGAmount).toFixed(2));
                }
            });
            $(".CurrencyRMB").text($.MvcSheetUI.GetControlValue("CurrencyRMB"));
            $(".CurrencyWB").text($.MvcSheetUI.GetControlValue("CurrencyWB"));

            // 审批申请按钮 不显示
            $("#ApplyApproveId").hide();
            // 生成合同号、申请修改合同号按钮 不显示
            $("#generateContractNoId").hide();
            $("#ApplyContractNoId").hide();
            // 流程图
            $("#apDiv1 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
            $("#apDiv22 input").removeClass("bt_project2").removeClass("bt_project3").addClass("bt_project1");
            $("#apDiv3 input").removeClass("bt_project1").removeClass("bt_project3").addClass("bt_project2");
            $("#apDiv4 input").removeClass("bt_project1").removeClass("bt_project2").addClass("bt_project3");
            // 信用证记录子表不能编辑
            $("input[data-datafield='PaymentTbl.Bank']").attr("disabled", "disabled");
            $("input[data-datafield='PaymentTbl.TotalAmount']").attr("disabled", "disabled");
            $("input[data-datafield='PaymentTbl.Status']").attr("disabled", "disabled");
            $("input[data-datafield='PaymentTbl.UpdatePayment']").attr("disabled", "disabled");
            $("input[data-datafield='PaymentTbl.TheNo']").attr("disabled", "disabled");

            $(".bannerTitleCreate").click();
            $(".bannerTitleApprove").click();
            //$(".bannerTitleOperate").click();

            // 资金计划
            //$("#EditZJPlanId").hide();
            // 请款
            //$("#ApproveQKId").hide();
            // 到款
            // 申请到款按钮显示否
            var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=getDKTbl",   //处理页的相对地址
                data: {
                    ContractNo: ContractNo,
                    UserID: CurrentUser.ObjectID,			
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    if (ret.length > 0) {
                        $("#ApproveDKId").show();
                    } else {
                        $("#ApproveDKId").hide();
                    }
                }
            });
            // 付款
            // $("#ApproveFKId").hide();
            // 结算
            // $("#ApproveJSId").hide();

            // 完成节点不显示
            $(".ContractContentComplete").hide();

            setFileReadOnly("ContractFile");
            setFileReadOnly("AgencyFile");
            setFileReadOnly("TalkFile");
            setFileReadOnly("SignDayERFile");
            setFileReadOnly("ContractFileNameSignVer");
            setFileReadOnly("AgencyFileNameSignVer");
            setFileReadOnly("ContractChangeFileNameSignVer");
            setFileReadOnly("AgencyChangeFileNameSignVer");
            setFileWriteable("OtherFile");
        }
    }
    
    

    // 累计金额只读
    $("input[data-datafield='LJQKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJQKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='FKPercentRMB']").attr("disabled", "disabled");
    $("input[data-datafield='FKPercentWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJQKFYAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJQKFYAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKFYAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJDKFYAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKFYAmountRMB']").attr("disabled", "disabled");
    $("input[data-datafield='LJFKFYAmountWB']").attr("disabled", "disabled");
    $("input[data-datafield='LJBGAmount']").attr("disabled", "disabled");
    // 支付管理

    // 获取支付管理相关数据
    //$.ajax({
    //    type: "POST",    //页面请求的类型
    //    url: "ContractHandler.ashx?Command=getPayManager",   //处理页的相对地址
    //    data: {
    //        ContractNo: $.MvcSheetUI.GetControlValue("ContractNo"),
    //    },
    //    async: false,
    //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
    //        for (var i = 0; i < ret.length; i++) {
    //            var obj = {};
    //            obj.zjjh = ret[i].ZJJH_Values;
    //            obj.zjjh_keys = ret[i].ZJJH_Keys;
    //            obj.qk = ret[i].QK_Values;
    //            obj.qk_keys = ret[i].QK_Keys;
    //            obj.dk = ret[i].DK_Values;
    //            obj.dk_keys = ret[i].DK_Keys;
    //            obj.fk = ret[i].FK_Values;
    //            obj.fk_keys = ret[i].FK_Keys;
    //            obj.djsje = ret[i].JSAmount;
    //            obj.id = ret[i].id;
    //            obj.ActivityCode = IsComplete == "End" ?"End":$.MvcSheetUI.SheetInfo.ActivityCode; // 合同状态
    //            // 往bootstrapTable添加数据
    //            $("#tableL02").bootstrapTable('insertRow', { index: i, row: obj });
    //            //tableData.push(obj);
    //        }

    //    }
    //});
    
    //$('#tableL02').bootstrapTable({
    //    height: 200,
    //    //        showRefresh: true,
    //    toolbar: '#toolbar',
    //    //模拟数据
    //    columns: [{
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'zjjh',
    //        title: '资金计划'
    //    }, {
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'qk',
    //        title: '请款'
    //    }, {
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'dk',
    //        title: '到款'
    //    }, {
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'fk',
    //        title: '付款'
    //    }, {
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'djsje',
    //        title: '待结算金额'
    //    }, {
    //        align: 'center',
    //        valign: 'middle',
    //        field: 'bj',
    //        title: '',
    //        events: operateEvents,
    //        formatter: addBtn
    //    }],
    //    data: tableData
    //});
    //// 信用证子表的改证显示判断
    //var rowp = 0;
    //$("[data-datafield='PaymentTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("PaymentTbl.Status", rowp);
    //    var changePaymentFlg = $.MvcSheetUI.GetControlValue("PaymentTbl.changePaymentFlg", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("PaymentTbl.RejectFlg", rowp);
    //    if (Status == "已开证") {
    //        $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").show();
    //        if (changePaymentFlg == "2") {
    //            $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
    //            $(this).find("td[data-field='PaymentTbl.UpdatePayment']").text("改证中");
    //        } else if (changePaymentFlg == "4") {
    //            $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
    //            $(this).find("td[data-field='PaymentTbl.UpdatePayment']").text("已改证");
    //        }
    //    } else {
    //        $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
    //    }
    //    if (RejectFlg == "1") {
    //        $(this).find("td[data-field='PaymentTbl.Operate'] a.updatePayment").show();
    //    } else {
    //        $(this).find("td[data-field='PaymentTbl.Operate'] a.updatePayment").hide();
    //    }
        
    //});

    //// 进口许可证子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='ImportLicenceTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.Status", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.RejectFlg", rowp);
    //    var CancelFlg = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.CancelFlg", rowp);
    //    var DisplayName = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.DisplayName", rowp);

    //    if (Status == "4") {
    //        if (RejectFlg == "1" || DisplayName == "草稿 ") {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").show();
    //        } else {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").hide();
    //        }
    //        if (CancelFlg == "1") {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").hide();
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").show();
    //        } else {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").show();
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").hide();
    //        }
    //    } else {
    //        if (RejectFlg == "1" || DisplayName == "草稿 ") {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").show();
    //        } else {
    //            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").hide();
    //        }
    //        $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").hide();
    //        $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").hide();
    //    }         
        
    //});
    //// 请款子表的合并单元格操作
    //var dtl = $.MvcSheetUI.GetElement("QKMainTbl").SheetGridView();
    //var len = dtl.RowCount;
    //var QKSeq = "";
    //if (len > 0) {
    //    for (var i = 0; i < len; i++) {

    //        if (QKSeq == "" || QKSeq != $.MvcSheetUI.GetControlValue("QKMainTbl.QKSeq", i + 1)) {
    //            QKSeq = $.MvcSheetUI.GetControlValue("QKMainTbl.QKSeq", i + 1);
    //            var SeqCnt = $.MvcSheetUI.GetControlValue("QKMainTbl.SeqCnt", i + 1);
    //            var Status = $.MvcSheetUI.GetControlValue("QKMainTbl.Status", i + 1);
    //            var k = 0;
    //            $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='QKMainTbl.QKSeq']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='QKMainTbl.QKTarget']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='QKMainTbl.Status']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='QKMainTbl.Operate']").attr("rowspan", SeqCnt);
    //                    if (Status == "草稿 " || Status == "驳回 ") {
    //                        $(this).find("td[data-field='QKMainTbl.Operate'] a.updateQK").show();
    //                    } else {
    //                        $(this).find("td[data-field='QKMainTbl.Operate'] a.updateQK").hide();
    //                    }
    //                }
    //                k++;
    //            });
    //        } else {
    //            QKSeq = $.MvcSheetUI.GetControlValue("QKMainTbl.QKSeq", i + 1);
    //            var k = 0;
    //            $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='QKMainTbl.QKSeq']").remove();
    //                    $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").remove();
    //                    $(this).find("td[data-field='QKMainTbl.QKTarget']").remove();
    //                    $(this).find("td[data-field='QKMainTbl.Status']").remove();
    //                    $(this).find("td[data-field='QKMainTbl.Operate']").remove();
    //                }
    //                k++;
    //            });
    //        }
    //    }
    //}

    //// 到款状态子表的显示判断
    //var rowp = 0;
    //var dtl = $.MvcSheetUI.GetElement("DKStatusTbl").SheetGridView();
    //var len = dtl.RowCount;
    //var QKSeq = "";
    //if (len > 0) {
    //    for (var i = 0; i < len; i++) {

    //        if (QKSeq == "" || QKSeq != $.MvcSheetUI.GetControlValue("DKStatusTbl.QKSeq", i + 1)) {
    //            QKSeq = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKSeq", i + 1);
    //            var SeqCnt = $.MvcSheetUI.GetControlValue("DKStatusTbl.SeqCnt", i + 1);
    //            var k = 0;
    //            $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='DKStatusTbl.QKSeq']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DKStatusTbl.QKTarget']").attr("rowspan", SeqCnt);
    //                }
    //                k++;
    //            });
    //        } else {
    //            QKSeq = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKSeq", i + 1);
    //            var k = 0;
    //            $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='DKStatusTbl.QKSeq']").remove();
    //                    $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").remove();
    //                    $(this).find("td[data-field='DKStatusTbl.QKTarget']").remove();
    //                }
    //                k++;
    //            });
    //        }
    //    }
    //}

    //// 到款记录子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='DKRecordTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("DKRecordTbl.Status", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("DKRecordTbl.RejectFlg", rowp);
    //    var DisplayName = $.MvcSheetUI.GetControlValue("DKRecordTbl.DisplayName", rowp);

    //    if (DisplayName == "驳回 ") {
    //        $(this).find("td[data-field='DKRecordTbl.Operate'] a.updateDK").show();
    //    } else {
    //        $(this).find("td[data-field='DKRecordTbl.Operate'] a.updateDK").hide();
    //    }

    //});

    //// 付款子表的合并单元格操作
    //var dtl = $.MvcSheetUI.GetElement("FKRecordTbl").SheetGridView();
    //var len = dtl.RowCount;
    //var TheNo = "";
    //if (len > 0) {
    //    for (var i = 0; i < len; i++) {

    //        if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1)) {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1);
    //            var Cnt = $.MvcSheetUI.GetControlValue("FKRecordTbl.Cnt", i + 1);
    //            var DisplayName = $.MvcSheetUI.GetControlValue("FKRecordTbl.DisplayName", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKRecordTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKRecordTbl.TheNo']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.ConvertAmount']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.FKDate']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.Content']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.PayType']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.Receiver']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.DisplayName']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTbl.Operate']").attr("rowspan", Cnt);
    //                    if (DisplayName == "驳回 ") {
    //                        $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").show();
    //                    } else {
    //                        if (DisplayName == "草稿 ") {
    //                            $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").show();
    //                        } else {
    //                            $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").hide();
    //                        }
    //                    }
    //                }
    //                k++;
    //            });
    //        } else {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKRecordTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKRecordTbl.TheNo']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.ConvertAmount']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.FKDate']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.Content']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.PayType']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.Receiver']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.DisplayName']").remove();
    //                    $(this).find("td[data-field='FKRecordTbl.Operate']").remove();
    //                }
    //                k++;
    //            });
    //        }
    //    }
    //}

    //// 拒付付款子表的合并单元格操作
    //var dtl = $.MvcSheetUI.GetElement("FKJFRecordTbl").SheetGridView();
    //var len = dtl.RowCount;
    //var TheNo = "";
    //if (len > 0) {
    //    for (var i = 0; i < len; i++) {

    //        if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1)) {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1);
    //            var Cnt = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.Cnt", i + 1);
    //            var DisplayName = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.DisplayName", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKJFRecordTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKJFRecordTbl.TheNo']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.ConvertAmount']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.FKDate']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.Content']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.PayType']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.Receiver']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.DisplayName']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKJFRecordTbl.Operate']").attr("rowspan", Cnt);
    //                    if (DisplayName == "驳回 ") {
    //                        $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").show();
    //                    } else {
    //                        if (DisplayName == "草稿 ") {
    //                            $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").show();
    //                        } else {
    //                            $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").hide();
    //                        }
    //                    }
    //                }
    //                k++;
    //            });
    //        } else {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKJFRecordTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKJFRecordTbl.TheNo']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.ConvertAmount']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.FKDate']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.Content']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.PayType']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.Receiver']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.DisplayName']").remove();
    //                    $(this).find("td[data-field='FKJFRecordTbl.Operate']").remove();
    //                }
    //                k++;
    //            });
    //        }
    //    }
    //}

    //// 结算中的到款记录子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.Status", rowp);
    //    if (Status == "已结算") {
    //        $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("settled");
    //    } else if (Status == "不必结算") {
    //        $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("nonSettlement");
    //    } else {
    //        $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("unsettled");
    //    }
    //});

    //// 结算中的付款子表的合并单元格操作
    //var dtl = $.MvcSheetUI.GetElement("FKRecordTblOfJS").SheetGridView();
    //var len = dtl.RowCount;
    //var TheNo = "";
    //if (len > 0) {
    //    for (var i = 0; i < len; i++) {

    //        if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1)) {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1);
    //            var Cnt = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.Cnt", i + 1);
    //            var Status = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.Status", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKRecordTblOfJS']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKRecordTblOfJS.TheNo']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTblOfJS.ConvertAmount']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Content']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Receiver']").attr("rowspan", Cnt);
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Status']").attr("rowspan", Cnt);
    //                    if (Status == "已结算") {
    //                        $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("settled");
    //                    } else if (Status == "不必结算") {
    //                        $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("nonSettlement");
    //                    } else {
    //                        $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("unsettled");
    //                    }
    //                }
    //                k++;
    //            });
    //        } else {
    //            TheNo = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1);
    //            var k = 0;
    //            $("[data-datafield='FKRecordTblOfJS']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='FKRecordTblOfJS.TheNo']").remove();
    //                    $(this).find("td[data-field='FKRecordTblOfJS.ConvertAmount']").remove();
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Content']").remove();
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Receiver']").remove();
    //                    $(this).find("td[data-field='FKRecordTblOfJS.Status']").remove();
    //                }
    //                k++;
    //            });
    //        }
    //    }
    //}

    //// 结算记录子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='JSRecordTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("JSRecordTbl.Status", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("JSRecordTbl.RejectFlg", rowp);
    //    var DisplayName = $.MvcSheetUI.GetControlValue("JSRecordTbl.DisplayName", rowp);
    //    if (DisplayName.indexOf("完成")>0) {
    //        $(this).find("td[data-field='JSRecordTbl.DisplayName']").addClass("settled");
    //    } else {
    //        $(this).find("td[data-field='JSRecordTbl.DisplayName']").addClass("unsettled");
    //    }

    //    if (DisplayName == "驳回" || DisplayName == "草稿") {
    //        $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").show();
    //        $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
    //        $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
    //    } else {
    //        if (DisplayName == "待请款") {
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
    //            if (Status == "") {
    //                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").show();
    //            } else {
    //                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
    //            }
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
    //        } else if (DisplayName == "待付款") {
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
    //            if (Status == "") {
    //                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").show();
    //            } else {
    //                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
    //            }
    //        } else {
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
    //            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
    //        }
    //    }

    //});
    

    //// 到货子表的合并单元格操作
    //var dtl_dh = $.MvcSheetUI.GetElement("DHTbl").SheetGridView();
    //var len_dh = dtl_dh.RowCount;
    //var DHSeq = "";
    //if (len_dh > 0) {
    //    for (var i = 0; i < len_dh; i++) {

    //        if (DHSeq == "" || DHSeq != $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1)) {
    //            DHSeq = $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1);
    //            var SeqCnt = $.MvcSheetUI.GetControlValue("DHTbl.SeqCnt", i + 1);
    //            var RejectFlg = $.MvcSheetUI.GetControlValue("DHTbl.RejectFlg", i + 1);
    //            var DisplayName = $.MvcSheetUI.GetControlValue("DHTbl.DisplayName", i + 1);
    //            var k = 0;
    //            $("[data-datafield='DHTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='DHTbl.TheNo']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.DHType']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.DHSeq']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.ShippingType']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.Supplier']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.DisplayName']").attr("rowspan", SeqCnt);
    //                    $(this).find("td[data-field='DHTbl.Operate']").attr("rowspan", SeqCnt);
    //                    if (RejectFlg == "1" || DisplayName == "草稿 ") {
    //                        $(this).find("td[data-field='DHTbl.Operate'] a.updateDH").show();
    //                    } else {
    //                        $(this).find("td[data-field='DHTbl.Operate'] a.updateDH").hide();
    //                    }
    //                }
    //                k++;
    //            });
    //        } else {
    //            DHSeq = $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1);
    //            var k = 0;
    //            $("[data-datafield='DHTbl']").find("tr.rows").each(function () {
    //                if (k == i) {
    //                    $(this).find("td[data-field='DHTbl.TheNo']").remove();
    //                    $(this).find("td[data-field='DHTbl.DHType']").remove();
    //                    $(this).find("td[data-field='DHTbl.DHSeq']").remove();
    //                    $(this).find("td[data-field='DHTbl.ShippingType']").remove();
    //                    $(this).find("td[data-field='DHTbl.Supplier']").remove();
    //                    $(this).find("td[data-field='DHTbl.DisplayName']").remove();
    //                    $(this).find("td[data-field='DHTbl.Operate']").remove();
    //                }
    //                k++;
    //            });
    //        }


    //    }
    //}

    //// 合同变更子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='BGTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("BGTbl.Status", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("BGTbl.RejectFlg", rowp);
    //    var DisplayName = $.MvcSheetUI.GetControlValue("BGTbl.DisplayName", rowp);

    //    if (Status == "4") {
    //        if (RejectFlg == "1" || DisplayName == "草稿 ") {
    //            $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").show();
    //        } else {
    //            $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").hide();
    //        }
    //    } else {
    //        if (RejectFlg == "1" || DisplayName == "草稿 ") {
    //            $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").show();
    //        } else {
    //            $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").hide();
    //        }
    //    }

    //});

    //// 保函子表的显示判断
    //var rowp = 0;
    //$("[data-datafield='BHTbl']").find("tr.rows").each(function () {
    //    rowp++;
    //    var Status = $.MvcSheetUI.GetControlValue("BHTbl.Status", rowp);
    //    var RejectFlg = $.MvcSheetUI.GetControlValue("BHTbl.RejectFlg", rowp);
    //    var DisplayName = $.MvcSheetUI.GetControlValue("BHTbl.TBStatus", rowp);

    //    if (DisplayName == "未退") {
    //        $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
    //    } else if (DisplayName == "驳回 ") {
    //        $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
    //    } else if (DisplayName == "审批中" || DisplayName == "确认中") {
    //        $(this).find("td[data-field='BHTbl.Edit'] a.editBH").hide();
    //        $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
    //        $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
    //    } else if (DisplayName == "没收" || DisplayName == "已退") {
    //        $(this).find("td[data-field='BHTbl.Edit'] a.editBH").hide();
    //        $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
    //        $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
    //    }

    //});

    

    // 资金计划子表不能编辑
    $("input[data-datafield='ZJPlanMainTbl.Content']").attr("disabled", "disabled");
    $("input[data-datafield='ZJPlanMainTbl.QKCurrency']").attr("disabled", "disabled");
    $("input[data-datafield='ZJPlanMainTbl.ExpirationFrom']").attr("disabled", "disabled");
    $("input[data-datafield='ZJPlanMainTbl.ExpirationTo']").attr("disabled", "disabled");
    $("input[data-datafield='ZJPlanMainTbl.IsAfterDK']").attr("disabled", "disabled");
    $("input[data-datafield='ZJPlanMainTbl.Amount']").attr("disabled", "disabled");

    // 合同文件归档子表的显示判断
    var rowp = 0;
    $("[data-datafield='ContractFileArchiveTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("ContractFileArchiveTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("ContractFileArchiveTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("ContractFileArchiveTbl.DisplayName", rowp);

        if (DisplayName == "驳回 ") {
            $(this).find("td[data-field='ContractFileArchiveTbl.Operate'] a.updateGD").show();
        } else {
            $(this).find("td[data-field='ContractFileArchiveTbl.Operate'] a.updateGD").hide();
        }

    });
    if (rowp > 0) {
        $("#GDContractFileId").hide();
    } else {
        $("#GDContractFileId").show();
    }
  // 合同变更归档子表的显示判断
    var rowp = 0;
    $("[data-datafield='ChangeArchiveTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("ChangeArchiveTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("ChangeArchiveTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("ChangeArchiveTbl.DisplayName", rowp);

        if (DisplayName == "驳回 ") {
            $(this).find("td[data-field='ChangeArchiveTbl.Operate'] a.updateGDChange").show();
        } else {
            $(this).find("td[data-field='ChangeArchiveTbl.Operate'] a.updateGDChange").hide();
        }

    });
    if (rowp > 0) {
        $("#GDChangeContractFileId").hide();
    } else {
        $("#GDChangeContractFileId").show();
    }
    // 审签节点中显示不显示
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var ContractType = "";
    var ContractProperty = "";
    var AgencyType = "";
    if (ContractNo != null && ContractNo != "") {
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            //async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret.ContractNo != null && ret.ContractNo != "") {
                    ContractType = ret.ContractType;
                    ContractProperty = ret.ContractProperty;
                    AgencyType = ret.AgencyType;
                    if (ContractType == "国内合同") {
                        $(".NotHYDiv").show();
                        $(".HYDiv").hide();
                        $(".JKDiv").hide();
                    } else if (ContractType == "进口合同") {
                        if (ContractProperty == "航空煤油") {
                            $(".NotHYDiv").hide();
                            $(".HYDiv").show();
                            $("input[data-datafield='JKTotalAmount']").attr("disabled", "disabled");

                            //当为航空煤油时禁用支付管理按钮
                            var List = $('.nav-tabs li').find('a');
                            for (var i = 0; i < List.length; i++) {
                                if ($(List[i]).html() == '支付管理' ) {
                                    $(List[i]).removeAttr('href');
                                    $(List[i]).addClass('disableBtn');
                                }
                            }

                        } else {
                            $(".NotHYDiv").show();
                            $(".HYDiv").hide();
                        }
                        $(".JKDiv").show();
                    }

                    if (AgencyType == '不需要' || AgencyType == '') {
                        $('.AgencySelect').hide();
                        $('.AgencyAfterRemark').hide();
                        $('.AgencyComment').hide();
                    } else if (AgencyType == '已审') {
                        if (ContractProperty == '航空煤油') {
                            $('.AgencySelect').hide();
                        } else {
                            $('.AgencySelect').show();
                        }
                        $('.AgencyAfterRemark').hide();
                        $('.AgencyComment').show();
                    } else if (AgencyType == '后审') {
                        $('.AgencySelect').hide();
                        $('.AgencyAfterRemark').show();
                        $('.AgencyComment').hide();
                    }


                    // 归档
                    if (ContractType == "国内合同") {
                        if (AgencyType == '后审') {
                            $(".GDAgencyShow").show();
                        } else {
                            $(".GDAgencyShow").hide();
                        }
                    } else {
                        if (ContractProperty == "航空煤油") {
                            $(".GDAgencyShow").hide();
                        } else {
                            if (AgencyType == '后审') {
                                $(".GDAgencyShow").show();
                            } else {
                                $(".GDAgencyShow").hide();
                            }
                        }
                    }
                }
            }
        });
    }
    getQKs();
    
    // 是否变更过合同，变更过则可提交变更签证版文件
    var dtl = $.MvcSheetUI.GetElement("BGTbl").SheetGridView();
    if (dtl.RowCount > 0) {
        $(".GDChangeShow").show();
    } else {
        $(".GDChangeShow").hide();
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackMainTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    $(".divContent_Tab div[data-title='征询意见']").parent().hide();

    // 查看（View）、编辑（Work）
    var Permission = getUrlParam("Permission");
    if (Permission == "View") {
        // 不显示保存提交按钮
        $("li[data-action='Save']").hide();
        $("li[data-action='Submit']").hide();
        $("li[data-action='Forward']").hide();
        // 页面输入项都禁止输入
        $("input").attr("disabled", true);
        $("select").attr("disabled", true);
        $("textarea").attr("disabled", true);
        // 生成合同号、申请修改合同号按钮 不显示
        $("#generateContractNoId").hide();
        $("#ApplyContractNoId").hide();
        // 审批申请按钮 不显示
        $("#ApplyApproveId").hide();
        // 信用证
        $("#ApprovePaymentId").hide();
        // 进口许可证
        $("#ApproveImportLicenseId").hide();
        // 到货
        $("#ApproveDHId").hide();
        // 合同变更
        $("#ApproveBGId").hide();
        // 合同归档
        $("#GDContractFileId").hide();
        $("#GDChangeContractFileId").hide();
        // 保函
        $("#ApproveBHId").hide();
        // 资金计划
        $("#EditZJPlanId").hide();
        // 请款
        $("#ApproveQKId").hide();
        // 到款
        if (IsDKRole("发起到款角色") == "true") {
            $("#ApproveDKId").attr("disabled", false);
            $("#ApproveDKId").show();
        } else {
            $("#ApproveDKId").hide();
        }
        // 付款
        $("#ApproveFKId").hide();
        // 结算
        $("#ApproveJSId").hide();
        // 支付管理
        $("table[data-datafield='PayManagerTbl'] :checkbox").attr("disabled", true);
    }
    // 金额显示千分位
    $('.AmountFormat').blur();
}

function IsDKRole(role) {
    var r = "false";
    var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=IsDKRole",   //处理页的相对地址
        data: {
            role: role,
            UserID: CurrentUser.ObjectID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            r = ret;
        }
    });
    return r;
}

// 点击执行中的各个图片
function clickToggle(Type, opflg) {
    $('.bannerTitle' + Type).next().show();
    if (opflg == "1") {
        $('.bt_progress_child_long1').removeClass("bt_progress_child_long1").addClass("bt_progress_child_long2");
        $('.operateChild' + Type).removeClass("bt_progress_child_long2").addClass("bt_progress_child_long1");
    }
    $('.Operate' + Type).click();
}

// 生成合同号
function generateContractNo() {
    // 合同类型
    var ContractType = $.MvcSheetUI.GetControlValue("ContractType");
    // 合同性质
    var ContractProperty = $.MvcSheetUI.GetControlValue("ContractProperty");
    // 项目编码
    var ProjectCode = $.MvcSheetUI.GetControlValue("ProjectCode");
    // 子工程编码
    var SubProjectCode = $.MvcSheetUI.GetControlValue("SubProjectCode");
    // 国别编码
    var Country = $.MvcSheetUI.GetControlValue("Country");
    if (ContractType == "") {
        layer.alert('请选择合同类型！', { icon: 2 });
    } else if (ContractProperty == "") {
        layer.alert('请选择合同性质！', { icon: 2 });
    }
    //else if (SubProjectCode == "") {
    //    layer.alert('请选择最终用户！', { icon: 2 });
    //}
    else {
        if (ContractType == "JK" && Country == "") {
            layer.alert('请选择国别！', { icon: 2 });
        } else {
            //给合同号申请成功标识符赋值
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=generateContractNo",   //处理页的相对地址
                data: {
                    ContractType: ContractType,
                    ContractProperty: ContractProperty,
                    ProjectCode: ProjectCode,
                    SubProjectCode: SubProjectCode,
                    Country: Country,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("ContractNo", ret);

                }
            });
        }
        
    }

}
// 申请修改合同号
function ApplyContractNo() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var ContractName = $.MvcSheetUI.GetControlValue("ContractName");
    var ContractObjectID = $.MvcSheetUI.SheetInfo.BizObjectID;
    var canUpdateFlg = true;
    //判断当前合同号是否有数据（是否进行保存过）
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.ContractNo == null || ret.ContractNo == '') {
                layer.alert('合同号还不存在，无法申请修改（请先进行保存）！', { icon: 2 });
                canUpdateFlg = false;
            }
        }
    });
    if (canUpdateFlg) {
        //判断当前合同号是否正在审批中
        var dtl = $.MvcSheetUI.GetElement("UpdateNoTbl").SheetGridView();
        var len = dtl.RowCount;
        if (len > 0 && $.MvcSheetUI.GetControlValue("UpdateNoTbl.Status", 1) == "审批中") {
            layer.alert('当前有正在审批中的数据，不能进行申请！', { icon: 2 });
            return false;
        }
        var WorkflowVersion_Update = $.MvcSheetUI.GetControlValue("WorkflowVersion_Update");
        // window.location.href = "/Portal/StartInstance.html?WorkflowCode=Apply2&ContractNo=" + ContractNo + "&ContractName=" + ContractName;
        //window.location.href = "/Portal/MvcDefaultSheet.aspx?SheetCode=UpdateContractNoMy&Mode=Originate&WorkflowCode=UpdateContractNo&WorkflowVersion=" + WorkflowVersion_Update + "&ContractNo=" + ContractNo + "&ContractName=" + ContractName;
        window.location.href = "/Portal/Sheets/Contract/UpdateContractNoMy.aspx?Mode=Originate&WorkflowCode=UpdateContractNo&WorkflowVersion=" + WorkflowVersion_Update + "&ContractObjectID=" + ContractObjectID;

    }
}

// 申请审签
function ApplyApprove() {
    //判断当前合同是否已经申请过审签
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    //var ContractFileCount = 0;
    //var TalkFileCount = 0;
    //$("div[data-datafield='ContractFile']").find(".LongWord").each(function () {
    //    ContractFileCount++;
    //}); 
    //if (ContractFileCount == 0) {
    //    layer.alert('请上传合同文本！', { icon: 2 });
    //    return false;
    //}
    //$("div[data-datafield='TalkFile']").find(".LongWord").each(function () {
    //    TalkFileCount++;
    //}); 
    //if (TalkFileCount == 0) {
    //    layer.alert('请上传合同谈判小结！', { icon: 2 });
    //    return false;
    //}

    var ContractFile = $("#ContractFile").xnfile("value");
    $.MvcSheetUI.SetControlValue("ContractFile", ContractFile);
    if (ContractFile == "") {
        layer.alert('请上传合同文本！', { icon: 2 });
        return false;
    }
    var TalkFile = $("#TalkFile").xnfile("value");
    $.MvcSheetUI.SetControlValue("TalkFile", TalkFile);
    if (TalkFile == "") {
        layer.alert('请上传合同谈判小结！', { icon: 2 });
        return false;
    }

  
    
    var canApproveFlg = true;
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getBizStatusOfContract",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            BizNo: "ContractApprove",
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret == null || ret == '') {
                canApproveFlg = true;
            } else {
                canApproveFlg = false;
                layer.alert('当前有正在申请中的数据，不能进行申请！', { icon: 2 });
            }
        }
    });

    if (canApproveFlg == true) {
        var ContractProperty = $.MvcSheetUI.GetControlValue("ContractProperty");
        var IsCompAgencyFeeByContPrice = $.MvcSheetUI.GetControlValue('IsCompAgencyFeeByContPrice');
        if ($.MvcSheetUI.GetControlValue('AgencyReturnType') == '人民币' || ContractProperty == "ContractProperty_HKMY") {
            $.MvcSheetUI.SetControlValue("ToApproveSubFlg", "true");
            $.MvcSheet.Save(this);
        } else if ($.MvcSheetUI.GetControlValue('AgencyReturnType') == '百分比') {
            if (IsCompAgencyFeeByContPrice != "") {
                $.MvcSheetUI.SetControlValue("ToApproveSubFlg", "true");
                $.MvcSheet.Save(this);
            } else {
                // 没勾选时需要弹出框确认一下
                layer.confirm('确认不按合同价计算代理费？', function (index) {
                    $.MvcSheetUI.SetControlValue("ToApproveSubFlg", "true");
                    $.MvcSheet.Save(this);
                });
            }
        } else {
            $.MvcSheetUI.SetControlValue("ToApproveSubFlg", "true");
            $.MvcSheet.Save(this);
        }

        
        
        //// 提交（不弹出确认框）
        //$.MvcSheet.Submit2(this);
       // 审签后重新调整回参与者，否则会回到按流程中设置的发起人
        //AdjustActivity("ActivityApprove");
        //var url = "";
        //$.ajax({
        //    type: "POST",    //页面请求的类型
        //    url: "ContractHandler.ashx?Command=getWorkItemIDByICPID",   //处理页的相对地址
        //    data: {
        //        InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
        //    },
        //    async: false,
        //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
        //        if (ret == null || ret == '') {
        //            alert("跳转失败，请尝试手动进入审签子页面！");
        //        } else {
        //            // 跳转到审签子页面
        //            url = "/Portal/Sheets/Contract/ContractApproveMy.aspx?Mode=Work&WorkItemID=" + ret;
        //        }
        //    }
        //});
        //window.location.href = url;
    // 提交(jqury 提交)
    //$(".navbar-inner [data-action='Submit']").click();

        // 发起审签子页面
        //var WorkflowVersion_Approve = $.MvcSheetUI.GetControlValue("WorkflowVersion_Approve");
        //window.location.href = "/Portal/Sheets/Contract/ContractApproveMy.aspx?Mode=Originate&WorkflowCode=ContractApprove&WorkflowVersion=" + WorkflowVersion_Approve + "&ContractNo=" + ContractNo;

   }

}


// 申请信用证
function ApprovePayment() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_Payment = $.MvcSheetUI.GetControlValue("WorkflowVersion_Payment");
    window.location.href = "/Portal/Sheets/Contract/PaymentMy.aspx?Mode=Originate&WorkflowCode=PaymentSub&WorkflowVersion=" + WorkflowVersion_Payment + "&ContractNo=" + ContractNo;

}

// 申请进口许可证
function ApproveImportLicense() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_ImportLicense = $.MvcSheetUI.GetControlValue("WorkflowVersion_ImportLicense");
    window.location.href = "/Portal/Sheets/Contract/ImportLicenseMy.aspx?Mode=Originate&WorkflowCode=ImportLicenseSub&WorkflowVersion=" + WorkflowVersion_ImportLicense + "&ContractNo=" + ContractNo;
}

// 申请到货
function ApproveDH() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var ContractProperty = $.MvcSheetUI.GetControlValue("ContractProperty");
    var WorkflowVersion_DH = $.MvcSheetUI.GetControlValue("WorkflowVersion_DH");
    var WorkflowVersion_DHHY = $.MvcSheetUI.GetControlValue("WorkflowVersion_DHHY");
    if (ContractProperty == "ContractProperty_HKMY") {
        window.location.href = "/Portal/Sheets/Contract/DHHYMy.aspx?Mode=Originate&WorkflowCode=DHHY&WorkflowVersion=" + WorkflowVersion_DHHY + "&ContractNo=" + ContractNo + "&IsHYFlg=1";
    } else {
        window.location.href = "/Portal/Sheets/Contract/DHMy.aspx?Mode=Originate&WorkflowCode=DH&WorkflowVersion=" + WorkflowVersion_DH + "&ContractNo=" + ContractNo + "&IsHYFlg=1";
    }
}

// 申请合同变更
function ApproveBG() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_BG = $.MvcSheetUI.GetControlValue("WorkflowVersion_BG");
    window.location.href = "/Portal/Sheets/Contract/BGMy.aspx?Mode=Originate&WorkflowCode=BG&WorkflowVersion=" + WorkflowVersion_BG + "&ContractNo=" + ContractNo ;
}

// 申请保函(录保)
function ApproveBH() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_BHInput = $.MvcSheetUI.GetControlValue("WorkflowVersion_BHInput");
    window.location.href = "/Portal/Sheets/Contract/BHInputMy.aspx?Mode=Originate&WorkflowCode=BHInput&WorkflowVersion=" + WorkflowVersion_BHInput + "&ContractNo=" + ContractNo;
}

// 申请合同文件归档
function ApplyFileGD() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_GD = $.MvcSheetUI.GetControlValue("WorkflowVersion_GD");
    window.location.href = "/Portal/Sheets/Contract/GDMy.aspx?Mode=Originate&WorkflowCode=GD&WorkflowVersion=" + WorkflowVersion_GD + "&ContractNo=" + ContractNo ;
}

// 申请合同变更归档
function ApplyFileGDChange() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_GDChange = $.MvcSheetUI.GetControlValue("WorkflowVersion_GDChange");
    window.location.href = "/Portal/Sheets/Contract/GDChangeMy.aspx?Mode=Originate&WorkflowCode=GDChange&WorkflowVersion=" + WorkflowVersion_GDChange + "&ContractNo=" + ContractNo ;
}



// 申请请款
function ApproveQK() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_QK = $.MvcSheetUI.GetControlValue("WorkflowVersion_QK");
    window.location.href = "/Portal/Sheets/Contract/QKMy.aspx?Mode=Originate&WorkflowCode=QK&WorkflowVersion=" + WorkflowVersion_QK + "&ContractNo=" + ContractNo;
}

// 申请到款
function ApproveDK() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_DK = $.MvcSheetUI.GetControlValue("WorkflowVersion_DK");
    window.location.href = "/Portal/Sheets/Contract/DKMy.aspx?Mode=Originate&WorkflowCode=DK&WorkflowVersion=" + WorkflowVersion_DK + "&ContractNo=" + ContractNo;
}

// 申请付款
function ApproveFK() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_FK = $.MvcSheetUI.GetControlValue("WorkflowVersion_FK");
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=Originate&WorkflowCode=FK&WorkflowVersion=" + WorkflowVersion_FK + "&ContractNo=" + ContractNo;
}

// 申请结算
function ApproveJS() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_JS = $.MvcSheetUI.GetControlValue("WorkflowVersion_JS");
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=Originate&WorkflowCode=JS&WorkflowVersion=" + WorkflowVersion_JS + "&ContractNo=" + ContractNo;
}


// 
function EmailSalerChange() {
    var dtl = $.MvcSheetUI.GetElement('SalerTbl').SheetGridView();
    var len = dtl.RowCount;
    var CompanyNameSaler = $.MvcSheetUI.GetControlValue('CompanyNameSaler');
    var ContactNameSaler = $.MvcSheetUI.GetControlValue('ContactNameSaler');
    var TelephoneSaler = $.MvcSheetUI.GetControlValue('TelephoneSaler');
    var MobileSaler = $.MvcSheetUI.GetControlValue('MobileSaler');
    var FaxSaler = $.MvcSheetUI.GetControlValue('FaxSaler');
    var EmailSaler = $.MvcSheetUI.GetControlValue('EmailSaler');
    // check 是否选择的联系人为同一个卖方
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            var CompanyName = $.MvcSheetUI.GetControlValue("SalerTbl.CompanyName", i + 1);
            if (CompanyNameSaler == CompanyName) {
                //alert("同一个卖方只能选择一个联系人！");
                //return false; 不能用return false，会触发两次onchange事件
                return;
            }
        }
    }
    dtl._AddRow();

    $.MvcSheetUI.SetControlValue("SalerTbl.CompanyName", CompanyNameSaler, len + 1);
    $.MvcSheetUI.SetControlValue("SalerTbl.ContactName", ContactNameSaler, len + 1);
    $.MvcSheetUI.SetControlValue("SalerTbl.Telephone", TelephoneSaler, len + 1);
    $.MvcSheetUI.SetControlValue("SalerTbl.Mobile", MobileSaler, len + 1);
    $.MvcSheetUI.SetControlValue("SalerTbl.Fax", FaxSaler, len + 1);
    $.MvcSheetUI.SetControlValue("SalerTbl.Email", EmailSaler, len + 1);
    $("input[data-datafield='SalerTbl.CompanyName']").attr("disabled", "disabled");
    $("input[data-datafield='SalerTbl.ContactName']").attr("disabled", "disabled");
    $("input[data-datafield='SalerTbl.Telephone']").attr("disabled", "disabled");
    $("input[data-datafield='SalerTbl.Mobile']").attr("disabled", "disabled");
    $("input[data-datafield='SalerTbl.Fax']").attr("disabled", "disabled");
    $("input[data-datafield='SalerTbl.Email']").attr("disabled", "disabled");
    $.MvcSheetUI.SetControlValue('Salers', $.MvcSheetUI.GetControlValue('Salers') + CompanyNameSaler + ';')
    return;
}

function BidPriceHideChange() {
    var dtl = $.MvcSheetUI.GetElement('BidTbl').SheetGridView();
    var len = dtl.RowCount;
    var ProjectShortNameHide = $.MvcSheetUI.GetControlValue('ProjectShortNameHide');
    var BidNoHide = $.MvcSheetUI.GetControlValue('BidNoHide');
    var PackageNameHide = $.MvcSheetUI.GetControlValue('PackageNameHide');
    var TenderPriceNoHide = $.MvcSheetUI.GetControlValue('TenderPriceNoHide');
    var BidPriceHide = $.MvcSheetUI.GetControlValue('BidPriceHide');
    // check 是否选择的联系人为同一个卖方
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            var ProjectName = $.MvcSheetUI.GetControlValue("BidTbl.ProjectName", i + 1);
            var PackageName = $.MvcSheetUI.GetControlValue("BidTbl.PackageName", i + 1);
            var TenderPriceNo = $.MvcSheetUI.GetControlValue("BidTbl.TenderPriceNo", i + 1);
            // 不能选择两种不同的招标项目
            if (ProjectName != ProjectShortNameHide) {
                layer.alert('不能选择两种不同的招标项目！', { icon: 2 });
                return;
            }
            if (ProjectName == ProjectShortNameHide && PackageName == PackageNameHide && TenderPriceNo == TenderPriceNoHide) {
                //return false; 不能用return false，会触发两次onchange事件
                return;
            }
        }
    }
    dtl._AddRow();

    $.MvcSheetUI.SetControlValue("BidTbl.ProjectName", ProjectShortNameHide, len + 1);
    $.MvcSheetUI.SetControlValue("BidTbl.ProjectName", ProjectShortNameHide, len + 1);
    $.MvcSheetUI.SetControlValue("BidTbl.PackageName", PackageNameHide, len + 1);
    $.MvcSheetUI.SetControlValue("BidTbl.TenderPriceNo", TenderPriceNoHide, len + 1);
    $.MvcSheetUI.SetControlValue("BidTbl.BidPrice", BidPriceHide, len + 1);
    $("input[data-datafield='BidTbl.ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='BidTbl.PackageName']").attr("disabled", "disabled");
    $("input[data-datafield='BidTbl.TenderPriceNo']").attr("disabled", "disabled");
    $("input[data-datafield='BidTbl.BidPrice']").attr("disabled", "disabled");
    $.MvcSheetUI.SetControlValue('BidNo', BidNoHide)
    return;


    var dtl = $.MvcSheetUI.GetElement('BidTbl').SheetGridView();
    dtl._Clear();
    dtl._AddRow();
    var ProjectShortNameHide = $.MvcSheetUI.GetControlValue('ProjectShortNameHide');
    var BidPriceHide = $.MvcSheetUI.GetControlValue('BidPriceHide');
    $.MvcSheetUI.SetControlValue('BidTbl.ProjectShortName', ProjectShortNameHide, 1);
    $.MvcSheetUI.SetControlValue('BidTbl.BidPrice', BidPriceHide, 1);
    $('input[data-datafield="BidTbl.ProjectShortName"]').attr('disabled', 'disabled');
    $('input[data-datafield="BidTbl.BidPrice"]').attr('disabled', 'disabled');
}
function setContractShortName() {
    var ProjectShortNameHidden = $.MvcSheetUI.GetControlValue('ProjectShortNameHidden');
    var SubProjectShortNameHidden = $.MvcSheetUI.GetControlValue('SubProjectShortNameHidden');
    $.MvcSheetUI.SetControlValue('ContractShortName', ProjectShortNameHidden + "(" + SubProjectShortNameHidden+") - ");
}
// 航油合同预设数据
function setDataFromHY() {
    var ContractProperty = $.MvcSheetUI.GetControlValue('ContractProperty');
    var IsFirstProperty = $.MvcSheetUI.GetControlValue('IsFirstProperty');
    /// 如果初始化载入，则不触发载入数据事件
    if (IsFirstProperty == "true") {
        $.MvcSheetUI.SetControlValue('IsFirstProperty',"false");
        return;
    }
    if (ContractProperty == 'ContractProperty_HKMY') {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getHYData",   //处理页的相对地址
            data: {
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret.ObjectID != null && ret.ObjectID != '') {
                    $.MvcSheetUI.SetControlValue("FinalUser", ret.FinalUser);
                    $.MvcSheetUI.SetControlValue("PostB", ret.PostB);
                    $.MvcSheetUI.SetControlValue("BidType", '0');
                    BidTypeChange();
                    $.MvcSheetUI.SetControlValue("BidNo", ret.BidNo);
                    $.MvcSheetUI.SetControlValue("ContractName", ret.ContractName);
                    $.MvcSheetUI.SetControlValue("ContractShortName", ret.ContractShortName);
                    $.MvcSheetUI.SetControlValue("ProjectName", ret.ProjectName);
                    $.MvcSheetUI.SetControlValue("SubProjectName", ret.SubProjectName);
                    $.MvcSheetUI.SetControlValue("SubProjectCode", ret.SubProjectCode);
                    //$.MvcSheetUI.SetControlValue("TradeMethod", ret.TradeMethod);
                    $.MvcSheetUI.SetControlValue("Country", ret.Country);
                    $.MvcSheetUI.SetControlValue("ContractRemark", ret.ContractRemark);

                    $.ajax({
                        type: "POST",    //页面请求的类型
                        url: "ContractHandler.ashx?Command=getSalesHYData",   //处理页的相对地址
                        data: {
                            ObjectID : ret.ObjectID
                        },
                        async: false,
                        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                            var dtl = $.MvcSheetUI.GetElement("SalerTbl").SheetGridView();
                            dtl._Clear();
                            for (var i = 0; i < ret.length; i++) {
                                dtl._AddRow();
                                $.MvcSheetUI.SetControlValue("SalerTbl.CompanyName", ret[i].CompanyName, i + 1);
                                $.MvcSheetUI.SetControlValue("SalerTbl.ContactName", ret[i].ContactName, i + 1);
                                $.MvcSheetUI.SetControlValue("SalerTbl.Telephone", ret[i].Telephone, i + 1);
                                $.MvcSheetUI.SetControlValue("SalerTbl.Mobile", ret[i].Mobile, i + 1);
                                $.MvcSheetUI.SetControlValue("SalerTbl.Fax", ret[i].Fax, i + 1);
                                $.MvcSheetUI.SetControlValue("SalerTbl.Email", ret[i].Email, i + 1);
                            }
                            $("input[data-datafield='SalerTbl.CompanyName']").attr("disabled", "disabled");
                            $("input[data-datafield='SalerTbl.ContactName']").attr("disabled", "disabled");
                            $("input[data-datafield='SalerTbl.Telephone']").attr("disabled", "disabled");
                            $("input[data-datafield='SalerTbl.Mobile']").attr("disabled", "disabled");
                            $("input[data-datafield='SalerTbl.Fax']").attr("disabled", "disabled");
                            $("input[data-datafield='SalerTbl.Email']").attr("disabled", "disabled"); 
                        }
                    });

                    $.MvcSheetUI.SetControlValue("Salers", ret.Salers);

                    //$.ajax({
                    //    type: "POST",    //页面请求的类型
                    //    url: "ContractHandler.ashx?Command=getBidsHYData",   //处理页的相对地址
                    //    data: {
                    //        ObjectID: ret.ObjectID
                    //    },
                    //    async: false,
                    //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    //        var dtl = $.MvcSheetUI.GetElement("BidTbl").SheetGridView();
                    //        dtl._Clear();
                    //        for (var i = 0; i < ret.length; i++) {
                    //            dtl._AddRow();
                    //            $.MvcSheetUI.SetControlValue("BidTbl.ProjectShortName", ret[i].ProjectShortName, i + 1);
                    //            $.MvcSheetUI.SetControlValue("BidTbl.BidPrice", ret[i].BidPrice, i + 1);
                    //        }
                    //        $("input[data-datafield='BidTbl.ProjectShortName']").attr("disabled", "disabled");
                    //        $("input[data-datafield='BidTbl.BidPrice']").attr("disabled", "disabled");
                    //    }
                    //});
                }
            }
        });
    }
}

function viewUpdateNo(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('UpdateNoTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/UpdateContractNoMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

function viewApprove(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ContractApproveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/ContractApproveMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 信用证改证
function updatePaymentApprove(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var PaymentId = $.MvcSheetUI.GetControlValue('PaymentTbl.PaymentId', rowIndex - 1);
    var WorkflowVersion_PaymentUpdate = $.MvcSheetUI.GetControlValue("WorkflowVersion_PaymentUpdate");
    window.location.href = "/Portal/Sheets/Contract/PaymentUpdateMy.aspx?Mode=Originate&WorkflowCode=PaymentUpdateSub&WorkflowVersion=" + WorkflowVersion_PaymentUpdate + "&ContractNo=" + ContractNo + "&PaymentId=" + PaymentId;
}
// 信用证查看
function viewPayment(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('PaymentTbl.WorkItemId', rowIndex - 1);
    var TheNo = $.MvcSheetUI.GetControlValue('PaymentTbl.TheNo', rowIndex - 1);
    if (TheNo == "") {
        window.location.href = "/Portal/Sheets/Contract/PaymentUpdateMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    } else {
        window.location.href = "/Portal/Sheets/Contract/PaymentMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    }
    
}
// 信用证修改
function updatePayment(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('PaymentTbl.WorkItemId', rowIndex - 1);
    var TheNo = $.MvcSheetUI.GetControlValue('PaymentTbl.TheNo', rowIndex - 1);
    if (TheNo == "") {
        window.location.href = "/Portal/Sheets/Contract/PaymentUpdateMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    } else {
        window.location.href = "/Portal/Sheets/Contract/PaymentMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    }
}

// 进口许可证查看
function viewImportLicence(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ImportLicenceTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/ImportLicenseMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 进口许可证修改
function updateImportLicence(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ImportLicenceTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/ImportLicenseMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 进口许可证废除
function cancelImportLicence(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var ImportLicenseId = $.MvcSheetUI.GetControlValue('ImportLicenceTbl.ImportLicenseId', rowIndex - 1);
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=cancelImportLicence",   //处理页的相对地址
        data: {
            ImportLicenseId: ImportLicenseId,
            flg: "cancel",
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var rowp = 1;
            $("[data-datafield='ImportLicenceTbl']").find("tr.rows").each(function () {
                if (rowp == rowIndex - 1) {
                    $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").hide();
                    $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").show();
                    $(this).find("td[data-field='ImportLicenceTbl.DisplayName']").text("已废除");
                }
                rowp++;
            });
        }
    });
}

// 编辑资金计划
function EditZJPlan(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkItemId = $.MvcSheetUI.GetControlValue('PlanWorkItemId');
    var WorkflowVersion_Plan = $.MvcSheetUI.GetControlValue('WorkflowVersion_Plan');
    // 为空则发起流程，否则修改即可
    if (WorkItemId == "") {
        window.location.href = "/Portal/Sheets/Contract/ZJPlanMy.aspx?Mode=Originate&WorkflowCode=ZJPlan&WorkflowVersion=" + WorkflowVersion_Plan + "&ContractNo=" + ContractNo;
    } else {
        window.location.href = "/Portal/Sheets/Contract/ZJPlanMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    }
}

// 到货查看
function viewDH(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('DHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/DHMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 到货修改
function updateDH(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('DHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/DHMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 变更查看
function viewBG(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BGTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BGMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 变更修改
function updateBG(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BGTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BGMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 查看保函
function viewBH(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BHMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 编辑保函(录保数据)
function editBH(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BHTbl.InputWorkitemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BHInputMy.aspx?Mode=Work&WorkItemID=" + WorkItemId ;
}

// 修改保函
function updateBH(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BHMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 退保
function doTB(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_BH = $.MvcSheetUI.GetControlValue("WorkflowVersion_BH");
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var InputBizObjectID = $.MvcSheetUI.GetControlValue('BHTbl.InputBizObjectID', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/BHMy.aspx?Mode=Originate&WorkflowCode=BH&WorkflowVersion=" + WorkflowVersion_BH + "&ContractNo=" + ContractNo + "&InputBizObjectID=" + InputBizObjectID;
}

// 归档查看
function viewGD(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ContractFileArchiveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GDMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 归档修改
function updateGD(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ContractFileArchiveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GDMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 变更归档查看
function viewGDChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ChangeArchiveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GDChangeMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 变更归档修改
function updateGDChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('ChangeArchiveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GDChangeMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 回退查看
function viewBack(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackMainTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 请款查看
function viewQK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('QKMainTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/QKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 请款修改
function updateQK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('QKMainTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/QKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 到款查看
function viewDK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('DKRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/DKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 到款修改
function updateDK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('DKRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/DKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 付款查看
function viewFK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('FKRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 付款修改
function updateFK(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('FKRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 拒付付款查看
function viewFKJF(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('FKJFRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 拒付付款修改
function updateFKJF(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('FKJFRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}


// 结算查看
function viewJS(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('JSRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 结算修改
function updateJS(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('JSRecordTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
}

// 结算中进行请款申请
function updateJSQK(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_QK = $.MvcSheetUI.GetControlValue("WorkflowVersion_QK");
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var JSObjectID = $.MvcSheetUI.GetControlValue('JSRecordTbl.JSObjectID', rowIndex - 1);
    var JSResultNum = $.MvcSheetUI.GetControlValue('JSRecordTbl.JSResultNum', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/QKMy.aspx?Mode=Originate&WorkflowCode=QK&WorkflowVersion=" + WorkflowVersion_QK + "&ContractNo=" + ContractNo + "&QKType=JS&JSObjectID=" + JSObjectID + "&JSResultNum=" + JSResultNum;
}

// 结算中进行付款申请
function updateJSFK(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_FK = $.MvcSheetUI.GetControlValue("WorkflowVersion_FK");
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var JSObjectID = $.MvcSheetUI.GetControlValue('JSRecordTbl.JSObjectID', rowIndex - 1);
    var JSResultNum = $.MvcSheetUI.GetControlValue('JSRecordTbl.JSResultNum', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=Originate&WorkflowCode=FK&WorkflowVersion=" + WorkflowVersion_FK + "&ContractNo=" + ContractNo + "&FKType=ZKType_JS&JSObjectID=" + JSObjectID + "&JSResultNum=" + JSResultNum ;
}


function undocancelImportLicence(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var ImportLicenseId = $.MvcSheetUI.GetControlValue('ImportLicenceTbl.ImportLicenseId', rowIndex - 1);
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=cancelImportLicence",   //处理页的相对地址
        data: {
            ImportLicenseId: ImportLicenseId,
            flg: "undocancel",
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var rowp = 1;
            $("[data-datafield='ImportLicenceTbl']").find("tr.rows").each(function () {
                if (rowp == rowIndex - 1) {
                    $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").show();
                    $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").hide();
                    $(this).find("td[data-field='ImportLicenceTbl.DisplayName']").text("已办证");
                }
                rowp++;
            });
        }
    });
}

/*
    子表删除行事件
    参数：row -> 被删除的行
*/
var rowPreRemoved = function (row) {
    var rownum = row.attr("data-row");
    var CompanyName = $.MvcSheetUI.GetControlValue("SalerTbl.CompanyName", rownum);
    var Salers = $.MvcSheetUI.GetControlValue('Salers');
    $.MvcSheetUI.SetControlValue('Salers', Salers.replace(CompanyName + ";", ''))
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
                        if (CurActivity == "ActivityApprove") {
                            if (ret.InstanceActivity[i].ActivityName == "创建合同") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityOperate") {
                            if (ret.InstanceActivity[i].ActivityName == "创建合同") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "合同审签") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "创建合同") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "合同审签") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "合同执行") {
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
                    //$.MvcSheetUI.SetControlValue("NeedActivityCode", $("#ActivityCodes").val());
                    //$.MvcSheetUI.SetControlValue("NeedActivityName", $("#ActivityCodes").find("option:selected").text());
                    $.MvcSheetUI.SetControlValue("GetBackFlg", "1");
                    $('#message-module').modal('hide');
                    //doGoBack($("#ActivityCodes").val());
                    GotoBackPage("ContractMain", CurActivity);
                    
                });
            }
        });
    },
    //OnActionDone: function (ret) {

    
    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});

// 增加终止按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Icon: "fa-sign-in",           // 按钮图标
    Text: "终止",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        //让弹出框显示的操作方法
        $('#message-module').find('.modal-body').html(
            '<div style="text-align: center;padding: 50px;line-height: 25px">' +
            '确定终止合同吗？' +
            '</div > '
        );
        var moduleFooter = $('#message-module').find('.modal-footer');
        var cancleButton = $('<button type="button" class="btn" id="Btn_left" data-dismiss="modal">取消</button>');
        var confirmButton = $('<button type="button" class="btn btn-default" id="Btn_right">确定</button>');

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
            GotoCancelPage();

        });

    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});


//function GotoBackPage() {
//    var WorkflowVersion_Back = $.MvcSheetUI.GetControlValue("WorkflowVersion_Back");
//    var InstanceActivity = $("#ActivityCodes").val();
//    var InstanceId = $.MvcSheetUI.SheetInfo.InstanceId;
//    var InstanceName = "";
//    var CurInstanceActivity = $.MvcSheetUI.SheetInfo.ActivityCode;
//    $.ajax({
//        type: "POST",    //页面请求的类型
//        url: "ContractHandler.ashx?Command=getInstanceById",   //处理页的相对地址
//        data: {
//            InstanceId: InstanceId,
//        },
//        async: false,
//        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//            if (ret.InstanceName != undefined) {
//                InstanceName = ret.InstanceName;
//            }
//        }
//    });
//    if (InstanceName == "") {
//        layer.alert('合同流程还未发起，请先发起！', { icon: 2 });
//        return false;
//    }
//    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
//    if (InstanceActivity != "") {
//        window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=Originate&WorkflowCode=GetBackContract&WorkflowVersion=" + WorkflowVersion_Back + "&InstanceId=" + InstanceId + "&InstanceActivity=" + InstanceActivity + "&CurInstanceActivity=" + CurInstanceActivity + "&ContractNo=" + ContractNo;
//    } else {
//        layer.alert('请选择取回的节点！', { icon: 2 });
//        return false;
//    }
//}


function GotoCancelPage() {
    var WorkflowVersion_Cancel = $.MvcSheetUI.GetControlValue("WorkflowVersion_Cancel");
    var InstanceId = $.MvcSheetUI.SheetInfo.InstanceId;
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var InstanceName = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getInstanceById",   //处理页的相对地址
        data: {
            InstanceId: InstanceId,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.InstanceName != undefined) {
                InstanceName = ret.InstanceName;
            }
        }
    });
    if (InstanceName == "") {
        layer.alert('合同流程还未发起，请先发起！', { icon: 2 });
        return false;
    }
    window.location.href = "/Portal/Sheets/Contract/CancelMy.aspx?Mode=Originate&WorkflowCode=Cancel&WorkflowVersion=" + WorkflowVersion_Cancel + "&InstanceId=" + InstanceId + "&ContractNo=" + ContractNo;

}

function AgencyTypeChange() {
    if ($("select[data-datafield='AgencyType']").children('option:selected').val() == 'NotNeed') {
        $('.AgencySelect').hide();
        $('.AgencyAfterRemark').hide();
        $('.AgencyComment').hide();
    } else if ($("select[data-datafield='AgencyType']").children('option:selected').val() == 'Approved') {
        if ($.MvcSheetUI.GetControlValue('ContractProperty') == 'ContractProperty_HKMY') {
            $('.AgencySelect').hide();
        } else {
            $('.AgencySelect').show();
        }
        $('.AgencyAfterRemark').hide();
        $('.AgencyComment').show();
    } else if ($("select[data-datafield='AgencyType']").children('option:selected').val() == 'AfterApprove') {
        $('.AgencySelect').hide();
        $('.AgencyAfterRemark').show();
        $('.AgencyComment').hide();
    }
}

function AgencySelectChange() {
    // 代理协议返回类型（固定值）
    if ($.MvcSheetUI.GetControlValue('AgencyReturnType') == '人民币') {
        $.MvcSheetUI.SetControlValue('AgencyComment', "代理费计算：固定金额");
        $.MvcSheetUI.SetControlValue('AgencyArchiveComment', "代理费计算：固定金额");
        $('.IsCompAgencyFeeByContPrice').hide();
        $('.AgencyComment2').show();
    } else if ($.MvcSheetUI.GetControlValue('AgencyReturnType') == '百分比') {
        $('.IsCompAgencyFeeByContPrice').show();
        $('.AgencyComment2').hide();
    }
}

function IsCompAgencyFeeByContPriceChange() {
    // 没选，则按中标价
    if ($.MvcSheetUI.GetControlValue('IsCompAgencyFeeByContPrice') == '') {
        $.MvcSheetUI.SetControlValue('AgencyComment', "代理费计算：按中标价＊费率");
        $.MvcSheetUI.SetControlValue('AgencyArchiveComment', "代理费计算：按中标价＊费率");
    } else {
        // 选择了则按合同价计算代理费
        $.MvcSheetUI.SetControlValue('AgencyComment', "代理费计算：按合同价＊费率");
        $.MvcSheetUI.SetControlValue('AgencyArchiveComment', "代理费计算：按合同价＊费率");
    }
}

function compRMBAmount() {
    // 合同金额(人民币合同） + 总金额（外币） * 签约日汇率
    var ContractTotalPrice = $.MvcSheetUI.GetControlValue('ContractTotalPrice').replace(/,/g, '');
    ContractTotalPrice = ContractTotalPrice == "" ? 0 : ContractTotalPrice;
    var JKTotalAmount = $.MvcSheetUI.GetControlValue('JKTotalAmount').replace(/,/g, '');
    JKTotalAmount = JKTotalAmount == "" ? 0 : JKTotalAmount;
    var SignDayExchangeRate = $.MvcSheetUI.GetControlValue('SignDayExchangeRate');
    SignDayExchangeRate = SignDayExchangeRate == "" ? 0 : SignDayExchangeRate;
    $.MvcSheetUI.SetControlValue('RMBTotalAmount', (parseFloat(ContractTotalPrice) + parseFloat(JKTotalAmount) * parseFloat(SignDayExchangeRate)).toFixed(2));
    $('.AmountFormat').blur();
}

function ContractTypeChange() {
    if ($("select[data-datafield='ContractType']").children('option:selected').val() == 'GN') {
        //当为国内合同时禁用按钮
        var List = $('.nav-tabs li').find('a');
        for(var i=0;i<List.length;i++){
            if($(List[i]).html() =='信用证' || $(List[i]).html() =='进口许可证' || $(List[i]).html() =='到货'){
                $(List[i]).removeAttr('href');
                $(List[i]).addClass('disableBtn');
            }
        }
        $('.CountryTitle').hide();
        $('.CountrySelect').hide();
    } else {
        //进口合同时恢复
        var List = $('.nav-tabs li').find('a');
        for(var i=0;i<List.length;i++){
            if($(List[i]).html() =='信用证'){
                $(List[i]).attr('href','#xyztab');
                $(List[i]).removeClass('disableBtn');
            }else if($(List[i]).html() =='进口许可证'){
                $(List[i]).attr('href','#importlicensetab');
                $(List[i]).removeClass('disableBtn');
            }else if($(List[i]).html() =='到货'){
                $(List[i]).attr('href','#dhtab');
                $(List[i]).removeClass('disableBtn');
            }
        }
        $('.CountryTitle').show();
        $('.CountrySelect').show();
    }
}

function BidTypeChange() {
    var BidType = $.MvcSheetUI.GetControlValue('BidType');
    if (BidType == '0') {
        $.MvcSheetUI.SetControlValue('BidNo', '');
        $('.BidNo').hide();
        var dtl = $.MvcSheetUI.GetElement("BidTbl").SheetGridView();
        dtl._Clear();
    } else {
        $('.BidNo').show();
    }
}

function computePayManager() {
    var objDk = document.getElementById("selectDk");
    var dk_num = 0.0;
    for (var i = 0; i < objDk.options.length; i++) {
        if (objDk.options[i].selected) {
            if (objDk.options[i].innerHTML.indexOf("人民币") >= 0 ) {
                var amount = objDk.options[i].innerHTML.split("人民币")[0];
                dk_num += parseFloat(amount);
            }
        }
    }
    var objFk = document.getElementById("selectFk");
    var fk_num = 0.0;
    for (var i = 0; i < objFk.options.length; i++) {
        if (objFk.options[i].selected) {
            if (objFk.options[i].innerHTML.indexOf("人民币") >= 0) {
                var amount = objFk.options[i].innerHTML.split("人民币")[0];
                fk_num += parseFloat(amount);
            }
        }
    }
    var dif = dk_num - fk_num;
    var djsje = "";
    if (dif == 0) {
        djsje = 0;
    } else if (dif > 0) {
        djsje = "应退" + dif;
    } else if (dif < 0) {
        djsje = "应收" + dif*(-1);
    }
    $('#selectDjsje').val(djsje);
    
}

// 调整活动节点
function AdjustActivity(ActivityCode) {
    var InstanceID = $.MvcSheetUI.SheetInfo.InstanceId;
    //var ActivityCode = $.MvcSheetUI.SheetInfo.ActivityCode;
    var PostA = $.MvcSheetUI.GetControlValue("PostA");
    var PostB = $.MvcSheetUI.GetControlValue("PostB");
    //var participants = new Array();
    //participants.push(PostA);//("18f923a7-5a5e-426d-94ae-a55ad1a4b239");
    //participants.push(PostB);//("18f923a7-5a5e-426d-94ae-a55ad1a4b239");
    // 根据流程名获取流程节点数据
    //$.ajax({
    //    type: "POST",    //页面请求的类型
    //    url: "ContractHandler.ashx?Command=getMasterByType",   //处理页的相对地址
    //    data: {
    //        Type: "ContractMain",
    //    },
    //    async: false,
    //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
    //        for (var i = 0; i < ret.length; i++) {
                // 每一个节点都需要调整参与者
                $.ajax({
                    type: "GET",    //页面请求的类型
                    url: "/Portal/InstanceDetail/AdjustActivity?ActivityCode=" + ActivityCode+"&InstanceID=" + InstanceID + "&Participants=" + PostA + "&Participants=" + PostB,   //处理页的相对地址
                    //async: false,
                    //data: {
                    //    InstanceID: InstanceID,
                    //    ActivityCode: ActivityCode,
                    //    Participants: participants
                    //},
                    success: function (ret2) {    //这是处理后执行的函数，msg是处理页返回的数据
                        if (ret2.SUCCESS == true) {
                            console.log("调整参与者成功！");
                        } else {
                            console.log("调整参与者失败！（调整活动节点失败）");
                        }
                    }
                });
    //        }


    //    }
    //});
    
}

// 获取信用证数据
function getPayments() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getPaymentStatusData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("PaymentFKStatus").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("PaymentFKStatus.Bank", ret[i].Bank, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentFKStatus.Amount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentFKStatus.PayedAmount", ret[i].PayedAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentFKStatus.RemainAmount", ret[i].RemainAmount, i + 1);
                }
                // 信用证状态记录子表不能编辑
                $("input[data-datafield='PaymentFKStatus.Bank']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentFKStatus.Amount']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentFKStatus.PayedAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentFKStatus.RemainAmount']").attr("disabled", "disabled");
            }
        });
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getPaymentData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("PaymentTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("PaymentTbl.TheNo", ret[i].TheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.Bank", ret[i].Bank, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.TotalAmount", ret[i].TotalAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.UpdatePayment", ret[i].UpdatePayment, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.PaymentId", ret[i].PaymentId, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.changePaymentFlg", ret[i].changePaymentFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("PaymentTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                }
                // 信用证记录子表不能编辑
                $("input[data-datafield='PaymentTbl.Bank']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentTbl.TotalAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentTbl.Status']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentTbl.UpdatePayment']").attr("disabled", "disabled");
                $("input[data-datafield='PaymentTbl.TheNo']").attr("disabled", "disabled");
            }
        });
    }
    

    // 信用证子表的改证显示判断
    var rowp = 0;
    $("[data-datafield='PaymentTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("PaymentTbl.Status", rowp);
        var changePaymentFlg = $.MvcSheetUI.GetControlValue("PaymentTbl.changePaymentFlg", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("PaymentTbl.RejectFlg", rowp);
        if (Status == "已开证") {
            $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").show();
            if (changePaymentFlg == "2") {
                $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
                $(this).find("td[data-field='PaymentTbl.UpdatePayment']").text("改证中");
            } else if (changePaymentFlg == "4") {
                $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
                $(this).find("td[data-field='PaymentTbl.UpdatePayment']").text("已改证");
            }
        } else {
            $(this).find("td[data-field='PaymentTbl.UpdatePayment'] a").hide();
        }
        if (RejectFlg == "1") {
            $(this).find("td[data-field='PaymentTbl.Operate'] a.updatePayment").show();
        } else {
            $(this).find("td[data-field='PaymentTbl.Operate'] a.updatePayment").hide();
        }

    });
}

// 获取进口许可证数据
function getImports() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getImportData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("ImportLicenceTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.GoodName", ret[i].GoodName, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.GoodCode", ret[i].GoodCode, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.ImportLicenseId", ret[i].ImportLicenseId, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.CancelFlg", ret[i].CancelFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("ImportLicenceTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='ImportLicenceTbl.GoodName']").attr("disabled", "disabled");
                $("input[data-datafield='ImportLicenceTbl.GoodCode']").attr("disabled", "disabled");
                $("input[data-datafield='ImportLicenceTbl.DisplayName']").attr("disabled", "disabled");
                $("input[data-datafield='ImportLicenceTbl.Status']").attr("disabled", "disabled");
                $("input[data-datafield='ImportLicenceTbl.ImportLicenseId']").attr("disabled", "disabled");
            }
        });
    }
    // 进口许可证子表的显示判断
    var rowp = 0;
    $("[data-datafield='ImportLicenceTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.RejectFlg", rowp);
        var CancelFlg = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.CancelFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("ImportLicenceTbl.DisplayName", rowp);

        if (Status == "4") {
            if (RejectFlg == "1" || DisplayName == "草稿 ") {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").show();
            } else {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").hide();
            }
            if (CancelFlg == "1") {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").hide();
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").show();
            } else {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").show();
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").hide();
            }
        } else {
            if (RejectFlg == "1" || DisplayName == "草稿 ") {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").show();
            } else {
                $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.updateImportLicence").hide();
            }
            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.cancelImportLicence").hide();
            $(this).find("td[data-field='ImportLicenceTbl.Operate'] a.undocancelImportLicence").hide();
        }

    });
}

// 获取到货数据
function getDHs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDHData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("DHTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("DHTbl.TheNo", ret[i].TheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.DHType", ret[i].DHType, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.DHSeq", ret[i].DHSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.ShippingType", ret[i].ShippingType, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.GoodName", ret[i].GoodName, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.Num", ret[i].Num, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.Amount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.Currency", ret[i].Currency, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.Supplier", ret[i].Supplier, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.BizObjectID", ret[i].BizObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("DHTbl.SeqCnt", ret[i].SeqCnt, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='DHTbl.TheNo']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.DHType']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.DHSeq']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.ShippingType']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.GoodName']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.Num']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.Amount']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.Currency']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.Supplier']").attr("disabled", "disabled");
                $("input[data-datafield='DHTbl.DisplayName']").attr("disabled", "disabled");
            }
        });
    }
    // 到货子表的合并单元格操作
    var dtl_dh = $.MvcSheetUI.GetElement("DHTbl").SheetGridView();
    var len_dh = dtl_dh.RowCount;
    var DHSeq = "";
    if (len_dh > 0) {
        for (var i = 0; i < len_dh; i++) {
            if (DHSeq == "" || DHSeq != $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1)) {
                DHSeq = $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1);
                var SeqCnt = $.MvcSheetUI.GetControlValue("DHTbl.SeqCnt", i + 1);
                var RejectFlg = $.MvcSheetUI.GetControlValue("DHTbl.RejectFlg", i + 1);
                var DisplayName = $.MvcSheetUI.GetControlValue("DHTbl.DisplayName", i + 1);
                var k = 0;
                $("[data-datafield='DHTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DHTbl.TheNo']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.DHType']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.DHSeq']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.ShippingType']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.Supplier']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.DisplayName']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DHTbl.Operate']").attr("rowspan", SeqCnt);
                        if (RejectFlg == "1" || DisplayName == "草稿 ") {
                            $(this).find("td[data-field='DHTbl.Operate'] a.updateDH").show();
                        } else {
                            $(this).find("td[data-field='DHTbl.Operate'] a.updateDH").hide();
                        }
                    }
                    k++;
                });
            } else {
                DHSeq = $.MvcSheetUI.GetControlValue("DHTbl.DHSeq", i + 1);
                var k = 0;
                $("[data-datafield='DHTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DHTbl.TheNo']").remove();
                        $(this).find("td[data-field='DHTbl.DHType']").remove();
                        $(this).find("td[data-field='DHTbl.DHSeq']").remove();
                        $(this).find("td[data-field='DHTbl.ShippingType']").remove();
                        $(this).find("td[data-field='DHTbl.Supplier']").remove();
                        $(this).find("td[data-field='DHTbl.DisplayName']").remove();
                        $(this).find("td[data-field='DHTbl.Operate']").remove();
                    }
                    k++;
                });
            }
        }
    }
}

// 获取变更数据
function getBGs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getBGData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BGTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("BGTbl.AmountOld", ret[i].AmountOld, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.AmountNew", ret[i].AmountNew, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.DHDateOld", ret[i].DHDateOld, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.DHDateNew", ret[i].DHDateNew, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.BizObjectID", ret[i].BizObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("BGTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='BGTbl.AmountOld']").attr("disabled", "disabled");
                $("input[data-datafield='BGTbl.AmountNew']").attr("disabled", "disabled");
                $("input[data-datafield='BGTbl.DHDateOld']").attr("disabled", "disabled");
                $("input[data-datafield='BGTbl.DHDateNew']").attr("disabled", "disabled");
                $("input[data-datafield='BGTbl.Status']").attr("disabled", "disabled");
                $("input[data-datafield='BGTbl.DisplayName']").attr("disabled", "disabled");
            }
        });
    }
    // 合同变更子表的显示判断
    var rowp = 0;
    $("[data-datafield='BGTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("BGTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("BGTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("BGTbl.DisplayName", rowp);

        if (Status == "4") {
            if (RejectFlg == "1" || DisplayName == "草稿 ") {
                $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").show();
            } else {
                $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").hide();
            }
        } else {
            if (RejectFlg == "1" || DisplayName == "草稿 ") {
                $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").show();
            } else {
                $(this).find("td[data-field='BGTbl.Operate'] a.updateBG").hide();
            }
        }

    });
}

// 获取保函数据
function getBHs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getBHData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BHTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("BHTbl.BHType", ret[i].BHType, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.BHProperty", ret[i].BHProperty, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.BHAmount", ret[i].BHAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.ReceiveDate", ret[i].ReceiveDate, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.ExpirationDate", ret[i].ExpirationDate, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.TBStatus", ret[i].TBStatus, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.InputWorkitemId", ret[i].InputWorkitemId, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.BizObjectID", ret[i].BizObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.InputBizObjectID", ret[i].InputBizObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("BHTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='BHTbl.BHType']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.BHProperty']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.BHAmount']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.ReceiveDate']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.ExpirationDate']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.TBStatus']").attr("disabled", "disabled");
                $("input[data-datafield='BHTbl.Status']").attr("disabled", "disabled");
            }
        });
    }
    // 保函子表的显示判断
    var rowp = 0;
    $("[data-datafield='BHTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("BHTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("BHTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("BHTbl.TBStatus", rowp);

        if (DisplayName == "未退" && Status == "20" ) {
            $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.viewBH").hide();
        } else if (DisplayName == "未退" && Status == "40") {
            $(this).find("td[data-field='BHTbl.Edit'] a.editBH").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.viewBH").hide();
        } else if (DisplayName == "驳回") {
            $(this).find("td[data-field='BHTbl.TB'] a.editBH").hide();
            $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
        } else if (DisplayName == "审批中" || DisplayName == "确认中") {
            $(this).find("td[data-field='BHTbl.Edit'] a.editBH").hide();
            $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
        } else if (DisplayName == "没收" || DisplayName == "已退") {
            $(this).find("td[data-field='BHTbl.Edit'] a.editBH").hide();
            $(this).find("td[data-field='BHTbl.TB'] a.doTB").hide();
            $(this).find("td[data-field='BHTbl.Operate'] a.updateBH").hide();
        }

    });
}

// 获取请款数据
function getQKs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getQKData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("QKMainTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKSeq", ret[i].QKSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.ZJMS", ret[i].ZJMS, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKTotalAmount", ret[i].QKTotalAmount == "0" ? "" : ret[i].QKTotalAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKTarget", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.SeqCnt", ret[i].SeqCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKCurrency", ret[i].QKCurrency, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKObjectID", ret[i].QKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("QKMainTbl.QKType", ret[i].QKType, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='QKMainTbl.QKSeq']").attr("disabled", "disabled");
                $("input[data-datafield='QKMainTbl.ZJMS']").attr("disabled", "disabled");
                $("input[data-datafield='QKMainTbl.QKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='QKMainTbl.QKTotalAmount']").attr("disabled", "disabled");
                $("input[data-datafield='QKMainTbl.QKTarget']").attr("disabled", "disabled");
                $("input[data-datafield='QKMainTbl.Status']").attr("disabled", "disabled");
            }
        });
    }
    // 请款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("QKMainTbl").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var IsFirst2 = true;
    var QKObjectID = "";
    var QKType = "";
    var QKCurrency = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            // 批次
            if (IsFirst2 || QKObjectID != $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1)) {
                IsFirst2 = false;
                QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                var SeqCnt = $.MvcSheetUI.GetControlValue("QKMainTbl.SeqCnt", i + 1);
                var Status = $.MvcSheetUI.GetControlValue("QKMainTbl.Status", i + 1);
                var k = 0;
                $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='QKMainTbl.QKSeq']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='QKMainTbl.QKTarget']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='QKMainTbl.Status']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='QKMainTbl.Operate']").attr("rowspan", SeqCnt);
                        if (Status == "草稿 " || Status == "驳回 ") {
                            $(this).find("td[data-field='QKMainTbl.Operate'] a.updateQK").show();
                        } else {
                            $(this).find("td[data-field='QKMainTbl.Operate'] a.updateQK").hide();
                        }
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='QKMainTbl.QKSeq']").remove();
                        $(this).find("td[data-field='QKMainTbl.QKTarget']").remove();
                        $(this).find("td[data-field='QKMainTbl.Status']").remove();
                        $(this).find("td[data-field='QKMainTbl.Operate']").remove();
                    }
                    k++;
                });
            }
            
        }
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var ContractProperty = GetContractPropertyByContractNo(ContractNo);
        if (ContractProperty == "航空煤油") {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || QKObjectID!= $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1) ) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("QKMainTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").remove();
                        }
                        k++;
                    });
                }

            }
        } else {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || QKObjectID + QKType + QKCurrency != $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("QKMainTbl.QKType", i + 1) + $.MvcSheetUI.GetControlValue("QKMainTbl.QKCurrency", i + 1)) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("QKMainTbl.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("QKMainTbl.QKCurrency", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("QKMainTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("QKMainTbl.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("QKMainTbl.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("QKMainTbl.QKCurrency", i + 1);
                    var k = 0;
                    $("[data-datafield='QKMainTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='QKMainTbl.QKTotalAmount']").remove();
                        }
                        k++;
                    });
                }

            }
        }
        
    }
}

// 获取到款数据
function getDKs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKStatusData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("DKStatusTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKSeq", ret[i].QKSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.SeqCnt", ret[i].SeqCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.ZJKX", ret[i].ZJKX, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.ZJMS", ret[i].ZJMS, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKCurrency", ret[i].QKCurrency, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKConvertAmount", ret[i].QKConvertAmount == "0" ? "" : ret[i].QKConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKTarget", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.LJDKTotalAmount", ret[i].LJDKTotalAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKObjectID", ret[i].QKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("DKStatusTbl.QKType", ret[i].QKType, i + 1);
                                        
                }
                // 子表不能编辑
                $("input[data-datafield='DKStatusTbl.QKSeq']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.SeqCnt']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.ZJKX']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.ZJMS']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.QKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.QKCurrency']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.QKConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.QKTarget']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.LJDKTotalAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.Status']").attr("disabled", "disabled");
                $("input[data-datafield='DKStatusTbl.DisplayName']").attr("disabled", "disabled");
            }
        });

    // 获取后台数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getDKData",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            UserID: CurrentUser.ObjectID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var dtl = $.MvcSheetUI.GetElement("DKRecordTbl").SheetGridView();
            dtl._Clear();
            for (var i = 0; i < ret.length; i++) {
                dtl._AddRow();
                $.MvcSheetUI.SetControlValue("DKRecordTbl.QKTarget", ret[i].QKTarget, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.DKDate", ret[i].DKDate, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.DKTotalAmount", ret[i].DKTotalAmount, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.Status", ret[i].Status, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.DisplayName", ret[i].DisplayName, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                $.MvcSheetUI.SetControlValue("DKRecordTbl.WorkItemId", ret[i].WorkItemId, i + 1);
            }
            // 子表不能编辑
            $("input[data-datafield='DKRecordTbl.QKTarget']").attr("disabled", "disabled");
            $("input[data-datafield='DKRecordTbl.DKDate']").attr("disabled", "disabled");
            $("input[data-datafield='DKRecordTbl.DKTotalAmount']").attr("disabled", "disabled");
            $("input[data-datafield='DKRecordTbl.Status']").attr("disabled", "disabled");
            $("input[data-datafield='DKRecordTbl.DisplayName']").attr("disabled", "disabled");
        }
        });
    }


    // 到款状态子表的显示判断
    var rowp = 0;
    var dtl = $.MvcSheetUI.GetElement("DKStatusTbl").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var IsFirst2 = true;
    var QKObjectID = "";
    var QKType = "";
    var QKCurrency = "";

    if (len > 0) {
        for (var i = 0; i < len; i++) {
            if (IsFirst2 || QKObjectID != $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1)) {
                IsFirst2 = false;
                QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                var SeqCnt = $.MvcSheetUI.GetControlValue("DKStatusTbl.SeqCnt", i + 1);
                var k = 0;
                $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKStatusTbl.QKSeq']").attr("rowspan", SeqCnt);
                        //$(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKStatusTbl.QKTarget']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKStatusTbl.QKSeq']").remove();
                        //$(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").remove();
                        $(this).find("td[data-field='DKStatusTbl.QKTarget']").remove();
                    }
                    k++;
                });
            }
        }
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var ContractProperty = GetContractPropertyByContractNo(ContractNo);
        if (ContractProperty == "航空煤油") {
            for (var i = 0; i < len; i++) {
                if (IsFirst1 || QKObjectID != $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1) ) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKStatusTbl.LJDKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKStatusTbl.DisplayName']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKStatusTbl.LJDKTotalAmount']").remove();
                            $(this).find("td[data-field='DKStatusTbl.DisplayName']").remove();
                        }
                        k++;
                    });
                }
            }
        } else {
            for (var i = 0; i < len; i++) {
                if (IsFirst1 || QKObjectID + QKType + QKCurrency != $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKStatusTbl.QKType", i + 1) + $.MvcSheetUI.GetControlValue("DKStatusTbl.QKCurrency", i + 1)) {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKCurrency", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKStatusTbl.LJDKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKStatusTbl.DisplayName']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKStatusTbl.QKCurrency", i + 1);
                    var k = 0;
                    $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKStatusTbl.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKStatusTbl.LJDKTotalAmount']").remove();
                            $(this).find("td[data-field='DKStatusTbl.DisplayName']").remove();
                        }
                        k++;
                    });
                }
            }
        }

    }

    // 到款记录子表的显示判断
    var rowp = 0;
    $("[data-datafield='DKRecordTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("DKRecordTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("DKRecordTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("DKRecordTbl.DisplayName", rowp);

        if (DisplayName == "驳回" || DisplayName == "发起申请") {
            $(this).find("td[data-field='DKRecordTbl.Operate'] a.updateDK").show();
        } else {
            $(this).find("td[data-field='DKRecordTbl.Operate'] a.updateDK").hide();
        }

    });

    // 子表的显示判断
    var rowp = 0;
    $("[data-datafield='DKStatusTbl']").find("tr.rows").each(function () {
        rowp++;
        var DisplayName = $.MvcSheetUI.GetControlValue("DKStatusTbl.DisplayName", rowp);
        if (DisplayName == "全部到款") {
            $(this).find("td[data-field='DKStatusTbl.DisplayName']").addClass("settled");//绿色
        } else if (DisplayName == "超额到款"){
            $(this).find("td[data-field='DKStatusTbl.DisplayName']").addClass("nonSettlement");// 红色
        }else {
            $(this).find("td[data-field='DKStatusTbl.DisplayName']").addClass("unsettled");// 橙色
        }
    });
}

// 获取付款数据
function getFKs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getFKData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("FKRecordTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.TheNo", ret[i].TheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.ZKMS", ret[i].ZKMS, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.Amount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.ConvertAmount", ret[i].ConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.FKDate", ret[i].FKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.Content", ret[i].Content, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.PayType", ret[i].PayType, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.Receiver", ret[i].Receiver, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTbl.Cnt", ret[i].Cnt, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='FKRecordTbl.TheNo']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.ZKMS']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.Amount']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.ConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.FKDate']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.Content']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.PayType']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.Receiver']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.DisplayName']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.Cnt']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTbl.Status']").attr("disabled", "disabled");
            }
        });

        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getFKJFData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("FKJFRecordTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.TheNo", ret[i].TheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.ZKMS", ret[i].ZKMS, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.Amount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.ConvertAmount", ret[i].ConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.FKDate", ret[i].FKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.Content", ret[i].Content, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.PayType", ret[i].PayType, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.Receiver", ret[i].Receiver, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("FKJFRecordTbl.Cnt", ret[i].Cnt, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='FKJFRecordTbl.TheNo']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.ZKMS']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.Amount']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.ConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.FKDate']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.Content']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.PayType']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.Receiver']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.DisplayName']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.Cnt']").attr("disabled", "disabled");
                $("input[data-datafield='FKJFRecordTbl.Status']").attr("disabled", "disabled");
            }
        });

    }
    // 付款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("FKRecordTbl").SheetGridView();
    var len = dtl.RowCount;
    var TheNo = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {

            if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1)) {
                TheNo = $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1);
                var Cnt = $.MvcSheetUI.GetControlValue("FKRecordTbl.Cnt", i + 1);
                var DisplayName = $.MvcSheetUI.GetControlValue("FKRecordTbl.DisplayName", i + 1);
                var k = 0;
                $("[data-datafield='FKRecordTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKRecordTbl.TheNo']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.ConvertAmount']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.FKDate']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.Content']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.PayType']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.Receiver']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.DisplayName']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTbl.Operate']").attr("rowspan", Cnt);
                        if (DisplayName == "驳回 ") {
                            $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").show();
                        } else {
                            if (DisplayName == "草稿 ") {
                                $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").show();
                            } else {
                                $(this).find("td[data-field='FKRecordTbl.Operate'] a.updateFK").hide();
                            }
                        }
                    }
                    k++;
                });
            } else {
                TheNo = $.MvcSheetUI.GetControlValue("FKRecordTbl.TheNo", i + 1);
                var k = 0;
                $("[data-datafield='FKRecordTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKRecordTbl.TheNo']").remove();
                        $(this).find("td[data-field='FKRecordTbl.ConvertAmount']").remove();
                        $(this).find("td[data-field='FKRecordTbl.FKDate']").remove();
                        $(this).find("td[data-field='FKRecordTbl.Content']").remove();
                        $(this).find("td[data-field='FKRecordTbl.PayType']").remove();
                        $(this).find("td[data-field='FKRecordTbl.Receiver']").remove();
                        $(this).find("td[data-field='FKRecordTbl.DisplayName']").remove();
                        $(this).find("td[data-field='FKRecordTbl.Operate']").remove();
                    }
                    k++;
                });
            }
        }
    }


    // 拒付付款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("FKJFRecordTbl").SheetGridView();
    var len = dtl.RowCount;
    var TheNo = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {

            if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1)) {
                TheNo = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1);
                var Cnt = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.Cnt", i + 1);
                var DisplayName = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.DisplayName", i + 1);
                var k = 0;
                $("[data-datafield='FKJFRecordTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKJFRecordTbl.TheNo']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.ConvertAmount']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.FKDate']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.Content']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.PayType']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.Receiver']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.DisplayName']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKJFRecordTbl.Operate']").attr("rowspan", Cnt);
                        if (DisplayName == "驳回 ") {
                            $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").show();
                        } else {
                            if (DisplayName == "草稿 ") {
                                $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").show();
                            } else {
                                $(this).find("td[data-field='FKJFRecordTbl.Operate'] a.updateFKJF").hide();
                            }
                        }
                    }
                    k++;
                });
            } else {
                TheNo = $.MvcSheetUI.GetControlValue("FKJFRecordTbl.TheNo", i + 1);
                var k = 0;
                $("[data-datafield='FKJFRecordTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKJFRecordTbl.TheNo']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.ConvertAmount']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.FKDate']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.Content']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.PayType']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.Receiver']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.DisplayName']").remove();
                        $(this).find("td[data-field='FKJFRecordTbl.Operate']").remove();
                    }
                    k++;
                });
            }
        }
    }

    
}

// 获取结算数据
function getJSs() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDKRecordTblOfJSData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("DKRecordTblOfJS").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKTarget", ret[i].QKTarget, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKType", ret[i].QKType, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.ZJKX", ret[i].ZJKX, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.ZJMS", ret[i].ZJMS, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKCurrencyName", ret[i].QKCurrencyName, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKConvertAmount", ret[i].QKConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.DKType", ret[i].DKType, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.CurDKAmount", ret[i].CurDKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.CurDKCurrency", ret[i].CurDKCurrency, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.DKDate", ret[i].DKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.DKObjectID", ret[i].DKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.QKCurrencyCnt", ret[i].QKCurrencyCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.SeqCnt", ret[i].SeqCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("DKRecordTblOfJS.Status", ret[i].Status, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='DKRecordTblOfJS.QKTarget']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.DKType']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.DKDate']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.Status']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.QKType']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.ZJKX']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.ZJMS']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.QKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.QKCurrencyName']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.QKConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.CurDKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.CurDKCurrency']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.DKObjectID']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.QKCurrencyCnt']").attr("disabled", "disabled");
                $("input[data-datafield='DKRecordTblOfJS.SeqCnt']").attr("disabled", "disabled");
            }
        });

        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getFKRecordTblOfJSData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("FKRecordTblOfJS").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.TheNo", ret[i].TheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.Receiver", ret[i].Receiver, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.ZKMS", ret[i].ZKMS, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.Amount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.ConvertAmount", ret[i].ConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.Content", ret[i].Content, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("FKRecordTblOfJS.Cnt", ret[i].Cnt, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='FKRecordTblOfJS.TheNo']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.Receiver']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.ZKMS']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.Amount']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.ConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.Content']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.Status']").attr("disabled", "disabled");
                $("input[data-datafield='FKRecordTblOfJS.Cnt']").attr("disabled", "disabled");
            }
        });

        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getJSData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("JSRecordTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.LJDKAmountRMB", ret[i].LJDKAmountRMB, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.LJFKAmountRMB", ret[i].LJFKAmountRMB, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.BankFY", ret[i].BankFY, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.AgencyFY", ret[i].AgencyFY, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.OtherFY", ret[i].OtherFY, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.JSResult", ret[i].JSResult, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.Status", ret[i].Status, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.DisplayName", ret[i].DisplayName, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.WorkItemId", ret[i].WorkItemId, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.RejectFlg", ret[i].RejectFlg, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.JSObjectID", ret[i].JSObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("JSRecordTbl.JSResultNum", ret[i].JSResultNum, i + 1);
                }
                // 子表不能编辑
                $("input[data-datafield='JSRecordTbl.LJDKAmountRMB']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.LJFKAmountRMB']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.BankFY']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.AgencyFY']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.OtherFY']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.JSResult']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.DisplayName']").attr("disabled", "disabled");
                $("input[data-datafield='JSRecordTbl.JSResultNum']").attr("disabled", "disabled");
            }
        });
    }

    // 到款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("DKRecordTblOfJS").SheetGridView();
    var len = dtl.RowCount;
    var IsFirst1 = true;
    var IsFirst2 = true;
    var DKObjectID = "";
    var QKCurrency = "";
    var QKObjectID = "";
    var QKType = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            // 对需要合并的项目进行合并
            if (IsFirst2 || DKObjectID + QKObjectID != $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1)) {
                var SeqCnt = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.SeqCnt", i + 1);
                IsFirst2 = false;
                DKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1);
                QKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRecordTblOfJS.QKTarget']").attr("rowspan", SeqCnt);
                        $(this).find("td[data-field='DKRecordTblOfJS.DKDate']").attr("rowspan", SeqCnt);
                    }
                    k++;
                });
            } else {
                var k = 0;
                $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='DKRecordTblOfJS.QKTarget']").remove();
                        $(this).find("td[data-field='DKRecordTblOfJS.DKDate']").remove();
                    }
                    k++;
                });
            }
        }
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var ContractProperty = GetContractPropertyByContractNo(ContractNo);
        if (ContractProperty == "航空煤油") {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || DKObjectID + QKObjectID != $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1)) {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1);
                    var SeqCnt = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.SeqCnt", i + 1);
                    IsFirst1 = false;
                    var k = 0;
                    $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKRecordTblOfJS.QKConvertAmount']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKAmount']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKCurrency']").attr("rowspan", SeqCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.Status']").attr("rowspan", SeqCnt);
                        }
                        k++;
                    });
                } else {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1);
                    var k = 0;
                    $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKRecordTblOfJS.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKCurrency']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.Status']").remove();
                        }
                        k++;
                    });
                }

            }
        } else {
            for (var i = 0; i < len; i++) {
                // 折算金额
                if (IsFirst1 || DKObjectID + QKObjectID + QKType + QKCurrency != $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1) + $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKType", i + 1) + $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKCurrency", i + 1)) {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKCurrency", i + 1);
                    IsFirst1 = false;
                    var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKCurrencyCnt", i + 1);
                    var k = 0;
                    $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKRecordTblOfJS.QKConvertAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKAmount']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKCurrency']").attr("rowspan", QKCurrencyCnt);
                            $(this).find("td[data-field='DKRecordTblOfJS.Status']").attr("rowspan", QKCurrencyCnt);
                        }
                        k++;
                    });
                } else {
                    DKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.DKObjectID", i + 1);
                    QKObjectID = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKObjectID", i + 1);
                    QKType = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKType", i + 1);
                    QKCurrency = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.QKCurrency", i + 1);
                    var k = 0;
                    $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
                        if (k == i) {
                            $(this).find("td[data-field='DKRecordTblOfJS.QKConvertAmount']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKAmount']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.CurDKCurrency']").remove();
                            $(this).find("td[data-field='DKRecordTblOfJS.Status']").remove();
                        }
                        k++;
                    });
                }

            }
        }

    }

    // 结算中的到款记录子表的显示判断
    var rowp = 0;
    $("[data-datafield='DKRecordTblOfJS']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("DKRecordTblOfJS.Status", rowp);
        if (Status == "已结算") {
            $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("settled");
        } else if (Status == "不必结算") {
            $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("nonSettlement");
        } else {
            $(this).find("td[data-field='DKRecordTblOfJS.Status']").addClass("unsettled");
        }
    });



    // 结算中的付款子表的合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("FKRecordTblOfJS").SheetGridView();
    var len = dtl.RowCount;
    var TheNo = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {

            if (TheNo == "" || TheNo != $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1)) {
                TheNo = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1);
                var Cnt = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.Cnt", i + 1);
                var Status = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.Status", i + 1);
                var k = 0;
                $("[data-datafield='FKRecordTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKRecordTblOfJS.TheNo']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTblOfJS.ConvertAmount']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTblOfJS.Content']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTblOfJS.Receiver']").attr("rowspan", Cnt);
                        $(this).find("td[data-field='FKRecordTblOfJS.Status']").attr("rowspan", Cnt);
                        if (Status == "已结算") {
                            $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("settled");
                        } else if (Status == "不必结算") {
                            $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("nonSettlement");
                        } else {
                            $(this).find("td[data-field='FKRecordTblOfJS.Status']").addClass("unsettled");
                        }
                    }
                    k++;
                });
            } else {
                TheNo = $.MvcSheetUI.GetControlValue("FKRecordTblOfJS.TheNo", i + 1);
                var k = 0;
                $("[data-datafield='FKRecordTblOfJS']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='FKRecordTblOfJS.TheNo']").remove();
                        $(this).find("td[data-field='FKRecordTblOfJS.ConvertAmount']").remove();
                        $(this).find("td[data-field='FKRecordTblOfJS.Content']").remove();
                        $(this).find("td[data-field='FKRecordTblOfJS.Receiver']").remove();
                        $(this).find("td[data-field='FKRecordTblOfJS.Status']").remove();
                    }
                    k++;
                });
            }
        }
    }

    // 结算记录子表的显示判断
    var rowp = 0;
    $("[data-datafield='JSRecordTbl']").find("tr.rows").each(function () {
        rowp++;
        var Status = $.MvcSheetUI.GetControlValue("JSRecordTbl.Status", rowp);
        var RejectFlg = $.MvcSheetUI.GetControlValue("JSRecordTbl.RejectFlg", rowp);
        var DisplayName = $.MvcSheetUI.GetControlValue("JSRecordTbl.DisplayName", rowp);
        if (DisplayName.indexOf("完成") > 0) {
            $(this).find("td[data-field='JSRecordTbl.DisplayName']").addClass("settled");
        } else {
            $(this).find("td[data-field='JSRecordTbl.DisplayName']").addClass("unsettled");
        }

        if (DisplayName == "驳回" || DisplayName == "草稿") {
            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").show();
            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
            $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
        } else {
            if (DisplayName == "待请款") {
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
                if (Status == "") {
                    $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").show();
                } else {
                    $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
                }
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
            } else if (DisplayName == "待付款") {
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
                if (Status == "") {
                    $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").show();
                } else {
                    $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
                }
            } else {
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJS").hide();
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSQK").hide();
                $(this).find("td[data-field='JSRecordTbl.Operate'] a.updateJSFK").hide();
            }
        }

    });
}

// 获取支付管理数据
function getPayManagers() {
    // 当前为执行节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        // 获取后台数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getPayManagerData",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                UserID: CurrentUser.ObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("PayManagerTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    // 请款
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKSeq", ret[i].QKSeq, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKTheNo", ret[i].QKTheNo, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKZJMS", ret[i].QKZJMS, i + 1);
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.QKAmount", ret[i].QKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKDate", ret[i].QKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKObjectID", ret[i].QKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKSubObjectID", ret[i].QKSubObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKAmountCnt", ret[i].QKAmountCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKCnt", ret[i].QKCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKCurrencyCnt", ret[i].QKCurrencyCnt, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKType", ret[i].QKType, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.QKCurrency", ret[i].QKCurrency, i + 1);
                    // 资金计划
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.ZJPlanContent", ret[i].ZJPlanContent, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.ZJPlanAmount", ret[i].ZJPlanAmount, i + 1);
                    // 到款
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.DKTotalAmount", ret[i].DKTotalAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.DKStatus", ret[i].DKStatus, i + 1);
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.DKBizObjectID", ret[i].DKBizObjectID, i + 1);
                    // 付款
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.FKAmount", ret[i].FKAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.FKZKMS", ret[i].FKZKMS, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.FKDate", ret[i].FKDate, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.FKObjectID", ret[i].FKObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.FKTblObjectID", ret[i].FKTblObjectID, i + 1);
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.FKCnt", ret[i].FKCnt, i + 1);
                    // 结算
                    $.MvcSheetUI.SetControlValue("PayManagerTbl.JSStatus", ret[i].JSStatus, i + 1);
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.SubsFee", ret[i].SubsFee, i + 1);
                    //$.MvcSheetUI.SetControlValue("PayManagerTbl.JSRecAndRemainFee", ret[i].JSRecAndRemainFee, i + 1);
                    var rowp = 0;
                    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                        var DKTotalAmount = $.MvcSheetUI.GetControlValue("PayManagerTbl.DKTotalAmount", rowp);
                        if (rowp == i) {
                            // 请款金额
                            $(this).find("td .QKAmount").empty();
                            $(this).find("td .QKAmount").append(ret[i].QKAmount);
                            // 到款金额
                            $(this).find("td .DKTotalAmount").empty();
                            $(this).find("td .DKTotalAmount").append(ret[i].DKTotalAmount);
                            // 到款ObjectID
                            $(this).find("td .DKBizObjectID").empty();
                            $(this).find("td .DKBizObjectID").append(ret[i].DKBizObjectID);
                            // 付款金额
                            $(this).find("td .FKAmount").empty();
                            $(this).find("td .FKAmount").append(ret[i].FKAmount);
                            // 扣除费用、结算记录及余额
                            $(this).find("td .SubsFee").empty();
                            $(this).find("td .SubsFee").append(ret[i].SubsFee);
                            $(this).find("td .JSRecAndRemainFee").empty();
                            $(this).find("td .JSRecAndRemainFee").append(ret[i].JSRecAndRemainFee);
                        }
                        rowp++;
                    });

                }

                // 子表不能编辑
                $("input[data-datafield='PayManagerTbl.ZJPlanContent']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.ZJPlanAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.QKSeq']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.QKTheNo']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.QKZJMS']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.QKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.QKDate']").attr("disabled", "disabled");
                $("[data-datafield='PayManagerTbl.DKTotalAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.DKStatus']").attr("disabled", "disabled");
                $("[data-datafield='PayManagerTbl.DKBizObjectID']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.FKAmount']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.FKZKMS']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.FKDate']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.FKTblObjectID']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.JSStatus']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.SubsFee']").attr("disabled", "disabled");
                $("input[data-datafield='PayManagerTbl.JSRecAndRemainFee']").attr("disabled", "disabled");
            }
        });
    }
    // 合并单元格操作
    var dtl = $.MvcSheetUI.GetElement("PayManagerTbl").SheetGridView();
    var len = dtl.RowCount;
    var QKObjectID = "";
    var QKSubObjectID = "";
    var QKSeq = "";
    var QKCurrency = "";
    var FKObjectID = "";
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            // 请款日期合并
            if (QKObjectID != $.MvcSheetUI.GetControlValue("PayManagerTbl.QKObjectID", i + 1)) {
                QKObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKObjectID", i + 1);
                var QKCnt = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKCnt", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.QKDate']").attr("rowspan", QKCnt);
                    }
                    k++;
                });
            } else {
                QKObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.QKDate']").remove();
                    }
                    k++;
                });
            }
            // 一个请款对应多个付款，请款要合并
            if (QKSubObjectID != $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSubObjectID", i + 1)) {
                QKSubObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSubObjectID", i + 1);
                var QKAmountCnt = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKAmountCnt", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.QKZJMS']").attr("rowspan", QKAmountCnt);
                        $(this).find("td[data-field='PayManagerTbl.QKAmount']").attr("rowspan", QKAmountCnt);
                    }
                    k++;
                });
            } else {
                QKSubObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSubObjectID", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.QKZJMS']").remove();
                        $(this).find("td[data-field='PayManagerTbl.QKAmount']").remove();
                    }
                    k++;
                });
            }
            // 资金计划合并
            if (QKSeq != $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSeq", i + 1) || QKCurrency != $.MvcSheetUI.GetControlValue("PayManagerTbl.QKCurrency", i + 1)) {
                QKSeq = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSeq", i + 1);
                QKCurrency = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKCurrency", i + 1);
                var QKCurrencyCnt = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKCurrencyCnt", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.ZJPlanContent']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='PayManagerTbl.ZJPlanAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='PayManagerTbl.DKTotalAmount']").attr("rowspan", QKCurrencyCnt);
                        $(this).find("td[data-field='PayManagerTbl.DKStatus']").attr("rowspan", QKCurrencyCnt);
                    }
                    k++;
                });
            } else {
                QKSeq = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKSeq", i + 1);
                QKCurrency = $.MvcSheetUI.GetControlValue("PayManagerTbl.QKCurrency", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.ZJPlanContent']").remove();
                        $(this).find("td[data-field='PayManagerTbl.ZJPlanAmount']").remove();
                        $(this).find("td[data-field='PayManagerTbl.DKTotalAmount']").remove();
                        $(this).find("td[data-field='PayManagerTbl.DKStatus']").remove();
                    }
                    k++;
                });
            }
            // 付款日期合并
            if (FKObjectID != $.MvcSheetUI.GetControlValue("PayManagerTbl.FKObjectID", i + 1) || $.MvcSheetUI.GetControlValue("PayManagerTbl.FKObjectID", i + 1) == "") {
                FKObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.FKObjectID", i + 1);
                var FKCnt = $.MvcSheetUI.GetControlValue("PayManagerTbl.FKCnt", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.FKDate']").attr("rowspan", FKCnt);
                        $(this).find("td[data-field='PayManagerTbl.JSStatus']").attr("rowspan", FKCnt);
                    }
                    k++;
                });
            } else {
                FKObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.FKObjectID", i + 1);
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.FKDate']").remove();
                        $(this).find("td[data-field='PayManagerTbl.JSStatus']").remove();
                    }
                    k++;
                });
            }
            // 扣除费用合并
            if (i==0) {
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.SubsFee']").attr("rowspan", len);
                        $(this).find("td[data-field='PayManagerTbl.JSRecAndRemainFee']").attr("rowspan", len);
                    }
                    k++;
                });
            } else {
                var k = 0;
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    if (k == i) {
                        $(this).find("td[data-field='PayManagerTbl.SubsFee']").remove();
                        $(this).find("td[data-field='PayManagerTbl.JSRecAndRemainFee']").remove();
                    }
                    k++;
                });
            }
        }
    }
    
}
// 请款中按钮按下事件
function QKAmountClick() {
    // 到款和付款的checkbox不可用
    var QKAmountCbx = false;
    var QKCurrency = "";
    var QKSeq = "";
    var QKCurrencyCnt = "";
    var QKAmountCnt = "";
    // 点击初始可用
    var createZJPlanDisabled = false;
    var applyDKDisabled = false;
    var applyFKDisabled = false;
    var CurCnt = 0;
    var i = 0;
    // 资金计划
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        $(this).find("td[data-field='PayManagerTbl.DKTotalAmount'] :checkbox").attr("disabled", true);
        $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").attr("disabled", true);
        QKAmountCbx = $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").prop("checked");
        if (QKAmountCbx == true) {
            if (QKSeq != "" && QKCurrency != "" &&
                (QKSeq != $(this).find("td[data-field='PayManagerTbl.QKSeq'] [data-datafield='PayManagerTbl.QKSeq']").val()
                || QKCurrency != $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val())) {
                createZJPlanDisabled = true;
                applyDKDisabled = true;
                return false;
            }
            QKSeq = $(this).find("td[data-field='PayManagerTbl.QKSeq'] [data-datafield='PayManagerTbl.QKSeq']").val();
            QKCurrency = $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val();
            QKCurrencyCnt = $(this).find("td[data-field='PayManagerTbl.QKCurrencyCnt'] [data-datafield='PayManagerTbl.QKCurrencyCnt']").val();
            QKAmountCnt = $(this).find("td[data-field='PayManagerTbl.QKAmountCnt'] [data-datafield='PayManagerTbl.QKAmountCnt']").val();
            CurCnt += parseInt(QKAmountCnt);
            i++;
        }
    });
    if (CurCnt != parseInt(QKCurrencyCnt)) {
        createZJPlanDisabled = true;
        applyDKDisabled = true;
    }
    // 付款
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        QKAmountCbx = $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").prop("checked");
        if (QKAmountCbx == true) {
            if (QKCurrency !="" && QKCurrency != $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val()) {
                applyFKDisabled = true; return false;
            }
            QKCurrency = $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val();
        }
    });

    $(".createZJPlan").attr("disabled", createZJPlanDisabled);
    $(".applyDK").attr("disabled", applyDKDisabled);
    $(".applyFK").attr("disabled", applyFKDisabled);

    if (i == 0) {
        $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
            $(this).find("td[data-field='PayManagerTbl.DKTotalAmount'] :checkbox").attr("disabled", false);
            $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").attr("disabled", false);
        });
        $(".createZJPlan").attr("disabled", true);
        $(".applyDK").attr("disabled", true);
        $(".applyFK").attr("disabled", true);
    }
}

function DKFKAmountClick(el) {
    var index = el.parentElement.parentElement.parentElement.rowIndex;
    var QKCurrency = "";
    var QKSeq = "";
    var DKTotalAmountCbx = false;
    var FKAmountCbx = false;
    var applyJSDisabled = true;
    var i = 0;
    // 结算
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").attr("disabled", true);
        DKTotalAmountCbx = $(this).find("td[data-field='PayManagerTbl.DKTotalAmount'] :checkbox").prop("checked");
        if (DKTotalAmountCbx == true) {
            QKSeq = $(this).find("td[data-field='PayManagerTbl.QKSeq'] [data-datafield='PayManagerTbl.QKSeq']").val();
            QKCurrency = $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val();
        }
    });
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        FKAmountCbx = $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").prop("checked");
        if (FKAmountCbx == true) {
            if (QKSeq == $(this).find("td[data-field='PayManagerTbl.QKSeq'] [data-datafield='PayManagerTbl.QKSeq']").val() &&
                QKCurrency == $(this).find("td[data-field='PayManagerTbl.QKCurrency'] [data-datafield='PayManagerTbl.QKCurrency']").val()) {
                applyJSDisabled = false;
                return false;
            }
        }        
    });
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        var FKObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.FKObjectID", index - 2);
        var FKTblObjectID = $.MvcSheetUI.GetControlValue("PayManagerTbl.FKTblObjectID", index - 2);
        // 点击checkbox
        if (el.name == "FKAmount") {
            if (el.checked == true) {
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    var FKObjectID2 = $(this).find("td[data-field='PayManagerTbl.FKObjectID'] [data-datafield='PayManagerTbl.FKObjectID']").val();
                    var FKTblObjectID2 = $(this).find("td[data-field='PayManagerTbl.FKTblObjectID'] [data-datafield='PayManagerTbl.FKTblObjectID']").val();
                    if (FKObjectID == FKObjectID2 && FKTblObjectID != FKTblObjectID2) {
                        $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").prop("checked", true);
                    }
                });
            } else {
                $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
                    var FKObjectID2 = $(this).find("td[data-field='PayManagerTbl.FKObjectID'] [data-datafield='PayManagerTbl.FKObjectID']").val();
                    var FKTblObjectID2 = $(this).find("td[data-field='PayManagerTbl.FKTblObjectID'] [data-datafield='PayManagerTbl.FKTblObjectID']").val();
                    if (FKObjectID == FKObjectID2 && FKTblObjectID != FKTblObjectID2) {
                        $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").prop("checked", false);
                    }
                });
            }
        }

    });
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        DKTotalAmountCbx = $(this).find("td[data-field='PayManagerTbl.DKTotalAmount'] :checkbox").prop("checked");
        if (DKTotalAmountCbx == true) {
            i++;
        }
    });
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        FKAmountCbx = $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").prop("checked");
        if (FKAmountCbx == true) {
            i++;
        }
    });
    $(".applyJS").attr("disabled", applyJSDisabled);
    if (i == 0) {
        $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
            $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").attr("disabled", false);
        });
        $(".applyJS").attr("disabled", true);
    }
}

function createZJPlan(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkItemId = $.MvcSheetUI.GetControlValue('PlanWorkItemId');
    var WorkflowVersion_Plan = $.MvcSheetUI.GetControlValue('WorkflowVersion_Plan');
    var QKSubObjectIDs = "";
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        var QKAmountCbx = $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").prop("checked");
        if (QKAmountCbx == true) {
            QKSubObjectIDs += $(this).find("td[data-field='PayManagerTbl.QKSubObjectID'] [data-datafield='PayManagerTbl.QKSubObjectID']").val()+",";
        }
    });
    // 为空则发起流程，否则修改即可
    if (WorkItemId == "") {
        window.location.href = "/Portal/Sheets/Contract/ZJPlanMy.aspx?Mode=Originate&WorkflowCode=ZJPlan&WorkflowVersion=" + WorkflowVersion_Plan + "&ContractNo=" + ContractNo + "&QKSubObjectIDs=" + QKSubObjectIDs;
    } else {
        window.location.href = "/Portal/Sheets/Contract/ZJPlanMy.aspx?Mode=Work&WorkItemID=" + WorkItemId + "&ContractNo=" + ContractNo + "&QKSubObjectIDs=" + QKSubObjectIDs;
    }
}

function applyDK(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_DK = $.MvcSheetUI.GetControlValue("WorkflowVersion_DK");
    var QKSubObjectIDs = "";
    var DKStatus = "";
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        var QKAmountCbx = $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").prop("checked");
        if (QKAmountCbx == true) {
            QKSubObjectIDs += $(this).find("td[data-field='PayManagerTbl.QKSubObjectID'] [data-datafield='PayManagerTbl.QKSubObjectID']").val() + ",";
            var ds = $(this).find("td[data-field='PayManagerTbl.DKStatus'] [data-datafield='PayManagerTbl.DKStatus']").val();
            DKStatus = (typeof(ds) != "undefined" && ds != "") ? ds : DKStatus;
        }
    });
    if (DKStatus =="全部到款") {
        layer.alert('该请款已经全部到款，不能再申请到款！', { icon: 2 });
        return;
    } else {
        window.location.href = "/Portal/Sheets/Contract/DKMy.aspx?Mode=Originate&WorkflowCode=DK&WorkflowVersion=" + WorkflowVersion_DK + "&ContractNo=" + ContractNo + "&QKSubObjectIDs=" + QKSubObjectIDs;
    }
}

function applyFK(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_FK = $.MvcSheetUI.GetControlValue("WorkflowVersion_FK");
    var QKSubObjectIDs = "";
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        var QKAmountCbx = $(this).find("td[data-field='PayManagerTbl.QKAmount'] :checkbox").prop("checked");
        if (QKAmountCbx == true) {
            QKSubObjectIDs += $(this).find("td[data-field='PayManagerTbl.QKSubObjectID'] [data-datafield='PayManagerTbl.QKSubObjectID']").val() + ",";
        }
    });
    window.location.href = "/Portal/Sheets/Contract/FKMy.aspx?Mode=Originate&WorkflowCode=FK&WorkflowVersion=" + WorkflowVersion_FK + "&ContractNo=" + ContractNo + "&QKSubObjectIDs=" + QKSubObjectIDs;
}

function applyJS(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_JS = $.MvcSheetUI.GetControlValue("WorkflowVersion_JS");
    var JSStatus = "";
    var DKObjectIDs = "";
    $("[data-datafield='PayManagerTbl']").find("tr.rows td[data-field='PayManagerTbl.DKTotalAmount'] :checkbox").each(function () {
        var DKTotalAmountEl = $(this);
        var DKTotalAmountCbx = DKTotalAmountEl.prop("checked");
        if (DKTotalAmountCbx == true) {
            DKObjectIDs += DKTotalAmountEl.attr("data") + ",";
        }
    });
    var FKObjectIDs = "";
    $("[data-datafield='PayManagerTbl']").find("tr.rows").each(function () {
        var FKAmountCbx = $(this).find("td[data-field='PayManagerTbl.FKAmount'] :checkbox").prop("checked");
        if (FKAmountCbx == true) {
            FKObjectIDs += $(this).find("td[data-field='PayManagerTbl.FKObjectID'] [data-datafield='PayManagerTbl.FKObjectID']").val() + ",";
            var js = $(this).find("td[data-field='PayManagerTbl.JSStatus'] [data-datafield='PayManagerTbl.JSStatus']").val();
            JSStatus = (typeof (js) != "undefined" && js != "") != "" ? js : JSStatus;
        }
    });
    
    if (JSStatus == "已结算") {
        layer.alert('已进行结算了，不能再申请结算！', { icon: 2 });
        return;
    }
    else {
        window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=Originate&WorkflowCode=JS&WorkflowVersion=" + WorkflowVersion_JS + "&ContractNo=" + ContractNo + "&DKObjectIDs=" + DKObjectIDs + "&FKObjectIDs=" + FKObjectIDs; 
    }
}

function GetContractPropertyByContractNo(ContractNo) {
    var r = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            r = ret.ContractProperty;
        }
    });
    return r;
}