﻿// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {
    //if (!checkCurrency()) {
    //    return false;
    //}
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
                    Status: "BatchQK_Start",
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    console.log("设置请付款状态为BatchQK_Start成功");
                }
            });
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityDKConfirm") {
        if (this.Action == "Submit") {
            var JSObjectIDs = $.MvcSheetUI.GetControlValue("JSObjectIDs");
            // 设置请付款状态为BatchDK_OK
            // 获取客户信息数据
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=setJS_Status",   //处理页的相对地址
                data: {
                    JSObjectIDs: JSObjectIDs,
                    Status: "BatchDK_OK",
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    console.log("设置请付款状态为BatchDK_OK成功");
                }
            });
        }
    }
}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 请款对象
    var Target = getUrlParam("Target");
    var Amount = getUrlParam("Amount");
    var JSObjectIDs = getUrlParam("JSObjectIDs");
    var IsHYFlg = getUrlParam("IsHYFlg");
    var QK_Target = "";
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
                QK_Target = ret.CompanyName + '（' + ret.ModelOrDepartment + '）';
                
            }
        });
        $.MvcSheetUI.SetControlValue("QK_Target", QK_Target);
        $.MvcSheetUI.SetControlValue("Amount", Amount);
        $.MvcSheetUI.SetControlValue("IsHYFlg", IsHYFlg);
        
        // 表格数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getJSLSData",   //处理页的相对地址
            data: {
                JS_Target: QK_Target,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("BatchJSTblOfQK").SheetGridView();
                dtl._Clear();
                var index = 0;
                for (var i = 0; i < ret.length; i++) {
                    // 勾选的数据是否在所有批量数据中
                    if (IsInArr(JSObjectIDArr, ret[i].JSObjectID)) {
                        dtl._AddRow();
                        index++;
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.ContractNo", ret[i].ContractNo, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.ContractNoHidden", ret[i].ContractNoHidden, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.ContractName", ret[i].ContractName, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.PostAB", ret[i].PostAB, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.DKAmount", ret[i].DKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.FKAmount", ret[i].FKAmount, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.BankFY", ret[i].BankFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.AgencyFY", ret[i].AgencyFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.OtherFY", ret[i].OtherFY, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.JSResult", ret[i].JSResult, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.WorkItemId", ret[i].WorkItemId, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.Cnt", ret[i].Cnt, index);
                        $.MvcSheetUI.SetControlValue("BatchJSTblOfQK.JSObjectID", ret[i].JSObjectID, index);
                    }
                }
                
            }
        });
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        $(".BatchJSTblOfQK").hide();
    }
    
    $("input[data-datafield='QK_Target']").attr("disabled", "disabled");
    $("input[data-datafield='Amount']").attr("disabled", "disabled");

    $("input[data-datafield='BatchJSTblOfQK.ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.ContractNoHidden']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.DKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.FKAmount']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.BankFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.AgencyFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.OtherFY']").attr("disabled", "disabled");
    $("input[data-datafield='BatchJSTblOfQK.JSResult']").attr("disabled", "disabled");

    // 自定义文件格式 请款上传文件
    $("#QKUploadFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\returnFileBatch");
    var QKUploadFile = $.MvcSheetUI.GetControlValue("QKUploadFile");
    if (QKUploadFile != "") {
        var arr = QKUploadFile.split(",");
        $("#QKUploadFile").xnfile("value", arr);
    }
    // 自定义文件格式 请款文件签字版
    $("#SignFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\returnFileSignedBatch");
    var SignFile = $.MvcSheetUI.GetControlValue("SignFile");
    if (SignFile != "") {
        var arr = SignFile.split(",");
        $("#SignFile").xnfile("value", arr);
    }

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileWriteable("QKUploadFile");
        setFileHide("SignFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        setFileReadOnly("QKUploadFile");
        setFileWriteable("SignFile");
    } else {
        setFileReadOnly("QKUploadFile");
        setFileHide("SignFile");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackBatchQKTbl").SheetGridView();
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
    var WorkItemId = $.MvcSheetUI.GetControlValue('BatchJSTblOfQK.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/JSMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    // 填写申请单环节，设置  必填
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var QKUploadFile = $("#QKUploadFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("QKUploadFile", QKUploadFile);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        var SignFile = $("#SignFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("SignFile", SignFile);
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
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityDKConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "批量请款送达确认") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "批量请款申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "公司领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") == "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油领导审批" && $.MvcSheetUI.GetControlValue("IsHYFlg") != "true") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "批量请款送达确认") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "到款确认") {
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
                    GotoBackPage("BatchQK", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackBatchQKTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}