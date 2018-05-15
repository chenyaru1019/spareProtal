//全部
var tableData = new Array();
/*
$('#Mycontract').bootstrapTable({
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

    },  {
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
        //valign: 'middle',
        field: 'Desc',
        width: '6%',
        title: '操作',
        formatter: operateFormatter
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});
*/
var contract_sele = "";//合同选择
var contract_states = "";//合同状态
var my_role = "";//角色
var contract_name = "";//合同名称
$('#Mycontract').bootstrapTable({
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
            contract_sele: contract_sele,
            contract_states: contract_states,
            my_role: my_role,
            contract_name: contract_name,
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
        //events: operateEvents,
        formatter: operateFormatter
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    pageList: [10, 25, 50, 100],
    data: tableData
});
function operateFormatter(value, row, index) {
    return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\')">查看</button>&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\')">编辑</button>'
    ].join('');

}
//合同编号超链接
function link_number(value, row, index) {
    return '<a href="javascript:;" onclick="edit_agreement(\'' + row.ObjectID + '\')">' + value + '</a>';
}
function herf_agreement(v) {
    //console.log(v);
    window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + v + "&Permission=View";
}
function edit_agreement(v) {
    window.location.href = "/Portal/Sheets/Contract/ContractMainMy.aspx?Mode=Work&WorkItemID=" + v + "&Permission=Work";
}
$.MvcSheet.Loaded = function () {
    //var user = $.MvcSheetUI.SheetInfo.UserID;
    //var my_role = $.MvcSheetUI.GetControlValue("my_role");//角色
    //$("#Mycontract").bootstrapTable('removeAll');
    //$.ajax({
    //    type: "POST",    //页面请求的类型
    //    url: "Mycontract.ashx?Command=getcontractList",   //处理页的相对地址
    //    data: {
    //        user: user,
    //        my_role: my_role,
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
    //            obj.ObjectID = ret[i].ObjectID;


    //            // 往bootstrapTable添加数据
    //            $("#Mycontract").bootstrapTable('insertRow', { index: i, row: obj });
    //        }
    //    }
    //});
    Search();
    // 隐藏导航栏
    $("#main-navbar").hide();
    $(".divContent div[data-title='征询意见']").parent().hide();
}

function Search() {
    contract_sele = $.MvcSheetUI.GetControlValue("contract_sele");//合同选择
    contract_states = $.MvcSheetUI.GetControlValue("contract_states");//合同状态
    my_role = $.MvcSheetUI.GetControlValue("my_role");//角色
    contract_name = $.MvcSheetUI.GetControlValue("contract_name");//合同名称
    $('#Mycontract').bootstrapTable('refresh');
}

//查询
//function sel_agreement() {
//    var contract_sele = $.MvcSheetUI.GetControlValue("contract_sele");//合同选择
//    var contract_states = $.MvcSheetUI.GetControlValue("contract_states");//合同状态
//    var my_role = $.MvcSheetUI.GetControlValue("my_role");//角色
//    var contract_name = $.MvcSheetUI.GetControlValue("contract_name");//合同名称
//    var user = $.MvcSheetUI.SheetInfo.UserID;
//    //console.log(contract_sele);
//    //console.log(contract_states);
//    //console.log(my_role);
//    //console.log(contract_number);
//    //return false;
//    $("#Mycontract").bootstrapTable('removeAll');
//    $.ajax({
//        type: "POST",    //页面请求的类型
//        url: "Mycontract.ashx?Command=getcontractList",   //处理页的相对地址
//        data: {
//            contract_sele: contract_sele,
//            contract_states: contract_states,
//            my_role: my_role,
//            contract_name: contract_name,
//            user: user,
//        },
//        async: false,
//        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
//            console.log(ret);
//            for (var i = 0; i < ret.length; i++) {
//                var obj = {};
//                obj.TheNo = ret[i].TheNo;
//                obj.Contract_number = ret[i].ContractNO;
//                obj.Ccontract_name = ret[i].ContractName;
//                obj.Contract_cretime = ret[i].CreatedTime;
//                obj.Contract_type = ret[i].ContractType;
//                obj.Contract_nature = ret[i].ContractProperty;
//                obj.Contract_fz = ret[i].Projecthead;
//                obj.end_user = ret[i].FinalUser;
//                obj.Contract_seller = ret[i].Salers;

//                obj.Contract_money = ret[i].ContractTotalPrice;
//                obj.qy_time = ret[i].SignDate;
//                obj.bg_time = ret[i].ModifiedTime;
//                obj.states = ret[i].contract_state;
//                obj.ObjectID = ret[i].ObjectID;


//                // 往bootstrapTable添加数据
//                $("#Mycontract").bootstrapTable('insertRow', { index: i, row: obj });
//            }
//        }
//    });
//}