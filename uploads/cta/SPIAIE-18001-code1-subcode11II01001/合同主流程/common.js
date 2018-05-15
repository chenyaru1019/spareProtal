
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-member-add").Validform({
		tiptype:2,
		callback:function(form){
			form[0].submit();
			var index = parent.layer.getFrameIndex(window.name);
			parent.$('.btn-refresh').click();
			parent.layer.close(index);
		}
	});
	
	
});


//弹出框的拖动
$('#move-header').mousedown( 
	function (event) { 
	var isMove = true; 
	var abs_x = event.pageX - $('div.moveBar').offset().left; 
	var abs_y = event.pageY - $('div.moveBar').offset().top; 
	$(document).mousemove(function (event) { 
		if (isMove) { 
			var obj = $('div.moveBar'); 
			obj.css({'left':event.pageX - abs_x, 'top':event.pageY - abs_y}); 
		} 
		} 
		).mouseup( 
		function () { 
		isMove = false; 
	}); 
}); 

//弹出全屏窗口(事件影响范围)
function popupFull(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

function timeStampToString(time) {
	var datetime = new Date();
	datetime.setTime(time);
	var year = datetime.getFullYear();
	var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1)
			: datetime.getMonth() + 1;
	var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime
			.getDate();
	var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime
			.getHours();
	var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
			: datetime.getMinutes();
	// var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
	// : datetime.getSeconds();
	// return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":"
	// + second;
	return year + "-" + month + "-" + date + " " + hour + ":" + minute;
}

function checkXlsData(excelFile) {

	var fileDir = $("#"+excelFile).val();
	var suffix = fileDir.substr(fileDir.lastIndexOf("."));
	if ("" == fileDir) {
		layer.msg('选择需要导入的Excel文件!', {
			icon : 7,
			time : 1000
		});
		return false;
	}
	if (".xls" != suffix && ".xlsx" != suffix) {
		layer.msg('选择Excel格式的文件导入!', {
			icon : 7,
			time : 1000
		});
		return false;
	}
	return true;
}

Date.prototype.format = function(format) {
    var date = {
           "M+": this.getMonth() + 1,
           "d+": this.getDate(),
           "h+": this.getHours(),
           "m+": this.getMinutes(),
           "s+": this.getSeconds(),
           "q+": Math.floor((this.getMonth() + 3) / 3),
           "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
           if (new RegExp("(" + k + ")").test(format)) {
                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
           }
    }
    return format;
}

function getSearchData(eventId,id,frame){
	$.ajax({
		url :"B001/getSearchStatus",
		type:"get",
		data:{
			id:id,
			eventId:eventId
			},
		datatype:"json",
		success : function(data) {
			if(data.status == "success" && (typeof(data.data) != 'undefined' && data.data != '')) {
				showSearchData(data.data,frame);
			}
		}
	})
}
//显示应急信息
function showSearchData(data,frame) {
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]+"/";  
	var t = "";
//	if(frame == '') {
//		t = $("#searchShow").DataTable({"destroy": true});
//	} else {
//		// 跨域
//		$(frame).contents().find("#searchShow").dataTable().fnDestroy();
////		t.draw();
//	}
	// 非跨域
	if(frame == '') {
		$("#searchShow_length").remove();
		$("#searchShow_filter").remove();
		t = $("#searchShow").DataTable();
		
	} else {
		// 跨域
		$("#searchShow_length").remove();
		$("#searchShow_filter").remove();
		t=$(frame).contents().find("#searchShow").dataTable().fnDestroy();
//		t = $(frame).contents().find("#searchShow").DataTable();
	}
	t.clear().draw();
	var ddHtml="";
	var qxtHtml="";
	var postHtml="";
	console.log("data="+data);
	for (var i = 0; i < data.length; i++) {
		if(data[i].attr1=='2'){//onClick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Sucess?id="+data[i].id+"&type=02','4','400','500')\" 
			ddHtml ="<a class=\"label label-success radius \" href=\"javascript:;\" title=\"信息状态\">发送成功</a>";
		}else if(data[i].attr1=='9') { //onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=02','4','400','500')\"
			ddHtml ="<a class=\"label  radius\"  href=\"javascript:;\" title=\"\">发送失败</a>";
		}else if(data[i].attr1=='0' || data[i].attr1=='1') { //onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=02','4','400','500')\"
			ddHtml ="<a class=\"label label-success radius \" href=\"javascript:;\" title=\"信息状态\">发送中</a>";
		}else if(data[i].attr1=='4')  {
			ddHtml ="";
		}
		
		if(data[i].attr2=='2'){//onClick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Sucess?id="+data[i].id+"&type=03','4','400','500')\"
			qxtHtml ="<a class=\"label label-success radius \"  href=\"javascript:;\" title=\"信息状态\">发送成功</a>";
		}else if(data[i].attr2=='9') {//onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=03','4','400','500')\"
			qxtHtml ="<a class=\"label  radius\"  href=\"javascript:;\" title=\"\">发送失败</a>";
		}else if(data[i].attr2=='0' || data[i].attr2=='1') { //onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=02','4','400','500')\"
			qxtHtml ="<a class=\"label label-success radius \" href=\"javascript:;\" title=\"信息状态\">发送中</a>";
		}else if(data[i].attr2=='4')  {
			qxtHtml ="";
		}
		
		if(data[i].attr3=='2'){
			postHtml ="<a class=\"label label-success radius \" onClick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Sucess?id="+data[i].id+"&type=01','4','400','500')\" href=\"javascript:;\" title=\"信息状态\">发送成功</a>";
		}else if(data[i].attr3=='9') {
			postHtml ="<a class=\"label  radius\" onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=01','4','400','500')\" href=\"javascript:;\" title=\"\">发送失败</a>";
		}else if(data[i].attr3=='0' || data[i].attr3=='1') { //onclick=\"yjxs_chakan('信息状态','"+basePath+"B001/B001_Error?id="+data[i].id+"&type=02','4','400','500')\"
			postHtml ="<a class=\"label label-success radius \" href=\"javascript:;\" title=\"信息状态\">发送中</a>";
		}else if(data[i].attr3=='4')  {
			postHtml ="";
		}
		
		t.row
		.add(
				[ // 发送时间
						data[i].sendPost,
						// 发布人
						data[i].msgContent,
						ddHtml,
						qxtHtml,
						postHtml,
						"<a title='更' onclick='updateContent(\""+data[i].msgContent+"\")'>更</a>&nbsp;"+
					   	"<a title='打标签' onclick='doMark(\""+data[i].id+"\")'>打标签</a>"
						]).draw();					
	}
	if(frame != '') {
		$("#searchShow_length").remove();
		$("#searchShow_filter").remove();
		$(frame).contents().find("#searchShow").parent().siblings().remove();
//		$(frame).contents().find("#searchShow").parent().before().remove();
//		$(frame).contents().find("#searchShow").parent().next().remove();
//		$(frame).contents().find("#searchShow").parent().next().remove();
	}
	
}