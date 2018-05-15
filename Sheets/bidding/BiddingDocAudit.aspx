<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BiddingDocAudit.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BiddingDocAudit" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">

</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">招标文件审批</label>
</div>
<div class="panel-body sheetContainer">
	<div class="nav-icon fa fa-chevron-right bannerTitle">
		<label id="divBasicInfo" data-en_us="Basic information">基本信息</label>
	</div>
	<div class="divContent">
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
					
				<span id="Label12" data-type="SheetLabel" data-datafield="ProjectName" style="" class="">项目名称</span></div>
				<div id="control1" class="col-md-4">
					<input type="text" data-datafield="ProjectName" data-type="SheetTextBox" id="ctl344779" class="" style=""><br>
                    <a href="#" onclick="goParent()">查看主流程</a>
                    <div style="display:none"><input id="MyControl1" type="text" data-datafield="ParentWorkItemId" data-type="SheetTextBox" style=""></div>
                </div>
				<div id="title2" class="col-md-2">
					
				<span id="Label13" data-type="SheetLabel" data-datafield="BiddingCode" style="" class="">招标编号</span></div>
				<div id="control2" class="col-md-4">
					
				<input type="text" data-datafield="BiddingCode" data-type="SheetTextBox" id="ctl138216" class="" style=""></div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					
				<span id="Label14" data-type="SheetLabel" data-datafield="BiddingDoc" style="" class="">招标文件</span></div>
				<div id="control3" class="col-md-4">
					<div id="bidding-doc"></div>
                    <div style="position:absolute;left:-1000px"><input type="text" data-datafield="BiddingDoc" data-type="SheetTextBox" id="ctl194184" class="hidden" style=""></div>
                </div>
				<div id="space4" class="col-md-2">
				<span id="Label15" data-type="SheetLabel" data-datafield="BiddingDocPrice" style="" class="">招标文件售价（元）</span></div>
				<div id="spaceControl4" class="col-md-4">
				<input type="text" data-datafield="BiddingDocPrice" data-type="SheetTextBox" id="ctl341323" class="" style=""></div>
			</div>
			
			<div class="row">
				<div id="title7" class="col-md-2">
					
				<span id="Label16" data-type="SheetLabel" data-datafield="AgencyAgreementType" style="" class="">代理协议类型</span></div>
				<div id="control7" class="col-md-4">
					
				<input type="text" data-datafield="AgencyAgreementType" data-type="SheetTextBox" id="ctl81895" class="" style=""></div>
				<div id="title8" class="col-md-2">
					
				</div>
				<div id="control8" class="col-md-4">
					
				</div>
			</div>
			<div class="row tableContent">
				<div id="title9" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Remark" style="">备注</span>
				</div>
				<div id="control9" class="col-md-10">
					<textarea id="Control17" data-datafield="Remark" data-type="SheetRichTextBox" style="" class="">					</textarea>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title11" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="AuditComment" style="">审批意见</span>
				</div>
				<div id="control11" class="col-md-10">
					<div id="Control18" data-datafield="AuditComment" data-type="SheetComment" style="" class=""></div>
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
            <div style="position:absolute;left:-1000px">
                <div id="div155370" class="col-md-2"></div>
                <div id="div599828" class="col-md-4">
                    <input id="Control11" type="text" data-datafield="IssueObjectId" data-type="SheetTextBox" style="" class="hidden">
                </div>
                <div id="div67791" class="col-md-2"></div>
                <div id="div789299" class="col-md-4"></div>
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
    <script src="file2.js"></script>
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
		+ "&BiddingCode=" + $.MvcSheetUI.GetControlValue("BiddingCode")
		+ "&TheActivityCode=" + $("#select-go-back-activity").val()
		+ "&TheInstanceId=" + _sheetInfo.InstanceId;
	window.location.href = url;
	window.event.returnValue = false;
}

$.MvcSheet.Loaded = function(sheetInfo) {
	_sheetInfo = sheetInfo;
	$("#ctl344779").attr("readonly", "readonly");
	$("#ctl138216").attr("readonly", "readonly");
	$("#ctl194184").attr("readonly", "readonly");
	$("#ctl341323").attr("readonly", "readonly");
	$("#ctl81895").attr("readonly", "readonly");
	var biddingDoc = $.MvcSheetUI.GetControlValue("BiddingDoc");
	$("#bidding-doc").xnfile();
	$("#bidding-doc").xnfile("value", biddingDoc);
	$("input[type=button]", $("#bidding-doc")).prop("disabled", true);
	$("input[type=file]", $("#bidding-doc")).prop("disabled", true);
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