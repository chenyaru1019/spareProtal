<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoBackApprove.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.GoBackApprove" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
$.MvcSheet.Loaded = function() {
	SearchApprovalTbl();
}

$.MvcSheet.ActionDone = function (data) {
    if (this.Action == "Submit") {
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "Activity3") {
            var instanceId = $.MvcSheetUI.GetControlValue("TheInstanceId");
            var activityCode = $.MvcSheetUI.GetControlValue("TheActivityCode");
            goBack(
                $.MvcSheetUI.GetControlValue("TheInstanceId"),
                $.MvcSheetUI.GetControlValue("TheActivityCode"),
                $.MvcSheetUI.SheetInfo.UserID
            );
        }
    }
}

function goBack(instanceId, activityCode, userId) {
    var participants = new Array();
    participants.push(userId);
    $.ajax({
        type: "POST",
        url: "/Portal/InstanceDetail/CancelInstance",
        async: false,
        data: {
            InstanceID: instanceId,
        },
        success: function (ret) {
            if (ret.SUCCESS) {
                $.ajax({
                    type: "POST",
                    url: "/Portal/InstanceDetail/ActivateInstance", 
                    async: false,
                    data: {
                        InstanceID: instanceId,
                    },
                    success: function (ret) {
                        if (ret.SUCCESS) {
                            $.ajax({
                                type: "POST",
                                url: "/Portal/InstanceDetail/ActivateActivity",
                                async: false,
                                data: {
                                    InstanceID: instanceId,
                                    ActivityCode: activityCode,
                                    Participants: participants,
                                },
                                success: function (ret) {
                                    if (ret.SUCCESS) {
                                        alert('取回成功。');
                                    } else {
                                        alert('取回失败.');
                                    }
                                }
                            });
                        } else {
                            alert('取回失败！');
                        }
                    }
                });
            } else {
                alert('取回失败。');
            }
        }
    });
}
</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">取回审批</label>
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
					<input id="Control11" type="text" data-datafield="ProjectName" data-type="SheetTextBox" style="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="BiddingCode" style="">招标编号</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="BiddingCode" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row hidden">
				<div id="div710945" class="col-md-2">
					<label data-datafield="TheInstanceId" data-type="SheetLabel" id="ctl203224" class="" style="">取回流程实例Id</label>
				</div>
				<div id="div294063" class="col-md-4">
					<input type="text" data-datafield="TheInstanceId" data-type="SheetTextBox" id="ctl38384" class="" style="">
				</div>
				<div id="div929321" class="col-md-2">
					<label data-datafield="TheActivityCode" data-type="SheetLabel" id="ctl754157" class="" style="">取回活动名称</label>
				</div>
				<div id="div999088" class="col-md-4">
					<input type="text" data-datafield="TheActivityCode" data-type="SheetTextBox" id="ctl945183" class="" style="">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="GoBackReason" style="">取回原因</span>
				</div>
				<div id="control3" class="col-md-10">
					<textarea id="Control13" data-datafield="GoBackReason" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title5" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="ManagerComment" style="">主管经理审批意见</span>
				</div>
				<div id="control5" class="col-md-10">
					<div id="Control14" data-datafield="ManagerComment" data-type="SheetComment" style=""></div>
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
	<script src="../js/bootstrap-select.min.js"></script>
	<script src="../js/bootstrap-table.min.js"></script>
	<script src="../js/bootstrap-table-zh-CN.min.js"></script>
	<script src="../js/ApprovalTbl.js"></script>
	<link rel="stylesheet" href="../js/bootstrap-select.min.css">
	<link rel="stylesheet" href="../js/bootstrap-table.min.css">
</asp:Content>