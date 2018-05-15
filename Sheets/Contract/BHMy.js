//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    var InputBizObjectID = getUrlParam("InputBizObjectID");
    if (InputBizObjectID != null && InputBizObjectID != "") {
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
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                }
                $.MvcSheetUI.SetControlValue("PostA", ret.PostACode);
                $.MvcSheetUI.SetControlValue("PostB", ret.PostBCode);
            }
        });
        // 根据InputBizObjectID获取对应相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByInputBizObjectID",   //处理页的相对地址
            data: {
                InputBizObjectID: InputBizObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                $.MvcSheetUI.SetControlValue("BHTarget2", ret.BHTarget);
                $.MvcSheetUI.SetControlValue("BHType2", ret.BHType);
                $.MvcSheetUI.SetControlValue("BHNo", ret.BHNo);
                $.MvcSheetUI.SetControlValue("BHProperty2", ret.BHProperty);
                $.MvcSheetUI.SetControlValue("ReceiveDate2", ret.ReceiveDate);
                $.MvcSheetUI.SetControlValue("BHAmount2", ret.BHAmount);
                $.MvcSheetUI.SetControlValue("ExpirationDate2", ret.ExpirationDate);
                $.MvcSheetUI.SetControlValue("Attachment2", ret.Attachment);
                $.MvcSheetUI.SetControlValue("BHGDQX2", ret.BHGDQX);
                $.MvcSheetUI.SetControlValue("RemindDate2", ret.RemindDate);
                $.MvcSheetUI.SetControlValue("ReturnAmountDate2", ret.ReturnAmountDate);
                $.MvcSheetUI.SetControlValue("Currency2", ret.Currency);
                $("[data-datafield='ApproveRemark2']").val(ret.ApproveRemark);
                //$.MvcSheetUI.SetControlValue("ApproveRemark2", ret.ApproveRemark);
            }
        });
        
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }


    $(".ApplyBH").show();
    $(".ApproveBH").show();
    $(".ConfirmBH").show();
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        // 只显示提交按钮
        $("li[data-action='Save']").hide();
        $("li[data-action='Print']").hide();
        $("li[data-action='Forward']").hide();
    }

    // 录保的数据只可见
    $("input[data-datafield='BHTarget2']").attr("disabled", "disabled");
    $("input[data-datafield='BHTarget2']").parent().find("a").hide();
    $("[data-datafield='BHType2']").attr("disabled", "disabled");
    $("[data-datafield='BHNo']").attr("disabled", "disabled");
    $("[data-datafield='BHProperty2']").attr("disabled", "disabled");
    $("[data-datafield='ReceiveDate2']").attr("disabled", "disabled");
    $("[data-datafield='BHAmount2']").attr("disabled", "disabled");
    $("[data-datafield='Currency2']").attr("disabled", "disabled");
    $("[data-datafield='BHGDQX2']").attr("disabled", "disabled");
    $("[data-datafield='ExpirationDate2']").attr("disabled", "disabled");
    $("[data-datafield='ReturnAmountDate2']").attr("disabled", "disabled");
    $("[data-datafield='RemindDate2']").attr("disabled", "disabled");
    $("[data-datafield='Remark2']").attr("disabled", "disabled");
    $("[data-datafield='Attachment2']").find("div").attr("disabled", "disabled");
    $("[data-datafield='Attachment2']").find("table tr").each(function () {
        $(this).find("a.fa-minus").hide();
    });
    $("[data-datafield='BHReceiptTbl2']").find("tr.rows").each(function () {
        $(this).find("td a.delete").hide();
    });
    $("[data-datafield='ApproveRemark2']").attr("disabled", "disabled");

    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");


    
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        $(".ApproveBH").hide();
        $(".ConfirmBH").hide();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYManager" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {
        $(".ApproveBH").show();
        $(".ConfirmBH").hide();

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHYCompanyLeader" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCompanyLeader") {
        $(".ApproveBH").show();
        $(".ConfirmBH").hide();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        $(".ApproveBH").show();
        $(".ConfirmBH").show();
    } 

    var BHType2 = $.MvcSheetUI.GetControlValue("BHType2");
    if (BHType2 == "保函") {
        $("[data-datafield='BankAccount']").hide();
        $("[data-datafield='BankName']").hide();
        $("[data-datafield='Receiver']").hide();
        $("[data-datafield='PayAttachment']").hide();
    }

    $("input[data-datafield='BHReceiptTbl2.ReceiptNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl2.PayTarget']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl2.Amount']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl2.Currency']").attr("disabled", "disabled");

    BHTypeChange();
    TBTypeChange();
    // 自定义文件格式 附件
    $("#Attachment2").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\保函");
    var Attachment2 = $.MvcSheetUI.GetControlValue("Attachment2");
    if (Attachment2 != "") {
        var arr = Attachment2.split(",");
        $("#Attachment2").xnfile("value", arr);
    }
    // 自定义文件格式 支付凭证
    $("#PayAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\保函");
    var PayAttachment = $.MvcSheetUI.GetControlValue("PayAttachment");
    if (PayAttachment != "") {
        var arr = PayAttachment.split(",");
        $("#PayAttachment").xnfile("value", arr);
    }
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileReadOnly("Attachment2");
        setFileWriteable("PayAttachment");
    } else {
        setFileReadOnly("Attachment2");
        setFileReadOnly("PayAttachment");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackBHTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }
}



function BHTypeChange() {
    var BHType2 = $.MvcSheetUI.GetControlValue("BHType2");
    // 如果是保证金，则保函固定期限、保函到期日等不显示
    if (BHType2 == "保证金") {
        $(".BHDiv").hide();
        $(".BZJDiv").show();
    } else if (BHType2 == "保函") {
        $(".BHDiv").show();
        $(".BZJDiv").hide();
    }
}


function TBTypeChange() {
    var TBType = $.MvcSheetUI.GetControlValue("TBType");
    var BHType2 = $.MvcSheetUI.GetControlValue("BHType2");
    if (BHType2 == "保证金") {
        if (TBType == "TB_TB") {
            $(".TBDiv").show();
        } else if (TBType == "TB_MS") {
            $(".TBDiv").hide();
        }
    } else {
        $(".TBDiv").hide();
    }
}




//function CurrencyChange() {
//    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
//    var CurrencyChangeFlg = $.MvcSheetUI.GetControlValue("CurrencyChangeFlg");
//    if (CurrencyChangeFlg == "true") {
//        var Currency = $.MvcSheetUI.GetControlValue("Currency");
//        var Contract = getContract(ContractNo);
//        if (Contract.Currency != Currency && Currency != "RMB") {
//            alert("只能选择人民币和合同外币！");
//            return false;
//        }
//    } else {
//        $.MvcSheetUI.SetControlValue("CurrencyChangeFlg", "true");
//        var Contract = getContract(ContractNo);
//        $.MvcSheetUI.SetControlValue("Currency", Contract.Currency);
//    }
//}

function CurrencyHiddenChange() {
    var dtl = $.MvcSheetUI.GetElement('BHReceiptTbl').SheetGridView();
    var len = dtl.RowCount;
    dtl._AddRow();
    var ReceiptNoHidden = $.MvcSheetUI.GetControlValue('ReceiptNoHidden');
    var PayTargetHidden = $.MvcSheetUI.GetControlValue('PayTargetHidden');
    var AmountHidden = $.MvcSheetUI.GetControlValue('AmountHidden');
    var CurrencyHidden = $.MvcSheetUI.GetControlValue('CurrencyHidden');
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.ReceiptNo", ReceiptNoHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.PayTarget", PayTargetHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.Amount", AmountHidden, len + 1);
    $.MvcSheetUI.SetControlValue("BHReceiptTbl.Currency", CurrencyHidden, len + 1);
    $("input[data-datafield='BHReceiptTbl.ReceiptNo']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.PayTarget']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Amount']").attr("disabled", "disabled");
    $("input[data-datafield='BHReceiptTbl.Currency']").attr("disabled", "disabled");
    var BHAmount = $.MvcSheetUI.GetControlValue('BHAmount');
    $.MvcSheetUI.SetControlValue('BHAmount', parseFloat(BHAmount) + parseFloat(AmountHidden));
}


// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var PayAttachment = $("#PayAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("PayAttachment", PayAttachment);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityFinance" || $.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOffice") {
        if (this.Action == "Submit") {
            var IsConfirmTB = $.MvcSheetUI.GetControlValue("IsConfirmTB");
            if (IsConfirmTB != "是;") {
                layer.alert('请选择确认退保！', { icon: 2 });
                return false;
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
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityFinance" || CurActivity == "ActivityOffice" ) {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
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
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
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
                            if (ret.InstanceActivity[i].ActivityName == "财务审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "办公室审批") {
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
                    GotoBackPage("BH", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackBHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}