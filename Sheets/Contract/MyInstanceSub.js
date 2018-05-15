
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;
window.operateEvents = {
    "click #TableOperate": function (e, value, row, index) {
        var WorkItemID = row.WorkItemID;
        var Mode = row.Mode;
        window.location.href = "/Portal/WorkItemSheets.html?WorkItemID=" + WorkItemID + "&Mode=" + Mode;
    },
}


//模拟数据结束
//显示进度条的自定义列
function addBtn(value, row) {
    //        console.log(row.gys);
    var str = "<a id='TableOperate'>" + row.OperationNumber+"</a>";

    return [str].join("")
}
var SInstanceName = "";
var StartTime = "";
var EndTime = "";
var Type = "";
var TypeOfMe = "";
$('#table_MyInstanceSub').bootstrapTable({
    //height: 580,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //search : true,
    cache: false,
    striped: true,
    method: 'get',
    url: "ContractHandler.ashx?Command=getMyInstanceSub",
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
            Type: Type,
            TypeOfMe: TypeOfMe,
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
        events: operateEvents,
        formatter: addBtn,
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
        field: 'StartTime',
        width: '15%',
        title: '发起时间'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'FinishTime',
        width: '15%',
        title: '完成时间'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'CurrentActivity',
        width: '10%',
        title: '审批环节'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Approver',
        width: '15%',
        title: '审批人'
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
    }/*, {
        align: 'center',
        valign: 'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEvents,
        formatter: addBtn
    }*/
    ],
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
    Type = $.MvcSheetUI.GetControlValue("Type");
    TypeOfMe = $.MvcSheetUI.GetControlValue("TypeOfMe");
    $('#table_MyInstanceSub').bootstrapTable('refresh');
}
