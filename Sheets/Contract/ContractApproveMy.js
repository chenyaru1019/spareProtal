//数据加载后
$.MvcSheet.Loaded = function () {
    // 合同号码
    var ContractNo = getUrlParam("ContractNo");
    //var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
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
                $.MvcSheetUI.SetControlValue("ContractType", ret.ContractType);
                $.MvcSheetUI.SetControlValue("ContractProperty", ret.ContractProperty);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
                $.MvcSheetUI.SetControlValue("Salers", ret.Salers);
                $.MvcSheetUI.SetControlValue("FinalUser", ret.FinalUser);
                $.MvcSheetUI.SetControlValue("BidNo", ret.BidNo);
                $.MvcSheetUI.SetControlValue("ContractRemark", ret.ContractRemark);
                
                if (ret.ContractProperty == "航空煤油") {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "true");
                    $.MvcSheetUI.SetControlValue("AgencyType", "航油合同代理协议文件");
                } else {
                    $.MvcSheetUI.SetControlValue("IsHYFlg", "false");
                    $.MvcSheetUI.SetControlValue("AgencyType", ret.AgencyType);
                }

                $("#ContractFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同主流程");
                var ContractFile = ret.ContractFile;
                if (ContractFile != "") {
                    var arr = ContractFile.split(",");
                    $("#ContractFile").xnfile("value", arr);
                }
                $("#TalkFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同主流程");
                var TalkFile = ret.TalkFile;
                if (TalkFile != "") {
                    var arr = TalkFile.split(",");
                    $("#TalkFile").xnfile("value", arr);
                }
            }
        });
    } else {
        ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        // 自定义文件格式 合同文本
        $("#ContractFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同主流程");
        var ContractFile = $.MvcSheetUI.GetControlValue("ContractFile");
        if (ContractFile != "") {
            var arr = ContractFile.split(",");
            $("#ContractFile").xnfile("value", arr);
        }

        // 自定义文件格式 合同谈判小结
        $("#TalkFile").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同主流程");
        var TalkFile = $.MvcSheetUI.GetControlValue("TalkFile");
        if (TalkFile != "") {
            var arr = TalkFile.split(",");
            $("#TalkFile").xnfile("value", arr);
        }
    }
    $("input[data-datafield='ContractNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractName']").attr("disabled", "disabled");
    $("input[data-datafield='ContractType']").attr("disabled", "disabled");
    $("input[data-datafield='ContractProperty']").attr("disabled", "disabled");
    $("input[data-datafield='PostAB']").attr("disabled", "disabled");
    $("input[data-datafield='Salers']").attr("disabled", "disabled");
    $("input[data-datafield='FinalUser']").attr("disabled", "disabled");
    $("input[data-datafield='BidNo']").attr("disabled", "disabled");
    $("input[data-datafield='ContractRemark']").attr("disabled", "disabled");
    $("input[data-datafield='AgencyType']").attr("disabled", "disabled");

    $("#ContractFile button").prop("disabled", true);
    $("#TalkFile button").prop("disabled", true);
    var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg");
    if (IsHYFlg == "true") {
        $(".NoHY").hide();
    } else if (IsHYFlg == "false") {
        $(".NoHY").show();
        // 自定义文件格式 资质证明文件
        $("#Attachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\合同审签");
        var Attachment = $.MvcSheetUI.GetControlValue("Attachment");
        if (Attachment != "") {
            var arr = Attachment.split(",");
            $("#Attachment").xnfile("value", arr);
        }
    }
    
    

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        setFileReadOnly("ContractFile");
        setFileReadOnly("TalkFile");
        setFileWriteable("Attachment");
    } else {
        setFileReadOnly("ContractFile");
        setFileReadOnly("TalkFile");
        setFileReadOnly("Attachment");
    }

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackContractApproveTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }

    SearchApprovalTbl();
}

// 表单验证接口
$.MvcSheet.Validate = function () {

    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
        var ContractFile = $("#ContractFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("ContractFile", ContractFile);
        var TalkFile = $("#TalkFile").xnfile("value");
        $.MvcSheetUI.SetControlValue("TalkFile", TalkFile);
        
        var IsHYFlg = $.MvcSheetUI.GetControlValue("IsHYFlg"); 
        if (IsHYFlg == "false") {
            var IsCheck = $.MvcSheetUI.GetControlValue("IsCheck");
            var Attachment = $("#Attachment").xnfile("value");
            $.MvcSheetUI.SetControlValue("Attachment", Attachment);
            if (this.Action == "Submit" && IsCheck == "") {
                layer.alert('请勾选资质证明！', { icon: 2 });
                return false;
            }
            if (this.Action == "Submit" && Attachment == "") {
                layer.alert('请上传资质证明文件！', { icon: 2 });
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
                        if (CurActivity == "ActivityFinance") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityHYCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "财务会审") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityCompanyLeader") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "财务会审") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        
                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "发起申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油部门经理审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "财务会审") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "航油公司领导审批") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "非航油公司领导审批") {
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
                    GotoBackPage("ContractApprove", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackContractApproveTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}