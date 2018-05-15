
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_AttendanceStatisticsQuery').bootstrapTable({
    height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    //columns: [{
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'TheNo',
    //    width: '5%',
    //    title: '序号'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'StaffName',
    //    width: '15%',
    //    title: '员工姓名'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'Organization',
    //    width: '30%',
    //    title: '员工部门'
    //},  {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'ApplicationDate',
    //    width: '20%',
    //    title: '申请日期'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'ReasonsForLeaving',
    //    width: '30%',
    //    title: '离职原因'
    //}, {
    //    align: 'center',
    //    valign: 'middle',
    //    field: 'WorkItemId',
    //    visible: false,
    //    title: 'WorkItemId'
    //}],
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
    var date = new Date();
    var year = date.getFullYear();
    var ParticularYear = $.MvcSheetUI.GetControlValue("ParticularYear");

    if (ParticularYear == '') {
        $.MvcSheetUI.SetControlValue("ParticularYear", year);
    }
    
    AttendanceStatisticsQuery();
}

// 查询
function AttendanceStatisticsQuery() {
    var ParticularYear = $.MvcSheetUI.GetControlValue("ParticularYear");
   // alert(ParticularYear);
    var Organization = $("[data-datafield='Organization']").find("option:selected").text();
    $("#table_AttendanceStatisticsQuery").bootstrapTable('removeAll');

    $.ajax({
        type: "POST",    //页面请求的类型
        url: "AttendanceStatisticsHandler.ashx?Command=getAttendanceStatisticsQuery",   //处理页的相对地址EmployeeLeaveHandler.ashx?Command=
        data: {
            ParticularYear: ParticularYear,
            Organization: Organization == "全部" ? "" : Organization,
            
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                //obj.TheNo = ret[i].TheNo;
                obj.StaffName = ret[i].StaffName;
                obj.ParticularYear = ParticularYear;
                if (ret[i].TotalDays1=='0') {
                    obj.dxTotalDays1 = '';
                } else {

                obj.dxTotalDays1 = ret[i].TotalDays1;
                }
                if (ret[i].SumApplyDays1 == '0') {
                    obj.dxSumApplyDays1 = '';
                } else {

                obj.dxSumApplyDays1 = ret[i].SumApplyDays1;
                }
                var DaysRemaining1 = ret[i].TotalDays1 * 1 - ret[i].SumApplyDays1 * 1;
                if (DaysRemaining1 ==0){
                    obj.dxDaysRemaining1 = '';
                } else {
                    obj.dxDaysRemaining1 = DaysRemaining1;
                }

                if (ret[i].TotalDays2 == '0') {
                    obj.jbTotalDays2 = '';
                } else {

                    obj.jbTotalDays2 = ret[i].TotalDays2;
                }
                if (ret[i].SumApplyDays2 == '0') {
                    obj.jbSumApplyDays2 = '';
                } else {

                    obj.jbSumApplyDays2 = ret[i].SumApplyDays2;
                }
                var DaysRemaining2 = ret[i].TotalDays2 * 1 - ret[i].SumApplyDays2 * 1;
                if (DaysRemaining2 == 0) {
                    obj.jbDaysRemaining2 = '';
                } else {
                    obj.jbDaysRemaining2 = DaysRemaining2;
                }
               
                if (ret[i].SumApplyDays3 == '0') {
                    obj.SumApplyDays3 = '';
                } else {

                    obj.SumApplyDays3 = ret[i].SumApplyDays3;
                }
                if (ret[i].SumApplyDays4 == '0') {
                    obj.SumApplyDays4 = '';
                } else {

                    obj.SumApplyDays4 = ret[i].SumApplyDays4;
                }
                if (ret[i].SumApplyDays5 == '0') {
                    obj.SumApplyDays5 = '';
                } else {

                    obj.SumApplyDays5 = ret[i].SumApplyDays5;
                }
                if (ret[i].SumApplyDays6 == '0') {
                    obj.SumApplyDays6 = '';
                } else {

                    obj.SumApplyDays6 = ret[i].SumApplyDays6;
                }
                if (ret[i].SumApplyDays7 == '0') {
                    obj.SumApplyDays7 = '';
                } else {

                    obj.SumApplyDays7 = ret[i].SumApplyDays7;
                }
                if (ret[i].SumApplyDays8 == '0') {
                    obj.SumApplyDays8 = '';
                } else {

                    obj.SumApplyDays8 = ret[i].SumApplyDays8;
                }
                if (ret[i].SumApplyDays9 == '0') {
                    obj.SumApplyDays9 = '';
                } else {

                    obj.SumApplyDays9 = ret[i].SumApplyDays9;
                }
                if (ret[i].SumApplyDays10 == '0') {
                    obj.SumApplyDays10 = '';
                } else {

                    obj.SumApplyDays10 = ret[i].SumApplyDays10;
                }
                if (ret[i].SumApplyDays11 == '0') {
                    obj.SumApplyDays11 = '';
                } else {

                    obj.SumApplyDays11 = ret[i].SumApplyDays11;
                }
                if (ret[i].SumApplyDays12 == '0') {
                    obj.SumApplyDays12 = '';
                } else {

                    obj.SumApplyDays12 = ret[i].SumApplyDays12;
                }
                if (ret[i].SumApplyDays13 == '0') {
                    obj.SumApplyDays13 = '';
                } else {

                    obj.SumApplyDays13 = ret[i].SumApplyDays13;
                }
                if (ret[i].SumApplyDays14 == '0') {
                    obj.SumApplyDays14 = '';
                } else {

                    obj.SumApplyDays14 = ret[i].SumApplyDays14;
                }
                if (ret[i].SumApplyDays15 == '0') {
                    obj.SumApplyDays15 = '';
                } else {

                    obj.SumApplyDays15 = ret[i].SumApplyDays15;
                }
                if (ret[i].SumApplyDays16 == '0') {
                    obj.SumApplyDays16 = '';
                } else {

                    obj.SumApplyDays16 = ret[i].SumApplyDays16;
                }
               
                // 往bootstrapTable添加数据
                $("#table_AttendanceStatisticsQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
function hidExport_Click() {
    var ParticularYear = $.MvcSheetUI.GetControlValue("ParticularYear");
    // alert(ParticularYear);
    var Organization = $("[data-datafield='Organization']").find("option:selected").text();
   // window.location.href = "AttendanceStatisticsHandler.ashx?Command=exportExcel&ParticularYear=" + ParticularYear + "&Organization=" + (Organization == "全部" ? "" : Organization);
    
    window.location.href = "AttendanceStatisticsHandler.ashx?Command=hidExport_Click&ParticularYear=" + ParticularYear + "&Organization=" + (Organization == "全部" ? "" : Organization);

    //$.ajax({
    //    type: "POST",    //页面请求的类型
    //    url: "AttendanceStatisticsHandler.ashx?Command=exportExcel",   //处理页的相对地址EmployeeLeaveHandler.ashx?Command=
    //    data: {
    //        ParticularYear: ParticularYear,
    //        Organization: Organization == "全部" ? "" : Organization,

    //    },
    //    async: false,
    //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            
    //    }
    //});
}
