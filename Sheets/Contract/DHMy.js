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
                $.MvcSheetUI.SetControlValue("ContractNo_Entrust", ret.ContractNo);
                $.MvcSheetUI.SetControlValue("ContractName", ret.ContractName);
                $.MvcSheetUI.SetControlValue("PostAB", ret.PostA + "," + ret.PostB);
                $.MvcSheetUI.SetControlValue("CurrencyRMB", "人民币");
                $.MvcSheetUI.SetControlValue("CurrencyWB", ret.CurrencyName);
               // $("[data-datafield='DHType']").val("DHType_JK");
               // $("[data-datafield='DHType']").attr("disabled", "disabled");

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

    // 自定义文件格式 到货单据
    $("#DHAttachment").xnfile().xnfile("option", "multiple", true).xnfile("option", "basePath", "\\cta\\" + ContractNo + "\\到货");
    var DHAttachment = $.MvcSheetUI.GetControlValue("DHAttachment");
    if (DHAttachment != "") {
        var arr = DHAttachment.split(",");
        $("#DHAttachment").xnfile("value", arr);
    }
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

    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApply") {
        $(".DHCheck").hide();
        $(".DHEntrust").hide();
        $(".DHConfirm").hide();
        $(".DHComplete").hide();
        $(".DHXB").hide();
        setFileWriteable("DHAttachment");
        setFileHide("BGAttachment");
        setFileHide("NewBGFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityCheck") {
        $(".DHCheck").show();
        $(".DHEntrust").hide();
        $(".DHConfirm").hide();
        $(".DHComplete").hide();
        $(".DHXB").hide();

        $(".DHApply").click();

        setFileReadOnly("DHAttachment");
        setFileHide("BGAttachment");
        setFileHide("NewBGFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityEntrust") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").hide();
        $(".DHComplete").hide();
        $(".DHXB").hide();

        $(".DHApply").click();
        $(".DHCheck").click();
        $("input[data-datafield='ShipDate_Entrust']").val($.MvcSheetUI.GetControlValue("ShipDate"));
        $("input[data-datafield='ShipDate_Entrust']").attr("disabled", "disabled");

        var dtl = $.MvcSheetUI.GetElement("DHGoodsTbl").SheetGridView();
        if (dtl.RowCount > 0) {

            var dt2 = $.MvcSheetUI.GetElement("ShopTable_Entrust").SheetGridView();
            if (dt2.RowCount == 0) {
                // 把商品信息的数据放到托运的表中
                for (var i = 0; i < dtl.RowCount; i++) {
                    dt2._AddRow();
                    $.MvcSheetUI.SetControlValue("ShopTable_Entrust.GoodNo", $.MvcSheetUI.GetControlValue("DHGoodsTbl.TaxNo", i + 1), i + 1);
                    $.MvcSheetUI.SetControlValue("ShopTable_Entrust.GoodName", $.MvcSheetUI.GetControlValue("DHGoodsTbl.GoodName", i + 1), i + 1);
                    $.MvcSheetUI.SetControlValue("ShopTable_Entrust.Num", $.MvcSheetUI.GetControlValue("DHGoodsTbl.Num", i + 1), i + 1);
                    $.MvcSheetUI.SetControlValue("ShopTable_Entrust.JZ", $.MvcSheetUI.GetControlValue("DHGoodsTbl.Weight", i + 1), i + 1);
                }
                
            }
        }
        setFileReadOnly("DHAttachment");
        setFileHide("BGAttachment");
        setFileHide("NewBGFile");

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityConfirm") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").show();
        $(".DHComplete").hide();
        $(".DHXB").hide();

        $(".DHApply").click();
        $(".DHCheck").click();
        $(".DHEntrust").click();
        setFileReadOnly("DHAttachment");
        setFileHide("BGAttachment");
        setFileHide("NewBGFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").show();
        $(".DHComplete").show();
        $(".DHXB").hide();

        $(".DHApply").click();
        $(".DHCheck").click();
        $(".DHEntrust").click();
        $(".DHConfirm").click();
        // 获取海关保证金数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getHGBZJ",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                var dtl = $.MvcSheetUI.GetElement("HGBZJTbl").SheetGridView();
                dtl._Clear();
                for (var i = 0; i < ret.length; i++) {
                    dtl._AddRow();
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.ZJKX", ret[i].ZJKX, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.PayAmount", ret[i].Amount, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.ConvertAmount", ret[i].ConvertAmount, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.PayContent", ret[i].PayContent, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.PayType", ret[i].PayType, i + 1);
                    $.MvcSheetUI.SetControlValue("HGBZJTbl.Receiver", ret[i].Receiver, i + 1);
                }
                $("input[data-datafield='HGBZJTbl.ZJKX']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl.PayAmount']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl.ConvertAmount']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl.PayContent']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl.PayType']").attr("disabled", "disabled");
                $("input[data-datafield='HGBZJTbl.Receiver']").attr("disabled", "disabled"); 

            }
        });
        setFileReadOnly("DHAttachment");
        setFileWriteable("BGAttachment");
        setFileHide("NewBGFile");
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityXB") {
        $(".DHCheck").show();
        $(".DHEntrust").show();
        $(".DHConfirm").show();
        $(".DHComplete").show();
        $(".DHXB").show();

        $(".DHApply").click();
        $(".DHCheck").click();
        $(".DHEntrust").click();
        $(".DHConfirm").click();
        $(".DHComplete").click();
        // 获取销保数据
        var dtl = $.MvcSheetUI.GetElement("HGBZJTbl").SheetGridView();
        var dtl_XB = $.MvcSheetUI.GetElement("XBTbl").SheetGridView();
        dtl_XB._Clear();
        for (var i = 0; i < dtl.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("HGBZJTbl.IsCheck", i + 1).split(";")[0];
            // 选中(选中为" " ,没选中没"")
            if (IsCheck == " ") {
                dtl_XB._AddRow();
                $.MvcSheetUI.SetControlValue("XBTbl.ZJKX", $.MvcSheetUI.GetControlValue("HGBZJTbl.ZJKX", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl.PayAmount", $.MvcSheetUI.GetControlValue("HGBZJTbl.PayAmount", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl.ConvertAmount", $.MvcSheetUI.GetControlValue("HGBZJTbl.ConvertAmount", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl.PayContent", $.MvcSheetUI.GetControlValue("HGBZJTbl.PayContent", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl.PayType", $.MvcSheetUI.GetControlValue("HGBZJTbl.PayType", i + 1), i + 1);
                $.MvcSheetUI.SetControlValue("XBTbl.Receiver", $.MvcSheetUI.GetControlValue("HGBZJTbl.Receiver", i + 1), i + 1);
            }
        }
        $("input[data-datafield='XBTbl.ZJKX']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl.PayAmount']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl.ConvertAmount']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl.PayContent']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl.PayType']").attr("disabled", "disabled");
        $("input[data-datafield='XBTbl.Receiver']").attr("disabled", "disabled");

        setFileReadOnly("DHAttachment");
        setFileReadOnly("BGAttachment");
        setFileWriteable("NewBGFile");
    } 

    // 回退节点是否显示，如果回退记录有，则显示，没有，则不显示
    var dtl_back = $.MvcSheetUI.GetElement("GetBackDHTbl").SheetGridView();
    if (dtl_back.RowCount > 0) {
        $(".ContractContentGetBack").show();
    } else {
        $(".ContractContentGetBack").hide();
    }
    SearchApprovalTbl();
}


function DHTypeChange() {
    var DHType = $.MvcSheetUI.GetControlValue("DHType");
    // 出口到货
    if (DHType == "DHType_GN") {
        $.MvcSheetUI.SetControlValue("ShippingType", "ShipType_HY");
        $.MvcSheetUI.SetControlValue("Supplier", "");
        $.MvcSheetUI.SetControlValue("ShipDate", "");
        $.MvcSheetUI.SetControlValue("ShipPort", "");
        $.MvcSheetUI.SetControlValue("TradeWord", "");
        var dtl = $.MvcSheetUI.GetElement("DHGoodsTbl").SheetGridView();
        dtl._Clear();
        $("[data-datafield='ShippingType']").attr("disabled", "disabled");
        $("[data-datafield='Supplier']").attr("disabled", "disabled");
        $("[data-datafield='ShipDate']").attr("disabled", "disabled");
        $("[data-datafield='ShipPort']").attr("disabled", "disabled");
        $("[data-datafield='TradeWord']").attr("disabled", "disabled");
        $(".DHGoodsTbl").hide();

        $(".DHType").text("出口");
        // 进口到货
    } else if(DHType == "DHType_JK") {
        $("[data-datafield='ShippingType']").attr("disabled", false);
        $("[data-datafield='Supplier']").attr("disabled", false);
        $("[data-datafield='ShipDate']").attr("disabled", false);
        $("[data-datafield='ShipPort']").attr("disabled", false);
        $("[data-datafield='TradeWord']").attr("disabled", false);
        $(".DHGoodsTbl").show();

        $(".DHType").text("进口");
    }
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

    if ($.MvcSheetUI.GetControlValue('XBTbl.XBStatus', rowIndex - 1) == "YTB") {
        var k = 1;
        $("[data-datafield='XBTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='XBTbl.TBAmount']").attr("disabled", false);
                $(this).find("input[data-datafield='XBTbl.TBDate']").attr("disabled", false);
            }
            k++;
        });
    } else {
        var k = 1;
        $("[data-datafield='XBTbl']").find("tr.rows").each(function () {
            if (k == rowIndex - 1) {
                $(this).find("input[data-datafield='XBTbl.TBAmount']").attr("disabled", "disabled");
                $(this).find("input[data-datafield='XBTbl.TBDate']").attr("disabled", "disabled");
            }
            k++;
        });
        $.MvcSheetUI.SetControlValue('XBTbl.TBAmount', "", rowIndex - 1);
        $.MvcSheetUI.SetControlValue('XBTbl.TBDate', "", rowIndex - 1);
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
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApply") {
        var DHType = $.MvcSheetUI.GetControlValue("DHType");
        // 进口到货
        if (DHType == "DHType_JK") {
        
            var dtl = $.MvcSheetUI.GetElement("DHGoodsTbl").SheetGridView();
            if (dtl.RowCount <= 0) {
                layer.alert('请至少添加一条商品信息！', { icon: 2 });
                return false;
            } else {
                for (var i = 0; i < dtl.RowCount; i++) {
                    var GoodName = $.MvcSheetUI.GetControlValue("DHGoodsTbl.GoodName", i + 1);
                    var Amount = $.MvcSheetUI.GetControlValue("DHGoodsTbl.Amount", i + 1);
                    var Num = $.MvcSheetUI.GetControlValue("DHGoodsTbl.Num", i + 1);
                    if (GoodName == "") {
                        layer.alert('请填写中英文品名！', { icon: 2 });
                        return false;
                    }
                    if (Amount == "") {
                        layer.alert('请填写货物金额！', { icon: 2 });
                        return false;
                    }
                    if (Num == "") {
                        layer.alert('请填写货物数量！', { icon: 2 });
                        return false;
                    }
                }
            }
        }
        var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
        var DHSeq = $.MvcSheetUI.GetControlValue("DHSeq");
        var DHSeqCnt = 0;
        var IsDHSeqMyself = false;
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getDHSeqCnt",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
                DHSeq: DHSeq,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                DHSeqCnt = parseInt(ret);
            }
        });
        // 如果没有此批次的数据，则通过
        if (DHSeqCnt < 1) {
            return true;
        } else {
            // 如果有此批次的数据，则判断该数据是否是自己
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=getDHByBizObjectID",   //处理页的相对地址
                data: {
                    BizObjectID: $.MvcSheetUI.SheetInfo.BizObjectID,
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    if (DHSeq == ret.DHSeq) {
                        IsDHSeqMyself = true;
                    }
                }
            });
            if (IsDHSeqMyself) {
                return true;
            } else {
                layer.alert('此批次已存在！', { icon: 2 });
                return false;
            }
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityEntrust") {
        var dtl = $.MvcSheetUI.GetElement("ShopTable_Entrust").SheetGridView();
        if (dtl.RowCount <= 0) {
            layer.alert('请至少添加一条托运商品信息！', { icon: 2 });
            return false;
        } else {
            for (var i = 0; i < dtl.RowCount; i++) {
                var GoodNo = $.MvcSheetUI.GetControlValue("ShopTable_Entrust.GoodNo", i + 1);
                if (GoodNo == "") {
                    layer.alert('请填写商品编码！', { icon: 2 });
                    return false;
                }
            }
        }
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
        var HasHGBZJ = $.MvcSheetUI.GetControlValue("HasHGBZJ").split(";")[0];
        var dtl = $.MvcSheetUI.GetElement("HGBZJTbl").SheetGridView();
        var checkFlg = false;
        for (var i = 0; i < dtl.RowCount; i++) {
            var IsCheck = $.MvcSheetUI.GetControlValue("HGBZJTbl.IsCheck", i + 1).split(";")[0];
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
        var dtl = $.MvcSheetUI.GetElement("XBTbl").SheetGridView();
        var checkFlg = false;
        for (var i = 0; i < dtl.RowCount; i++) {
            var XBStatus = $.MvcSheetUI.GetControlValue("XBTbl.XBStatus", i + 1);
            if (XBStatus == "") {
                layer.alert('请选择销保状态！', { icon: 2 });
                return false;
            } else if (XBStatus == "YTB") {
                var TBAmount = $.MvcSheetUI.GetControlValue("XBTbl.TBAmount", i + 1);
                var TBDate = $.MvcSheetUI.GetControlValue("XBTbl.TBDate", i + 1);
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
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApply") {
        var DHAttachment = $("#DHAttachment").xnfile("value");
        $.MvcSheetUI.SetControlValue("DHAttachment", DHAttachment);
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityComplete") {
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
                        if (CurActivity == "ActivityCheck") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityEntrust") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityConfirm") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "报关委托") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityComplete") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "报关委托") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "确认") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }
                        if (CurActivity == "ActivityXB") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "报关委托") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "确认") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "报关完成") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                        }

                        if (CurActivity == "End") {
                            if (ret.InstanceActivity[i].ActivityName == "到货申请") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "复核") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "报关委托") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
                            if (ret.InstanceActivity[i].ActivityName == "确认") {
                                options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                            }
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
                    GotoBackPage("DH", CurActivity);

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
    var WorkItemId = $.MvcSheetUI.GetControlValue('GetBackDHTbl.WorkItemId', rowIndex - 1);
    window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
}