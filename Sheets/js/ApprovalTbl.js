
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;


$('.ApprovalTbl').bootstrapTable({
    //height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'ActivityName',
        width: '15%',
        title: '处理名称'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Operator',
        width: '15%',
        title: '处理人'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'OperateTime',
        width: '15%',
        title: '处理时间'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'OperateStatus',
        width: '15%',
        title: '处理结果'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Comment',
        width: '40%',
        title: '备注'
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});

// 查询
function SearchApprovalTbl() {
    
    // 获取记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getApprovalTblData",   //处理页的相对地址
        data: {
            InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.ActivityName = ret[i].ActivityName;
                obj.Operator = ret[i].Operator;
                obj.OperateTime = ret[i].OperateTime;
                obj.OperateStatus = ret[i].OperateStatus;
                obj.Comment = ret[i].Comment;
                // 往bootstrapTable添加数据
                $(".ApprovalTbl").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}