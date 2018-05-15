
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_FWQuery').bootstrapTable({
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
        field: 'Title',
        width: '25%',
        title: '标题'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'FileType',
        width: '10%',
        title: '文件类型'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'FWNo',
        width: '15%',
        title: '发文编号'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'ImportLevel',
        width: '15%',
        title: '重要程度'
    }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'Originator',
        width: '15%',
        title: '经办人'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'FWDate',
        width: '15%',
        title: '发文日期'
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
}

// 查询
function FWQuery() {
    var Title = $.MvcSheetUI.GetControlValue("Title");
    var FileType = $("[data-datafield='FileType']").find("option:selected").text();
    var FWNo = $.MvcSheetUI.GetControlValue("FWNo");
    var FWDateFrom = $.MvcSheetUI.GetControlValue("FWDateFrom");
    var FWDateTo = $.MvcSheetUI.GetControlValue("FWDateTo");

    $("#table_FWQuery").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getFWQuery",   //处理页的相对地址
        data: {
            Title: Title,
            FileType: FileType == "全部" ? "" : FileType,
            FWNo: FWNo,
            FWDateFrom: FWDateFrom,
            FWDateTo: FWDateTo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Title = '<a href="/Portal/Sheets/OAOffice/FWMy.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].Title + '</a>';
                obj.FileType = ret[i].FileType;
                obj.FWNo = ret[i].FWNo;
                obj.ImportLevel = ret[i].ImportLevel;
                obj.Originator = ret[i].Originator;
                obj.FWDate = ret[i].FWDate;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_FWQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
