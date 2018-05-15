﻿// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    //if (!checkCurrency()) {
    //    return false;
    //}
}
// 表单验证接口
$.MvcSheet.Validate = function () {

    return true;
}
// 提交后事件
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        if (this.Action == "Submit" || this.Action == "Save") {
            var JSObjectIDs = $.MvcSheetUI.GetControlValue("JSObjectIDs");
            // 设置请付款状态为BatchQK_Start
            // 获取客户信息数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=setJS_Status",   //处理页的相对地址
                data: {
                    JSObjectIDs: JSObjectIDs,
                    Status: "BatchJQ_Start",
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    console.log("设置请付款状态为BatchJQ_Start成功");
                }
            });
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCompanyLeader") {
        if (this.Action == "Submit") {
            var JSObjectIDs = $.MvcSheetUI.GetControlValue("JSObjectIDs");
            // 设置请付款状态为BatchJQ_OK
            // 获取客户信息数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=setJS_Status",   //处理页的相对地址
                data: {
                    JSObjectIDs: JSObjectIDs,
                    Status: "BatchJQ_OK",
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    console.log("设置请付款状态为BatchJQ_OK成功");
                }
            });
        }
    }

}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 请款对象
    var Target = getUrlParam("Target");
    var JSObjectIDs = getUrlParam("JSObjectIDs");
    var IsHYFlg = getUrlParam("IsHYFlg");
    var JQ_Target = "";
    if (Target != null && Target != "") {
        $.MvcSheetUI.SetControlValue("JSObjectIDs", JSObjectIDs);
        var JSObjectIDArr = JSObjectIDs.split(",");
        // 获取客户信息数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getCustomerById",   //处理页的相对地址
            data: {
                ObjectID: Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                JQ_Target = ret.CompanyName + '（' + ret.ModelOrDepartment + '）';
                
            }
        });
        $.MvcSheetUI.SetControlValue("JQ_Target", JQ_Target);
        $.MvcSheetUI.SetControlValue("IsHYFlg", IsHYFlg);
        
        // 表格数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getJSLSData",   //处理页的相对地址
            data: {
                JS_Target: JQ_Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BatchJSTblOfJQ").SheetGridView();
                dtl._Clear();
                var index = 0;
                for (var i = 0; i < ret.length; i++) {
                    // 勾选的数据是否在所有批量数据中
                    if (IsInArr(JSObjectIDArr, ret[i].JSObjectID)) {
                        dtl._AddRow();
                        index++;
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.ContractNo", ret[i].ContractNo, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.ContractNoHidden", ret[i].ContractNoHidden, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.ContractName", ret[i].ContractName, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.PostAB", ret[i].PostAB, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.DKAmount", ret[i].DKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.FKAmount", ret[i].FKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.BankFY", ret[i].BankFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.AgencyFY", ret[i].AgencyFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.OtherFY", ret[i].OtherFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.JSResult", ret[i].JSResult, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.WorkItemId", ret[i].WorkItemId, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.Cnt", ret[i].Cnt, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfJQ.JSObjectID", ret[i].JSObjectID, index);
                    }
                }
            }
        });
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        $(".BatchJSTblOfJQ").hide();
    }
    

    $("input[data-datafield='JQ_Target']").attr("disabled", "disabled");

    $("input[data-datafield='BatchJSTblOfJQ.ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.ContractNoHidden']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.DKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.FKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.BankFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.AgencyFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.OtherFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfJQ.JSResult']").attr("disabled", "disabled");

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackBatchJQTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }
    SearchApprovalTbl();
}

function IsInArr(arr, str) {
    for (var j = 0; j < arr.length; j++) {
        if (str == arr[j]) {
            return true;
        }
    }
    return false;
}

// 查看
function viewJS(el) {
    var rowIndex = el.parentElement.parentElement.rowIndex;
    var WorkItemId = $.MvcSheetUI.GetControlValue('BatchJSTblOfJQ.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
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
                            if (ret.InstanceActivity[i].ActivityName == "发起批量结清") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起批量结清") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起批量结清") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }

                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起批量结清") {
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
                    GotoBackPage("BatchJQ", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackBatchJQTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}