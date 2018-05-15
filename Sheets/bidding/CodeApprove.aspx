<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CodeApprove.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.CodeApprove" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
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
				{code: "Activity2", name: "手工"},
				{code: "Activity3", name: "审批"}
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
		+ "&BiddingCode=" + ""
		+ "&TheActivityCode=" + $("#select-go-back-activity").val()
		+ "&TheInstanceId=" + _sheetInfo.InstanceId;
	window.location.href = url;
	window.event.returnValue = false;
}

$.MvcSheet.Loaded = function(sheetInfo) {
	_sheetInfo = sheetInfo;
    $("input[data-datafield='ProjectName']").attr("disabled", "disabled");
    $("input[data-datafield='BiddingScope']").attr("disabled", "disabled");
    $("input[data-datafield='BiddingMethod']").attr("disabled", "disabled");
    $("input[data-datafield='AutoGenerateNumber']").attr("disabled", "disabled");
    $("#spaceControl6").hide();
	SearchApprovalTbl();
}

var isWarned = false;

$.MvcSheet.Validate = function() {
	if (this.Action == "Submit") {
		if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
		var scope = $.MvcSheetUI.GetControlValue("BiddingScope");
		var method = $.MvcSheetUI.GetControlValue("BiddingMethod");
		var code = $.MvcSheetUI.GetControlValue("BiddingNumber");
		var isWrongFormat = false;
		var yy = new Date().getFullYear() % 100;
		if (scope == "国外" && method == "公开招标") {
			if (code.length < 17) {
				isWrongFormat = true;
			}
			else {
				if (code.substring(0, 4) != "0681")
					isWrongFormat = true;
				else if (code.substring(5, 7) != yy)
					isWrongFormat = true;
				else if (code.substring(7, 9) != "40")
					isWrongFormat = true;
				else if (code.substring(9, 11) != "ZB" || code.substring(8, 10) != "YQ" || code.substring(8, 10) != "JT")
					isWrongFormat = true;
				else if (code.substring(11, 12) != "J")
					isWrongFormat = true;
				else if (code.substring(12, 14) != yy)
					isWrongFormat = true;
			}
		}
		else {
			if (code.length < 16)
				isWrongFormat = true;
			else {
				if (code.substring(0, 6) != "SPIAIE")
					isWrongFormat = true;
				else if (code.substring(8, 10) != "ZB" || code.substring(8, 10) != "YQ" || code.substring(8, 10) != "JT")
					isWrongFormat = true;
				else if (code.substring(10, 11) != "J")
					isWrongFormat = true;
				else if (code.substring(11, 13) != yy)
					isWrongFormat = true;
			}
		}
		if (isWrongFormat) {
			layer.confirm('招标编号格式不符合约定，确认提交吗?', function (index) {
			   $.MvcSheet.Submit2(this);
			});
			return false;
			} else {
				return true;
			}
		}
	}
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
	<label id="lblTitle" class="panel-title">招标编号审批</label>
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
					<span id="Label12" data-type="SheetLabel" data-datafield="BiddingScope" style="">招标范围</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="BiddingScope" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="BiddingMethod" style="">招标方式</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="BiddingMethod" data-type="SheetTextBox" style="">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="AutoGenerateNumber" style="">自动生成招标编号</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="AutoGenerateNumber" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="BiddingNumber" style="">修改后招标编号</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="BiddingNumber" data-type="SheetTextBox" style="">
				</div>
				<div id="space6" class="col-md-2">
				</div>
				<div id="spaceControl6" class="col-md-4">
					<input type="text" data-datafield="IssueObjectId" data-type="SheetTextBox" id="ctl604855" class="hidden" style="">
				</div>
			</div>
            <div class="row">
                <div id="div575256" class="col-md-2">
                    <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl394818" class="" style="">审批备注</label>
                </div>
                <div id="div557023" class="col-md-10">
                    <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl660397" class="" style=""></div>
                </div>
            </div>		
			<div class="row tableContent">
				<div id="title9" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="AuditComment" style="">审批意见</span>
				</div>
				<div id="control9" class="col-md-10">
					<div id="Control17" data-datafield="AuditComment" data-type="SheetComment" style=""></div>
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