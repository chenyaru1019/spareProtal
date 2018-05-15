//全部
var tableData = new Array();
window.operateEvents = {
    "click #TableView": function (e, value, row, index) {
        var WorkItemId = row.ObjectID;
        window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + WorkItemId + "&Permission=View";
    },
    "click #TableUpdate": function (e, value, row, index) {
        var WorkItemId = row.ObjectID;
        window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + WorkItemId + "&Permission=Work";
    },
}
/*
$('#Contract_query').bootstrapTable({
    //height: ,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        //width: '15%',
        title: '序号',

    },{
        align: 'center',
        valign: 'middle',
        field: 'Contract_number',
        //width: '15%',
        title: '合同号',
        formatter: link_number
        
    }, {
        valign: 'middle',
        field: 'ObjectID',
        title: '流程ID',
        visible: false

    },{
        align: 'center',
        valign: 'middle',
        field: 'Ccontract_name',
        //width: '15%',
        title: '合同名称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_cretime',
        width: '8%',
        title: '创建日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_type',
        //width: '15%',
        title: '合同类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_nature',
        //width: '15%',
        title: '合同性质'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_fz',
        //width: '15%',
        title: '项目负责人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'end_user',
        //width: '15%',
        title: '最终用户'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_seller',
        //width: '15%',
        title: '合同卖方'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Contract_money',
        //width: '15%',
        title: '合同金额'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'qy_time',
        width: '7%',
        title: '签约日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'bg_time',
        width: '7%',
        title: '变更日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'states',
        //width: '15%',
        title: '当前状态'
    }, {
        align: 'center',
        field: 'PostA',
        visible: false
    }, {
        align: 'center',
        field: 'PostB',
        visible: false
    }, {
        align: 'center',
        //valign: 'middle',
        field: 'Desc',
        width: '7%',
        title: '操作',
        events: operateEvents,
        formatter: operateFormatter
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});
*/

var contract_number = "";//合同号
var contract_name = "";//合同名称
var qy_time = "";//签约日期
var qy_time2 = "";//签约日期2
var Project_head = "";//项目负责人
var my_way = "";//贸易方式
var contract_creatime = "";//合同创建时间
var contract_creatime2 = "";//合同创建时间2
var end_user = "";//最终用户
var contract_xz = "";//合同性质
var contract_bgtime = "";//合同变更时间
var contract_bgtime2 = "";//合同变更时间2
var contract_mf = "";//合同卖方
var contract_type = "";//合同类型
var user = "";//$.MvcSheetUI.SheetInfo.UserID;


$('#Contract_query').bootstrapTable({
    //height: 580,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //search : true,
    cache: false,
    striped: true,
    method: 'get',
    url: "../Mycontract/Mycontract.ashx?Command=getcontractList",
    sidePagination: "server",
    queryParams: function (params) {
        var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
        return {
            pageNumber: params.offset + 1,
            pageSize: params.limit,
            user: CurrentUser.ObjectID,
            contract_number: contract_number,
            contract_name: contract_name,
            qy_time: qy_time,
            qy_time2: qy_time2,
            my_way: my_way,
            contract_creatime: contract_creatime,
            contract_creatime2: contract_creatime2,
            end_user: end_user,
            contract_xz: contract_xz,
            contract_bgtime: contract_bgtime,
            contract_bgtime2: contract_bgtime2,
            contract_mf: contract_mf,
            contract_type: contract_type,
        };
    },
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        //width: '15%',
        title: '序号',

    }, {
        align: 'center',
        valign: 'middle',
        field: 'ContractNO',
        //width: '15%',
        title: '合同号',
        formatter: link_number

    }, {
        valign: 'middle',
        field: 'ObjectID',
        title: '流程ID',
        visible: false

    }, {
        align: 'center',
        valign: 'middle',
        field: 'ContractName',
        //width: '15%',
        title: '合同名称'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'CreatedTime',
        width: '8%',
        title: '创建日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ContractType',
        //width: '15%',
        title: '合同类型'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ContractProperty',
        //width: '15%',
        title: '合同性质'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Projecthead',
        //width: '15%',
        title: '项目负责人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'FinalUser',
        //width: '15%',
        title: '最终用户'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Salers',
        //width: '15%',
        title: '合同卖方'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ContractTotalPrice',
        //width: '15%',
        title: '合同金额'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'SignDate',
        width: '7%',
        title: '签约日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ModifiedTime',
        width: '7%',
        title: '变更日期'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'FKPercent',
        width: '9%',
        title: '支付比例'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'contract_state',
        //width: '15%',
        title: '当前状态'
    }, {
        align: 'center',
        field: 'PostA',
        visible: false
    }, {
        align: 'center',
        field: 'PostB',
        visible: false
    }, {
        align: 'center',
        //valign: 'middle',
        field: 'Desc',
        width: '7%',
        title: '操作',
        events: operateEvents,
        formatter: operateFormatter
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    pageList: [10, 25, 50, 100],
    data: tableData
});

function operateFormatter(value, row, index) {
    //return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\')">查看</button>&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\')">编辑</button>'
    //].join('');
    var str = "";
    //var user = $.MvcSheetUI.SheetInfo.UserID;
    var CurrentUser = eval("(" + window.localStorage.getItem('getCurrentUser') + ")");
    if (row.PostA == CurrentUser.ObjectID || row.PostB == CurrentUser.ObjectID) {
        str = "<a id='TableView' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>&nbsp;"
            + "<a id='TableUpdate' class='btn btn-primary btn-xs' data-toggle='modal'>编辑</a>";
    } else {
        str = "<a id='TableView' class='btn btn-primary btn-xs' data-toggle='modal'>查看</a>";
    }
    return [str].join("")
}
//合同编号超链接
function link_number(value, row, index) {
    return '<a href="javascript:;" onclick="herf_agreement(\'' + row.ObjectID + '\')">' + value + '</a>';
}
function herf_agreement(v) {
    console.log(v);
    window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=View&WorkItemID=" + v;
}
function edit_agreement(v) {
    window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + v;
}
$.MvcSheet.Loaded = function () {
    //var user = $.MvcSheetUI.SheetInfo.UserID;
    //$("#Contract_query").bootstrapTable('removeAll');
    //$.ajax({
    //    type: "POST",    //页面请求的类型
    //    url: "../Mycontract/Mycontract.ashx?Command=getcontractList",   //处理页的相对地址
    //    data: {
    //        //user:user,
    //    },
    //    async: false,
    //    success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
    //        console.log(ret);
    //        for (var i = 0; i < ret.length; i++) {
    //            var obj = {};
    //            obj.TheNo = ret[i].TheNo;
    //            obj.Contract_number = ret[i].ContractNO;
    //            obj.Ccontract_name = ret[i].ContractName;
    //            obj.Contract_cretime = ret[i].CreatedTime;
    //            obj.Contract_type = ret[i].ContractType;
    //            obj.Contract_nature = ret[i].ContractProperty;
    //            obj.Contract_fz = ret[i].Projecthead;
    //            obj.end_user = ret[i].FinalUser;
    //            obj.Contract_seller = ret[i].Salers;

    //            obj.Contract_money = ret[i].ContractTotalPrice;
    //            obj.qy_time = ret[i].SignDate;
    //            obj.bg_time = ret[i].ModifiedTime;
    //            obj.states = ret[i].contract_state;
    //            obj.PostA = ret[i].PostA;
    //            obj.PostB = ret[i].PostB;
    //            obj.ObjectID = ret[i].ObjectID;
    //            // 往bootstrapTable添加数据
    //            $("#Contract_query").bootstrapTable('insertRow', { index: i, row: obj });
    //        }
    //    }
    //});
    // 隐藏导航栏
    $("#main-navbar").hide();
    $(".divContent div[data-title='征询意见']").parent().hide();
}

function Search() {
    contract_number = $.MvcSheetUI.GetControlValue("contract_number");//合同号
    contract_name = $.MvcSheetUI.GetControlValue("contract_name");//合同名称
    qy_time = $.MvcSheetUI.GetControlValue("qy_time");//签约日期
    qy_time2 = $.MvcSheetUI.GetControlValue("qy_time2");//签约日期2
    Project_head = $.MvcSheetUI.GetControlValue("Project_head");//项目负责人
    my_way = $.MvcSheetUI.GetControlValue("my_way");//贸易方式
    contract_creatime = $.MvcSheetUI.GetControlValue("contract_creatime");//合同创建时间
    contract_creatime2 = $.MvcSheetUI.GetControlValue("contract_creatime2");//合同创建时间2
    end_user = $.MvcSheetUI.GetControlValue("end_user");//最终用户
    contract_xz = $.MvcSheetUI.GetControlValue("contract_xz");//合同性质
    contract_bgtime = $.MvcSheetUI.GetControlValue("contract_bgtime");//合同变更时间
    contract_bgtime2 = $.MvcSheetUI.GetControlValue("contract_bgtime2");//合同变更时间2
    contract_mf = $.MvcSheetUI.GetControlValue("contract_mf");//合同卖方
    contract_type = $.MvcSheetUI.GetControlValue("contract_type");//合同类型
    user = "";//$.MvcSheetUI.SheetInfo.UserID;
    $('#Contract_query').bootstrapTable('refresh');
}

//查询
/*
function sel_agreement() {

    var contract_number = $.MvcSheetUI.GetControlValue("contract_number");//合同号
    var contract_name = $.MvcSheetUI.GetControlValue("contract_name");//合同名称
    var qy_time = $.MvcSheetUI.GetControlValue("qy_time");//签约日期
    var qy_time2 = $.MvcSheetUI.GetControlValue("qy_time2");//签约日期2
    var Project_head = $.MvcSheetUI.GetControlValue("Project_head");//项目负责人
    var my_way = $.MvcSheetUI.GetControlValue("my_way");//贸易方式
    var contract_creatime = $.MvcSheetUI.GetControlValue("contract_creatime");//合同创建时间
    var contract_creatime2 = $.MvcSheetUI.GetControlValue("contract_creatime2");//合同创建时间2
    var end_user = $.MvcSheetUI.GetControlValue("end_user");//最终用户
    var contract_xz = $.MvcSheetUI.GetControlValue("contract_xz");//合同性质
    var contract_bgtime = $.MvcSheetUI.GetControlValue("contract_bgtime");//合同变更时间
    var contract_bgtime2 = $.MvcSheetUI.GetControlValue("contract_bgtime2");//合同变更时间2
    var contract_mf = $.MvcSheetUI.GetControlValue("contract_mf");//合同卖方
    var contract_type = $.MvcSheetUI.GetControlValue("contract_type");//合同类型
    var user = "";//$.MvcSheetUI.SheetInfo.UserID;

    $("#Contract_query").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "../Mycontract/Mycontract.ashx?Command=getcontractList",   //处理页的相对地址
        data: {
            contract_number: contract_number,
            contract_name: contract_name,
            qy_time: qy_time,
            qy_time2: qy_time2,
            Project_head: Project_head,
            my_way: my_way,
            contract_creatime: contract_creatime,
            contract_creatime2: contract_creatime2,
   
            end_user: end_user,
            contract_xz: contract_xz,
            contract_bgtime: contract_bgtime,
            contract_bgtime2: contract_bgtime2,
            contract_mf: contract_mf,
            contract_type: contract_type,
            user:user,
            
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            console.log(ret);
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Contract_number = ret[i].ContractNO;
                obj.Ccontract_name = ret[i].ContractName;
                obj.Contract_cretime = ret[i].CreatedTime;
                obj.Contract_type = ret[i].ContractType;
                obj.Contract_nature = ret[i].ContractProperty;
                obj.Contract_fz = ret[i].Projecthead;
                obj.end_user = ret[i].FinalUser;
                obj.Contract_seller = ret[i].Salers;

                obj.Contract_money = ret[i].ContractTotalPrice;
                obj.qy_time = ret[i].SignDate;
                obj.bg_time = ret[i].ModifiedTime;
                obj.states = ret[i].contract_state;
                obj.ObjectID = ret[i].ObjectID;


                // 往bootstrapTable添加数据
                $("#Contract_query").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}
*/