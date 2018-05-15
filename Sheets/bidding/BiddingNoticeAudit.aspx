<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BiddingNoticeAudit.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BiddingNotice" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">招标公告</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
                <div id="div286116" class="col-md-2">
                    <label data-datafield="ProjectName" data-type="SheetLabel" id="ctl260921" class="" style="">项目名称</label>
                </div>
                <div id="div817552" class="col-md-4">
                    <input type="text" data-datafield="ProjectName" data-type="SheetTextBox" id="ctl664211" class="" style=""><br>
                    <a href="#" onclick="goParent()">查看主流程</a>
                    <div style="display:none"><input id="MyControl1" type="text" data-datafield="ParentWorkItemId" data-type="SheetTextBox" style=""></div>
                </div>
                <div id="div20357" class="col-md-2">
                    <div style="display:none"><label data-datafield="PackageName" data-type="SheetLabel" id="ctl855162" class="" style="display:none">包名</label></div>
                </div>
                <div id="div98523" class="col-md-4">
                    <div style="display:none"><input type="text" data-datafield="PackageName" data-type="SheetTextBox" id="ctl773276" class="" style=""></div>
                </div>
            </div>
            <div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="NoticeDoc" style="" class="">招标公告</span>
				</div>
				<div id="control1" class="col-md-10">
					<div id="BiddingNotice"></div>
                    <div style="display:none"><input type="text" data-datafield="BiddingNotice" data-type="SheetTextBox" id="ctl217833" class="hidden" style=""></div>
                </div>                
			</div>
			<div class="row tableContent">
				<div id="title3" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="AuditComment" style="">审批意见</span>
				</div>
				<div id="control3" class="col-md-10">
					<div id="Control12" data-datafield="AuditComment" data-type="SheetComment" style=""></div>
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
            <div class="row" style="display:none">
                <div id="div335032" class="col-md-2"></div>
                <div id="div374463" class="col-md-4">
                    <input type="text" data-datafield="IssueObjectId" data-type="SheetTextBox" id="ctl494848" class="hidden" style="">
                </div>
                <div id="div174479" class="col-md-2"></div>
                <div id="div954826" class="col-md-4"></div>

            </div>
             <div class="row hidden" >
                <div id="div335042" class="col-md-2"></div>
                <div id="div374473" class="col-md-4">
                    <input type="text" data-datafield="IssueObjectId" data-type="SheetTextBox" id="ctl494858" class="hidden" style="">
                </div>
                <div id="div174489" class="col-md-2">
					<input type="text" data-datafield="ManagerA" data-type="SheetTextBox" id="ctl494849"  style="">
					<input type="text" data-datafield="AManager" data-type="SheetUser" id="ctl494949"  style="">
				</div>
                <div id="div954836" class="col-md-4">
					<input type="text" data-datafield="ManagerB" data-type="SheetTextBox" id="ctl494850"  style="">
					<input type="text" data-datafield="BManager" data-type="SheetUser" id="ctl494950"  style="">
				</div>

            
		</div>
		</div>
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
    
<script src="jquery-ui.min.js"></script>
<script src="select2.js"></script>
<script src="file2.js"></script>
<script>

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
    var filename = $.MvcSheetUI.GetControlValue("BiddingNotice");
    console.log("bidding notice is " + filename);
    var ManagerA = $.MvcSheetUI.GetControlValue("ManagerA");
    var ManagerB = $.MvcSheetUI.GetControlValue("ManagerB");
    $.MvcSheetUI.SetControlValue("AManager", ManagerA);
    $.MvcSheetUI.SetControlValue("BManager", ManagerB);
    $("#BiddingNotice").xnfile();
    $("#BiddingNotice").xnfile("value", filename);
    $("#BiddingNotice input[type=button]").prop("disabled", true);
    $("#BiddingNotice input[type=file]").prop("disabled", true);
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
	<div class="ContractContent">
		<label data-en_us="Sheet information">处理记录</label>
		<div class="myTable">
			<table data-toggle="table" class="table table-striped table-bordered table-hover ApprovalTbl"></table>
		</div>
	</div>
	<script src="../js/bootstrap-select.min.js"></script>
	<script src="../js/bootstrap-table.min.js"></script>
	<script src="../js/bootstrap-table-zh-CN.min.js"></script>
	<script src="../js/ApprovalTbl.js"></script>
	<link rel="stylesheet" href="../js/bootstrap-select.min.css">
	<link rel="stylesheet" href="../js/bootstrap-table.min.css">
</asp:Content>