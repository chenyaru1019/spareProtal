
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_SWQuery').bootstrapTable({
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
        field: 'FromNo',
        width: '15%',
        title: '来电编号'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'FromDW',
        width: '15%',
        title: '来电单位'
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
        field: 'SWDate',
        width: '15%',
        title: '收文日期'
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
function SWQuery() {
    var Title = $.MvcSheetUI.GetControlValue("Title");
    var FileType = $("[data-datafield='FileType']").find("option:selected").text();
    var FromDW = $.MvcSheetUI.GetControlValue("FromDW");
    var SWDateFrom = $.MvcSheetUI.GetControlValue("SWDateFrom");
    var SWDateTo = $.MvcSheetUI.GetControlValue("SWDateTo");

    $("#table_SWQuery").bootstrapTable('removeAll');
    // 获取批量结算之批量付款记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getSWQuery",   //处理页的相对地址
        data: {
            Title: Title,
            FileType: FileType == "全部" ? "" : FileType,
            FromDW: FromDW,
            SWDateFrom: SWDateFrom,
            SWDateTo: SWDateTo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Title = '<a href="/Portal/Sheets/OAOffice/SWMy.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].Title + '</a>';
                obj.FileType = ret[i].FileType;
                obj.FromNo = ret[i].FromNo;
                obj.FromDW = ret[i].FromDW;
                obj.Originator = ret[i].Originator;
                obj.SWDate = ret[i].SWDate;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_SWQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
