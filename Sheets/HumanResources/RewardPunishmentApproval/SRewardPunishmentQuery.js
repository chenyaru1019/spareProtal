
//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#table_RewardPunishmentQuery').bootstrapTable({
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
        width: '15%',
        title: '标题'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'StaffName',
        width: '5%',
        title: '员工姓名'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RewardPunishmentTime',
        width: '10%',
        title: '奖惩时间'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RewardsPunishmentsReasons',
        width: '20%',
        title: '奖惩原因'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RewardsPunishmentsType',
        width: '10%',
        title: '奖惩类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'RewardPunishmentDetails',
        width: '10%',
        title: '奖惩明细'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'AmountOfMoney',
        width: '10%',
        title: '金额'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Organization',
        width: '10%',
        title: '机构'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'CreatedBy',
        width: '5%',
        title: '创建者'
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
    RewardPunishmentQuery();
}

// 查询
function RewardPunishmentQuery() {
    var StaffName = $.MvcSheetUI.GetControlValue("StaffName");
    var RewardPunishmentTimeFrom = $.MvcSheetUI.GetControlValue("RewardPunishmentTimeFrom");
    var RewardPunishmentTimeTo = $.MvcSheetUI.GetControlValue("RewardPunishmentTimeTo");
    var RewardsPunishmentsType = $("[data-datafield='RewardsPunishmentsType']").find("option:selected").text();
    var RewardsPunishmentsReasons = $.MvcSheetUI.GetControlValue("RewardsPunishmentsReasons");
    var RewardPunishmentDetails = $("[data-datafield='RewardPunishmentDetails']").find("option:selected").text();
    $("#table_RewardPunishmentQuery").bootstrapTable('removeAll');

    $.ajax({
        type: "POST",    //页面请求的类型
        url: "RewardPunishmentApprovalHandler.ashx?Command=getRewardPunishmentApprovalQuery",   //处理页的相对地址EmployeeLeaveHandler.ashx?Command=
        data: {
            StaffName: StaffName,
            RewardPunishmentTimeFrom: RewardPunishmentTimeFrom,
            RewardPunishmentTimeTo: RewardPunishmentTimeTo,
            RewardsPunishmentsType: RewardsPunishmentsType == "全部" ? "" : RewardsPunishmentsType,
            RewardsPunishmentsReasons: RewardsPunishmentsReasons,
            RewardPunishmentDetails: RewardPunishmentDetails == "全部" ? "" : RewardPunishmentDetails,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Title = '<a href="/Portal/Sheets/RewardPunishmentApproval/SRewardPunishmentApproval.aspx?Mode=View&WorkItemID=' + ret[i].WorkItemId + '">' + ret[i].Title + '</a>';
                obj.StaffName = ret[i].StaffName;
                obj.RewardPunishmentTime = ret[i].RewardPunishmentTime;
                obj.RewardsPunishmentsReasons = ret[i].RewardsPunishmentsReasons;
                obj.RewardsPunishmentsType = ret[i].RewardsPunishmentsType;
                obj.RewardPunishmentDetails = ret[i].RewardPunishmentDetails;
                obj.AmountOfMoney = ret[i].AmountOfMoney;
                obj.Organization = ret[i].Organization;
                obj.CreatedBy = ret[i].CreatedBy;
                obj.WorkItemId = ret[i].WorkItemId;
                // 往bootstrapTable添加数据
                $("#table_RewardPunishmentQuery").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}
