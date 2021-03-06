﻿// 提交前事件
$.MvcSheet.SubmitAction.OnActionPreDo = function () {

    
}
// 表单验证接口
$.MvcSheet.Validate = function () {
    if (this.Action == "Submit") {
        // 当前节点是发起节点
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
            var ContractNoOld = $.MvcSheetUI.GetControlValue("ContractNoOld");
            var ContractNoNew = $.MvcSheetUI.GetControlValue("ContractNoNew");
            // 因为合同规则比较复杂，验证也无法保证输入是否准确合法，所有不做验证，用审批人审批时来确认合同号的正确性
            //var chkFlg = "true";
            //try {
            //    // 如果为国内合同
            //    if (ContractNoOld.substring(0, 6) == "SPIAIE") {
            //        // 除了流水号可以修改，其他的不能修改
            //        var newArr = ContractNoNew.split("-");
            //        if (newArr.length < 3) {
            //            chkFlg = "false";
            //        }
            //        if (chkFlg == "true") {
            //            var firstIndO = ContractNoOld.indexOf("-");
            //            var firstIndN = ContractNoNew.indexOf("-");
            //            var firstStrO = ContractNoOld.substring(0, firstIndO);
            //            var firstStrN = ContractNoNew.substring(0, firstIndN);
            //            var secondIndO = ContractNoOld.substring(firstIndO + 1).indexOf("-");
            //            var secondIndN = ContractNoNew.substring(firstIndN + 1).indexOf("-");
            //            var secondStrO = ContractNoOld.substring(firstIndO + 1, firstIndO + 1 + secondIndO);
            //            var secondStrN = ContractNoNew.substring(firstIndN + 1, firstIndN + 1 + secondIndN);
            //            var thirdStrO = ContractNoOld.substring(firstIndO + secondIndO + 2);
            //            var thirdStrN = ContractNoNew.substring(firstIndN + secondIndN + 2);
            //            if (firstStrO != firstStrN || secondStrO.substring(0, 2) != secondStrN.substring(0, 2) || thirdStrO.substring(0, thirdStrO.length - 3) != thirdStrN.substring(0, thirdStrO.length - 3)) {
            //                chkFlg = "false";
            //            }
            //            if (!/^[0-9]*$/.test(secondStrN.substring(2)) || !/^[0-9]*$/.test(thirdStrN.substring(thirdStrO.length - 3))) {
            //                chkFlg = "false";
            //            }
            //        }
            //        // 如果为出口合同
            //    } else if (ContractNoOld.substring(2, 8) == "SPIAIE") {
            //        var newArr = ContractNoNew.split("-");
            //        // 航油合同
            //        if (newArr.length == 2) {
            //            var firstStrO = ContractNoOld.split("-")[0];
            //            var firstStrN = ContractNoNew.split("-")[0];
            //            var secondStrO = ContractNoOld.split("-")[1];
            //            var secondStrN = ContractNoNew.split("-")[1];
            //            if (firstStrO != firstStrN || secondStrO.substring(secondStrO.length - 2) != secondStrN.substring(secondStrN.length - 2)) {
            //                chkFlg = "false";
            //            }
            //            if (!/^[0-9]*$/.test(secondStrN.substring(0, 3))) {
            //                chkFlg = "false";
            //            }
            //            // 非航油出口合同
            //        } else if (newArr.length > 2) {
            //            var firstIndO = ContractNoOld.indexOf("-");
            //            var firstIndN = ContractNoNew.indexOf("-");
            //            var firstStrO = ContractNoOld.substring(0, firstIndO);
            //            var firstStrN = ContractNoNew.substring(0, firstIndN);
            //            var secondIndO = ContractNoOld.substring(firstIndO + 1).indexOf("-");
            //            var secondIndN = ContractNoNew.substring(firstIndN + 1).indexOf("-");
            //            var secondStrO = ContractNoOld.substring(firstIndO + 1, firstIndO + 1 + secondIndO);
            //            var secondStrN = ContractNoNew.substring(firstIndN + 1, firstIndN + 1 + secondIndN);
            //            var thirdStrO = ContractNoOld.substring(firstIndO + secondIndO + 2);
            //            var thirdStrN = ContractNoNew.substring(firstIndN + secondIndN + 2);
            //            if (firstStrO != firstStrN || secondStrO.substring(secondStrO.length - 2) != secondStrN.substring(secondStrN.length - 2) || thirdStrO.substring(0, thirdStrO.length - 3) != thirdStrN.substring(0, thirdStrO.length - 3)) {
            //                chkFlg = "false";
            //            }
            //            if (!/^[0-9]*$/.test(secondStrN.substring(0, 3)) || !/^[0-9]*$/.test(thirdStrN.substring(thirdStrO.length - 3))) {
            //                chkFlg = "false";
            //            }
            //        } else {
            //            chkFlg = "false";
            //        }
            //    }
            //} catch (err) {
            //    chkFlg = "false";
            //}
            //if (chkFlg == "false") {
            //    layer.confirm('合同编号规则有误，确认提交吗！', function (index) {
            //        $.MvcSheet.Submit2(this);
            //    });
            //    return false;
            //} else {
            //    return true;
            //}

        }
    }
}
//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractObjectID = getUrlParam("ContractObjectID");
    if (ContractObjectID != null && ContractObjectID != "") {
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractObjectID: ContractObjectID,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                $.MvcSheetUI.SetControlValue("ContractNoOld", ret.ContractNo);
                $.MvcSheetUI.SetControlValue("ContractName", ret.ContractName);
                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("Country", ret.Country);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
            }
        });
        $.MvcSheetUI.SetControlValue("ContractObjectID", ContractObjectID);
    }
    $("input[data-datafield='ContractNoOld']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='ContractType']").attr("disabled", "disabled");
    $("input[data-datafield='Country']").attr("disabled", "disabled");
    $("input[data-datafield='ContractProperty']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackUpdateContractNoTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
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
                    GotoBackPage("UpdateContractNo", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackUpdateContractNoTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}

