﻿
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;

window.operateEvents = {
    "click .TableView": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/NoticeMy.aspx?Mode=View&WorkItemID=" + WorkItemId;
    },
    "click .TableUpdate": function (e, value, row, index) {
        var WorkItemId = row.WorkItemId;
        window.location.href = "/Portal/Sheets/OAOffice/NoticeMy.aspx?Mode=Work&WorkItemID=" + WorkItemId;
    },
    "click .TableViewPage": function (e, value, row, index) {
        var WorkItemId2 = row.WorkItemId2;
        window.location.href = "/Portal/Sheets/OAOffice/NoticeViewMy.aspx?Mode=View&WorkItemID=" + WorkItemId2;
    },
}

//模拟数据结束
//显示进度条的自定义列
function addBtn(value, row) {
    //        console.log(row.gys);
    var str = "";
    if (row.DisplayName == "驳回" || row.DisplayName == "发起公告") {
        str = "<a class='btn btn-primary btn-xs TableView' data-toggle='modal'>查看</a>"
            + "<a class='btn btn-primary btn-xs TableUpdate' data-toggle='modal'>修改</a>";
    } else if (row.DisplayName == "完成") {
        str = "<a class='btn btn-primary btn-xs TableView' data-toggle='modal'>查看</a>"
            + "<a class='btn btn-primary btn-xs TableViewPage' data-toggle='modal'>预览</a>";
    } else {
        str = "<a class='btn btn-primary btn-xs TableView' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}

$('#table_NoticeManager').bootstrapTable({
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
        field: 'IsTop',
        width: '5%',
        title: '置顶'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'NoticeType',
        width: '10%',
        title: '公告类型'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Title',
        width: '15%',
        title: '信息标题'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Status',
        width: '10%',
        title: '状态'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'PublishDate',
        width: '15%',
        title: '发布日期'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'ReadCount',
        width: '5%',
        title: '阅读数'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'PLCount',
        width: '5%',
        title: '评论数'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Originator',
        width: '10%',
        title: '创建者'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'DisplayName',
        width: '10%',
        title: '审批状态'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RejectFlg',
        visible: false,
        title: 'RejectFlg'
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
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemId2',
        visible: false,
        title: 'WorkItemId2'
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

    NoticeQuery();
}

// 新增公司公告
function NewNotice() {
    var WorkflowVersion_Notice = $.MvcSheetUI.GetControlValue("WorkflowVersion_Notice");
    window.location.href = "/Portal/Sheets/OAOffice/NoticeMy.aspx?Mode=Originate&WorkflowCode=Notice&WorkflowVersion=" + WorkflowVersion_Notice;
}

// 查询
function NoticeQuery() {
    var Title = $.MvcSheetUI.GetControlValue("Title");
    var NoticeType = $("[data-datafield='NoticeType']").find("option:selected").text();
    //var Content = $.MvcSheetUI.GetControlValue("Content");

    $("#table_NoticeManager").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getNoticeQuery",   //处理页的相对地址
        data: {
            Title: Title,
            NoticeType: NoticeType == "全部" ? "" : NoticeType,
            //Content: Content,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.IsTop = ret[i].IsTop;
                obj.NoticeType = ret[i].NoticeType;
                obj.Title = ret[i].Title;
                obj.Status = ret[i].Status;
                obj.PublishDate = ret[i].PublishDate;
                obj.ReadCount = ret[i].ReadCount;
                obj.PLCount = ret[i].PLCount;
                obj.Originator = ret[i].Originator;
                obj.Originator = ret[i].Originator;
                obj.DisplayName = ret[i].DisplayName;
                obj.RejectFlg = ret[i].RejectFlg;
                obj.WorkItemId = ret[i].WorkItemId;
                obj.WorkItemId2 = ret[i].WorkItemId2;
                // 往bootstrapTable添加数据
                $("#table_NoticeManager").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
