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
                $.MvcSheetUI.SetControlValue("ContractName", ret.ContractName);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
                $.MvcSheetUI.SetControlValue("CurrencyRMBOld", "人民币");
                $.MvcSheetUI.SetControlValue("CurrencyRMBNew", "人民币");
                $.MvcSheetUI.SetControlValue("AmountRMBOld", ret.ContractTotalPrice);
                $.MvcSheetUI.SetControlValue("AmountWBOld", ret.JKTotalAmount);
                $.MvcSheetUI.SetControlValue("CurrencyWBOld", ret.CurrencyName);
                $.MvcSheetUI.SetControlValue("CurrencyWBNew", ret.CurrencyName);
                $.MvcSheetUI.SetControlValue("DHDateOld", ret.ContractDHDate);
                $.MvcSheetUI.SetControlValue("AgencyNumOld", ret.AgencyComputerNum);
                $.MvcSheetUI.SetControlValue("AgencyTypeOld", ret.AgencyComputerTypeName);
                $.MvcSheetUI.SetControlValue("PayConditionOld", ret.PayCondition);

                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);

                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
                //$("[data-datafield='AmountRMBNew']").hide();
                //$("input[data-datafield='CurrencyRMBNew']").hide();
                //$("[data-datafield='AmountWBNew']").hide();
                //$("input[data-datafield='CurrencyWBNew']").hide();
                //$("[data-datafield='DHDateNew']").hide();
                //$("[data-datafield='AgencyNumNew']").hide();
                //$(".AgencyTypeNewDiv").hide();
                //$("[data-datafield='PayConditionNew']").hide();
                
            }
        });

    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='CurrencyRMBOld']").attr("disabled", "disabled");
    $("input[data-datafield='CurrencyRMBNew']").attr("disabled", "disabled");
    $("input[data-datafield='AmountRMBOld']").attr("disabled", "disabled");
    $("input[data-datafield='AmountWBOld']").attr("disabled", "disabled");
    $("input[data-datafield='CurrencyWBOld']").attr("disabled", "disabled");
    $("input[data-datafield='CurrencyWBNew']").attr("disabled", "disabled");
    $("[data-datafield='DHDateOld']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyNumOld']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyTypeOld']").attr("disabled", "disabled");
    $("[data-datafield='PayConditionOld']").attr("disabled", "disabled");

    // 自定义文件格式 合同变更情况说明
    $("#RemarkAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同变更申请");
    var RemarkAttachment = $.MvcSheetUI.GetControlValue("RemarkAttachment");
    if (RemarkAttachment != "") {
        var arr = RemarkAttachment.split(",");
        $("#RemarkAttachment").xnfile("value", arr);
    }
    // 自定义文件格式 合同变更书
    $("#BGAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同变更申请");
    var BGAttachment = $.MvcSheetUI.GetControlValue("BGAttachment");
    if (BGAttachment != "") {
        var arr = BGAttachment.split(",");
        $("#BGAttachment").xnfile("value", arr);
    }
    // 自定义文件格式 代理协议变更书
    $("#AgencyBGAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同变更申请");
    var AgencyBGAttachment = $.MvcSheetUI.GetControlValue("AgencyBGAttachment");
    if (AgencyBGAttachment != "") {
        var arr = AgencyBGAttachment.split(",");
        $("#AgencyBGAttachment").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {

        $(".ApproveDiv").hide();
        $(".BGManager").hide();
        $(".BGLeader").hide();
        $(".BGConfirm").hide();

        setFileWriteable("RemarkAttachment");
        setFileWriteable("BGAttachment");
        setFileWriteable("AgencyBGAttachment");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYManager" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {
        $(".ApproveDiv").show();
        $(".BGManager").show();
        $(".BGLeader").hide();
        $(".BGConfirm").hide();

        setFileReadOnly("RemarkAttachment");
        setFileReadOnly("BGAttachment");
        setFileReadOnly("AgencyBGAttachment");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYCompanyLeader" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCompanyLeader") {
        $(".ApproveDiv").show();
        $(".BGManager").show();
        $(".BGLeader").show();
        $(".BGConfirm").hide();

        setFileReadOnly("RemarkAttachment");
        setFileReadOnly("BGAttachment");
        setFileReadOnly("AgencyBGAttachment");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        $(".ApproveDiv").show();
        $(".BGManager").show();
        $(".BGLeader").show();
        $(".BGConfirm").show();

        setFileReadOnly("RemarkAttachment");
        setFileReadOnly("BGAttachment");
        setFileReadOnly("AgencyBGAttachment");
    } 

    var ContractType = $.MvcSheetUI.GetControlValue("ContractType");
    var ContractProperty = $.MvcSheetUI.GetControlValue("ContractProperty");
    if (ContractType == "国内合同") {
        if (ContractProperty == "技术合同") {
            $(".GNAmountDiv").show();
            $(".JKAmountDiv").hide();
            $(".DHDateDiv").hide();
        } else if (ContractProperty == "货物合同") {
            $(".GNAmountDiv").show();
            $(".JKAmountDiv").hide();
            $(".DHDateDiv").show();
        } 
        $(".HYDiv").hide();
        
    } else {
        if (ContractProperty == "技术合同") {
            $(".GNAmountDiv").show();
            $(".JKAmountDiv").show();
            $(".DHDateDiv").hide();
            $(".HYDiv").hide();
        } else if (ContractProperty == "货物合同") {
            $(".GNAmountDiv").show();
            $(".JKAmountDiv").show();
            $(".DHDateDiv").show();
            $(".HYDiv").hide();
        } else if (ContractProperty == "航空煤油") {
            $(".GNAmountDiv").hide();
            $(".JKAmountDiv").hide();
            $(".DHDateDiv").show();
            $(".HYDiv").show();
        }
    }
    AmountRMBChange();
    AmountWBChange();
    DHDateChange();
    AgencyChange();
    PayConditionChange();


    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackBGTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }
}

function AmountRMBChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangeAmountRMB");

    if (v == "是") {
        $(".AmountRMBDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("AmountRMBNew", "");
        $(".AmountRMBDiv").hide();
    }

}

function AmountWBChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangeAmountWB");

    if (v == "是") {
        $(".AmountWBDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("AmountWBNew", "");
        $(".AmountWBDiv").hide();
    }

}

function DHDateChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangeDHDate");

    if (v == "是") {
        $(".DHDateNewDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("DHDateNew", "");
        $(".DHDateNewDiv").hide();
    }

}

function AgencyChange() {
    var v = $.MvcSheetUI.GetControlValue("IsChangeAgency");

    if (v == "是") {
        $(".AgencyDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("AgencyNumNew", "");
        $(".AgencyDiv").hide();
    }

}

function PayConditionChange() {
    var IsChangePayCondition = $.MvcSheetUI.GetControlValue("IsChangePayCondition");

    if (IsChangePayCondition == "是") {
        $(".PayConditionDiv").show();
    } else {
        $.MvcSheetUI.SetControlValue("PayConditionNew", "");
        $(".PayConditionDiv").hide();
    }

}


// 表单验证接口
$.MvcSheet.Validate = function () {
    // 变更合同金额 RMB
    var IsChangeAmountRMB = $.MvcSheetUI.GetControlValue("IsChangeAmountRMB");
    // 变更合同金额 WB
    var IsChangeAmountWB = $.MvcSheetUI.GetControlValue("IsChangeAmountWB");
    // 变更到货期
    var IsChangeDHDate = $.MvcSheetUI.GetControlValue("IsChangeDHDate");
    // 变更代理费率
    var IsChangeAgency = $.MvcSheetUI.GetControlValue("IsChangeAgency");
    // 变更支付条件
    var IsChangePayCondition = $.MvcSheetUI.GetControlValue("IsChangePayCondition");



    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var RemarkAttachment = $("#RemarkAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("RemarkAttachment", RemarkAttachment);
        var BGAttachment = $("#BGAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("BGAttachment", BGAttachment);
        var AgencyBGAttachment = $("#AgencyBGAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("AgencyBGAttachment", AgencyBGAttachment);
        if (this.Action == "Submit") {
            if (IsChangeAmountRMB == "是") {
                var AmountRMBNew = $.MvcSheetUI.GetControlValue("AmountRMBNew");
                if (parseFloat(AmountRMBNew) <= 0) {
                    layer.alert('合同变更金额必须大于0！', { icon: 2 });
                    return false;
                }
            } 
            if (IsChangeAmountWB == "是") {
                var AmountWBNew = $.MvcSheetUI.GetControlValue("AmountWBNew");
                if (parseFloat(AmountWBNew) <= 0) {
                    layer.alert('合同变更金额必须大于0！', { icon: 2 });
                    return false;
                }
            } 
            if (IsChangeDHDate == "是") {
                var DHDateNew = $.MvcSheetUI.GetControlValue("DHDateNew");
                if (DHDateNew == "") {
                    layer.alert('请填写合同到货期！', { icon: 2 });
                    return false;
                }
            } 
            if (IsChangeAgency == "是") {
                var AgencyNumNew = $.MvcSheetUI.GetControlValue("AgencyNumNew");
                if (parseFloat(AgencyNumNew) <= 0) {
                    layer.alert('代理费费率／金额必须大于0！', { icon: 2 });
                    return false;
                }
            } 
            if (IsChangePayCondition == "是") {
                var PayConditionNew = $.MvcSheetUI.GetControlValue("PayConditionNew");
                if (PayConditionNew == "") {
                    layer.alert('请填写支付条件！', { icon: 2 });
                    return false;
                }
            } 

        }
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
                    console.log("GetAdjustActivityInfo=" + ret);
                    for (var i = 0; i < ret.InstanceActivity.length; i++) {
                        if (CurActivity == "ActivityHYManager" || CurActivity == "ActivityManager") {
                            if (ret.InstanceActivity[i].ActivityName == "变更发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "变更发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "变更发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "变更发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "变更发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "确认") {
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
                    GotoBackPage("BG", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackBGTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}