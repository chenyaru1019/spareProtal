
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;
window.operateEvents = {
    "click #TableOperate": function (e, value, row, index) {
        var WorkItemID = row.WorkItemID;
        window.location.href = "/Portal/WorkItemSheets.html?WorkItemID=" + WorkItemID;
    },
}


//模拟数据结束
//显示进度条的自定义列
function addBtn(value, row) {
    //        console.log(row.gys);
    var str = "<a id='TableOperate' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";

    return [str].join("")
}
var SInstanceName = "";
var StartTime = "";
var EndTime = "";
$('#table_FinishedTask').bootstrapTable({
    //height: 580,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //search : true,
    cache: false,
    striped: true,
    method: 'get',
    url: "ContractHandler.ashx?Command=getFinishedTask",
    sidePagination: "server",
    queryParams: function (params) {
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        return {
            pageNumber: params.offset + 1,
            pageSize: params.limit,
            CurrentUser: CurrentUser.ObjectID,
            SInstanceName: SInstanceName,
            StartTime: StartTime,
            EndTime: EndTime,
        };
    },
    //模拟数据
    columns: [{
        //sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'InstanceName',
        width: '10%',
        title: '流程名称'
    },
    {
        align: 'center',
        valign: 'middle',
        field: 'OperationNumber',
        width: '10%',
        title: '编号'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ProjectAbbreviation',
        width: '10%',
        title: '项目简称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'TaskName',
        width: '10%',
        title: '任务名称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ReceiveTime',
        width: '15%',
        title: '接收时间'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'OriginatorName',
        width: '10%',
        title: '发起人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'OUName',
        width: '15%',
        title: '发起人所属组织'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ICObjectID',
        visible: false,
        title: 'ICObjectID'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'WorkItemID',
        visible: false,
        title: 'WorkItemID'
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
    pageList: [10, 25, 50, 100],
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
    //Search();
}

function Search() {
    SInstanceName = $.MvcSheetUI.GetControlValue("SInstanceName");
    StartTime = $.MvcSheetUI.GetControlValue("StartTime");
    EndTime = $.MvcSheetUI.GetControlValue("EndTime");
    $('#table_FinishedTask').bootstrapTable('refresh');
}
// 查询
//function Search() {
//    var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
//    var SInstanceName = $.MvcSheetUI.GetControlValue("SInstanceName");

//    $("#table_UnfinishedTask").bootstrapTable('removeAll');

//    $.ajax({
//        type: "POST",    //页面请求的类型
//        url: "ContractHandler.ashx?Command=getUnfinishedTask",   //处理页的相对地址
//        data: {
//            CurrentUser: CurrentUser.ObjectID,
//            SInstanceName: SInstanceName,
//        },
//        async: false,
//        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//            for (var i = 0; i < ret.length; i++) {
//                var obj = {};
//                obj.ICObjectID = ret[i].ICObjectID;
//                obj.WorkItemID = ret[i].WorkItemID;
//                obj.InstanceName = ret[i].InstanceName;
//                obj.OperationNumber = ret[i].OperationNumber;
//                obj.ProjectAbbreviation = ret[i].ProjectAbbreviation;
//                obj.TaskName = ret[i].TaskName;
//                obj.ReceiveTime = ret[i].ReceiveTime;
//                obj.OriginatorName = ret[i].OriginatorName;
//                obj.OUName = ret[i].OUName;
//                obj.CreatedTime = ret[i].CreatedTime;
//                // 往bootstrapTable添加数据
//                $("#table_UnfinishedTask").bootstrapTable('insertRow', { index: i, row: obj });
//            }
//        }
//    });

//}
