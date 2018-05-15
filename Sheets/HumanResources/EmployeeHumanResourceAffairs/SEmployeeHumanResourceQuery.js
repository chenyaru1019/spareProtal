
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_EmployeeHumanQuery').bootstrapTable({
    height: 510,
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
        field: 'Title',
        width: '25%',
        title: '标题'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'BusinessType',
        width: '20%',
        title: '业务类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ApplicationNumber',
        width: '15%',
        title: '事务编号'
    },  {
        align: 'center',
        valign: 'middle',
        field: 'Originator',
        width: '15%',
        title: '经办人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ApplicationDate',
        width: '20%',
        title: '申请日期'
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
    EmployeeHumanQuery();
}

// 查询
function EmployeeHumanQuery() {
    var Title = $.MvcSheetUI.GetControlValue("Title");
    var BusinessType = $("[data-datafield='BusinessType']").find("option:selected").text();
    var ApplicationNumber = $.MvcSheetUI.GetControlValue("ApplicationNumber");
    var ApplicationDateFrom = $.MvcSheetUI.GetControlValue("ApplicationDateFrom");
    var ApplicationDateTo = $.MvcSheetUI.GetControlValue("ApplicationDateTo");

    $("#table_EmployeeHumanQuery").bootstrapTable('removeAll');
   
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeHumanHandler.ashx?Command=getEmployeeHumanQuery",   //处理页的相对地址
        data: {
            Title: Title,
            BusinessType: BusinessType == "全部" ? "" : BusinessType,
            ApplicationNumber: ApplicationNumber,
            ApplicationDateFrom: ApplicationDateFrom,
            ApplicationDateTo: ApplicationDateTo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Title = '<a href="/Portal/Sheets/EmployeeHumanResourceAffairs/SEmployeeHumanResourceAffairs.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].Title + '</a>';
                
                obj.BusinessType = ret[i].BusinessType;
                obj.ApplicationNumber = ret[i].ApplicationNumber;
                obj.Originator = ret[i].Originator;
                obj.ApplicationDate = ret[i].ApplicationDate;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_EmployeeHumanQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
