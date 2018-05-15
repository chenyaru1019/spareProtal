﻿//全部
var tableData = new Array();
$('#project_sel').bootstrapTable({
    //height: ,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        //width: '15%',
        title: '序号'
    },{
        align: 'center',
        valign: 'middle',
        field: 'Project_name',
        //width: '15%',
        title: '项目简称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zb_number',
        //width: '15%',
        title: '招标编号',
        formatter: link_number
    }, {
        valign: 'middle',
        field: 'ObjectID',
        title: '流程ID',
        visible: false

    }, {
        align: 'center',
        valign: 'middle',
        field: 'bale_No',
        //width: '15%',
        title: '包号'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Cretetime',
        //width: '15%',
        title: '创建日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zb_scope',
        //width: '15%',
        title: '招标范围'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zb_way',
        //width: '15%',
        title: '招标方式'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zb_people',
        //width: '15%',
        title: '招标人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Project_head',
        //width: '15%',
        title: '项目负责人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zb_book',
        //width: '15%',
        title: '中标通知书'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'statues',
        //width: '15%',
        title: '状态'
    }, {
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
    return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\')">查看</button>&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\')">编辑</button>'
    ].join('');

}
//项目编号超链接
function link_number(value, row, index) {
    return '<a href="javascript:;" onclick="herf_agreement(\'' + row.ObjectID + '\')">' + value + '</a>';
}
function herf_agreement(v) {
    console.log(v);
    window.location.href = "/Portal/Sheets/bidding/InviteBids.aspx?Mode=View&WorkItemID=" + v;
}
function edit_agreement(v) {
    window.location.href = "/Portal/Sheets/bidding/InviteBids.aspx?Mode=Work&WorkItemID=" + v;
}
$.MvcSheet.Loaded = function () {
    //var user = $.MvcSheetUI.SheetInfo.UserID;
    //var Project_sel = $.MvcSheetUI.GetControlValue("Project_sel");//项目选择
    //var Project_state = $.MvcSheetUI.GetControlValue("Project_state");//项目状态
    //var Project_role = $.MvcSheetUI.GetControlValue("Project_role");//角色
    //var bids_code = $.MvcSheetUI.GetControlValue("bids_code");//招标编码
    //var zb_advice2 = $.MvcSheetUI.GetControlValue("zb_advice2");//中标通知书2
    //var zb_advice = $.MvcSheetUI.GetControlValue("zb_advice");//中标通知书1
    $("#project_sel").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "../My_project/My_project.ashx?Command=getproject",   //处理页的相对地址
        data: {
            //Project_sel: Project_sel,
            //Project_state: Project_state,
            //Project_role: Project_role,
            //bids_code: bids_code,
            //zb_advice2: zb_advice2,
            //zb_advice: zb_advice,
            //user: user,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            console.log(ret);
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Project_name = ret[i].ProjectShortName;
                obj.zb_number = ret[i].BiddingCode;
                obj.bale_No = ret[i].PackageName;
                obj.Cretetime = ret[i].CreatedTime;
                obj.zb_scope = ret[i].BiddingScope;
                obj.zb_way = ret[i].OrgName;
                obj.zb_people = ret[i].Project_head;
                obj.Project_head = ret[i].Project_head;
                obj.zb_book = ret[i].WinnerNoticeDate;
                obj.statues = ret[i].con_state;
                obj.ObjectID = ret[i].ObjectID;
                // 往bootstrapTable添加数据
                $("#project_sel").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}
//查询
function sel_project() {
    var zb_number = $.MvcSheetUI.GetControlValue("zb_number");//招标编码
    var Project_head = $.MvcSheetUI.GetControlValue("Project_head");//项目负责人
    var fb_time = $.MvcSheetUI.GetControlValue("fb_time");//发标开始时间
    var fb_time2 = $.MvcSheetUI.GetControlValue("fb_time2");//发标结束时间
    var Project_name = $.MvcSheetUI.GetControlValue("Project_name");//项目名称
    var pb_specialist = $.MvcSheetUI.GetControlValue("pb_specialist");//评标专家
    var kb_time = $.MvcSheetUI.GetControlValue("kb_time");//开标开始时间
    var kb_time2 = $.MvcSheetUI.GetControlValue("kb_time2");//开标结束时间
    var bao_number = $.MvcSheetUI.GetControlValue("bao_number");//包号
    var Project_state = $.MvcSheetUI.GetControlValue("Project_state");//项目状态
    var jx_time = $.MvcSheetUI.GetControlValue("jx_time");//结项开始时间
    var jx_time2 = $.MvcSheetUI.GetControlValue("jx_time2");//结项结束时间
    var tb_units = $.MvcSheetUI.GetControlValue("tb_units");//投标单位
    var zb_way = $.MvcSheetUI.GetControlValue("zb_way");//招标方式
    var zb_money = $.MvcSheetUI.GetControlValue("zb_money");//中标开始价格
    var zb_money2 = $.MvcSheetUI.GetControlValue("zb_money2");//中标结束价格
    var zb_units = $.MvcSheetUI.GetControlValue("zb_units");//中标单位
    var zb_scope = $.MvcSheetUI.GetControlValue("zb_scope");//招标范围
    var agency_fee = $.MvcSheetUI.GetControlValue("agency_fee");//代理费开始
    var agency_fee2 = $.MvcSheetUI.GetControlValue("agency_fee2");//代理费结束
    var zb_people = $.MvcSheetUI.GetControlValue("zb_people");//招标人
    var objection = $.MvcSheetUI.GetControlValue("objection");//是否有意义
    var zb_time = $.MvcSheetUI.GetControlValue("zb_time");//中标通知书开始
    var zb_time2 = $.MvcSheetUI.GetControlValue("zb_time2");//中标通知书结束
    var user = $.MvcSheetUI.SheetInfo.UserID;
    $("#project_sel").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "../My_project/My_project.ashx?Command=getcontractList",   //处理页的相对地址
        data: {
            bids_code: zb_number,
            Project_head: Project_head,
            Project_role: Project_role,
            fb_time: fb_time,
            fb_time2: fb_time2,
            Project_name: Project_name,
            pb_specialist: pb_specialist,
            kb_time: kb_time,
            kb_time2: kb_time2,
            bao_number: bao_number,
            Project_state: Project_state,
            jx_time: jx_time,
            jx_time2: jx_time2,
            tb_units: tb_units,
            zb_way: zb_way,
            zb_money: zb_money,
            zb_money2: zb_money,
            zb_units: zb_units,
            zb_scope: zb_scope,
            agency_fee: agency_fee,
            agency_fee2: agency_fee2,
            zb_people: zb_people,
            objection: objection,
            zb_advice2: zb_time,
            zb_advice:zb_time2,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            console.log(ret);
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Project_name = ret[i].ProjectShortName;
                obj.zb_number = ret[i].BiddingCode;
                obj.bale_No = ret[i].PackageName;
                obj.Cretetime = ret[i].CreatedTime;
                obj.zb_scope = ret[i].BiddingScope;
                obj.zb_way = ret[i].OrgName;
                obj.zb_people = ret[i].Project_head;
                obj.Project_head = ret[i].Project_head;
                obj.zb_book = ret[i].WinnerNoticeDate;
                obj.statues = ret[i].con_state;
                obj.ObjectID = ret[i].ObjectID;
                // 往bootstrapTable添加数据
                $("#My_project").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}