
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
    var str = "<a id='TableOperate' class='btn btn-primary btn-xs' data-toggle='modal'>进入</a>";

    return [str].join("")
}
var ModuleName = "";
var SubInstanceName = "";
var FullText = "";
$('#table_FullTextSearch').bootstrapTable({
    //height: 580,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //search : true,
    cache: false,
    striped: true,
    method: 'get',
    url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getFullTextSearchData",
    sidePagination: "server",
    queryParams: function (params) {
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        return {
            pageNumber: params.offset + 1,
            pageSize: params.limit,
            CurrentUser: CurrentUser.ObjectID,
            ModuleName: ModuleName,
            SubInstanceName: SubInstanceName,
            FullText: FullText,
        };
    },
    //模拟数据
    columns: [{
        //sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'ModuleName',
        width: '10%',
        title: '模块'
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
        field: 'SubInstanceName',
        width: '10%',
        title: '流程名称'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'ReceiveTime',
    //    width: '15%',
    //    title: '接收时间'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'OriginatorName',
    //    width: '10%',
    //    title: '发起人'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'OUName',
    //    width: '15%',
    //    title: '发起人所属组织'
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
    
    // 只显示关闭按钮
    $("li[data-action='Save']").hide();
    $("li[data-action='Submit']").hide();
    $("li[data-action='Print']").hide();
    $("li[data-action='Forward']").hide();
    $("li[data-action='ViewInstance']").hide();

    var FullText = getUrlParamZW("PFullText");
    var ModuleName = getUrlParam("PModuleName");
    var SubInstanceName = getUrlParam("PSubInstanceName");
    if (FullText != null && FullText != "") {
        $("#FullText").val(FullText);
        $("#ModuleName").val(ModuleName);
        $("#ModuleName").change()
        $("#SubInstanceName").val(SubInstanceName);
        Search();
    }
}

function Search() {
    ModuleName = $("#ModuleName").val();
    SubInstanceName = $("#SubInstanceName").val();
    FullText = $("#FullText").val();
    $('#table_FullTextSearch').bootstrapTable('refresh');
}


function getSubInstanceName() {
    var ModuleName = $("#ModuleName").val();
    if (ModuleName != "") {
        //关联查询
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getSubInstanceName",   //处理页的相对地址
            data: {
                ModuleName: ModuleName,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                $("#SubInstanceName").empty();
                var str = "<option value=''>请选择</option>";
                for (var i = 0; i < ret.length; i++) {
                    str += "<option value='" + ret[i].key + "'>" + ret[i].attr1 + "</option>";
                }
                $("#SubInstanceName").append(str);

            }
        });
    }
    
}