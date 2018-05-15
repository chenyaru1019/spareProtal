<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LaborContractDetail.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.LaborContractDetail" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
</script>
    <link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" href="LaborContractDetail.css"/>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">劳动合同管理</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
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
					<span id="Label11" data-type="SheetLabel" data-datafield="StaffName" style="">员工</span>
				</div>
				<div id="control1" class="col-md-4">
					<input type="text" data-datafield="StaffName" data-type="SheetTextBox" id="ctl524181" class="" style="" data-popupwindow="PopupWindow" data-schemacode="GetInformationByStaffName" data-querycode="GetInformationByStaffName" data-outputmappings="StaffName:Name1,OrgID:OrgID,Organization:Organization">
				
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="ContractStatus" style="">合同状态</span>
				</div>
				<div id="control2" class="col-md-4">
					
				<select data-datafield="ContractStatus" data-type="SheetDropDownList" id="ctl801774" class="" style="" data-masterdatacategory="劳动合同状态"></select></div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="DateOfContract" style="">签约日期</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="DateOfContract" data-type="SheetTime" style="">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="DueDate" style="">到期日期</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="DueDate" data-type="SheetTime" style="">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ContractPeriod" style="" class="">合同期限</span>
				</div>
				<div id="control5" class="col-md-4">
					
				<select data-datafield="ContractPeriod" data-type="SheetDropDownList" id="ctl117380" class="" style="" data-masterdatacategory="劳动合同期限">
				</select></div>
				<div id="space6" class="col-md-2">
				</div>
				<div id="spaceControl6" class="col-md-4">
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="AttachmentUpload" style="">附件上传</span>
				</div>
				<div id="control7" class="col-md-10">
					<div id="Control16" data-datafield="AttachmentUpload" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title9" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Describes" style="">描述</span>
				</div>
				<div id="control9" class="col-md-10">
					<textarea id="Control17" data-datafield="Describes" data-type="SheetRichTextBox" style="" class="">					</textarea>
				</div>
			</div>
			<div class="row hidden">
				<div id="div464948" class="col-md-2">
					<label data-datafield="OrgID" data-type="SheetLabel" id="ctl447821" class="" style="">机构ID
					</label>
				</div>
				<div id="div722327" class="col-md-4">
					<input type="text" data-datafield="OrgID" data-type="SheetTextBox" id="ctl136018" class="" style="">
				</div>
				<div id="div467121" class="col-md-2">
					<label data-datafield="Organization" data-type="SheetLabel" id="ctl521273" class="" style="">机构名称
					</label>
				</div>
				<div id="div729408" class="col-md-4">
					<input type="text" data-datafield="Organization" data-type="SheetTextBox" id="ctl686669" class="" style="">
				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>