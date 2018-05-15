﻿
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;

window.operateEvents = {
    "click .TableView": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/LicenceManagerMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click .TableUpdate": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/LicenceManagerMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
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

$('#table_LicenceManager').bootstrapTable({
    //height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '5%',
        title: '序号'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'LicenceType',
        width: '10%',
        title: '证件类型'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'LicenceNo',
        width: '15%',
        title: '证件编号'
    }, {
            sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'LicenceName',
        width: '20%',
        title: '证件名称'
    }, {
            sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'StartDate',
        width: '8%',
        title: '开始日期'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'EndDate',
        width: '8%',
        title: '结束日期'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'NJDate',
        width: '8%',
        title: '年检日期'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'ChangeLicDate',
        width: '8%',
        title: '换证日期'
    }, {
        sortable: true,//启用排序
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '8%',
        title: '申请状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEvents,
        formatter: addBtn
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId',
        visible: false,
        title: 'WorkItemId'
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

    LicenceQuery();
}

// 新增
function NewLicence() {
    var WorkflowVersion_Licence = $.MvcSheetUI.GetControlValue("WorkflowVersion_Licence");
    window.location.href = "/Portal/Sheets/OAOffice/LicenceManagerMy.aspx?Mode=Originate&WorkflowCode=LicenceManager&WorkflowVersion=" + WorkflowVersion_Licence;
}

// 查询
function LicenceQuery() {
    var LicenceType = $("[data-datafield='LicenceType']").find("option:selected").text();
    var LicenceNo = $.MvcSheetUI.GetControlValue("LicenceNo");
    var LicenceName = $.MvcSheetUI.GetControlValue("LicenceName");

    $("#table_LicenceManager").bootstrapTable('removeAll');
    // 获取
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getLicenceQuery",   //处理页的相对地址
        data: {
            LicenceType: LicenceType == "全部" ? "" : LicenceType,
            LicenceNo: LicenceNo,
            LicenceName: LicenceName,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.LicenceType = ret[i].LicenceType;
                obj.LicenceNo = ret[i].LicenceNo;
                obj.LicenceName = ret[i].LicenceName;
                obj.StartDate = ret[i].StartDate;
                obj.EndDate = ret[i].EndDate;
                obj.NJDate = ret[i].NJDate;
                obj.ChangeLicDate = ret[i].ChangeLicDate;
                obj.DisplayName = ret[i].DisplayName;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_LicenceManager").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
