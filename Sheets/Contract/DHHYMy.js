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
                $.MvcSheetUI.SetControlValue("CurrencyRMB", "人民币");
                $.MvcSheetUI.SetControlValue("CurrencyWB", ret.CurrencyName);
            }
        });

        // 根据合同号码获取批次数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDHSeq",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                $.MvcSheetUI.SetControlValue("DHSeq", ret);

            }
        });
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractNo_Entrust']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='ShopTable_Entrust.Num']").attr("disabled", "disabled");
    $("input[data-datafield='Date90']").attr("disabled", "disabled");
    $(".CurrencyRMB").text($.MvcSheetUI.GetControlValue("CurrencyRMB"));
    $(".CurrencyWB").text($.MvcSheetUI.GetControlValue("CurrencyWB"));

    // 自定义文件格式 报关单
    $("#BGAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\到货");
    var BGAttachment = $.MvcSheetUI.GetControlValue("BGAttachment");
    if (BGAttachment != "") {
        var arr = BGAttachment.split(",");
        $("#BGAttachment").xnfile("value", arr);
    }
    // 自定义文件格式 新报关文
    $("#NewBGFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\到货");
    var NewBGFile = $.MvcSheetUI.GetControlValue("NewBGFile");
    if (NewBGFile != "") {
        var arr = NewBGFile.split(",");
        $("#NewBGFile").xnfile("value", arr);
    }

   if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").show();
        $(".DHComplete").show();
        $(".DHXB").hide();
        // 获取海关保证金数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getHGBZJ",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("HGBZJTbl_HY").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.ZJKX", ret[i].ZJKX, i + 1); 
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.PayAmount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.ConvertAmount", ret[i].ConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.PayContent", ret[i].PayContent, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.PayType", ret[i].PayType, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl_HY.Receiver", ret[i].Receiver, i + 1);
                }
                $("input[data-datafield='HGBZJTbl_HY.ZJKX']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl_HY.PayAmount']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl_HY.ConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl_HY.PayContent']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl_HY.PayType']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl_HY.Receiver']").attr("disabled", "disabled"); 

            }
        });

        setFileWriteable("BGAttachment");
        setFileHide("NewBGFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityXB") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").show();
        $(".DHComplete").show();
        $(".DHXB").show();
        // 获取销保数据
        var dtl = $.MvcSheetUI.GetElement("HGBZJTbl_HY").SheetGridView();
        var dtl_XB = $.MvcSheetUI.GetElement("XBTbl_HY").SheetGridView();
        dtl_XB._Clear();
        for (var i = 0; i < dtl.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.IsCheck", i + 1).split(";")[0];
            // 选中(选中为" " ,没选中没"")
            if (IsCheck == " ") {
                dtl_XB._AddRow();
                $.MvcSheetUI.SetControlValue("XBTbl_HY.ZJKX", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.ZJKX", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl_HY.PayAmount", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.PayAmount", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl_HY.ConvertAmount", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.ConvertAmount", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl_HY.PayContent", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.PayContent", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl_HY.PayType", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.PayType", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl_HY.Receiver", $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.Receiver", i + 1), i + 1);
            }
        }
        $("input[data-datafield='XBTbl_HY.ZJKX']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl_HY.PayAmount']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl_HY.ConvertAmount']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl_HY.PayContent']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl_HY.PayType']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl_HY.Receiver']").attr("disabled", "disabled");

        setFileReadOnly("BGAttachment");
        setFileWriteable("NewBGFile");
    } 


   // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
   var dtl_back = $.MvcSheetUI.GetElement("GetBackDHHYTbl").SheetGridView();
   if (dtl_back.RowCount > 0) {
       $(".ContractContentGetBack").show();
   } else {
       $(".ContractContentGetBack").hide();
   }
   SearchApprovalTbl();
}


function ExpirationDateChange() {
    var ExpectShipDate = $("input[data-datafield='ExpectShipDate']").val();
    var RemindDate = lastMonthDate(ExpectShipDate) ;
    $("input[data-datafield='RemindDate']").val(RemindDate);
}

function BGSignDateChange() {
    var BGSignDate = $("input[data-datafield='BGSignDate']").val();
    var Date90 = last3MonthDate(BGSignDate,90);
    $("input[data-datafield='Date90']").val(Date90);
}

function XBStatusChange(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;

    if ($.MvcSheetUI.GetControlValue('XBTbl_HY.XBStatus', rowIndex - 1) == "YTB") {
        var k = 1;
        $("[data-datafield='XBTbl_HY']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='XBTbl_HY.TBAmount']").attr("disabled", false);
                $(this).find("input[data-datafield='XBTbl_HY.TBDate']").attr("disabled", false);
            }
            k++;
        });
    } else {
        var k = 1;
        $("[data-datafield='XBTbl_HY']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='XBTbl_HY.TBAmount']").attr("disabled", "disabled");
                $(this).find("input[data-datafield='XBTbl_HY.TBDate']").attr("disabled", "disabled");
            }
            k++;
        });
        $.MvcSheetUI.SetControlValue('XBTbl_HY.TBAmount', "", rowIndex - 1);
        $.MvcSheetUI.SetControlValue('XBTbl_HY.TBDate', "", rowIndex - 1);
    }

}



function GoodNameChange(el) {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var DHSeq = $.MvcSheetUI.GetControlValue("DHSeq");
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var GoodName = $.MvcSheetUI.GetControlValue('ShopTable_Entrust.GoodName', rowIndex - 1);
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getGoodNum",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            DHSeq: DHSeq,
            GoodName: GoodName,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var rowIndex = el.parentElement.parentElement.rowIndex;
            $.MvcSheetUI.SetControlValue('ShopTable_Entrust.Num', ret, rowIndex - 1);
        }
    });

    //var count = $("[data-datafield='ShopTable_Entrust']").find('tr.rows').length;
    //var i = 0;
    //$("[data-datafield='ShopTable_Entrust']").find('tr.rows').each(function () {
    //    if (i == rowIndex) {
    //        var GoodName = $(this).find("[data-datafield='ShopTable_Entrust.GoodName']")[i].value;
    //        $.ajax({
    //            type: "POST",    //页面请求的类型
    //            url: "ContractHandler.ashx?Command=GoodNum",   //处理页的相对地址
    //            data: {
    //                ContractNo: ContractNo,
    //                DHSeq: DHSeq,
    //                GoodName: GoodName,
    //            },
    //            async: false,
    //            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
    //                $(this).find("[data-datafield='ShopTable_Entrust.GoodNum']")[i].value = ret;
    //            }
    //        });
    //    }
    //    i++;
    //});
}

// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    // 当前节点是节点
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
        var HasHGBZJ = $.MvcSheetUI.GetControlValue("HasHGBZJ").split(";")[0];
        var dtl = $.MvcSheetUI.GetElement("HGBZJTbl_HY").SheetGridView();
        var checkFlg = false;
        for (var i = 0; i < dtl.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("HGBZJTbl_HY.IsCheck", i + 1).split(";")[0];
            if (IsCheck == " ") {
                checkFlg = true;
            }
        }
        if (HasHGBZJ == "1") {
            if (checkFlg == false) {
                layer.alert('请选择一条海关保证金数据！', { icon: 2 });
                return false;
            }
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityXB") {
        var dtl = $.MvcSheetUI.GetElement("XBTbl_HY").SheetGridView();
        var checkFlg = false;
        for (var i = 0; i < dtl.RowCount; i++) {
            var XBStatus = $.MvcSheetUI.GetControlValue("XBTbl_HY.XBStatus", i + 1);
            if (XBStatus == "") {
                layer.alert('请选择销保状态！', { icon: 2 });
                return false;
            } else if (XBStatus == "YTB") {
                var TBAmount = $.MvcSheetUI.GetControlValue("XBTbl_HY.TBAmount", i + 1);
                var TBDate = $.MvcSheetUI.GetControlValue("XBTbl_HY.TBDate", i + 1);
                if (TBAmount == "") {
                    layer.alert('请填写退保金额！', { icon: 2 });
                    return false;
                }
                if (TBDate == "") {
                    layer.alert('请填写退保日期！', { icon: 2 });
                    return false;
                }
            }
        }
    }
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
        var BGAttachment = $("#BGAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("BGAttachment", BGAttachment);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityXB") {
        var NewBGFile = $("#NewBGFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("NewBGFile", NewBGFile);
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
                        if (CurActivity == "ActivityXB") {
                            if (ret.InstanceActivity[i].ActivityName == "报关完成") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "报关完成") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "销保") {
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
                    GotoBackPage("DHHY", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackDHHYTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}