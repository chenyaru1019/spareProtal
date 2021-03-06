﻿
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;
window.operateEventsQK = {
    "click #TableViewQK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_QKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click #TableUpdateQK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_QKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
}

window.operateEventsFK = {
    "click #TableViewFK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_FKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click #TableUpdateFK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_FKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
}

window.operateEventsJQ = {
    "click #TableViewJQ": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_JQMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click #TableUpdateJQ": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchJS_JQMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
}

//模拟数据结束
//显示进度条的自定义列
function addBtnQK(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "驳回" || row.DisplayName == "草稿") {
        str = "<a id='TableViewQK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>"
            + "<a id='TableUpdateQK' class='btn btn-primary btn-xs' data-toggle='modal'>修改</a>";
    } else {
        str = "<a id='TableViewQK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}

function addBtnFK(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "驳回" || row.DisplayName == "草稿") {
        str = "<a id='TableViewFK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>"
            + "<a id='TableUpdateFK' class='btn btn-primary btn-xs' data-toggle='modal'>修改</a>";
    } else {
        str = "<a id='TableViewFK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}

function addBtnJQ(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "驳回" || row.DisplayName == "草稿") {
        str = "<a id='TableViewJQ' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>"
            + "<a id='TableUpdateJQ' class='btn btn-primary btn-xs' data-toggle='modal'>修改</a>";
    } else {
        str = "<a id='TableViewJQ' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}

$('#table_BatchJS_QK').bootstrapTable({
    //height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '5%',
        title: '序号'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'QK_Target',
        width: '15%',
        title: '请款对象'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Content',
        width: '18%',
        title: '请款内容'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Amount',
        width: '15%',
        title: '请款金额'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'SDDate',
        width: '12%',
        title: '请款送达日期'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DKDate',
        width: '15%',
        title: '到款日期'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '10%',
        title: '状态'
    }, {

        align: 'center',
        valign: 'middle',
        field: 'Status',
        visible: false,
        title: '状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RejectFlg',
        visible: false,
        title: 'RejectFlg'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId',
        visible: false,
        title: 'WorkItemId'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEventsQK,
        formatter: addBtnQK
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});


$('#table_BatchJS_FK').bootstrapTable({
    height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '5%',
        title: '序号'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Receiver',
        width: '15%',
        title: '收款人'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'PayType',
        width: '10%',
        title: '支付方式'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Content',
        width: '20%',
        title: '付款内容'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Amount',
        width: '15%',
        title: '付款金额'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'FKDate',
        width: '15%',
        title: '付款日期'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '10%',
        title: '状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Status',
        visible: false,
        title: '状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RejectFlg',
        visible: false,
        title: 'RejectFlg'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId',
        visible: false,
        title: 'WorkItemId'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEventsFK,
        formatter: addBtnFK
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});

$('#table_BatchJS_JQ').bootstrapTable({
    height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '10%',
        title: '序号'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'JQ_Target',
        width: '25%',
        title: '结清对象'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Content',
        width: '30%',
        title: '结清内容'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '15%',
        title: '状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Status',
        visible: false,
        title: '状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RejectFlg',
        visible: false,
        title: 'RejectFlg'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId',
        visible: false,
        title: 'WorkItemId'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '20%',
        events: operateEventsJQ,
        formatter: addBtnJQ
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});




// 表单验证接口
$.MvcSheet.Validate = function () {


}

//}
//数据加载后
$.MvcSheet.Loaded = function () {

    $(".ContractContent div[data-title='征询意见']").parent().hide();
    $(".BatchJSQueryMy_Title").text("批量结算（请款）");

        // 隐藏导航栏
    $("#main-navbar").hide();
}

function setTitle(str) {
    $(".BatchJSQueryMy_Title").text(str);
}

// 跳转到批量结算申请页面
function ToBatchJSApply() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_BatchJSApply = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchJSApply");
    window.location.href = "/Portal/Sheets/Contract/BatchJSApplyMy.aspx?Mode=Originate&WorkflowCode=BatchJSApply&WorkflowVersion=" + WorkflowVersion_BatchJSApply;
}


// 请款查询
function BatchQKSearch() {
    var QK_Target = $("[data-datafield='QK_Target']").find("option:selected").text();
    var QK_Status = $.MvcSheetUI.GetControlValue("QK_Status");

    $("#table_BatchJS_QK").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getBatchJS_QKData",   //处理页的相对地址
        data: {
            QK_Target: QK_Target == "全部" ? "" : QK_Target,
            QK_Status: QK_Status,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.QK_Target = ret[i].QK_Target;
                obj.Content = ret[i].Content;
                obj.Amount = ret[i].Amount;
                obj.SDDate = ret[i].SDDate;
                obj.DKDate = ret[i].DKDate;
                obj.DisplayName = ret[i].DisplayName;
                obj.Status = ret[i].Status;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.RejectFlg = ret[i].RejectFlg;
                // 往bootstrapTable添加数据
                $("#table_BatchJS_QK").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}

// 付款查询
function BatchFKSearch() {
    var FK_Target = $("[data-datafield='FK_Target']").find("option:selected").text();
    var FK_Status = $.MvcSheetUI.GetControlValue("FK_Status");

    $("#table_BatchJS_FK").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getBatchJS_FKData",   //处理页的相对地址
        data: {
            FK_Target: FK_Target == "全部" ? "" : FK_Target,
            FK_Status: FK_Status,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Receiver = ret[i].Receiver;
                obj.PayType = ret[i].PayType;
                obj.Content = ret[i].Content;
                obj.Amount = ret[i].Amount;
                obj.FKDate = ret[i].FKDate;
                obj.DisplayName = ret[i].DisplayName;
                obj.Status = ret[i].Status;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.RejectFlg = ret[i].RejectFlg;
                // 往bootstrapTable添加数据
                $("#table_BatchJS_FK").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}

// 结清查询
function BatchJQSearch() {
    var JQ_Target = $("[data-datafield='JQ_Target']").find("option:selected").text();
    var JQ_Status = $.MvcSheetUI.GetControlValue("JQ_Status");

    $("#table_BatchJS_JQ").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getBatchJS_JQData",   //处理页的相对地址
        data: {
            JQ_Target: JQ_Target == "全部" ? "" : JQ_Target,
            JQ_Status: JQ_Status,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.JQ_Target = ret[i].JQ_Target;
                obj.Content = ret[i].Content;
                obj.DisplayName = ret[i].DisplayName;
                obj.Status = ret[i].Status;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.RejectFlg = ret[i].RejectFlg;
                // 往bootstrapTable添加数据
                $("#table_BatchJS_JQ").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}