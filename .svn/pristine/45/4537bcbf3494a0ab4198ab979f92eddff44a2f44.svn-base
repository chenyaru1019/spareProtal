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
                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);
                $.MvcSheetUI.SetControlValue("ContractTotalPrice", ret.ContractTotalPrice + "人民币 " + ret.JKTotalAmount + ret.CurrencyName);
                $.MvcSheetUI.SetControlValue("Country", ret.Country);
                $.MvcSheetUI.SetControlValue("TradeMethod", ret.TradeMethodName);
                $.MvcSheetUI.SetControlValue("FinalUser", ret.FinalUser);
                $.MvcSheetUI.SetControlValue("Salers", ret.Salers);
                $.MvcSheetUI.SetControlValue("BidNo", ret.BidNo);
                $.MvcSheetUI.SetControlValue("ValuationType", ret.ValuationType);
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
    $("input[data-datafield='ContractType']").attr("disabled", "disabled");
    $("input[data-datafield='ContractProperty']").attr("disabled", "disabled");
    $("input[data-datafield='ContractTotalPrice']").attr("disabled", "disabled");
    $("input[data-datafield='Country']").attr("disabled", "disabled");
    $("input[data-datafield='TradeMethod']").attr("disabled", "disabled");
    $("input[data-datafield='FinalUser']").attr("disabled", "disabled");
    $("input[data-datafield='Salers']").attr("disabled", "disabled");
    $("input[data-datafield='BidNo']").attr("disabled", "disabled");
    $("input[data-datafield='ValuationType']").attr("disabled", "disabled");

    // 自定义文件格式 合同正本签字版
    $("#ContractFileSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
    var ContractFileSignVer = $.MvcSheetUI.GetControlValue("ContractFileSignVer");
    if (ContractFileSignVer != "") {
        var arr = ContractFileSignVer.split(",");
        $("#ContractFileSignVer").xnfile("value", arr);
    }
    var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
    if (IsHYFlg == "true") {
        // 自定义文件格式 协议正本签字版
        $("#AgencyFileSignVer").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\归档");
        var AgencyFileSignVer = $.MvcSheetUI.GetControlValue("AgencyFileSignVer");
        if (AgencyFileSignVer != "") {
            var arr = AgencyFileSignVer.split(",");
            $("#AgencyFileSignVer").xnfile("value", arr);
        }
        $(".HYDiv").show();
    } else {
        $(".HYDiv").hide();
    }


    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("ContractFileSignVer");
        setFileWriteable("AgencyFileSignVer");
    } else {
        setFileReadOnly("ContractFileSignVer");
        setFileReadOnly("AgencyFileSignVer");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackGDTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var ContractFileSignVer = $("#ContractFileSignVer").xnfile("value");
        $.MvcSheetUI.SetControlValue("ContractFileSignVer", ContractFileSignVer);
        var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
        if (IsHYFlg == "true") {
            var AgencyFileSignVer = $("#AgencyFileSignVer").xnfile("value");
            $.MvcSheetUI.SetControlValue("AgencyFileSignVer", AgencyFileSignVer);
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
                        if (CurActivity == "ActivityConfirm") {
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
                    GotoBackPage("GD", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackGDTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}