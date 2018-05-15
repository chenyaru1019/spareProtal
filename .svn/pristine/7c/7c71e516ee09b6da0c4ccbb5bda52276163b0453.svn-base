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

                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg","1");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "0");
                }

            }
        });
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");


    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        $(".ActivityApprove").hide();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
        $(".ActivityApprove").show();
    }

    var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
    if (IsHYFlg == "1") {
        $(".HYClass").show();
        $(".NoHYClass").hide();
    } else {
        $(".HYClass").hide();
        $(".NoHYClass").show();
    }

    $("input[data-datafield='CurrencyChangeFlg']").next().hide();

    // 自定义文件格式 附件
    $("#Attachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\进口许可证");
    var Attachment = $.MvcSheetUI.GetControlValue("Attachment");
    if (Attachment != "") {
        var arr = Attachment.split(",");
        $("#Attachment").xnfile("value", arr);
    }
    // 自定义文件格式 进口许可证副本
    $("#ApproveAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\进口许可证");
    var ApproveAttachment = $.MvcSheetUI.GetControlValue("ApproveAttachment");
    if (ApproveAttachment != "") {
        var arr = ApproveAttachment.split(",");
        $("#ApproveAttachment").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("Attachment");
        setFileHide("ApproveAttachment");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
        setFileReadOnly("Attachment");
        setFileWriteable("ApproveAttachment");
    } else {
        setFileReadOnly("Attachment");
        setFileHide("ApproveAttachment");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackImportLicenseSubTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
}

function CurrencyChange() {
    var CurrencyChangeFlg = $.MvcSheetUI.GetControlValue("CurrencyChangeFlg");
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    if (CurrencyChangeFlg == "true") {
        var Currency = $.MvcSheetUI.GetControlValue("Currency_N");
        var Contract = getContract(ContractNo);
        if (Contract.Currency != Currency && Currency != "RMB") {
            layer.alert('只能选择人民币和合同外币！', { icon: 2 });
            return false;
        }
    } else {
        $.MvcSheetUI.SetControlValue("CurrencyChangeFlg", "true");
        var Contract = getContract(ContractNo);
        $.MvcSheetUI.SetControlValue("Currency_N", Contract.Currency);
    }
}



function ExpirationDateChange() {
    var ExpirationDate = $("input[data-datafield='ExpirationDate']").val();
    var RemindDate = lastMonthDate(ExpirationDate) ;
    $("input[data-datafield='RemindDate']").val(RemindDate);
}

// 表单验证接口
$.MvcSheet.Validate = function () {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    // 申请进口单位 [SQJKDW_HY]
    var SQJKDW_HY = $.MvcSheetUI.GetControlValue("SQJKDW_HY");
    // 申请单位经办人 [SQDWJJR_HY]
    var SQDWJJR_HY = $.MvcSheetUI.GetControlValue("SQDWJJR_HY");
    // 地区及企业法人代码 [DQJQYCode_HY]
    var DQJQYCode_HY = $.MvcSheetUI.GetControlValue("DQJQYCode_HY");
    // 电话 [Telephone_HY]
    var Telephone_HY = $.MvcSheetUI.GetControlValue("Telephone_HY");
    // 申请进口单位地址 [SQJKDWAddress_HY]
    var SQJKDWAddress_HY = $.MvcSheetUI.GetControlValue("SQJKDWAddress_HY");
    // 邮政编码 [ZipCode_HY]
    var ZipCode_HY = $.MvcSheetUI.GetControlValue("ZipCode_HY");
    // 进口使用单位 [JKSYDW_HY]
    var JKSYDW_HY = $.MvcSheetUI.GetControlValue("JKSYDW_HY");
    // 对外成交单位 [DWCJDW_HY]
    var DWCJDW_HY = $.MvcSheetUI.GetControlValue("DWCJDW_HY");
    // 地区及企业法人代码（进口使用单位） [JKDWCode_HY]
    var JKDWCode_HY = $.MvcSheetUI.GetControlValue("JKDWCode_HY");
    // 地区及企业法人代码（对外成交单位） [DWDWCode_HY]
    var DWDWCode_HY = $.MvcSheetUI.GetControlValue("DWDWCode_HY");
    // 贸易方式 [TradeType_HY]
    var TradeType_HY = $.MvcSheetUI.GetControlValue("TradeType_HY");
    // 贸易国(地区) [TradeArea_HY]
    var TradeArea_HY = $.MvcSheetUI.GetControlValue("TradeArea_HY");
    // 是否国营贸易 [IsCountryTrade_HY]
    var IsCountryTrade_HY = $.MvcSheetUI.GetControlValue("IsCountryTrade_HY");
    // 外汇来源 [WHLY_HY]
    var WHLY_HY = $.MvcSheetUI.GetControlValue("WHLY_HY");
    // 原产地国(地区) [OrigArea_HY]
    var OrigArea_HY = $.MvcSheetUI.GetControlValue("OrigArea_HY");
    // 报关口岸 [BGKA_HY]
    var BGKA_HY = $.MvcSheetUI.GetControlValue("BGKA_HY");
    // 商品用途 [GoodUse_HY]
    var GoodUse_HY = $.MvcSheetUI.GetControlValue("GoodUse_HY");
    // 预计到港时间 [ImportDate_HY]
    var ImportDate_HY = $.MvcSheetUI.GetControlValue("ImportDate_HY");
    
    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var Attachment = $("#Attachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("Attachment", Attachment);
        if (this.Action == "Submit") {
            var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
            // 航油时做如下验证
            if (IsHYFlg == "1") {
                if (!SQJKDW_HY) {
                    $.MvcSheetUI.GetElement("SQJKDW_HY").focus();
                    layer.alert('请填写申请进口单位.', { icon: 2 });
                    return false;
                }
                if (!SQDWJJR_HY) {
                    $.MvcSheetUI.GetElement("SQDWJJR_HY").focus();
                    layer.alert('请填写申请单位经办人.', { icon: 2 });
                    return false;
                }
                if (!DQJQYCode_HY) {
                    $.MvcSheetUI.GetElement("DQJQYCode_HY").focus();
                    layer.alert('请填写地区及企业法人代码.', { icon: 2 });
                    return false;
                }
                if (!Telephone_HY) {
                    $.MvcSheetUI.GetElement("Telephone_HY").focus();
                    layer.alert('请填写电话.', { icon: 2 });
                    return false;
                }
                if (!SQJKDWAddress_HY) {
                    $.MvcSheetUI.GetElement("SQJKDWAddress_HY").focus();
                    layer.alert('请填写申请进口单位地址.', { icon: 2 });
                    return false;
                }
                if (!ZipCode_HY) {
                    $.MvcSheetUI.GetElement("ZipCode_HY").focus();
                    layer.alert('请填写邮政编码.', { icon: 2 });
                    return false;
                }
                if (!JKSYDW_HY) {
                    $.MvcSheetUI.GetElement("JKSYDW_HY").focus();
                    layer.alert('请填写进口使用单位.', { icon: 2 });
                    return false;
                }
                if (!DWCJDW_HY) {
                    $.MvcSheetUI.GetElement("DWCJDW_HY").focus();
                    layer.alert('请填写对外成交单位.', { icon: 2 });
                    return false;
                }
                if (!JKDWCode_HY) {
                    $.MvcSheetUI.GetElement("JKDWCode_HY").focus();
                    layer.alert('请填写地区及企业法人代码.', { icon: 2 });
                    return false;
                }
                if (!DWDWCode_HY) {
                    $.MvcSheetUI.GetElement("DWDWCode_HY").focus();
                    layer.alert('请填写地区及企业法人代码.', { icon: 2 });
                    return false;
                }
                if (!TradeType_HY) {
                    $.MvcSheetUI.GetElement("TradeType_HY").focus();
                    layer.alert('请填写贸易方式.', { icon: 2 });
                    return false;
                }
                if (!TradeArea_HY) {
                    $.MvcSheetUI.GetElement("TradeArea_HY").focus();
                    layer.alert('请填写贸易国(地区).', { icon: 2 });
                    return false;
                }
                if (!IsCountryTrade_HY) {
                    $.MvcSheetUI.GetElement("IsCountryTrade_HY").focus();
                    layer.alert('请填写是否国营贸易.', { icon: 2 });
                    return false;
                }
                if (!WHLY_HY) {
                    $.MvcSheetUI.GetElement("WHLY_HY").focus();
                    layer.alert('请填写外汇来源.', { icon: 2 });
                    return false;
                }
                if (!OrigArea_HY) {
                    $.MvcSheetUI.GetElement("OrigArea_HY").focus();
                    layer.alert('请填写原产地国(地区).', { icon: 2 });
                    return false;
                }
                if (!BGKA_HY) {
                     $.MvcSheetUI.GetElement("BGKA_HY").focus();
                     layer.alert('请填写报关口岸.', { icon: 2 });
                    return false;
                }
                if (!GoodUse_HY) {
                     $.MvcSheetUI.GetElement("GoodUse_HY").focus();
                     layer.alert('请填写商品用途.', { icon: 2 });
                     return false;
                 }
                if (!ImportDate_HY) {
                    $.MvcSheetUI.GetElement("ImportDate_HY").focus();
                    layer.alert('请填写预计到港时间.', { icon: 2 });
                    return false;
                 }
            } 
            if (IsHYFlg == "0") {
                var Currency = $.MvcSheetUI.GetControlValue("Currency_N");
                var Contract = getContract(ContractNo);
                if (Contract.Currency != Currency && Currency != "RMB") {
                    layer.alert('币种只能选择人民币和合同外币！', { icon: 2 });
                    return false;
                }
            }
           
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
        var ApproveAttachment = $("#ApproveAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("ApproveAttachment", ApproveAttachment);
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
                        if (CurActivity == "ActivityApprove") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "审批") {
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
                    GotoBackPage("ImportLicenseSub", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackImportLicenseSubTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}