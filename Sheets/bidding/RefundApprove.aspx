<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundApprove.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.RefundApprove" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
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
				{code: "Activity10", name: "部门经理审批"},
				{code: "Activity12", name: "公司经理审批"},
				{code: "Activity13", name: "财务人员审批"},
				{code: "Activity14", name: "办公室人员确认"}
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
	_sheetInfo = sheetInfo;
    $("#Control11").prop("readonly", "readonly");
    $("#Control12").prop("readonly", "readonly");
    $("#Control13").prop("readonly", "readonly");
    $("#Control14").prop("readonly", "readonly");
    $("#Control15").prop("readonly", "readonly");
    $("#Control16").prop("readonly", "readonly");
    $("#Control17").prop("readonly", "readonly");
	SearchApprovalTbl();
}

function goParent() {
    var url = "/Portal/Sheets/bidding/InviteBids.aspx?Mode=Work&WorkItemID="
        + $.MvcSheetUI.GetControlValue("ParentWorkItemId")
        + "&&T=" + Math.random()
    location.href = url;
    window.event.returnValue = false;
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
	<label id="lblTitle" class="panel-title">退保</label>
</div>
<div class="panel-body sheetContainer">
	 <div class="ContractContent">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="ProjectName" style="">项目名称</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="ProjectName" data-type="SheetTextBox" style=""><br>
                    <a href="#" onclick="goParent()">查看主流程</a>
                    <div style="display:none"><input id="MyControl1" type="text" data-datafield="ParentWorkItemId" data-type="SheetTextBox" style=""></div>
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="BiddingCode" style="">招标编号</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="BiddingCode" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="Tender" style="">投标单位</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="Tender" data-type="SheetTextBox" style="">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="WinnerOrLoser" style="">中落标标志</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="WinnerOrLoser" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="CashDepositType" style="">保证金类型</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="CashDepositType" data-type="SheetTextBox" style="">
				</div>
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="CashDeposit" style="">保证金</span>
				</div>
				<div id="control6" class="col-md-4">
					<input id="Control16" type="text" data-datafield="CashDeposit" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="DepositType" style="">退保类型</span>
				</div>
				<div id="control7" class="col-md-4">
					<input id="Control17" type="text" data-datafield="DepositType" data-type="SheetTextBox" style="">
				</div>
				<div id="title8" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="Payee" style="">收款人</span>
				</div>
				<div id="control8" class="col-md-4">
					<input id="Control18" type="text" data-datafield="Payee" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="BankAccount" style="">银行帐号</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control19" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="">
				</div>
				<div id="title10" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="Bank" style="">开户银行</span>
				</div>
				<div id="control10" class="col-md-4">
					<input id="Control20" type="text" data-datafield="Bank" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="Receipts" style="">支付凭证</span>
				</div>
				<div id="control11" class="col-md-10">
					<div id="Control21" data-datafield="Receipts" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="div532498" class="col-md-2">
					<label data-datafield="AuditComment" data-type="SheetLabel" id="ctl103981" class="" style="">部门经理审批意见</label>
				</div>
				<div id="div545304" class="col-md-10">
					<div data-datafield="AuditComment" data-type="SheetComment" id="ctl97001" class="" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="div306636" class="col-md-2">
					<label data-datafield="GenManagerAuditComment" data-type="SheetLabel" id="ctl706714" class="" style="">公司领导审批意见</label>
				</div>
				<div id="div641615" class="col-md-10">
					<div data-datafield="GenManagerAuditComment" data-type="SheetComment" id="ctl857833" class="" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="div52431" class="col-md-2">
					<label data-datafield="FinancialStaffAuditComment" data-type="SheetLabel" id="ctl285558" class="" style="">财务人员审批意见</label>
				</div>
				<div id="div914937" class="col-md-10">
					<div data-datafield="FinancialStaffAuditComment" data-type="SheetComment" id="ctl113551" class="" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="div18518" class="col-md-2">
					<label data-datafield="OfficeStaffAuditComment" data-type="SheetLabel" id="ctl449926" class="" style="">办公室人员审批意见</label>
				</div>
				<div id="div903077" class="col-md-10">
					<div data-datafield="OfficeStaffAuditComment" data-type="SheetComment" id="ctl421227" class="" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="div5073091" class="col-md-2">
					<label data-datafield="ApproveRemark" data-type="SheetLable" id="ctl818667" class="" style="">备注</label>
				</div>
				<div id="div2032972" class="col-md-10">
					<div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
				</div>
			</div>
			<div style="position:absolute;left:-1000px;top:-1000px">
				<div id="title15" class="col-md-2">
				</div>
				<div id="control15" class="col-md-4">
					<input id="Control23" type="text" data-datafield="IssueObjectId" data-type="SheetTextBox" class="hidden" style="">
				</div>
				<div id="space16" class="col-md-2">
				</div>
				<div id="spaceControl16" class="col-md-4">
				</div>
			</div>
		</div>
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