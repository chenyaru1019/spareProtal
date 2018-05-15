<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SRewardPunishmentApproval.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SRewardPunishmentApproval" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">奖惩申请审批</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="Title" style="">标题</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="Title" data-type="SheetTextBox" style="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="StaffName" style="">员工姓名</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="StaffName" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetInformationByStaffName" data-querycode="GetInformationByStaffName" data-outputmappings="StaffName:Name1,Organization:Organization,StaffObjectId:StaffObjectId" readonly="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="RewardPunishmentTime" style="">奖惩时间</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="RewardPunishmentTime" data-type="SheetTime" style="">
				</div>
                <div id="title12" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="Organization" style="">机构</span>
				</div>
				<div id="control12" class="col-md-4">
					<input id="Control18" type="text" data-datafield="Organization" data-type="SheetTextBox" style="" readonly="">
				</div>
				
			</div>
			<div class="row tableContent">
				<div id="title5" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="RewardsPunishmentsReasons" style="">奖惩原因</span>
				</div>
				<div id="control5" class="col-md-10">
					<textarea id="Control14" data-datafield="RewardsPunishmentsReasons" data-type="SheetRichTextBox" style="" class="">					</textarea>
				</div>
			</div>
			<div class="row">
				<div id="div184150" class="col-md-2">
					<label data-datafield="RewardPunishmentDetails" data-type="SheetLabel" id="ctl543369" class="" style="">奖惩明细
					</label>
				</div>
				<div id="div820689" class="col-md-4">
					<select data-datafield="RewardPunishmentDetails" data-type="SheetDropDownList" id="ctl157044" class="" style="" data-masterdatacategory="奖惩明细">
					</select>
				</div>
                <div id="space4" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="RewardsPunishmentsType" style="" class="">奖惩类型</span>
				</div>
				<div id="spaceControl4" class="col-md-4">
					<select data-datafield="RewardsPunishmentsType" data-type="SheetDropDownList" id="ctl584970" class="" style="" data-masterdatacategory="奖惩类型">
					</select>
				</div>
			</div>
			
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="AmountOfMoney" style="">金额</span>
				</div>
				<div id="control11" class="col-md-4">
					<input id="Control17" type="text" data-datafield="AmountOfMoney" data-type="SheetTextBox" style="" class="">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title13" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="InChargeLeaderApprovalOpinions" style="">分管领导审批意见</span>
				</div>
				<div id="control13" class="col-md-10">
					<div id="Control19" data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title15" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="ManagerApprovalOpinion" style="">部门经理审批意见</span>
				</div>
				<div id="control15" class="col-md-10">
					<div id="Control20" data-datafield="ManagerApprovalOpinion" data-type="SheetComment" style=""></div>
				</div>
			</div>
            <div class="row hidden"><div id="div965719" class="col-md-2"><label data-datafield="StaffObjectId" data-type="SheetLabel" id="ctl242579" class="" style="">员工的objectId</label></div><div id="div812271" class="col-md-4"><input type="text" data-datafield="StaffObjectId" data-type="SheetTextBox" id="ctl474067" class="" style=""></div><div id="div730884" class="col-md-2"></div><div id="div143275" class="col-md-4"></div></div>
		
		</div>
	</div>
    </div>
</asp:Content>