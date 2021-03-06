﻿
var tableData = new Array();
$('#My_agreement').bootstrapTable({
    //height: ,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        //width: '5%',
        title: '序号'
    },{
        align: 'center',
        valign: 'middle',
        field: 'Agreement_name',
        //width: '15%',
        title: '协议名称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'AgreeMent_number',
        //width: '15%',
        title: '协议编号',
        formatter: link_number
    }, {
        //align: 'center',
        valign: 'middle',
        field: 'Desc',
        
        //width: '15%',
        field: 'ObjectID',
        title: '流程ID',
        visible: false

    },{
        align: 'center',
        valign: 'middle',
        field: 'Agreement_client',
        //width: '15%',
        title: '委托方'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Rate_type',
        //width: '15%',
        title: '收费类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'agency_rate',
        //width: '15%',
        title: '费率/金额'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'sign_time',
        //width: '15%',
        title: '签约时间'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'BGSignDate',
        //width: '15%',
        title: '变更签约时间'
    },{
        align: 'center',
        valign: 'middle',
        field: 'Project_head',
        //width: '15%',
        title: '项目负责人'
    },{
        align: 'center',
        valign: 'middle',
        field: 'con_state',
        //width: '15%',
        title: '状态'
    },{
        //align: 'center',
        //valign: 'middle',
        field: 'Desc',
        //width: '15%',
        title: '操作',
        formatter: operateFormatter
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});
function operateFormatter(value, row, index) {
  
    return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name + '\')">查看</button>&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name + '\')">编辑</button>'
    ].join('');

}
//协议编号超链接
function link_number(value, row, index) {
 
    return '<a href="javascript:;" onclick="edit_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name + '\')">' + value + '</a>';
}
function herf_agreement(v,name) {
    console.log(v);
    if ("航空煤油"==name) {
        window.location.href = "/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=View&WorkItemID=" + v;
    } else {

         window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=View&WorkItemID=" + v;
    }
}
function edit_agreement(v, name) {
    if ("航空煤油"==name) {
        window.location.href = "/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=Work&WorkItemID=" + v;
    } else {

        window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=Work&WorkItemID=" + v;
    }
    //window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=Work&WorkItemID=" + v;
}
$.MvcSheet.Loaded = function () {
    var agreement_type = $.MvcSheetUI.GetControlValue("my_agreement");
    var my_role = $.MvcSheetUI.GetControlValue("my_role");
    var user = $.MvcSheetUI.SheetInfo.UserID;
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "My_agreement.ashx?Command=getagreementList",   //处理页的相对地址
        data: {
            agreement_type: agreement_type,
            user: user,
            my_role: my_role,
            //FK_Target: FK_Target == "全部" ? "" : FK_Target,
            //FK_Status: FK_Status,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Agreement_name = ret[i].AgreeMent_name;
                obj.AgreeMent_number = ret[i].AgreeMent_number;
                obj.Agreement_client = ret[i].Agreement_client;
                obj.Rate_type = ret[i].Rate_type;
                obj.agency_rate = ret[i].agency_rate;
                obj.sign_time = ret[i].siDate;
                obj.Project_head = ret[i].Project_head;
                obj.con_state = ret[i].con_state;
                obj.BGSignDate = ret[i].BGSignDate;
                obj.ObjectID = ret[i].ObjectID;

                // 往bootstrapTable添加数据
                $("#My_agreement").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}
//查询
function sel_agreement() {
   
    var agreement_type = $.MvcSheetUI.GetControlValue("my_agreement");
    //$("[data-datafield='my_role']").find("option:selected").text();
    var my_role = $.MvcSheetUI.GetControlValue("my_role");
    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
   // var Contra_type = $.MvcSheetUI.GetControlValue("Contra_type");
    var Contra_type = $("[data-datafield='Contra_type']").find("option:selected").text();
    var user = $.MvcSheetUI.SheetInfo.UserID;
    var BGSignDate = $.MvcSheetUI.GetControlValue("BGSignDate");//变更签约日期
    var BGSignDate2 = $.MvcSheetUI.GetControlValue("BGSignDate2");//变更签约日期
    //console.log(agreement_type);
    //console.log(my_role);
    //console.log(AgreeMent_number);
    //console.log(user);
    //return false;
    $("#My_agreement").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "My_agreement.ashx?Command=getagreementList",   //处理页的相对地址
        data: {
            agreement_type: agreement_type,
            my_role: my_role,
            AgreeMent_number: AgreeMent_number,
            //Contra_type: Contra_type,
            Contra_type: Contra_type == "全部" ? "" : Contra_type,
            user: user,
            BGSignDate: BGSignDate,
            BGSignDate2: BGSignDate2,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Agreement_name = ret[i].AgreeMent_name;
                obj.AgreeMent_number = ret[i].AgreeMent_number;
                obj.Agreement_client = ret[i].Agreement_client;
                obj.Rate_type = ret[i].Rate_type;
                obj.agency_rate = ret[i].agency_rate;
                obj.sign_time = ret[i].siDate;
                obj.Project_head = ret[i].Project_head;
                obj.con_state = ret[i].con_state;
                obj.BGSignDate = ret[i].BGSignDate;
                obj.ObjectID = ret[i].ObjectID;

                // 往bootstrapTable添加数据
                $("#My_agreement").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}