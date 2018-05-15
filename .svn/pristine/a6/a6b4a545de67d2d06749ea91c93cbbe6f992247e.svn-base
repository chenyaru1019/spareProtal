

//数据加载后
$.MvcSheet.Loaded = function () {

    // 只显示关闭按钮
    $("li[data-action='ViewInstance']").hide();
    $("li[data-action='Print']").hide();
    $(".ContractContent div[data-title='征询意见']").parent().hide();

    // 插入查阅表
    InsertRead();
    // 初始化评论列表
    initComment();
    // 获取评论数、查阅数
    QueryCount();
}

function initComment() {
    $(".comment-show").empty();
    // 获取评论相关数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getComments",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
        },
        //async: false,
        success: function (data) {    //这是处理后执行的函数，msg是处理页返回的数据
            var oHtml = "";
            var hfHtml = "";
            var groupId_Bak = "";
            for (var i = 0; i < data.length; i++) {
                if (data[i].groupId != groupId_Bak && groupId_Bak != "") {
                    oHtml = oHtml.replace("InsertReplace", hfHtml);
                    $(".comment-show").append(oHtml);
                    hfHtml = "";
                    oHtml = "";
                }
                if (data[i].ParentId == '0') {
                    oHtml = '<div class="comment-show-con clearfix"> ' +
                        '       <div class="comment-show-con-list pull-left clearfix">' +
                        '           <div class="pl-text clearfix"> <input type="hidden" class="PLId" value="' + data[i].Id + '"><a href="#" class="comment-size-name">' + data[i].PLAuthor + '</a> <span class="my-pl-con"> : &nbsp;' + data[i].PLContent + '</span> </div> ' +
                        '           <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + data[i].PLTime + '</span> ' +
                        '               <div class="date-dz-right pull-right comment-pl-block"><a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a>  ' +
                        '               </div > ' +
                        '           </div > ' +
                        '           <div class="hf-list-con">InsertReplace</div>' +
                        '       </div > ' +
                        '     </div > ';
                } else {
                    hfHtml += '<div class="all-pl-con"> ' +
                        '           <div class="pl-text hfpl-text clearfix"><a href="#" class="comment-size-name">' + data[i].PLAuthor + '</a>  : 回复@ <a href="#" class="comment-size-name">' + data[i].HFAuthor + '</a> : <span class="my-pl-con">' + data[i].PLContent + '</span></div>' +
                        '           <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + data[i].PLTime + '</span> ' +
                        '               <div class="date-dz-right pull-right comment-pl-block">  <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> </div> ' +
                        '          </div >' +
                        '        </div > ';
                }
                
                groupId_Bak = data[i].groupId;
                
            }
            if (groupId_Bak != "") {
                oHtml = oHtml.replace("InsertReplace", hfHtml);
                $(".comment-show").append(oHtml);
            }
        }
    });
}

$(function () {
    $('.content').flexText();
});


function keyUP(t){
    var len = $(t).val().length;
    if(len > 139){
        $(t).val($(t).val().substring(0, 140));
    }
}

$('.commentAll').on('click','.plBtn',function(){
    //var myDate = new Date();
    ////获取当前年
    //var year=myDate.getFullYear();
    ////获取当前月
    //var month=myDate.getMonth()+1;
    ////获取当前日
    //var date=myDate.getDate();
    //var h=myDate.getHours();       //获取当前小时数(0-23)
    //var m=myDate.getMinutes();     //获取当前分钟数(0-59)
    //if(m<10) m = '0' + m;
    //var s=myDate.getSeconds();
    //if(s<10) s = '0' + s;
    //var now=year+'-'+month+"-"+date+" "+h+':'+m+":"+s;
    ////获取输入内容
    //var oSize = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
    //console.log(oSize);
    ////动态创建评论模块
    //oHtml = '<div class="comment-show-con clearfix"> '+
    //    //'       < div class="comment-show-con-img pull-left" > <img src="images/header-img-comment_03.png" alt=""></div> ' +
    //    '       <div class="comment-show-con-list pull-left clearfix">' +
    //    '           <div class="pl-text clearfix"> <a href="#" class="comment-size-name">David Beckham : </a> <span class="my-pl-con">&nbsp;' + oSize + '</span> </div> ' +
    //    '           <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> ' +
    //    '               <div class="date-dz-right pull-right comment-pl-block"><a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a>  '+
    //    '               </div > ' +
    //    '           </div > ' +
    //    '           <div class="hf-list-con"></div>' +
    //    '       </div > ' +
    //    '     </div > ';
    //if(oSize.replace(/(^\s*)|(\s*$)/g, "") != ''){
    //    $(this).parents('.reviewArea ').siblings('.comment-show').prepend(oHtml);
    //    $(this).siblings('.flex-text-wrap').find('.comment-input').prop('value','').siblings('pre').find('span').text('');
    //}

    // 新增评论相关数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=insertComment",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
            PLAuthor: $.MvcSheetUI.SheetInfo.UserName,
            PLContent: $(".content").val(),
            HFAuthor: "",
            ParentId: "0",
        },
        async: false,
        success: function (data) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (data == "success") {
                // 初始化评论列表
                initComment();
                $(".content").val("");
            }
        }
    });
});

$('.comment-show').on('click','.pl-hf',function(){
    //获取回复人的名字
    var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
    //回复@
    var fhN = '回复@'+fhName+' : ';
    //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
    var fhHtml = '<div class="hf-con pull-left"> <textarea class="content comment-input hf-input" placeholder="" onkeyup="keyUP(this)"></textarea> <a href="javascript:;" class="hf-pl">评论</a></div>';
    //显示回复
    if($(this).is('.hf-con-block')){
         $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
        $(this).removeClass('hf-con-block');
        $('.content').flexText();
        $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding','6px 15px');
        //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
        //input框自动聚焦
        $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus().val(fhN);
    }else {
         $(this).addClass('hf-con-block');
        $(this).parents('.date-dz-right').siblings('.hf-con').remove();
    }
});

$('.comment-show').on('click','.hf-pl',function(){
    //var oThis = $(this);
    //var myDate = new Date();
    ////获取当前年
    //var year=myDate.getFullYear();
    ////获取当前月
    //var month=myDate.getMonth()+1;
    ////获取当前日
    //var date=myDate.getDate();
    //var h=myDate.getHours();       //获取当前小时数(0-23)
    //var m=myDate.getMinutes();     //获取当前分钟数(0-59)
    //if(m<10) m = '0' + m;
    //var s=myDate.getSeconds();
    //if(s<10) s = '0' + s;
    //var now=year+'-'+month+"-"+date+" "+h+':'+m+":"+s;
    ////获取输入内容
    //var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
    //console.log(oHfVal)
    //var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
    //var oAllVal = '回复@'+oHfName;
    //if(oHfVal.replace(/^ +| +$/g,'') == '' || oHfVal == oAllVal){

    //}else {
    //    $.getJSON("../json/pl.json", function (data) {
    //        var oAt = '';
    //        var oHf = '';
    //        $.each(data, function (n, v) {
    //            delete v.hfContent;
    //            delete v.atName;
    //            var arr;
    //            var ohfNameArr;
    //            if (oHfVal.indexOf("@") == -1) {
    //                data['atName'] = '';
    //                data['hfContent'] = oHfVal;
    //            } else {
    //                arr = oHfVal.split(':');
    //                ohfNameArr = arr[0].split('@');
    //                data['hfContent'] = arr[1];
    //                data['atName'] = ohfNameArr[1];
    //            }

    //            if (data.atName == '') {
    //                oAt = data.hfContent;
    //            } else {
    //                oAt = '回复<a href="#" class="atName">@' + data.atName + '</a> : ' + data.hfContent;
    //            }
    //            oHf = data.hfName;
    //        });

    //        var oHtml = '<div class="all-pl-con"><div class="pl-text hfpl-text clearfix"><a href="#" class="comment-size-name">我的名字 : </a><span class="my-pl-con">' + oAt + '</span></div><div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> <div class="date-dz-right pull-right comment-pl-block"> <a href="javascript:;" class="removeBlock">删除</a> <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> <span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">666</i>)</a> </div> </div></div>';
    //        oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display', 'block').prepend(oHtml) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
    //    });
    //}

    //获取输入内容
    var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
    var ind = oHfVal.indexOf(":");
    oHfVal = ind > -1 ? oHfVal.substring(ind+1).trim() : "";
    var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
    var ParentId = $(this).parents(".comment-show-con").find('.PLId').val();
    // 新增评论相关数据
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=insertComment",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
            PLAuthor: $.MvcSheetUI.SheetInfo.UserName,
            PLContent: oHfVal,
            HFAuthor: oHfName,
            ParentId: ParentId,
        },
        async: false,
        success: function (data) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (data == "success") {
                // 初始化评论列表
                initComment();
                $(".content").val("");
            }
        }
    });
});

$('.commentAll').on('click','.removeBlock',function(){
    var oT = $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con');
    if(oT.siblings('.all-pl-con').length >= 1){
        oT.remove();
    }else {
        $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con').parents('.hf-list-con').css('display', 'none')
        oT.remove();
    }
    $(this).parents('.date-dz-right').parents('.date-dz').parents('.comment-show-con-list').parents('.comment-show-con').remove();

})


//**********************初始化table ajax请求的data
var tableData = new Array();

var selectRow = null;
var indexRow = null;



$('#tableRead').bootstrapTable({
    height: 510,
    //        showRefresh: true,
    toolbar: '#toolbar',
    //模拟数据
    columns: [{
        align: 'center',
        valign: 'middle',
        field: 'TheNo',
        width: '10%',
        title: '序号'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'Reader',
        width: '45%',
        title: '查阅人'
    }, {
        align: 'center',
        valign: 'middle',
        field: 'ReadTime',
        width: '45%',
        title: '查阅时间'
    }],
    pagination: true,
    pageNumber: 1,
    pageSize: 10,
    data: tableData
});


// 插入
function InsertRead() {

    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=insertRead",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
            Reader: $.MvcSheetUI.SheetInfo.UserName,
        },
        async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret == "success") {
                ReadQuery();
            }
        }
    });

}
// 查询
function ReadQuery() {

    $("#tableRead").bootstrapTable('removeAll');
    // 获取read记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getReads",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
        },
        //async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            for (var i = 0; i < ret.length; i++) {
                var obj = {};
                obj.TheNo = ret[i].TheNo;
                obj.Reader = ret[i].Reader;
                obj.ReadTime = ret[i].ReadTime;
                // 往bootstrapTable添加数据
                $("#tableRead").bootstrapTable('insertRow', { index: i, row: obj });
            }
        }
    });

}

// 查询
function QueryCount() {

    $(".PLCount").val(0);
    $(".ReadCount").val(0);
    // 获取read记录
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "OAOfficeHandler.ashx?Command=getPLAndReadCounts",   //处理页的相对地址
        data: {
            ArticleID: $.MvcSheetUI.GetControlValue('NoticeInstanceID'),
        },
        //async: false,
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            if (ret != "") {
                $(".PLCount").text(ret.PLCount);
                $(".ReadCount").text(ret.ReadCount);
            }

        }
    });

}