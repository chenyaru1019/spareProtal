<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ObjectionApprove.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.ObjectionApprove" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
<script type="text/javascript">

var _sheetInfo;
var _workflowVersion = {};
	
function initGobackForm() {
	$("#go-back-btn").click(onRequestGoBack);
	$.MvcSheet.AddAction({
		Action: "GoBack",
		Icon: "fa-sign-in",
		Text: "取回",
		Datas: [],
		OnAction: function () {
			var activities = [
				{code: "Activity2", name: "发起申请"},
				{code: "Activity3", name: "部门经理审批"},
				{code: "Activity8", name: "公司经理审批"}
			];
			if (_sheetInfo.ActivityCode == activities[0].code) {
				layer.alert('发起申请时不需要取回。', { icon: 2 });
			}
			else {
				$("#select-go-back-activity").empty();
				for (var i = 0; i < activities.length; i++) {
					if (activities[i].code == _sheetInfo.ActivityCode)
						break;
					$("#select-go-back-activity").append("<option value='"
						+ activities[i].code + "' "
						+ (i == 0 ? "selected" : "")
						+ ">" + activities[i].name
						+ "</option>"
					);
				}
				$("#go-back-form").modal("show");
				$("#go-back-form div.row").removeAttr("style", "display:none");
			}
		}
	});
}

function onRequestGoBack() {
	var url = "/Portal/MvcDefaultSheet.aspx?SheetCode=SGoBackBiddingWorkflow"
		+ "&Mode=Originate&WorkflowCode=GoBackBiddingWorkflow&WorkflowVersion="
		+ _workflowVersion["GoBackBiddingWorkflow"]
		+ "&ProjectName=" + $.MvcSheetUI.GetControlValue("ProjectName")
		+ "&BiddingCode=" + $.MvcSheetUI.GetControlValue("TenderReference")
		+ "&TheActivityCode=" + $("#select-go-back-activity").val()
		+ "&TheInstanceId=" + _sheetInfo.InstanceId;
	window.location.href = url;
	window.event.returnValue = false;
}

$.MvcSheet.Loaded = function(sheetInfo) {
	SearchApprovalTbl();
}

$.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadWorkflowVersion", function(data) {
	for (var i = 0; i < data.length; i++) {
		_workflowVersion[data[i].code] = data[i].version;
	}
	initGobackForm();
});

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">异议处理审批</label>
</div>
<div class="panel-body sheetContainer">
	<div class="nav-icon fa fa-chevron-right bannerTitle" style="display:none;">
		<label id="divBasicInfo" data-en_us="Basic information">基本信息</label>
	</div>
	<div class="divContent" style="display:none;">
		<div class="row">
			<div id="divFullNameTitle" class="col-md-2">
				<label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-en_us="Originator" data-bindtype="OnlyVisiable" style="">发起人</label>
			</div>
			<div id="divFullName" class="col-md-4">
				<label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData" style=""></label>
			</div>
			<div id="divOriginateDateTitle" class="col-md-2">
				<label id="lblOriginateDateTitle" data-type="SheetLabel" data-datafield="OriginateTime" data-en_us="Originate Date" data-bindtype="OnlyVisiable" style="">发起时间</label>
			</div>
			<div id="divOriginateDate" class="col-md-4">
				<label id="lblOriginateDate" data-type="SheetLabel" data-datafield="OriginateTime" data-bindtype="OnlyData" style=""></label>
			</div>
		</div>
		<div class="row">
			<div id="divOriginateOUNameTitle" class="col-md-2">
				<label id="lblOriginateOUNameTitle" data-type="SheetLabel" data-datafield="Originator.OUName" data-en_us="Originate OUName" data-bindtype="OnlyVisiable" style="">所属组织</label>
			</div>
			<div id="divOriginateOUName" class="col-md-4">
				<!--					<label id="lblOriginateOUName" data-type="SheetLabel" data-datafield="Originator.OUName" data-bindtype="OnlyData">
<span class="OnlyDesigner">Originator.OUName</span>
					</label>-->
					<select data-datafield="Originator.OUName" data-type="SheetOriginatorUnit" id="ctlOriginaotrOUName" class="" style="">
					</select>
				</div>
				<div id="divSequenceNoTitle" class="col-md-2">
					<label id="lblSequenceNoTitle" data-type="SheetLabel" data-datafield="SequenceNo" data-en_us="SequenceNo" data-bindtype="OnlyVisiable" style="">流水号</label>
				</div>
				<div id="divSequenceNo" class="col-md-4">
					<label id="lblSequenceNo" data-type="SheetLabel" data-datafield="SequenceNo" data-bindtype="OnlyData" style=""></label>
				</div>
			</div>
		</div>
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="ProjectName" style="">项目名称</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="ProjectName" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetSuccessfulTender" data-querycode="GetSuccessfulTender" data-outputmappings="ProjectName:ProjectName,TenderReference:BiddingCode,SuccessfulTender:BidWinner">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="TenderReference" style="">招标编号</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="TenderReference" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="SuccessfulTender" style="">中标人</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="SuccessfulTender" data-type="SheetTextBox" style="">
				</div>
				<div id="space4" class="col-md-2">
				</div>
				<div id="spaceControl4" class="col-md-4">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="OppositionDocument" style="">异议文件</span>
				</div>
				<div id="control5" class="col-md-10">
					<div id="Control14" data-datafield="OppositionDocument" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ReplyToObjection" style="">异议回复</span>
				</div>
				<div id="control7" class="col-md-10">
					<div id="Control15" data-datafield="ReplyToObjection" data-type="SheetAttachment" style=""></div>
				</div>
			</div><div class="row"><div id="div776570" class="col-md-2"><label data-datafield="ApprovalOpinion" data-type="SheetLabel" id="ctl667236" class="" style="">贸易部经理异议审批意见</label></div><div id="div312146" class="col-md-10"><textarea data-datafield="ApprovalOpinion" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl172403" class=""></textarea></div></div><div class="row"><div id="div642225" class="col-md-2"><label data-datafield="LeadershipApproval" data-type="SheetLabel" id="ctl82524" class="" style="">公司领导审批意见</label></div><div id="div266240" class="col-md-10"><textarea data-datafield="LeadershipApproval" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl386822" class=""></textarea></div></div>
		</div>
	</div>
	<div class="ContractContent">
		<label data-en_us="Sheet information">处理记录</label>
		<div class="myTable">
			<table data-toggle="table" class="table table-striped table-bordered table-hover ApprovalTbl"></table>
		</div>
	</div>
	<div id="go-back-form" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="BiddingRecordFormLabel">流程取回</h4>
				</div>
				<div class="modal-body">
					<div class="container col-md-12" style="padding:16px">
						<div class="row">
							<div class="col-md-4">选择活动</div>
							<div class="col-md-8">
								<select id="select-go-back-activity" class="form-control"></select>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="go-back-btn">确定</button>、
				</div>
			</div>
		</div>
	</div>
	<script src="../js/bootstrap-select.min.js"></script>
	<script src="../js/bootstrap-table.min.js"></script>
	<script src="../js/bootstrap-table-zh-CN.min.js"></script>
	<script src="../js/ApprovalTbl.js"></script>
	<link rel="stylesheet" href="../js/bootstrap-select.min.css">
	<link rel="stylesheet" href="../js/bootstrap-table.min.css">
</asp:Content>

