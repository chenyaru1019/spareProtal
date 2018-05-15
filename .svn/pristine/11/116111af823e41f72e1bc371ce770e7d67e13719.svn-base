<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExpertsManage.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.ExpertsManage" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
    </script>
    <link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" href="pagecss.css"/>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">专家库管理</label>
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
					<span id="Label11" data-type="SheetLabel" data-datafield="ExpertsNames" style="">专家姓名</span>
				</div>
				<div id="control1" class="col-md-10">
					<input id="Control11" type="text" data-datafield="ExpertsNames" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="District" style="">地区</span>
				</div>
				<div id="control2" class="col-md-10">
					<select data-datafield="District" data-type="SheetDropDownList" id="ctl972132" class="" style="" data-masterdatacategory="地区">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="DateOfBirth" style="">出生年月</span>
				</div>
				<div id="control3" class="col-md-10">
					<input id="Control13" type="text" data-datafield="DateOfBirth" data-type="SheetTime" style="" class="">
				</div>
			</div>
			<div class="row">
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="IDNumber" style="">身份证号</span>
				</div>
				<div id="control4" class="col-md-10">
					<input id="Control14" type="text" data-datafield="IDNumber" data-type="SheetTextBox" style="" class="" data-vaildationrule="/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ProfessionField" style="">专业领域</span>
				</div>
				<div id="control5" class="col-md-10">
					<div data-datafield="ProfessionField" data-type="SheetCheckboxList" id="ctl574790" class="" style="" data-repeatcolumns="3" data-masterdatacategory="专家的专业领域"></div>
				</div>
			</div>
			<div class="row">
				
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="ProfessionalRanks" style="">职称</span>
				</div>
				<div id="control6" class="col-md-10">
					<input id="Control16" type="text" data-datafield="ProfessionalRanks" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Unit" style="">单位</span>
				</div>
				<div id="control7" class="col-md-10">
					<input id="Control17" type="text" data-datafield="Unit" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title8" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="Telephone" style="">电话</span>
				</div>
				<div id="control8" class="col-md-10">
					<input id="Control18" type="text" data-datafield="Telephone" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="Phone" style="">手机</span>
				</div>
				<div id="control9" class="col-md-10">
					<input id="Control19" type="text" data-datafield="Phone" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title10" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="Fix" style="">传真</span>
				</div>
				<div id="control10" class="col-md-10">
					<input id="Control20" type="text" data-datafield="Fix" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="Email" style="">邮箱</span>
				</div>
				<div id="control11" class="col-md-10">
					<input id="Control21" type="text" data-datafield="Email" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title12" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="Address" style="">住址</span>
				</div>
				<div id="control12" class="col-md-10">
					<input id="Control22" type="text" data-datafield="Address" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title13" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="Remarks" style="">备注</span>
				</div>
				<div id="control13" class="col-md-10">
					<textarea id="Control23" data-datafield="Remarks" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
			</div>
			<div class="row">
				<div id="title15" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="BankOfDeposit" style="">开户银行</span>
				</div>
				<div id="control15" class="col-md-10">
					<input id="Control24" type="text" data-datafield="BankOfDeposit" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">	
				<div id="title16" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="BankAccount" style="">银行账号</span>
				</div>
				<div id="control16" class="col-md-10">
					<input id="Control25" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="">
				</div>
			</div>
           
		</div>
	</div>
</asp:Content>