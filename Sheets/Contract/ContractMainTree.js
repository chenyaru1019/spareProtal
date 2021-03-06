﻿var setting = {
    check: {
        enable: true
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onCheck: onCheck
    }
};

var zNodes = [];
//    [
//    { id: 1, pId: 0, name: "随意勾选 1", open: true },
//    { id: 11, pId: 1, name: "随意勾选 1-1", open: true },
//    { id: 111, pId: 11, name: "随意勾选 1-1-1" },
//    { id: 112, pId: 11, name: "随意勾选 1-1-2" },
//    { id: 12, pId: 1, name: "随意勾选 1-2", open: true },
//    { id: 121, pId: 12, name: "随意勾选 1-2-1" },
//    { id: 122, pId: 12, name: "随意勾选 1-2-2" },
//    { id: 2, pId: 0, name: "随意勾选 2", checked: true, open: true },
//    { id: 21, pId: 2, name: "随意勾选 2-1" },
//    { id: 22, pId: 2, name: "随意勾选 2-2", open: true },
//    { id: 221, pId: 22, name: "随意勾选 2-2-1", checked: true },
//    { id: 222, pId: 22, name: "随意勾选 2-2-2" },
//    { id: 23, pId: 2, name: "随意勾选 2-3" }
//];

function setCheck() {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    // 被勾选时：关联父 关联子 Y ps
    // 取消勾选时：关联父 关联子 N ps
    var type = { "Y": "p", "N": "s" };
    zTree.setting.check.chkboxType = type;

}
function setCheckBidNo() {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    // 被勾选时：关联父 关联子 Y ps
    // 取消勾选时：关联父 关联子 N ps
    var type = { "Y": "p", "N": "s" };
    zTree.setting.check.chkboxType = type;
    zTree.setting.callback.onCheck = onCheckBidNo;
}

function onCheck(e, treeId, treeNode) {
    var treeSelected = $("#showTreeSelected").val();
    var treeSelectedHide = $("#showTreeSelectedHide").val();
    var newTreeSelected = "";
    var newTreeSelectedHide = "";
    var added = false;
    var added2 = false;
    // 如果是勾选，则加
    if (treeNode.checked) {
        // 如果是勾选公司
        if (treeNode.level == 0) {
            // 如果不为空，则加分号区分开
            newTreeSelected += treeSelected + treeNode.name + "：；";
            newTreeSelectedHide += treeSelectedHide + treeNode.id + "：；";
            // 如果是勾选项目
        } else if (treeNode.level == 1) {
            // 获取该项目所属的公司
            var companyNode = getTreeValue(treeNode.pId);
            var comps = treeSelected.split("；");
            var compsHide = treeSelectedHide.split("；");
            for (var i = 0; i < comps.length; i++) {
                if (comps[i] != "") {
                    // 如果包含公司，则在改公司后加
                    if (companyNode.name == comps[i].split("：")[0]) {
                        newTreeSelected += comps[i] + treeNode.name + "（）、；";
                        newTreeSelectedHide += compsHide[i] + treeNode.id + "（）、；";
                        added = true;
                    } else {
                        newTreeSelected += comps[i] + "；";
                        newTreeSelectedHide += compsHide[i] + "；";
                    }
                }
            }
            if (!added) {
                newTreeSelected += companyNode.name + "：" + treeNode.name + "（）、；";
                newTreeSelectedHide += companyNode.id + "：" + treeNode.id + "（）、；";
            }
            // 如果是勾选子工程
        } else if (treeNode.level == 2) {
            // 获取该项目所属的项目
            var projectNode = getTreeValue(treeNode.pId);
            // 获取该项目所属的公司
            var companyNode = getTreeValue(projectNode.pId);
            var comps = treeSelected.split("；");
            var compsHide = treeSelectedHide.split("；");
            for (var i = 0; i < comps.length; i++) {
                if (comps[i] != "") {
                    // 如果包含公司，则在改公司后加
                    if (companyNode.name == comps[i].split("：")[0]) {
                        added = true;
                        var pros = comps[i].split("：")[1].split("、");
                        var prosHide = compsHide[i].split("：")[1].split("、");
                        newTreeSelected += comps[i].split("：")[0] + "：";
                        newTreeSelectedHide += compsHide[i].split("：")[0] + "：";
                        for (var j = 0; j < pros.length; j++) {
                            if (pros[j] != "") {
                                if (projectNode.name == pros[j].split("（")[0]) {
                                    newTreeSelected += pros[j].split("）")[0] + treeNode.name + "，）、";
                                    newTreeSelectedHide += prosHide[j].split("）")[0] + treeNode.id + "，）、";
                                    added2 = true;
                                } else {
                                    newTreeSelected += pros[j] + "、";
                                    newTreeSelectedHide += prosHide[j] + "、";
                                }
                            }
                        }
                        if (!added2) {
                            newTreeSelected += projectNode.name + "（" + treeNode.name + "，）、；";
                            newTreeSelectedHide += projectNode.id + "（" + treeNode.id + "，）、；";
                        } else {
                            newTreeSelected += "；";
                            newTreeSelectedHide += "；";
                        }
                    } else {
                        newTreeSelected += comps[i] + "；";
                        newTreeSelectedHide += compsHide[i] + "；";
                    }
                }
            }
            if (!added) {
                newTreeSelected += companyNode.name + "：" + projectNode.name + "（" + treeNode.name + "，）、；";
                newTreeSelectedHide += companyNode.id + "：" + projectNode.id + "（" + treeNode.id + "，）、；";
            }
        }
        // 如果是取消勾选，则去掉
    } else {
        // 如果是取消勾选公司
        if (treeNode.level == 0) {
            // 删除该公司所有内容
            var comps = treeSelected.substring(0, treeSelected.indexOf(treeNode.name + "："));
            var compsHide = treeSelectedHide.substring(0, treeSelectedHide.indexOf(treeNode.id + "："));
            var remind = treeSelected.substring(treeSelected.indexOf(treeNode.name + "："));
            var remindHide = treeSelectedHide.substring(treeSelectedHide.indexOf(treeNode.id + "："));
            var comps2 = remind.substring(remind.indexOf("；") + 1);
            var comps2Hide = remindHide.substring(remindHide.indexOf("；") + 1);
            // 该公司之前的公司 + 该公司之后的公司
            newTreeSelected += comps + comps2;
            newTreeSelectedHide += compsHide + comps2Hide;
            // 如果是取消勾选项目
        } else if (treeNode.level == 1) {
            // 获取该项目所属的公司
            var companyNode = getTreeValue(treeNode.pId);
            var comps = treeSelected.substring(0, treeSelected.indexOf(companyNode.name + "："));
            var remind = treeSelected.substring(treeSelected.indexOf(companyNode.name + "："));
            var comps2 = remind.substring(remind.indexOf("；") + 1);
            remind = remind.substring(0, remind.indexOf("；") + 1);
            var thisComp = "";
            var pros = remind.substring(0, remind.indexOf(treeNode.name + "（"));;
            var remind2 = remind.substring(remind.indexOf(treeNode.name + "（"));;
            var pros2 = remind2.substring(remind2.indexOf("、") + 1);
            newTreeSelected += comps + pros + pros2 + comps2;
            
            var compsHide = treeSelectedHide.substring(0, treeSelectedHide.indexOf(companyNode.id + "："));
            var remindHide = treeSelectedHide.substring(treeSelectedHide.indexOf(companyNode.id + "："));
            var comps2Hide = remindHide.substring(remindHide.indexOf("；") + 1);
            remindHide = remindHide.substring(0, remindHide.indexOf("；") + 1);
            var thisCompHide = "";
            var prosHide = remindHide.substring(0, remindHide.indexOf(treeNode.id + "（"));;
            var remind2Hide = remindHide.substring(remindHide.indexOf(treeNode.id + "（"));;
            var pros2Hide = remind2Hide.substring(remind2Hide.indexOf("、") + 1);
            newTreeSelectedHide += compsHide + prosHide + pros2Hide + comps2Hide;
        } else if (treeNode.level == 2) {
            // 获取该项目所属的项目
            var projectNode = getTreeValue(treeNode.pId);
            // 获取该项目所属的公司
            var companyNode = getTreeValue(projectNode.pId);
            var comps = treeSelected.substring(0, treeSelected.indexOf(companyNode.name + "："));
            var remind = treeSelected.substring(treeSelected.indexOf(companyNode.name + "："));
            var comps2 = remind.substring(remind.indexOf("；") + 1);
            remind = remind.substring(0,remind.indexOf("；")+1);
            var thisComp = "";
            var pros = remind.substring(0, remind.indexOf(projectNode.name + "（"));
            var remind2 = remind.substring(remind.indexOf(projectNode.name + "（"));
            var pros2 = remind2.substring(remind2.indexOf("、") + 1);
            remind2 = remind2.substring(0, remind2.indexOf("、") + 1);
            var subs = remind2.substring(0, remind2.indexOf(treeNode.name + "，"));
            var remind3 = remind2.substring(remind2.indexOf(treeNode.name + "，"));
            var subs2 = remind3.substring(remind3.indexOf("，")+1);
            newTreeSelected += comps + pros + subs + subs2 + pros2 + comps2;

            var compsHide = treeSelectedHide.substring(0, treeSelectedHide.indexOf(companyNode.id + "："));
            var remindHide = treeSelectedHide.substring(treeSelectedHide.indexOf(companyNode.id + "："));
            var comps2Hide = remindHide.substring(remindHide.indexOf("；") + 1);
            remindHide = remindHide.substring(0, remindHide.indexOf("；") + 1);
            var thisCompHide = "";
            var prosHide = remindHide.substring(0, remindHide.indexOf(projectNode.id + "（"));
            var remind2Hide = remindHide.substring(remindHide.indexOf(projectNode.id + "（"));
            var pros2Hide = remind2Hide.substring(remind2Hide.indexOf("、") + 1);
            remind2Hide = remind2Hide.substring(0, remind2Hide.indexOf("、") + 1);
            var subsHide = remind2Hide.substring(0, remind2Hide.indexOf(treeNode.id + "，"));
            var remind3Hide = remind2Hide.substring(remind2Hide.indexOf(treeNode.id + "，"));
            var subs2Hide = remind3Hide.substring(remind3Hide.indexOf("，") + 1);
            newTreeSelectedHide += compsHide + prosHide + subsHide + subs2Hide + pros2Hide + comps2Hide;
        } 
    }
    $("#showTreeSelected").val(newTreeSelected);
    $("#showTreeSelectedHide").val(newTreeSelectedHide);
}	
function onCheckBidNo(e, treeId, treeNode) {
    // 项目编号@项目名称@包名@中标价序号@中标价；
    var treeSelectedHide = $("#showTreeSelectedBidNoHide").val();
    var newTreeSelectedHide = "";
    var added = false;
    var added2 = false;
    // 如果是勾选，则加
    if (treeNode.checked) {
        // 如果是勾选
        if (treeNode.level == 0) {
            // 如果是
        } else if (treeNode.level == 1) {
            // 如果是中标价
        } else if (treeNode.level == 2) {
            // 获取包
            var packageNode = getTreeValue(treeNode.pId);
            // 获取项目
            var bidNode = getTreeValue(packageNode.pId);
            var bidNo = bidNode.name.split("（")[0];
            var projectName = bidNode.name.split("（")[1].split("）")[0];
            var packageName = packageNode.name;
            var tenderPriceNo = treeNode.id.split("_")[2];
            var tenderPrice = treeNode.name.split("：")[1];
            var curNode = bidNo + "@" + projectName + "@" + packageName + "@" + tenderPriceNo + "@" + tenderPrice;

            newTreeSelectedHide = treeSelectedHide + curNode + "；";
        }
        // 如果是取消勾选，则去掉
    } else {
        // 如果是
        if (treeNode.level == 0) {
        } else if (treeNode.level == 1) {
        } else if (treeNode.level == 2) {
            // 获取包
            var packageNode = getTreeValue(treeNode.pId);
            // 获取项目
            var bidNode = getTreeValue(packageNode.pId);
            var bidNo = bidNode.name.split("（")[0];
            var projectName = bidNode.name.split("（")[1].split("）")[0];
            var packageName = packageNode.name;
            var tenderPriceNo = treeNode.id.split("_")[2];
            var tenderPrice = treeNode.name.split("：")[1];
            var bids = treeSelectedHide.split("；");
            for (var i = 0; i < bids.length; i++) {
                if (bids[i] != "") {
                    var nodes = bids[i].split("@");
                    if (nodes[0] == bidNo && 
                        nodes[1] == projectName && 
                        nodes[2] == packageName && 
                        nodes[3] == tenderPriceNo && 
                        nodes[4] == tenderPrice ) {
                        continue;
                    } else {
                        newTreeSelectedHide += bids[i] + "；";
                    }
                }
            }
        }
    }
    $("#showTreeSelectedBidNoHide").val(newTreeSelectedHide);
}

// 获取最终用户
function getFinalUsers() {

    // 获取最终用户的树结构数据

    //让弹出框显示的操作方法
    $('#message-module-ztree').find('.modal-body').html(
        '<div style="text-align: center;padding: 10px;line-height: 25px">' +
        '<form class="bs-example form-horizontal" name="form" >' +
        '<div class=" content-border">' +
        '    <div class="fenge-line"></div>' +
        '    <div class="zTreeDemoBackground">' +
        '        <ul id="treeDemo" class="ztree"></ul>' +
        '    </div>' +
        '</div>' +
        '<div> 你选择的是：<input type="text" id="showTreeSelected" readonly/>' +
        '<input type="hidden" id="showTreeSelectedHide" /><br/>*按所选的第一个子工程来生成合同编号</div>' +
        '</form > ' +
        '</div > '
    );
    var moduleFooter = $('#message-module-ztree').find('.modal-footer');
    moduleFooter.html("");
    var cancleButton = $('<button type="button" class="btn " data-dismiss="modal" style=" border-radius: 0px;border: 0px;margin-left: 0px;width: 50%;background-color:white;float: left;border-bottom-left-radius: 5px;border-color: #ff993b;line-height: 25px;color:black">取消</button>');
    var confirmButton = $('<button id="confirmButton1" type="button" class="btn btn-default" style="border-radius: 0px;border: 0px;background-color: #FF993B;width: 50%;float: right;border-bottom-right-radius: 6px;line-height: 25px;margin-left: 0px;">确定</button>');

    //if (moduleFooter.find('button').length === 0) {
    cancleButton.appendTo(moduleFooter);
    confirmButton.appendTo(moduleFooter);
    //}
    $('#message-module-ztree').modal({ keyboard: true, show: true, backdrop: true });
    $('#message-module-ztree').on('shown.bs.modal', function () {
        $.LoadingMask.Hide();
    });

    $.ajax({
        //dataType: "json",
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getFinalUserTree",   //处理页的相对地址
        data: {
            Type: "UltimateUser" // 最终用户类型
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.fn.zTree.init($('#treeDemo'), setting, ret);
            //var returninfo = eval("(" + response.responseText + ")");

            //if (returninfo.status == "success") {
            //    zNodes = returninfo.data;
            //    $.fn.zTree.init($('#treeDemo'), setting, zNodes);
            //}
        }
    });

    //$.fn.zTree.init($("#treeDemo"), setting, zNodes);
    setCheck();

    
    confirmButton.click(function () {
        $('#message-module-ztree').modal('hide');
        confirmSelectFinal();

    });

    
}

// 获取招标编号
function getBidNo() {

    //让弹出框显示的操作方法
    $('#message-module-ztree').find('.modal-body').html(
        '<div style="text-align: center;padding: 10px;line-height: 25px">' +
        '<div>招标编号：<input type="text" style="width: 30%" id="bidNoSearch" />  项目名称：<input type="text" style="width: 30%" id="projectNameSearch" /> <input type="button" value="搜索" onclick="bidNoSearchButton()" /></div>' +
        '<form class="bs-example form-horizontal" name="form" >' +
        '<div class=" content-border">' +
        '    <div class="fenge-line"></div>' +
        '    <div class="zTreeDemoBackground">' +
        '        <ul id="treeDemo" class="ztree"></ul>' +
        '    </div>' +
        '</div>' +
        '<div> *请选择的中标价节点，以选的中标价为准<input type="hidden" id="showTreeSelectedBidNoHide" /></div>' +
        '</form > ' +
        '</div > '
    );
    var moduleFooter = $('#message-module-ztree').find('.modal-footer');
    moduleFooter.html("");
    var cancleButton = $('<button type="button" class="btn " data-dismiss="modal" style=" border-radius: 0px;border: 0px;margin-left: 0px;width: 50%;background-color:white;float: left;border-bottom-left-radius: 5px;border-color: #ff993b;line-height: 25px;color:black">取消</button>');
    var confirmButton = $('<button id="confirmButton2" type="button" class="btn btn-default" style="border-radius: 0px;border: 0px;background-color: #FF993B;width: 50%;float: right;border-bottom-right-radius: 6px;line-height: 25px;margin-left: 0px;">确定</button>');

    //if (moduleFooter.find('button').length === 0) {
        cancleButton.appendTo(moduleFooter);
        confirmButton.appendTo(moduleFooter);
    //}
    $('#message-module-ztree').modal({ keyboard: true, show: true, backdrop: true });
    $('#message-module-ztree').on('shown.bs.modal', function () {
        $.LoadingMask.Hide();
    });

    $.ajax({
        //dataType: "json",
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getBidNoTree",   //处理页的相对地址
        data: {
            BiddingCode: "", // 
            ProjectName: "", // 
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.fn.zTree.init($('#treeDemo'), setting, ret);
            //var returninfo = eval("(" + response.responseText + ")");

            //if (returninfo.status == "success") {
            //    zNodes = returninfo.data;
            //    $.fn.zTree.init($('#treeDemo'), setting, zNodes);
            //}
        }
    });

    //$.fn.zTree.init($("#treeDemo"), setting, zNodes);
    setCheckBidNo();


    confirmButton.click(function () {
        $('#message-module-ztree').modal('hide');
        confirmSelectBidNo();

    });

}

function bidNoSearchButton() {
    var BiddingCode = $("#bidNoSearch").val();
    var ProjectName = $("#projectNameSearch").val();
    $.ajax({
        //dataType: "json",
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getBidNoTree",   //处理页的相对地址
        data: {
            BiddingCode: BiddingCode, // 
            ProjectName: ProjectName, // 
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.fn.zTree.init($('#treeDemo'), setting, ret);
            //var returninfo = eval("(" + response.responseText + ")");

            //if (returninfo.status == "success") {
            //    zNodes = returninfo.data;
            //    $.fn.zTree.init($('#treeDemo'), setting, zNodes);
            //}
        }
    });
    setCheckBidNo();
}
function confirmSelectFinal() {
    var showTreeSelected = $("#showTreeSelected").val();
    var showTreeSelectedHide = $("#showTreeSelectedHide").val();
    var FinalUser = "";
    var SubProjectName = "";
    var ts = showTreeSelected.split("；");
    if (ts.length == 2) {
        var ps = ts[0].split("：");
        var str = ps.length > 0 ? ps[1].split("；")[0] : "";
        str = str.replace(new RegExp("，）", "gm"), "）");
        SubProjectName = str != "" ? str.substring(0, str.length-1):""
    } else if (ts.length > 2){
        SubProjectName = showTreeSelected;
    }
    for (var i = 0; i < ts.length; i++) {
        if (ts[i] != "") {
            FinalUser += ts[i].split("：")[0] + "；";
        }
    }
    var cps = showTreeSelectedHide.split("：");
    var firproj = cps.length > 0 ? cps[1].split("；")[0] : "";
    var firprocode = "";
    var firsubprocode = "";
    if (firproj != "") {
        firprocode = firproj.split("（")[0];
        var subs = firproj.split("（")[1].split("，");
        firsubprocode = subs.length > 0 ? subs[0].replace("）", "").replace("、", "") : "";
    }
    FinalUser = FinalUser != "" ? FinalUser.substring(0, FinalUser.length-1):""
    $.MvcSheetUI.SetControlValue("FinalUser", FinalUser);
    $.MvcSheetUI.SetControlValue("ProjectName", SubProjectName);
    $.MvcSheetUI.SetControlValue("SubProjectName", SubProjectName);
    $.MvcSheetUI.SetControlValue("ContractShortName", SubProjectName + "-");
    $.MvcSheetUI.SetControlValue("ProjectCode", firprocode);
    $.MvcSheetUI.SetControlValue("SubProjectCode", firsubprocode);
}

function confirmSelectBidNo() {
    var showTreeSelectedHide = $("#showTreeSelectedBidNoHide").val();
    var bids = showTreeSelectedHide.split("；");
    var bidNo = "";
    for (var i = 0; i < bids.length; i++) {
        if (bids[i] != "") {
            var nodes = bids[i].split("@");
            if (bidNo != "" && nodes[0] != bidNo ) {
                layer.alert('不能选择招标项目不同的数据！', { icon: 2 });
                return false;
            }
            bidNo = nodes[0];
        }
    }
    var dtl = $.MvcSheetUI.GetElement('BidTbl').SheetGridView();
    dtl._Clear();
    for (var i = 0; i < bids.length; i++) {
        if (bids[i] != "") {
            dtl._AddRow();
            var nodes = bids[i].split("@");
            $.MvcSheetUI.SetControlValue("BidNo", nodes[0]);
            $.MvcSheetUI.SetControlValue("BidTbl.ProjectName", nodes[1], i + 1);
            $.MvcSheetUI.SetControlValue("BidTbl.PackageName", nodes[2], i + 1);
            $.MvcSheetUI.SetControlValue("BidTbl.TenderPriceNo", nodes[3], i + 1);
            $.MvcSheetUI.SetControlValue("BidTbl.BidPrice", nodes[4], i + 1);
        }
    }
    
    $('input[data-datafield="BidTbl.ProjectName"]').attr('disabled', 'disabled');
    $('input[data-datafield="BidTbl.PackageName"]').attr('disabled', 'disabled');
    $('input[data-datafield="BidTbl.TenderPriceNo"]').attr('disabled', 'disabled');
    $('input[data-datafield="BidTbl.BidPrice"]').attr('disabled', 'disabled');
}

function getTreeValue(key) {
    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    var checkednodes = treeObj.getCheckedNodes(true);
    for (var i = 0; i < checkednodes.length; i++) {
        if (checkednodes[i].id == key) {
            return checkednodes[i];
        }
    }
    var uncheckednodes = treeObj.getCheckedNodes(false);
    for (var i = 0; i < uncheckednodes.length; i++) {
        if (uncheckednodes[i].id == key) {
            return uncheckednodes[i];
        }
    }
}

