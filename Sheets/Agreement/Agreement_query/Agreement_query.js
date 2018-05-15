//全部
var tableData = new Array();
$('#Agreement_query').bootstrapTable({
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
        valign: 'middle',
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
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Project_head',
        //width: '15%',
        title: '项目负责人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'con_state',
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
    return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name + '\')">查看</button>'
    ].join('');
    //&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name +  '\')">编辑</button>
}
//协议编号超链接
function link_number(value, row, index) {
    return '<a href="javascript:;" onclick="herf_agreement(\'' + row.ObjectID + '\',\'' + row.Agreement_name +  '\')">' + value + '</a>';
}
function herf_agreement(v, name) {
    console.log(v);
    if (("航空煤油" == name)) {
        window.location.href = "/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=View&WorkItemID=" + v;
    } else {

        window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=View&WorkItemID=" + v;
    }
}
function edit_agreement(v, name) {
    if (("航空煤油" == name)) {
        window.location.href = "/Portal/Sheets/Contract/AircraftOilAgreement/AircraftOilAgreement.aspx?Mode=Work&WorkItemID=" + v;
    } else {

        window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=Work&WorkItemID=" + v;
    }
    //window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=Work&WorkItemID=" + v;
}

//function operateFormatter(value, row, index) {
//    return ['<button  type="button" class="btn btn-primary btn-xs" onclick="herf_agreement(\'' + row.ObjectID + '\')">查看</button>&nbsp;<button  type="button" class="btn btn-primary btn-xs" onclick="edit_agreement(\'' + row.ObjectID + '\')">编辑</button>'
//    ].join('');

//}
////协议编号超链接
//function link_number(value, row, index) {
//    return '<a href="javascript:;" onclick="herf_agreement(\'' + row.ObjectID + '\')">' + value + '</a>';
//}
//function herf_agreement(v) {
//    console.log(v);
//    window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=View&WorkItemID=" + v;
//}
//function edit_agreement(v) {
//    window.location.href = "/Portal/Sheets/AgreeMent/AgreeMent_main/AgreeMent_main.aspx?Mode=Work&WorkItemID=" + v;
//}
$.MvcSheet.Loaded = function () {
    //var user = $.MvcSheetUI.SheetInfo.UserID;
    $("#Agreement_query").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "../My_agreement/My_agreement.ashx?Command=getagreementList",   //处理页的相对地址
        data: {
            //user:user,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            console.log(ret);
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
                $("#Agreement_query").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}
//查询
function sel_agreement() {

    var AgreeMent_number = $.MvcSheetUI.GetControlValue("AgreeMent_number");
    var entrust_side = $.MvcSheetUI.GetControlValue("entrust_side");//委托方
    //差两个签约时间的查询条件
    var qy_time1 = $.MvcSheetUI.GetControlValue("qy_time1");//签约时间
    var qy_time2 = $.MvcSheetUI.GetControlValue("qy_time2");//签约时间
    var Agreement_name = $.MvcSheetUI.GetControlValue("Agreement_name");//协议名称
    var Contract_number = $.MvcSheetUI.GetControlValue("Contract_number");//合同编号
    //var Contract_nature = $.MvcSheetUI.GetControlValue("Contract_nature");//合同性质
    var Contract_nature = $("[data-datafield='Contract_nature']").find("option:selected").text();
    var BGSignDate = $.MvcSheetUI.GetControlValue("BGSignDate");//变更签约日期
    var BGSignDate2 = $.MvcSheetUI.GetControlValue("BGSignDate2");//变更签约日期
    //console.log(agreement_type);
    //console.log(my_role);
    //console.log(agreement_number);
    //console.log(Contract_nature);
    //return false;
    $("#Agreement_query").bootstrapTable('removeAll');
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "../My_agreement/My_agreement.ashx?Command=getagreementList",   //处理页的相对地址
        data: {
            AgreeMent_number: AgreeMent_number,
            entrust_side: entrust_side,
            Agreement_name: Agreement_name,
            Contract_number: Contract_number,
            //Contract_nature: Contract_nature,
            Contract_nature: Contract_nature == "全部" ? "" : Contract_nature,
            qy_time1: qy_time1,
            qy_time2: qy_time2,
            BGSignDate: BGSignDate,
            BGSignDate2: BGSignDate2,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            console.log(ret);
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
                $("#Agreement_query").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });
}