//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    // InstanceId
    var NeedInstanceId = getUrlParam("InstanceId");
    var NeedInstanceActivity = getUrlParam("InstanceActivity");
    var Module = getUrlParam("Module");
    var CurInstanceActivity = getUrlParam("CurInstanceActivity");
    var InstanceActivityName = GetName(Module,NeedInstanceActivity);
    var OldInstanceActivityName = GetName(Module,CurInstanceActivity);
    if (ContractNo != null && ContractNo != ""
        && NeedInstanceId != null && NeedInstanceId != ""
        && NeedInstanceActivity != null && NeedInstanceActivity != "") {
        // 设置相关数据
        $.MvcSheetUI.SetControlValue("ContractNo", ContractNo);
        $.MvcSheetUI.SetControlValue("NeedInstanceId", NeedInstanceId);
        $.MvcSheetUI.SetControlValue("NeedInstanceActivity", NeedInstanceActivity);
        $.MvcSheetUI.SetControlValue("InstanceActivityName", InstanceActivityName);
        $.MvcSheetUI.SetControlValue("OldInstanceActivityName", OldInstanceActivityName);
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
            }
        });
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='InstanceActivityName']").attr("disabled", "disabled");
    $("input[data-datafield='OldInstanceActivityName']").attr("disabled", "disabled");
}

function GetName(Module, InstanceActivity) {
    if (Module == "ContractMain") {
        if (InstanceActivity == "ActivityCreate") {
            return "创建合同";
        } else if (InstanceActivity == "ActivityApprove") {
            return "合同审签";
        } else if (InstanceActivity == "ActivityOperate") {
            return "合同执行";
        } else if (InstanceActivity == "End") {
            return "合同完成";
        } 
    } else if (Module == "QK" || Module == "BatchQK") {
        if (InstanceActivity == "ActivityOrig" && Module == "QK" ) {
            return "发起申请";
        } else if (InstanceActivity == "ActivityOrig" && Module == "BatchQK") {
            return "批量请款申请";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门审批";
        } else if (InstanceActivity == "ActivityHYCompanyLeader") {
            return "公司领导审批";
        } else if (InstanceActivity == "ActivityCompanyLeader") {
            return "非航油领导审批";
        } else if (InstanceActivity == "ActivityConfirm" && Module == "QK" ) {
            return "请款送达确认";
        } else if (InstanceActivity == "ActivityConfirm" && Module == "BatchQK") {
            return "批量请款送达确认";
        } else if (InstanceActivity == "ActivityDKConfirm" && Module == "BatchQK") {
            return "到款确认";
        } 
    } else if (Module == "DK" || Module == "BatchDK") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityConfirm") {
            return "复核";
        } 
    } else if (Module == "FK" || Module == "BatchFK") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门审批";
        } else if (InstanceActivity == "ActivityHYCompanyManager") {
            return "航油领导审批";
        } else if (InstanceActivity == "ActivityCompanyManager") {
            return "非航油领导审批";
        } else if (InstanceActivity == "ActivityConfirm") {
            return "财务确认";
        }
    } else if (Module == "BatchJQ") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起批量结清";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门审批";
        } else if (InstanceActivity == "ActivityHYCompanyManager") {
            return "航油领导审批";
        } else if (InstanceActivity == "ActivityCompanyManager") {
            return "非航油领导审批";
        }
    } else if (Module == "GD" || Module == "GDChange") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityConfirm") {
            return "审批";
        }
    } else if (Module == "BH") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门审批";
        } else if (InstanceActivity == "ActivityHYCompanyLeader") {
            return "航油领导审批";
        } else if (InstanceActivity == "ActivityCompanyLeader") {
            return "非航油领导审批";
        } else if (InstanceActivity == "ActivityFinance") {
            return "财务审批";
        } else if (InstanceActivity == "ActivityOffice") {
            return "办公室审批";
        }
    } else if (Module == "BG") {
        if (InstanceActivity == "ActivityOrig") {
            return "变更发起";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门审批";
        } else if (InstanceActivity == "ActivityHYCompanyLeader") {
            return "航油领导审批";
        } else if (InstanceActivity == "ActivityCompanyLeader") {
            return "非航油领导审批";
        } else if (InstanceActivity == "ActivityConfirm") {
            return "确认";
        } 
    } else if (Module == "DH" || Module == "DHHY") {
        if (InstanceActivity == "ActivityApply") {
            return "到货申请";
        } else if (InstanceActivity == "ActivityCheck") {
            return "复核";
        } else if (InstanceActivity == "ActivityEntrust") {
            return "报关委托";
        } else if (InstanceActivity == "ActivityConfirm") {
            return "确认";
        } else if (InstanceActivity == "ActivityComplete") {
            return "报关完成";
        } else if (InstanceActivity == "ActivityXB") {
            return "销保";
        }
    } else if (Module == "ImportLicenseSub") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityApprove") {
            return "审批";
        }
    } else if (Module == "PaymentSub" || Module == "PaymentUpdateSub") {
        if (Module == "PaymentSub" && InstanceActivity == "ActivityOrig") {
            return "信用证发起";
        } else if (Module == "PaymentUpdateSub" && InstanceActivity == "ActivityOrig") {
            return "信用证改证发起";
        } else if (InstanceActivity == "ActivityBankApprove") {
            return "开证行确认";
        } else if (InstanceActivity == "ActivityPaymentApprove") {
            return "信用证申请";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门经理审批";
        } else if (InstanceActivity == "ActivityHYCompanyLeader") {
            return "航油公司领导审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门经理审批";
        } else if (InstanceActivity == "ActivityCompanyLeader") {
            return "非航油公司领导审批";
        } else if (InstanceActivity == "ActivityOperate") {
            return "开证执行";
        }
    } else if (Module == "ContractApprove") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityHYManager") {
            return "航油部门经理审批";
        } else if (InstanceActivity == "ActivityHYCompanyLeader") {
            return "航油公司领导审批";
        } else if (InstanceActivity == "ActivityManager") {
            return "非航油部门经理审批";
        } else if (InstanceActivity == "ActivityCompanyLeader") {
            return "非航油公司领导审批";
        } else if (InstanceActivity == "ActivityFinance") {
            return "财务会审";
        }
    }
    else if (Module == "UpdateContractNo") {
        if (InstanceActivity == "ActivityOrig") {
            return "发起申请";
        } else if (InstanceActivity == "ActivityApprove") {
            return "审批";
        }
    }
    
}
// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityAdmin") {
            var UserID = $.MvcSheetUI.SheetInfo.UserID;
            doGoBack(UserID);
        }
    }
}

// 先取消，再激活，再调整活动节点
function doGoBack(UserID) {
    //alert(ActivityCode);
    var NeedInstanceId = $.MvcSheetUI.GetControlValue("NeedInstanceId");
    var NeedActivityCode = $.MvcSheetUI.GetControlValue("NeedInstanceActivity");
    var participants = new Array();
    participants.push(UserID);//("18f923a7-5a5e-426d-94ae-a55ad1a4b239");
    // ------ 取消
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/InstanceDetail/CancelInstance",   //处理页的相对地址
        async: false,
        data: {
            InstanceID: NeedInstanceId,
        },
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.SUCCESS == true) {
                // ------ 激活
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "/Portal/InstanceDetail/ActivateInstance",   //处理页的相对地址
                    async: false,
                    data: {
                        InstanceID: NeedInstanceId,
                    },
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        if (ret.SUCCESS == true) {
                            // ------ 调整活动节点

                            $.ajax({
                                type: "POST",    //页面请求的类型
                                url: "/Portal/InstanceDetail/ActivateActivity",   //处理页的相对地址
                                async: false,
                                data: {
                                    InstanceID: NeedInstanceId,
                                    ActivityCode: NeedActivityCode,
                                    Participants: participants,
                                },
                                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                                    if (ret.SUCCESS == true) {
                                        layer.alert('回退成功！', { icon: 2 });
                                    } else {
                                        layer.alert('回退失败！（调整活动节点失败）', { icon: 2 });
                                    }
                                }
                            });
                        } else {
                            layer.alert('回退失败！（激活流程失败）', { icon: 2 });
                        }
                    }
                });
            } else {
                layer.alert('回退失败！（取消流程失败）', { icon: 2 });
            }
        }
    });
}

