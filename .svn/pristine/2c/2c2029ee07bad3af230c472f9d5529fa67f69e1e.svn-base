$.MvcSheet.Loaded = function () {

    var date = new Date;
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    month = (month < 10 ? "0" + month : month); 
    var mydate = (year.toString()+"-" + month.toString());

    $.MvcSheetUI.SetControlValue("StartTime", mydate);
    generateEmployeeOvertimeNo();
    $.MvcSheetUI.SetControlValue("DepartmentsJointlySignButton", "false");
    $("li[data-action='DepartmentsJointlyAction']").hide();
    $(".TriagePersonnel").hide();
    $(".FirstGradeCountersignedOpinion").hide();
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApproval") {
       

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenOffice") {
        $("li[data-action='DepartmentsJointlyAction']").show();
        $(".TriagePersonnel").show();
        // 获取相关部门审批的数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "EmployeeOvertimeHandler.ashx?Command=getCommentByFlg",   //处理页的相对地址
            data: {
                InstanceId: $.MvcSheetUI.SheetInfo.InstanceId,
                flg: "ActivityTriagePersonnel"
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                if (ret != "") {
                    $(".FirstGradeCountersignedOpinion").show();
                }
            }
        });
        
        
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityTriagePersonnel") {
        $("li[data-action='DepartmentsJointlyAction']").hide();
        $(".FirstGradeCountersignedOpinion").show();
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityHumanResourcesManager") {

    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") {

    }

    $("input[data-datafield='ApplicationDate']").attr("disabled", "disabled");
    $("input[data-datafield='ApplicationNumber']").attr("disabled", "disabled");
    $("input[data-datafield='OvertimeDetail.OvertimeHours']").attr("disabled", "disabled");
    

}
$.MvcSheet.Validate = function () {


    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApproval") {
        if (this.Action == "Submit") {
            var FinancialAuditLength = $("table[data-datafield='OvertimeDetail']").find("tr.rows").length;
            if (FinancialAuditLength < 1) {
                layer.alert('加班详情不能为空！', { icon: 2 });
                return false;
            }
        }
    }
    return true;
}
function generateEmployeeOvertimeNo() {
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeOvertimeHandler.ashx?Command=generateEmployeeOvertimeNo",   //处理页的相对地址
        data: {
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.MvcSheetUI.SetControlValue("ApplicationNumber", ret);

        }
    });
}
function EditOvertimeHours(o1) {
    var rowIndex = o1.parentElement.parentElement.rowIndex;
    var OvertimeDateString = $.MvcSheetUI.GetControlValue("OvertimeDetail.OvertimeDate", rowIndex - 1);
    var StartTimeString = $.MvcSheetUI.GetControlValue("OvertimeDetail.StartTime", rowIndex - 1);
    var EndTimeString = $.MvcSheetUI.GetControlValue("OvertimeDetail.EndTime", rowIndex - 1);
    var OvertimeDate1 = OvertimeDateString + " " + StartTimeString;
    var OvertimeDate2 = OvertimeDateString + " " + EndTimeString;
    var date1 = new Date(OvertimeDate1);
    var date2 = new Date(OvertimeDate2);

    var s1 = date1.getTime(), s2 = date2.getTime();
    var total = (s2 - s1) / 1000;

    var Hours = parseFloat(total / (60 * 60));
    var aa = (Hours.toString()).split(".");
   
    if (aa.length > 1) {
        if (aa[1].length > 2){
        aa[1]=aa[1].substring(0,2);
        }
        Hours = aa[0] + "." + aa[1];
    } else {
        Hours = aa[0];
    }
    $.MvcSheetUI.SetControlValue("OvertimeDetail.OvertimeHours", Hours,rowIndex - 1);
    //var day = parseInt(total / (24 * 60 * 60));//计算整数天数
    //var afterDay = total - day * 24 * 60 * 60;//取得算出天数后剩余的秒数
    //var hour = parseInt(afterDay / (60 * 60));//计算整数小时数
    //var afterHour = total - day * 24 * 60 * 60 - hour * 60 * 60;//取得算出小时数后剩余的秒数
    //var min = parseInt(afterHour / 60);//计算整数分
}
// 增加按钮方法，触发后台事件
$.MvcSheet.AddAction({
    Action: "DepartmentsJointlyAction",
    Icon: "fa-check",           // 按钮图标
    Text: "相关部门会审",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        var tr = document.getElementsByClassName('InvalidText')
        if (tr.length > 0) {
            layer.alert('必填项不能为空！', { icon: 2 });
            return false;
        }

        var ApplicationNumber = $.MvcSheetUI.GetControlValue("ApplicationNumber");
        
        var TriagePersonnel = $.MvcSheetUI.GetControlValue("TriagePersonnel");
        if (TriagePersonnel == "") {
            layer.alert('请选择相关部门审批人！', { icon: 2 });
            return false;
        }
        layer.confirm('确认相关部门审批吗？', function (index) {

            $.MvcSheetUI.SetControlValue("DepartmentsJointlySignButton", "true");
            // 提交
            $.MvcSheet.Submit2(this);
        });


    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});
