//获取url中的参数
$.MvcSheet.AddAction({
    Icon: "fa-sign-in",           // 按钮图标
    Text: "关闭",           // 按钮名称
    Datas: [],    // 参数，多个参数 "{Param1}","Param2"...
    OnAction: function () {
        window.history.back();
    },
    //OnActionDone: function (ret) {


    //},
    PostSheetInfo: true         // 是否提交表单数据，如果 false，那么不返回表单的数据
});
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
// 获取中文参数 需要传入参数进行encodeURI(param)
function getUrlParamZW(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return decodeURI(r[2]); return null; //返回参数值
}

// 获取一个月前的日期
function lastMonthDate(datestr) {
    var Nowdate = new Date(datestr);
    var vYear = Nowdate.getFullYear();
    var vMon = Nowdate.getMonth() + 1;
    var vDay = Nowdate.getDate();
    //每个月的最后一天日期（为了使用月份便于查找，数组第一位设为0）
    var daysInMonth = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    if (vMon == 1) {
        vYear = Nowdate.getFullYear() - 1;
        vMon = 12;
    } else {
        vMon = vMon - 1;
    }
    //若是闰年，二月最后一天是29号
    if (vYear % 4 == 0 && vYear % 100 != 0 || vYear % 400 == 0) {
        daysInMonth[2] = 29;
    }
    if (daysInMonth[vMon] < vDay) {
        vDay = daysInMonth[vMon];
    }
    if (vDay < 10) {
        vDay = "0" + vDay;
    }
    if (vMon < 10) {
        vMon = "0" + vMon;
    }
    var date = vYear + "-" + vMon + "-" + vDay;
    console.log(date)
    return date;
}

function last3MonthDate(datestr,AddDayCount) {
    var dd = new Date(datestr);
    dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期  
    var y = dd.getFullYear();
    var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd.getMonth() + 1);//获取当前月份的日期，不足10补0  
    var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();//获取当前几号，不足10补0  
    return y + "-" + m + "-" + d;
} 

function getContract(ContractNo) {
    var Contract;
    if (ContractNo != null && ContractNo != "") {
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ContractNo: ContractNo,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                Contract = ret;
            }
        });
    }
    return Contract;
}

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    return currentdate;
}

function setFileWriteable(id) {
    // 默认即可
}
function setFileReadOnly(id) {
    // 隐藏删除按钮
    $("#" + id).find(".files").each(function () {
        $(this).find(".delete-file").hide();
    });
    // 隐藏上传按钮
    $("#" + id).find("form").hide();
    // 隐藏Label
    $("#" + id).parent().find("label").hide();
}
function setFileHide(id) {
    // 隐藏id
    $("#" + id).hide();
}

//光标离开输入的金额四舍五入并保留2位小数
$("input.AmountFormat").blur(function () {//输入obj=123456.7890
    var obj = this.value.replace(/,/g, '');
    if (obj == "") return;
    if (isNaN(obj)) { layer.alert('输入数值有误！', { icon: 2 }); return; }
    var n = 2; //保留得小数位
    obj = parseFloat(obj).toFixed(n); //obj=123456.789
    var left = obj.split(".")[0].split("").reverse();//left = ["6","5","4","3","2","1"]
    var right = obj.split(".")[1]; //right = "789"
    var total = new Array();
    for (i = 0; i < left.length; i++) {
        total.push(left[i]);
        if ((i + 1) % 3 == 0 && (i + 1) != left.length) {
            total.push(",");
        }
    } //total = ["6","5","4",",","3","2","1"]
    var v = total.reverse().join("") + "." + right;
    this.value = v=="0.00"?"":v;
})
$("input.AmountFormat").focus(function () {
    var oldMny = this.value.replace(/,/g, '');
    if (oldMny.indexOf(".") > 0) {
        oldMny = oldMny.replace(/0+?$/, "");//去除尾部多余的0
        oldMny = oldMny.replace(/[.]$/, "");//如果最后一位是.则去掉
    }
    this.value = oldMny;
})

//光标离开输入的金额四舍五入并保留3位小数
$("input.AmountFormat3").blur(function () {//输入obj=123456.7890
    var obj = this.value.replace(/,/g, '');
    if (obj == "") return;
    if (isNaN(obj)) { layer.alert('输入数值有误！', { icon: 2 }); return; }
    var n = 3; //保留得小数位
    obj = parseFloat(obj).toFixed(n); //obj=123456.789
    var left = obj.split(".")[0].split("").reverse();//left = ["6","5","4","3","2","1"]
    var right = obj.split(".")[1]; //right = "789"
    var total = new Array();
    for (i = 0; i < left.length; i++) {
        total.push(left[i]);
        if ((i + 1) % 3 == 0 && (i + 1) != left.length) {
            total.push(",");
        }
    } //total = ["6","5","4",",","3","2","1"]
    var v = total.reverse().join("") + "." + right;
    this.value = v == "0.000" ? "" : v;
})
$("input.AmountFormat3").focus(function () {
    var oldMny = this.value.replace(/,/g, '');
    if (oldMny.indexOf(".") > 0) {
        oldMny = oldMny.replace(/0+?$/, "");//去除尾部多余的0
        oldMny = oldMny.replace(/[.]$/, "");//如果最后一位是.则去掉
    }
    this.value = oldMny;
})

//光标离开输入的金额四舍五入并保留5位小数
$("input.AmountFormat5").blur(function () {//输入obj=123456.7890
    var obj = this.value.replace(/,/g, '');
    if (obj == "") return;
    if (isNaN(obj)) { layer.alert('输入数值有误！', { icon: 2 }); return; }
    var n = 5; //保留得小数位
    obj = parseFloat(obj).toFixed(n); //obj=123456.789
    var left = obj.split(".")[0].split("").reverse();//left = ["6","5","4","3","2","1"]
    var right = obj.split(".")[1]; //right = "789"
    var total = new Array();
    for (i = 0; i < left.length; i++) {
        total.push(left[i]);
        if ((i + 1) % 3 == 0 && (i + 1) != left.length) {
            total.push(",");
        }
    } //total = ["6","5","4",",","3","2","1"]
    var v = total.reverse().join("") + "." + right;
    this.value = v == "0.00000" ? "" : v;
})
$("input.AmountFormat5").focus(function () {
    var oldMny = this.value.replace(/,/g, '');
    if (oldMny.indexOf(".") > 0) {
        oldMny = oldMny.replace(/0+?$/, "");//去除尾部多余的0
        oldMny = oldMny.replace(/[.]$/, "");//如果最后一位是.则去掉
    }
    this.value = oldMny;
})

function GotoBackPage(Module, CurInstanceActivity) {
    var WorkflowVersion_Back = $.MvcSheetUI.GetControlValue("WorkflowVersion_Back");
    var InstanceActivity = $("#ActivityCodes").val();
    var InstanceId = $.MvcSheetUI.SheetInfo.InstanceId;
    var InstanceName = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getInstanceById",   //处理页的相对地址
        data: {
            InstanceId: InstanceId,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret.InstanceName != undefined) {
                InstanceName = ret.InstanceName;
            }
        }
    });
    if (InstanceName == "") {
        layer.alert('流程还未发起，请先发起！', { icon: 2 });
        return false;
    }
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    if (InstanceActivity != "") {
        window.location.href = "/Portal/Sheets/Contract/GetBackMy.aspx?Mode=Originate&WorkflowCode=GetBackContract&WorkflowVersion=" + WorkflowVersion_Back + "&InstanceId=" + InstanceId + "&InstanceActivity=" + InstanceActivity + "&CurInstanceActivity=" + CurInstanceActivity + "&ContractNo=" + ContractNo + "&Module=" + Module;
    } else {
        layer.alert('请选择取回的节点！', { icon: 2 });
        return false;
    }
}

function viewContractF() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkItemId = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getWorkItemIDByContractNo",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            CurrentUser: $.MvcSheetUI.SheetInfo.UserID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret != undefined) {
                WorkItemId = ret;
            }
        }
    });
    window.open("/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=View&WorkItemID=" + WorkItemId);
}
function viewAgreementF() {
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    var Self_agreeMent_number = $.MvcSheetUI.GetControlValue("Self_agreeMent_number");
    if (AgreeMent_number == '' || AgreeMent_number == null) {
        AgreeMent_number = Self_agreeMent_number;
    }
    var WorkItemId = "";
    var isHY = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Agreement/AgreeMent_main/AgreeMent_main.ashx?Command=getWorkItemIDByAgreeMent_number",   //处理页的相对地址
        data: {
            AgreeMent_number: AgreeMent_number,
            CurrentUser: $.MvcSheetUI.SheetInfo.UserID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            WorkItemId = ret.workItemId;
            isHY = ret.isHY;

        }
    });

    if (isHY == 'true') {
        window.open("/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=View&WorkItemID=" + WorkItemId);
    } else if (isHY == 'false') {
        window.open("/Portal/Sheets/Agreement/AgreeMent_main/AgreeMent_main.aspx?Mode=View&WorkItemID=" + WorkItemId);
    }
}
function viewContractF() {
    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var WorkItemId = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getWorkItemIDByContractNo",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
            CurrentUser: $.MvcSheetUI.SheetInfo.UserID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret != undefined) {
                WorkItemId = ret;
            }
        }
    });
    window.open("/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=View&WorkItemID=" + WorkItemId);
}
function viewAgreementF() {
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    var Self_agreeMent_number = $.MvcSheetUI.GetControlValue("Self_agreeMent_number");
    if (AgreeMent_number == '' || AgreeMent_number == null) {
        AgreeMent_number = Self_agreeMent_number;
    }
    var WorkItemId = "";
    var isHY = "";
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/Sheets/Agreement/AgreeMent_main/AgreeMent_main.ashx?Command=getWorkItemIDByAgreeMent_number",   //处理页的相对地址
        data: {
            AgreeMent_number: AgreeMent_number,
            CurrentUser: $.MvcSheetUI.SheetInfo.UserID,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            WorkItemId = ret.workItemId;
            isHY = ret.isHY;
           
        }
    }); 

    if (isHY == 'true') {
        window.open("/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=View&WorkItemID=" + WorkItemId);
    } else if (isHY == 'false'){
        window.open("/Portal/Sheets/Agreement/AgreeMent_main/AgreeMent_main.aspx?Mode=View&WorkItemID=" + WorkItemId);
    }
}

//$("#FullTextSearch").keydown(function (event) {
//    if (event.which == "13") {
//        $val = $("#FullTextSearch").val();
//        $url = window.location.href;
//        window.location.href = '/Portal/Sheets/Common/MyFullTextSearch.aspx?FullText=' + $val;
//    }
//})
