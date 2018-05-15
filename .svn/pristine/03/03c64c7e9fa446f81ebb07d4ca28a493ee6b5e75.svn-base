
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_EmployeeTurnoverQuery').bootstrapTable({
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
        field: 'StaffName',
        width: '15%',
        title: '员工姓名'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Organization',
        width: '30%',
        title: '员工部门'
    },  {
        align: 'center',
        valign: 'middle',
        field: 'ApplicationDate',
        width: '20%',
        title: '申请日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ReasonsForLeaving',
        width: '30%',
        title: '离职原因'
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
    EmployeeTurnoverQuery();
}

// 查询
function EmployeeTurnoverQuery() {
    var StaffName = $.MvcSheetUI.GetControlValue("StaffName");
    var Organization = $("[data-datafield='Organization']").find("option:selected").text();
    var ApplicationDateFrom = $.MvcSheetUI.GetControlValue("ApplicationDateFrom");
    var ApplicationDateTo = $.MvcSheetUI.GetControlValue("ApplicationDateTo");
    $("#table_EmployeeTurnoverQuery").bootstrapTable('removeAll');

    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeTurnoverHandler.ashx?Command=getEmployeeTurnoversQuery",   //处理页的相对地址EmployeeLeaveHandler.ashx?Command=
        data: {
            StaffName: StaffName,
            Organization: Organization == "全部" ? "" : Organization,
            ApplicationDateFrom: ApplicationDateFrom,
            ApplicationDateTo: ApplicationDateTo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.StaffName = '<a href="/Portal/Sheets/EmployeeLeaveApplication/SEmployeeLeaveApplication.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].StaffName + '</a>';

                obj.Organization = ret[i].Organization;
                obj.ApplicationDate = ret[i].ApplicationDate;
                obj.ReasonsForLeaving = ret[i].ReasonsForLeaving;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_EmployeeLeaveQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
