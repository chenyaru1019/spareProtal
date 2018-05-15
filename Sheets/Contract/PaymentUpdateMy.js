﻿//数据加载后
$.MvcSheet.Loaded = function () {


    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        $(".ManagerApprove").hide();
        $(".CompanyLeaderApprove").hide();
        $(".PaymentOperate").hide();

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
                    $.MvcSheetUI.SetControlValue("PaymentType", "改证");
                    if (ret.ContractProperty == "航空煤油") {
                        $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                    } else {
                        $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                    }
                }
            });
        } else {
            ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        }

        $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
        $("input[data-datafield='ContractName']").attr("disabled", "disabled");
        $("input[data-datafield='PostAB']").attr("disabled", "disabled");
        $("input[data-datafield='PaymentType']").attr("disabled", "disabled");
        // 信用证编号
        var PaymentObjectID = getUrlParam("PaymentId");
        if (PaymentObjectID != null && PaymentObjectID != "") {
            $.MvcSheetUI.SetControlValue("PaymentObjectID", PaymentObjectID);
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=getPaymentByID",   //处理页的相对地址
                data: {
                    PaymentObjectID: PaymentObjectID,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    if (ret != null && ret != "") {
                        $.MvcSheetUI.SetControlValue("PaymentNo", ret.PaymentNo);
                        $.MvcSheetUI.SetControlValue("PaymentAmount", ret.PaymentAmount);
                        $.MvcSheetUI.SetControlValue("CurrencyWBCode", ret.Currency);
                    }
                }
            });
        }
        $("input[data-datafield='PaymentNo']").attr("disabled", "disabled");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYManager" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {
        $(".ManagerApprove").show();
        $(".CompanyLeaderApprove").hide();
        $(".PaymentOperate").hide();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYCompanyLeader" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCompanyLeader") {
        $(".ManagerApprove").show();
        $(".CompanyLeaderApprove").show();
        $(".PaymentOperate").hide();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        $(".ManagerApprove").show();
        $(".CompanyLeaderApprove").show();
        $(".PaymentOperate").show();
        // 根据信用证编号获取对应信用证相关数据
        var PaymentObjectID = $.MvcSheetUI.GetControlValue("PaymentObjectID");
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getPaymentByID",   //处理页的相对地址
            data: {
                PaymentObjectID: PaymentObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != null && ret != "") {
                    var PaymentUpdateDate = $.MvcSheetUI.GetControlValue("PaymentUpdateDate");
                    var ExpirationDate = $.MvcSheetUI.GetControlValue("ExpirationDate");
                    var RemindDate = $.MvcSheetUI.GetControlValue("RemindDate");
                    var OperateRemark = $.MvcSheetUI.GetControlValue("OperateRemark");
                    if (PaymentUpdateDate == null || PaymentUpdateDate == "") {
                        $.MvcSheetUI.SetControlValue("PaymentUpdateDate", ret.PaymentDate);
                    }
                    if (ExpirationDate == null || ExpirationDate == "") {
                        $.MvcSheetUI.SetControlValue("ExpirationDate", ret.ExpirationDate);
                    }
                    if (RemindDate == null || RemindDate == "") {
                        $.MvcSheetUI.SetControlValue("RemindDate", ret.RemindDate);
                    }
                    if (OperateRemark == null || OperateRemark == "") {
                        $.MvcSheetUI.SetControlValue("OperateRemark", ret.OperateRemark);
                    }
                }
                
            }
        });
    } 
    $("input[data-datafield='CurrencyChangeFlg']").next().hide();
    $("[data-datafield='Currency']").attr("disabled", "disabled");

    // 自定义文件格式 附件
    $("#Attachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\信用证");
    var Attachment = $.MvcSheetUI.GetControlValue("Attachment");
    if (Attachment != "") {
        var arr = Attachment.split(",");
        $("#Attachment").xnfile("value", arr);
    }
    // 自定义文件格式 信用证副本
    $("#PaymentAttachment").xnfile().xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\信用证");
    var PaymentAttachment = $.MvcSheetUI.GetControlValue("PaymentAttachment");
    if (PaymentAttachment != "") {
        var arr = PaymentAttachment.split(",");
        $("#PaymentAttachment").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Attachment");
        setFileHide("PaymentAttachment");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        setFileReadOnly("Attachment");
        setFileWriteable("PaymentAttachment");
    } else {
        setFileReadOnly("Attachment");
        setFileHide("PaymentAttachment");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackPaymentUpdateSubTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
}

$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
            var PaymentObjectID = $.MvcSheetUI.GetControlValue("PaymentObjectID");
            // 设置表单的已改证标识为“改证中”
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=setChangePayment",   //处理页的相对地址
                data: {
                    PaymentObjectID: PaymentObjectID,
                    Status: 2,
                },
                //async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据

                }
            });
        }

        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
            var PaymentObjectID = $.MvcSheetUI.GetControlValue("PaymentObjectID");
            var PaymentAmount = $.MvcSheetUI.GetControlValue("PaymentAmount");
            // 设置表单的已改证标识为“已改证”
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=setChangePayment",   //处理页的相对地址
                data: {
                    PaymentObjectID: PaymentObjectID,
                    Status: 4,
                    PaymentAmount: PaymentAmount,
                },
                //async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据

                }
            });
        }
    }
}

function ChangeDemo() {
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var CurrencyWBCode = $.MvcSheetUI.GetControlValue("CurrencyWBCode");
        $.MvcSheetUI.SetControlValue("Currency", CurrencyWBCode);
    }

}

//function CurrencyChange() {
//    var CurrencyChangeFlg = $.MvcSheetUI.GetControlValue("CurrencyChangeFlg");
//    if (CurrencyChangeFlg == "true") {
//        return;
//    } else {
//        $.MvcSheetUI.SetControlValue("CurrencyChangeFlg", "true");
//        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
//        if (ContractNo != null && ContractNo != "") {
//            // 根据合同号码获取对应合同相关数据
//            $.ajax({
//                type: "POST",    //页面请求的类型
//                url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
//                data: {
//                    ContractNo: ContractNo,
//                },
//                async: false,
//                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//                    $.MvcSheetUI.SetControlValue("Currency", ret.Currency);
//                }
//            });
//        }
//    }
//}

function ExpirationDateChange() {
    var ExpirationDate = $("input[data-datafield='ExpirationDate']").val();
    var RemindDate = lastMonthDate(ExpirationDate) ;
    $("input[data-datafield='RemindDate']").val(RemindDate);
}


// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    // 当前节点是节点
    //if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
    //    $.MvcSheetUI.SetControlValue("RejectFlg", "0");
    //}
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Attachment = $("#Attachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("Attachment", Attachment);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOperate") {
        var PaymentAttachment = $("#PaymentAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("PaymentAttachment", PaymentAttachment);
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
                            if (ret.InstanceActivity[i].ActivityName == "信用证改证发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "信用证改证发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "信用证改证发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityOperate") {
                            if (ret.InstanceActivity[i].ActivityName == "信用证改证发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "信用证改证发起") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "开证执行") {
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
                    GotoBackPage("PaymentUpdateSub", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackPaymentUpdateSubTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}