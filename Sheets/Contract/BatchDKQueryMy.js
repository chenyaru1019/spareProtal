﻿
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;
window.operateEventsDK = {
    "click #TableViewDK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchDK_DKMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click #TableUpdateDK": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/Contract/BatchDK_DKMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
}

//模拟数据结束
//显示进度条的自定义列
function addBtnDK(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "驳回" || row.DisplayName == "草稿") {
        str = "<a id='TableViewDK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>"
            + "<a id='TableUpdateDK' class='btn btn-primary btn-xs' data-toggle='modal'>修改</a>";
    } else {
        str = "<a id='TableViewDK' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}


$('#table_BatchDK_DK').bootstrapTable({
    //height: 510,
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
        field: 'DK_Target',
        width: '20%',
        title: '到款对象'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DKDate',
        width: '20%',
        title: '到款日期'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Amount',
        width: '20%',
        title: '到款金额'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '20%',
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
        events: operateEventsDK,
        formatter: addBtnDK
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
    // 隐藏导航栏
    $("#main-navbar").hide();
}


// 跳转到批量到款申请页面
function ToBatchDKApply() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkflowVersion_BatchDKApply = $.MvcSheetUI.GetControlValue("WorkflowVersion_BatchDKApply");
    window.location.href = "/Portal/Sheets/Contract/BatchDKApplyMy.aspx?Mode=Originate&WorkflowCode=BatchDKApply&WorkflowVersion=" + WorkflowVersion_BatchDKApply;
}


// 到款查询
function BatchDKSearch() {
    var DK_Target = $("[data-datafield='DK_Target']").find("option:selected").text();
    var DK_Status = $.MvcSheetUI.GetControlValue("DK_Status");

    $("#table_BatchDK_DK").bootstrapTable('removeAll');
    // 获取批量到款之批量到款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getBatchDK_DKData",   //处理页的相对地址
        data: {
            DK_Target: DK_Target == "全部" ? "" : DK_Target,
            DK_Status: DK_Status,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.DK_Target = ret[i].DK_Target;
                obj.DKDate = ret[i].DKDate;
                obj.Amount = ret[i].Amount;
                obj.DisplayName = ret[i].DisplayName;
                obj.Status = ret[i].Status;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.RejectFlg = ret[i].RejectFlg;
                // 往bootstrapTable添加数据
                $("#table_BatchDK_DK").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
