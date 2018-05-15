﻿
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;

window.operateEvents = {
    "click .TableView": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/SupplierManagerMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click .TableUpdate": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/SupplierManagerMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
}

//模拟数据结束
//显示进度条的自定义列
function addBtn(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "发起申请") {
        str = "<a class='btn btn-primary btn-xs TableView' data-toggle='modal'>查看</a>"
            + "<a class='btn btn-primary btn-xs TableUpdate' data-toggle='modal'>修改</a>";
    } else {
        str = "<a class='btn btn-primary btn-xs TableView' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}

$('#table_SupplierManagerQuery').bootstrapTable({
    //height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '5%',
        title: '序号'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ManagerType',
        width: '10%',
        title: '管理类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'SupplierName',
        width: '20%',
        title: '名称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'SupplierNo',
        width: '10%',
        title: '统一信息码'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contact',
        width: '10%',
        title: '联系人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Telephone',
        width: '10%',
        title: '联系电话'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ManagerOrg',
        width: '10%',
        title: '管理机构'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Salesman',
        width: '10%',
        title: '业务员'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId',
        visible: false,
        title: 'WorkItemId'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '5%',
        title: '审批状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEvents,
        formatter: addBtn
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

    SupplierManagerQuery();
}

// 新增供应商管理
function NewSupplierManager() {
    //window.location.href = "/Portal/Sheets/OAOffice/OAOfficeHandler.ashx?Command=exportExcel";
    var WorkflowVersion_SM = $.MvcSheetUI.GetControlValue("WorkflowVersion_SM");
    window.location.href = "/Portal/Sheets/OAOffice/SupplierManagerMy.aspx?Mode=Originate&WorkflowCode=SupplierManager&WorkflowVersion=" + WorkflowVersion_SM;
}

// 查询
function SupplierManagerQuery() {
    var ManagerType = $("[data-datafield='ManagerType']").find("option:selected").text();
    var SupplierName = $.MvcSheetUI.GetControlValue("SupplierName");
    var Salesman = $.MvcSheetUI.GetControlValue("Salesman");

    $("#table_SupplierManagerQuery").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getSupplierManagerQuery",   //处理页的相对地址
        data: {
            ManagerType: ManagerType == "全部" ? "" : ManagerType,
            SupplierName: SupplierName,
            Salesman: Salesman,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.ManagerType = ret[i].ManagerType;
                obj.SupplierName = '<a href="/Portal/Sheets/OAOffice/SupplierManagerMy.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].SupplierName + '</a>';
                obj.SupplierNo = ret[i].SupplierNo;
                obj.Contact = ret[i].Contact;
                obj.Telephone = ret[i].Telephone;
                obj.ManagerOrg = ret[i].ManagerOrg;
                obj.Salesman = ret[i].Salesman;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.DisplayName = ret[i].DisplayName;
                // 往bootstrapTable添加数据
                $("#table_SupplierManagerQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
