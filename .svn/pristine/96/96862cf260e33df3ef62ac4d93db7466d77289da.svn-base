//数据加载后
$.MvcSheet.Loaded = function () {
    // 协议号
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    // InstanceId
    var NeedInstanceId = getUrlParam("InstanceId");
    var NeedInstanceActivity = getUrlParam("InstanceActivity");
    //alert(NeedInstanceActivity);
    var InstanceActivityName = GetName(NeedInstanceActivity);
    if (AgreeMent_number != null && AgreeMent_number != ""
        && NeedInstanceId != null && NeedInstanceId != ""
        && NeedInstanceActivity != null && NeedInstanceActivity != "") {
        // 设置相关数据
        $.MvcSheetUI.SetControlValue("AgreeMent_number", AgreeMent_number);
        $.MvcSheetUI.SetControlValue("NeedInstanceId", NeedInstanceId);
        $.MvcSheetUI.SetControlValue("NeedInstanceActivity", NeedInstanceActivity);
        $.MvcSheetUI.SetControlValue("InstanceActivityName", InstanceActivityName);
    }
    $("input[data-datafield='AgreeMent_number']").attr("disabled", "disabled");
    $("input[data-datafield='InstanceActivityName']").attr("disabled", "disabled");
}

function GetName(InstanceActivity) {
    if (InstanceActivity == "cre_agreement") {
        return "创建协议";
    } else if (InstanceActivity == "agreement_sign") {
        return "协议审签";
    } else if (InstanceActivity == "agreement_excu") {
        return "协议执行";
    } else if (InstanceActivity == "Activity4") {
        return "结束";
    }
}
$.MvcSheet.ActionDone = function (data) {
    // this.Action; // 获取当前按钮名称
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityAdmin") {
            var UserID = $.MvcSheetUI.SheetInfo.UserID;
            doGoBack(UserID);
        }
    }
}

// 先取消，再激活，再调整活动节点
function doGoBack(UserID) {
    var NeedInstanceId = $.MvcSheetUI.GetControlValue("NeedInstanceId");
    var NeedActivityCode = $.MvcSheetUI.GetControlValue("NeedInstanceActivity");
    var participants = new Array();
    participants.push(UserID);
   // participants.push("18f923a7-5a5e-426d-94ae-a55ad1a4b239");
    // ------ 取消
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/InstanceDetail/CancelInstance",   //处理页的相对地址
        async: false,
        data: {
            InstanceID: NeedInstanceId,
        },
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.SUCCESS == true) {
                // ------ 激活
                $.ajax({
                    type: "POST",    //页面请求的类型
                    url: "/Portal/InstanceDetail/ActivateInstance",   //处理页的相对地址
                    async: false,
                    data: {
                        InstanceID: NeedInstanceId,
                    },
                    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                        if (ret.SUCCESS == true) {
                            // ------ 调整活动节点

                            $.ajax({
                                type: "POST",    //页面请求的类型
                                url: "/Portal/InstanceDetail/ActivateActivity",   //处理页的相对地址
                                async: false,
                                data: {
                                    InstanceID: NeedInstanceId,
                                    ActivityCode: NeedActivityCode,
                                    Participants: participants,
                                },
                                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                                    if (ret.SUCCESS == true) {
                                        alert("取回成功！");
                                    } else {
                                        alert("取回失败！（调整活动节点失败）");
                                    }
                                }
                            });
                        } else {
                            alert("取回失败！（激活流程失败）");
                        }
                    }
                });
            } else {
                alert("取回失败！（取消流程失败）");
            }
        }
    });
}

