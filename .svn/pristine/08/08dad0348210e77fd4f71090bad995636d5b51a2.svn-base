//$.MvcSheet.SaveAction.OnActionPreDo = function () {
//    var BusinessType = $.MvcSheetUI.GetControlValue("BusinessType");
//    var Title = $.MvcSheetUI.GetControlValue("Title");
//    var IntendToMakeComments = $.MvcSheetUI.GetControlValue("IntendToMakeComments");
//    var AttachmentUpload = $.MvcSheetUI.GetControlValue("AttachmentUpload");
//    var ApplicationNumber = $.MvcSheetUI.GetControlValue("ApplicationNumber");
//    if (BusinessType == '') {
//        layer.alert('业务类型不能为空！', { icon: 2 });
//        return false;
//    }
//    if (Title == '') {
//        alert("标题不能为空！");
//        return false;
//    }
//    if (IntendToMakeComments == '') {
//        alert("拟办意见不能为空！");
//        return false;
//    }
//    if (AttachmentUpload == '') {
//        alert("附件上传不能为空！");
//        return false;
//    }
//    if (ApplicationNumber == '') {
//        alert("申请编号不能为空！");
//        return false;
//    }

//}
var SurplusDaysBeforeApplying = 0;
var SumApplyDays = 0;
var minDateString = "";
var maxDateString = "";
function generateEmployeeLeaveNo() {
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeLeaveHandler.ashx?Command=generateEmployeeLeaveNo",   //处理页的相对地址
        data: {
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            $.MvcSheetUI.SetControlValue("ApplicationNumber", ret);

        }
    });
}

function ChangeHolidayType() {
    var ParticularYear = $.MvcSheetUI.GetControlValue("ParticularYear");
    var HolidayType = $("[data-datafield='HolidayType']").find("option:selected").text();
    var Applicant = $.MvcSheetUI.GetControlValue("Applicant");
    if (ParticularYear == '') {
        layer.alert('年份不能为空！', { icon: 2 });
        return false;
    }
    if (HolidayType == '') {
        return false;
    }
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "EmployeeLeaveHandler.ashx?Command=getSurplusDaysBeforeApplying",   //处理页的相对地址
        data: {
            ParticularYear: ParticularYear,
            HolidayType: HolidayType,
            Applicant: Applicant,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            SurplusDaysBeforeApplying = ret;
            $.MvcSheetUI.SetControlValue("SurplusDaysBeforeApplying", ParticularYear + "年" + "【" + HolidayType + "】" + "剩余" + ret + "天");
            $.MvcSheetUI.SetControlValue("SurplusDaysAfterApplying", "本次申请" + SumApplyDays + "天后剩余" + (SurplusDaysBeforeApplying - SumApplyDays) + "天");
            if (ret != "") {
            }
        }
    });
}
function FocusHolidayType() {
    var HolidayType = $("[data-datafield='HolidayType']").find("option:selected").text();
    if (HolidayType == '') {
        layer.alert('假期类型不能为空！', { icon: 2 });
        
        return false;
    }
}
    
function ChangeLeaveDate(e1) {
    var rowIndex = e1.parentElement.parentElement.rowIndex;
    var LeaveDateString = $.MvcSheetUI.GetControlValue("LeaveDetails.LeaveDate",rowIndex -1);
    if (LeaveDateString == '') {
        $.MvcSheetUI.SetControlValue("LeaveDetails.NumberOfDays", 0, rowIndex - 1);
        $.MvcSheetUI.SetControlValue("LeaveDetails.Years", '', rowIndex - 1);
        return false;
    }
    if (minDateString == '') {
        minDateString = LeaveDateString;

    }
    if (maxDateString == '') {
        maxDateString = LeaveDateString;
    } 
    var minDate = stringToDate(minDateString, "-");
    var maxDate = stringToDate(maxDateString, "-");
    var LeaveDate = stringToDate(LeaveDateString,"-");
    var minDays = parseInt(minDate.getTime() / (1000 * 60 * 60 * 24));
    var maxDays = parseInt(maxDate.getTime() / (1000 * 60 * 60 * 24));
    var LeaveDays = parseInt(LeaveDate.getTime() / (1000 * 60 * 60 * 24));
    if (minDays > LeaveDays) {
        minDateString = LeaveDateString;
    }
    if (maxDays < LeaveDays) {
        maxDateString = LeaveDateString;
    }

    
    $.MvcSheetUI.SetControlValue("AskForLeave", minDateString);
    $.MvcSheetUI.SetControlValue("EndTime", maxDateString);
   
    //for (var i = 0; i < $("#SelectType").options.length; i++) {
    //    if (yearobj.options[i].innerHTML == '全天') {
    //        yearobj.options[i].selected = true;
    //        break;
    //    }
    //}
    //alert($("[data-datafield='LeaveDetails.Type']").find("option[text='全天']").text());
    //$("[data-datafield='LeaveDetails.Type']").find("option[text='全天']").attr("selected", true);
    //$("#SelectType").find("option[text='全天']").attr("selected", true); 
   
    //select.option[0].selected = true;
    $.MvcSheetUI.SetControlValue("LeaveDetails.NumberOfDays", 1, rowIndex - 1);
    $.MvcSheetUI.SetControlValue("LeaveDetails.Years", LeaveDateString.substring(0, 4), rowIndex - 1);
    
}
function ChangeType(t1) {
    var rowIndex = t1.parentElement.parentElement.rowIndex;
    // $.MvcSheetUI.SetControlValue('QKSubTbl.Rate', 1, rowIndex - 1);
    var type = $.MvcSheetUI.GetControlValue("LeaveDetails.Type", rowIndex - 1);
    if (type == '全天') {
        $.MvcSheetUI.SetControlValue("LeaveDetails.NumberOfDays", 1, rowIndex - 1);
    } else {
        $.MvcSheetUI.SetControlValue("LeaveDetails.NumberOfDays", 0.5, rowIndex - 1);
    }
}
function ChangeSumApplyDays() {
   
    SumApplyDays = $.MvcSheetUI.GetControlValue("SumApplyDays");
    if (SurplusDaysBeforeApplying - SumApplyDays < 0) {
        var HolidayType = $("[data-datafield='HolidayType']").find("option:selected").text();
        layer.alert('您的' + HolidayType+'剩余' + (SurplusDaysBeforeApplying - SumApplyDays)+'天，请删除一些请假明细, 或选择其它请假类型。', { icon: 2 });
    }
    $.MvcSheetUI.SetControlValue("SurplusDaysAfterApplying", "本次申请" + SumApplyDays + "天后剩余" + (SurplusDaysBeforeApplying - SumApplyDays) + "天");

}
$.MvcSheet.Validate = function () {
    
    
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApproval") {
        if (this.Action == "Submit") {
            if (SurplusDaysBeforeApplying - SumApplyDays < 0) {
                var HolidayType = $("[data-datafield='HolidayType']").find("option:selected").text();
                layer.alert('您的' + HolidayType + '剩余' + (SurplusDaysBeforeApplying - SumApplyDays) + '天，请删除一些请假明细, 或选择其它请假类型。', { icon: 2 });
                return false;
            }
        }
    }
    return true;
}
$.MvcSheet.Loaded = function () {
    
    var date = new Date;
    var year = date.getFullYear();
    $.MvcSheetUI.SetControlValue("ParticularYear", year);
    $.MvcSheetUI.SetControlValue("AskForLeave", dateToString(date));
    var AskForLeave = $.MvcSheetUI.GetControlValue("AskForLeave");
    
    generateEmployeeLeaveNo();
    //$("#generateEmployeeLeaveNoId").hide();
   
    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApproval") {
       // $("#generateEmployeeLeaveNoId").show();
       
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityManager") {
       
    } else if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityGenManager") {

    } 
    
    $("input[data-datafield='SurplusDaysBeforeApplying']").attr("disabled", "disabled");
    $("input[data-datafield='ApplicationDate']").attr("disabled", "disabled");
    $("input[data-datafield='AskForLeave']").attr("disabled", "disabled");
    $("input[data-datafield='EndTime']").attr("disabled", "disabled");
    $("input[data-datafield='SurplusDaysAfterApplying']").attr("disabled", "disabled");
    $("input[data-datafield='Applicant']").attr("disabled", "disabled");
    $("input[data-datafield='ApplicationNumber']").attr("disabled", "disabled");

}
function dateToString(now) {
    var year = now.getFullYear();
    var month = (now.getMonth() + 1).toString();
    var day = (now.getDate()).toString();
    //var hour = (now.getHours()).toString();
    //var minute = (now.getMinutes()).toString();
    //var second = (now.getSeconds()).toString();
    if (month.length == 1) {
        month = "0" + month;
    }
    if (day.length == 1) {
        day = "0" + day;
    }
    //if (hour.length == 1) {
    //    hour = "0" + hour;
    //}
    //if (minute.length == 1) {
    //    minute = "0" + minute;
    //}
    //if (second.length == 1) {
    //    second = "0" + second;
    //}
    //var dateTime = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
    var dateTime = year + "-" + month + "-" + day ;
    return dateTime;
}
var stringToDate = function (dateStr, separator) {
    if (!separator) {
        separator = "-";
    }
    var dateArr = dateStr.split(separator);
    var year = parseInt(dateArr[0]);
    var month;
    //处理月份为04这样的情况                          
    if (dateArr[1].indexOf("0") == 0) {
        month = parseInt(dateArr[1].substring(1));
    } else {
        month = parseInt(dateArr[1]);
    }
    var day = parseInt(dateArr[2]);
    var date = new Date(year, month - 1, day);
    return date;
} 
