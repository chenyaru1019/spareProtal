/**
 * Created by dkwang on 2017/10/15.
 */

//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;
window.operateEvents = {
    "click #TableEditor"  : function (e,value,row,index) {
        indexRow = index;
        var nv = document.getElementById("myModalLabel");
        nv.innerHTML="编辑";

        selectRow = row;
    },
    "click #delete": function (e, value, row, index) {
        selectRow = row;
        //让弹出框显示的操作方法
        $('#message-module').find('.modal-body').html(
            '<div style="text-align: center;padding: 50px;line-height: 25px">' +
            '确认要删除吗？ ' +
            '</div > '
        );
        var moduleFooter = $('#message-module').find('.modal-footer');
        var cancleButton = $('<button type="button" class="btn " data-dismiss="modal" style=" border-radius: 0px;border: 0px;margin-left: 0px;width: 50%;background-color:white;float: left;border-bottom-left-radius: 5px;border-color: #ff993b;line-height: 25px;color:black">取消</button>');
        var confirmButton = $('<button type="button" class="btn btn-default" style="border-radius: 0px;border: 0px;background-color: #FF993B;width: 50%;float: right;border-bottom-right-radius: 6px;line-height: 25px;margin-left: 0px;">确定</button>');

        if (moduleFooter.find('button').length === 0) {
            cancleButton.appendTo(moduleFooter);
            confirmButton.appendTo(moduleFooter);
        }
        $('#message-module').modal({ keyboard: true, show: true, backdrop: true });
        $('#message-module').on('shown.bs.modal', function () {
            $.LoadingMask.Hide();
        });
        confirmButton.click(function () {
            $.ajax({
                type: "POST",    //页面请求的类型
                url: "ContractHandler.ashx?Command=insertOrUpdatePayManager",   //处理页的相对地址
                data: {
                    Flg: "delete",
                    id: selectRow.id,
                    ContractNo: $.MvcSheetUI.GetControlValue("ContractNo"),
                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    //$("#tableL02").bootstrapTable('insertRow', { index: 0, row: dict });
                    Render(ret);
                    selectRow = null;
                },
                error: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    layer.alert('删除数据出错！', { icon: 2 });
                }
            });
            $('#message-module').modal('hide');

        });
        
    }
}

$('#tableL02').bootstrapTable({
    //height:300,
//        showRefresh: true,
    toolbar : '#toolbar',
    //模拟数据
    columns: [{
        sortable: true,
        align:'center',
        valign:'middle',
        field: 'zjjh',
        width: '10%',
        title: '资金计划'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'zjjh_keys',
        visible: false,
        title: '资金计划keys'
        }, {
            sortable: true,
        align:'center',
        valign:'middle',
        field: 'qk',
        width: '23%',
        title: '请款'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'qk_keys',
        visible: false,
        title: '请款_keys'
        }, {
            sortable: true,
        align:'center',
        valign:'middle',
        field: 'dk',
        width: '24%',
        title: '到款'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'dk_keys',
        visible: false,
        title: '到款_keys'
        }, {
            sortable: true,
        align: 'center',
        valign: 'middle',
        field: 'fk',
        width: '23%',
        title: '付款'
    },{
        align: 'center',
        valign: 'middle',
        field: 'fk_keys',
        visible: false,
        title: '付款keys'
        }, {
            sortable: true,
        align:'center',
        valign:'middle',
        field: 'djsje',
        width: '10%',
        title: '结算'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'id',
        visible: false,
        title: 'id'
    }, {
        align: 'center',
        field: 'ActivityCode',
        visible: false
    },{
        align:'center',
        valign:'middle',
        field: 'bj',
        title: '操作',
        width: '10%',
        events: operateEvents,
        formatter:addBtn
    }],
    //pagination: true,
    //pageNumber: 1,
    //pageSize : 10,
    data:tableData
});


//模拟数据结束
//显示进度条的自定义列
function addBtn (value,row){
//        console.log(row.gys);
    if (row.ActivityCode == 'ActivityOperate') {
        return ["<a id='TableEditor' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#myModal'>编辑</a>"
            + "<a id=\"delete\" class=\"btn btn-primary btn-xs\" data-toggle=\"modal\" >删除</a>"].join("")
    } else {
        return [""].join("")
    }
    

}

//对话框
$('#myModal').on('shown.bs.modal', function (event) {
    var modal = $(this);

    //*************************基本的数据，通过接口获取
    
    //var defaultData = {
    //    'selectZjjh_All': '1,2,3,4,5,6',
    //    'selectQk_All':'1,2,3,4,5,6',
    //    'selectDk_All':'1,2,3,4,5,6',
    //    'selectFk_All':'1,2,3,4,5,6'
    //    //'selectDjsje':''
    //};

    var ContractNo = $.MvcSheetUI.GetControlValue("ContractNo");
    var selectZjjh_All = new Array();
    var selectQk_All = new Array();
    var selectDk_All = new Array();
    var selectFk_All = new Array();
    // 获取支付管理相关数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "ContractHandler.ashx?Command=getZFGLData",   //处理页的相对地址
        data: {
            ContractNo: ContractNo,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var zjjh = ret.zjjh;
            for (var i = 0; i < zjjh.length; i++) {
                var item = {};
                item.key = zjjh[i].key;
                item.value = zjjh[i].value;
                selectZjjh_All.push(item);
            }
            var qk = ret.qk;
            for (var i = 0; i < qk.length; i++) {
                var item = {};
                item.key = qk[i].key;
                item.value = qk[i].value;
                selectQk_All.push(item);
            }
            var dk = ret.dk;
            for (var i = 0; i < dk.length; i++) {
                var item = {};
                item.key = dk[i].key;
                item.value = dk[i].value;
                selectDk_All.push(item);
            }
            var fk = ret.fk;
            for (var i = 0; i < fk.length; i++) {
                var item = {};
                item.key = fk[i].key;
                item.value = fk[i].value;
                selectFk_All.push(item);
            }
        }
    });
   
    //解析
   // var selectZjjh_All = defaultData['selectZjjh_All'].split(',');
    //var selectQk_All = defaultData['selectQk_All'].split(',');
    //var selectDk_All = defaultData['selectDk_All'].split(',');
    //var selectFk_All = defaultData['selectFk_All'].split(',');

    var selectZjjh_List = [];
    var selectQk_List = [];
    var selectDk_List = [];
    var selectFk_List = [];
    var selectDjsje = null;
    if(selectRow != null){
        var selectZjjh_List = selectRow.zjjh_keys.split(',');
        var selectQk_List = selectRow.qk_keys.split(',');
        var selectDk_List = selectRow.dk_keys.split(',');
        var selectFk_List = selectRow.fk_keys.split(',');
        var selectDjsje = selectRow.djsje;
    }

    //
    for(var i=0;i<selectZjjh_All.length;i++){
        var isSame = 0;
        for(var x=0;x<selectZjjh_List.length;x++){
            if (selectZjjh_All[i].key == selectZjjh_List[x]){
                isSame = 1;
                break;
            }
        }
        if(isSame == 1){
            $('#selectZjjh.selectpicker').append("<option selected value=" + selectZjjh_All[i].key + ">" + selectZjjh_All[i].value + "</option>");
        }else {
            $('#selectZjjh.selectpicker').append("<option value=" + selectZjjh_All[i].key + ">" + selectZjjh_All[i].value + "</option>");
        }
    }

    //
    for(var i=0;i<selectQk_All.length;i++){
        var isSame = 0;
        for(var x=0;x<selectQk_List.length;x++){
            if (selectQk_All[i].key == selectQk_List[x]){
                isSame = 1;
                break;
            }
        }
        if(isSame == 1){
            $('#selectQk.selectpicker').append("<option selected value=" + selectQk_All[i].key + ">" + selectQk_All[i].value + "</option>");
        }else {
            $('#selectQk.selectpicker').append("<option value=" + selectQk_All[i].key + ">" + selectQk_All[i].value + "</option>");
        }
    }

    //
    for(var i=0;i<selectDk_All.length;i++){
        var isSame = 0;
        for(var x=0;x<selectDk_List.length;x++){
            if (selectDk_All[i].key == selectDk_List[x]){
                isSame = 1;
                break;
            }
        }
        if(isSame == 1){
            $('#selectDk.selectpicker').append("<option selected value=" + selectDk_All[i].key + ">" + selectDk_All[i].value + "</option>");
        }else {
            $('#selectDk.selectpicker').append("<option value=" + selectDk_All[i].key + ">" + selectDk_All[i].value + "</option>");
        }
    }

    //
    for(var i=0;i<selectFk_All.length;i++){
        var isSame = 0;
        for(var x=0;x<selectFk_List.length;x++){
            if (selectFk_All[i].key == selectFk_List[x]){
                isSame = 1;
                break;
            }
        }
        if(isSame == 1){
            $('#selectFk.selectpicker').append("<option selected value=" + selectFk_All[i].key + ">" + selectFk_All[i].value + "</option>");
        }else {
            $('#selectFk.selectpicker').append("<option value=" + selectFk_All[i].key + ">" + selectFk_All[i].value + "</option>");
        }
    }

    document.getElementById("selectDjsje").value = selectDjsje;

    $('#selectDk').selectpicker('refresh');
    $('#selectQk').selectpicker('refresh');
    $('#selectZjjh').selectpicker('refresh');
    $('#selectFk').selectpicker('refresh');

    //var html = 'dage';
    //modal.find('.modal-body').html(html);
});


$("#myModal").on("hide.bs.modal",function(event){
    //回到初始状态
    document.getElementById("selectZjjh").options.length=0;
    $("#selectZjjh").selectpicker('refresh');

    document.getElementById("selectQk").options.length=0;
    $("#selectQk").selectpicker('refresh');

    document.getElementById("selectDk").options.length=0;
    $("#selectDk").selectpicker('refresh');

    document.getElementById("selectFk").options.length=0;
    $("#selectFk").selectpicker('refresh');

    selectRow = null;

    document.getElementById("selectDjsje").value = '';
});

function keep() {
    
        var strZjjh_keys = new Array();
        var strZjjh_values = new Array();
        var objZjjh = document.getElementById("selectZjjh");
        for(var i=0;i<objZjjh.options.length;i++){
            if(objZjjh.options[i].selected){
                strZjjh_keys.push(objZjjh.options[i].value);
                strZjjh_values.push(objZjjh.options[i].innerHTML);
            }
        }

        var strQk_keys = new Array();
        var strQk_values = new Array();
        var objQk = document.getElementById("selectQk");
        for(var i=0;i<objQk.options.length;i++){
            if(objQk.options[i].selected){
                strQk_keys.push(objQk.options[i].value);
                strQk_values.push(objQk.options[i].innerHTML);
            }
        }


        var strDk_keys = new Array();
        var strDk_values = new Array();
        var objDk = document.getElementById("selectDk");
        for(var i=0;i<objDk.options.length;i++){
            if(objDk.options[i].selected){
                strDk_keys.push(objDk.options[i].value);
                strDk_values.push(objDk.options[i].innerHTML);
            }
        }

        var strFk_keys = new Array();
        var strFk_values = new Array();
        var objFk = document.getElementById("selectFk");
        for(var i=0;i<objFk.options.length;i++){
            if(objFk.options[i].selected){
                strFk_keys.push(objFk.options[i].value);
                strFk_values.push(objFk.options[i].innerHTML);
            }
        }

        //**********************ajax 计算
        var djsje = $('#selectDjsje').val();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var zjjh = strZjjh.toString();
        //var dict = {
        //    zjjh: strZjjh_values.toString(),
        //    qk: strQk_values.toString(),
        //    dk: strDk_values.toString(),
        //    fk: strFk_values.toString(),
        //    djsje: djsje
        //};
        // check 
        if (strZjjh_keys.length == 0) {
            layer.alert('请选择资金计划！', { icon: 2 });
            return false;
        } else if (strQk_keys.length == 0) {
            layer.alert('请选择请款！', { icon: 2 });
            return false;
        } else if (strDk_keys.length == 0) {
            layer.alert('请选择到款！', { icon: 2 });
            return false;
        } else if (strFk_keys.length == 0) {
            layer.alert('请选择付款！', { icon: 2 });
            return false;
        }
    if (selectRow == null) {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=insertOrUpdatePayManager",   //处理页的相对地址
            data: {
                Flg: "insert",
                ContractNo: $.MvcSheetUI.GetControlValue("ContractNo"),
                zjjh_keys: strZjjh_keys.toString(),
                zjjh_values: strZjjh_values.toString(),
                qk_keys: strQk_keys.toString(),
                qk_values: strQk_values.toString(),
                dk_keys: strDk_keys.toString(),
                dk_values: strDk_values.toString(),
                fk_keys: strFk_keys.toString(),
                fk_values: strFk_values.toString(),
                djsje: djsje,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                //$("#tableL02").bootstrapTable('insertRow', { index: 0, row: dict });
                Render(ret);
            },
            error: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                layer.alert('添加数据出错！', { icon: 2 });
            }
        });

        ////**********************提交请求 新增
    }else {
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "ContractHandler.ashx?Command=insertOrUpdatePayManager",   //处理页的相对地址
            data: {
                Flg: "update",
                id: selectRow.id,
                ContractNo: $.MvcSheetUI.GetControlValue("ContractNo"),
                zjjh_keys: strZjjh_keys.toString(),
                zjjh_values: strZjjh_values.toString(),
                qk_keys: strQk_keys.toString(),
                qk_values: strQk_values.toString(),
                dk_keys: strDk_keys.toString(),
                dk_values: strDk_values.toString(),
                fk_keys: strFk_keys.toString(),
                fk_values: strFk_values.toString(),
                djsje: djsje,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                //$("#tableL02").bootstrapTable('insertRow', { index: 0, row: dict });
                Render(ret);
            },
            error: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                layer.alert('添加数据出错！', { icon: 2 });
            }
        });

        ////**********************提交请求 修改
    }
    $("#myModal").hide();
    $(".modal-backdrop").remove();

}

function Render(ret) {
    $("#tableL02").bootstrapTable('removeAll');
    for (var i = 0; i < ret.length; i++) {
        var obj = {};
        obj.zjjh = ret[i].ZJJH_Values;
        obj.zjjh_keys = ret[i].ZJJH_Keys;
        obj.qk = ret[i].QK_Values;
        obj.qk_keys = ret[i].QK_Keys;
        obj.dk = ret[i].DK_Values;
        obj.dk_keys = ret[i].DK_Keys;
        obj.fk = ret[i].FK_Values;
        obj.fk_keys = ret[i].FK_Keys;
        obj.djsje = ret[i].JSAmount;
        obj.id = ret[i].id;
        // 往bootstrapTable添加数据
        $("#tableL02").bootstrapTable('insertRow', { index: i, row: obj });
    }
}
