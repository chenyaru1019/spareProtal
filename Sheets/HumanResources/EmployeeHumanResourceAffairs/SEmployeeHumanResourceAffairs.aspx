<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SEmployeeHumanResourceAffairs.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SEmployeeHumanResourceAffairs" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="SEmployeeHumanResourceAffairs.js"></script>
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">办公室人力资源事务</label>
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
					<span id="Label11" data-type="SheetLabel" data-datafield="BusinessType" style="">业务类型</span>
				</div>
				<div id="control1" class="col-md-4">
					
				<select data-datafield="BusinessType" data-type="SheetDropDownList" id="ctl931875" class="" style="" data-masterdatacategory="员工人力资源事务的业务类型"></select></div>
			
			</div>
			<div class="row">
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Title" style="">标题</span>
				</div>
				<div id="control2" class="col-md-10">
					<input id="Control12" type="text" data-datafield="Title" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="IntendToMakeComments" style="">拟办意见</span>
				</div>
				<div id="control3" class="col-md-10">
					
				<div data-datafield="IntendToMakeComments" data-type="SheetComment" id="ctl637126" class="" style=""></div></div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="AttachmentUpload" style="">附件上传</span>
				</div>
				<div id="control5" class="col-md-10">
					<div id="Control14" data-datafield="AttachmentUpload" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ApplicationNumber" style="">申请编号</span>
				</div>
				<div id="control7" class="col-md-4">
					<input id="Control15" type="text" data-datafield="ApplicationNumber" data-type="SheetTextBox" style="" readonly="readonly">
				</div>
				<div id="space10" class="col-md-2">
					<%--<input id="generateEmployeeHumanNoId" type="button" onclick="generateEmployeeHumanNo()" value="自动生成编号" class="btn btn-primary" />--%>
				</div>
				<div id="spaceControl10" class="col-md-4">
				</div>
			</div>
			<div class="row">
				<div id="title8" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="Applicant" style="">申请人</span>
				</div>
				<div id="control8" class="col-md-4">
					<div id="Control16" data-datafield="Applicant" data-type="SheetUser" style=""></div>
				</div>
				<div id="title9" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="ApplicationDate" style="">申请日期</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control17" type="text" data-datafield="ApplicationDate" data-type="SheetTime" style="">
				</div>
				
			</div>
            <div class="row">
                <div id="div205968" class="col-md-2">
                    <label data-datafield="DepartmentsJointlySign" data-type="SheetLabel" id="ctl390333" class="" style="">相关部门会签
                    </label>
                </div>
                <div id="div627458" class="col-md-10">
                    <div data-datafield="DepartmentsJointlySign" data-type="SheetUser" id="ctl9004" class="" style="">
                    </div>
                </div>
            </div>
            <div class="row FirstGradeCountersignedOpinion">
                <div id="div168269" class="col-md-2">
                    <label data-datafield="FirstGradeCountersignedOpinion" data-type="SheetLabel" id="ctl92951" class="" style="">一级会签意见
                    </label>
                </div>
                <div id="div428995" class="col-md-10">
					
				<div data-datafield="FirstGradeCountersignedOpinion" data-type="SheetComment" id="ctl38122" class="" style=""></div></div>
            </div>
            <div class="row">
                <div id="div556058" class="col-md-2">
                    <label data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetLabel" id="ctl803005" class="" style="">分管领导审批意见
                    </label>
                </div>
               <div id="div466128" class="col-md-10">
					
				<div data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetComment" id="ctl842813" class="" style=""></div></div>
            </div>
            <div class="row TwoLevelCountersignedPersonnel">
                <div id="div360971" class="col-md-2">
                    <label data-datafield="TwoLevelCountersignedPersonnel" data-type="SheetLabel" id="ctl263792" class="" style="">二级会签人员
                    </label>
                </div>
                <div id="div91035" class="col-md-10">
                    <div data-datafield="TwoLevelCountersignedPersonnel" data-type="SheetUser" id="ctl28909" class="" style="">
                    </div>
                </div>
            </div>
            <div class="row TwoLevelCountersignedOpinion">
                <div id="div171237" class="col-md-2">
                    <label data-datafield="TwoLevelCountersignedOpinion" data-type="SheetLabel" id="ctl129302" class="" style="">二级会签意见
                    </label>
                </div>
               <div id="div672797" class="col-md-10">
					
				<div data-datafield="TwoLevelCountersignedOpinion" data-type="SheetComment" id="ctl719398" class="" style=""></div></div>
            </div>
            <div class="row">
                <div id="div834759" class="col-md-2">
                    <label data-datafield="GeneralManagerApprovalOpinion" data-type="SheetLabel" id="ctl646732" class="" style="">总经理审批意见
                    </label>
                </div>
               <div id="div135371" class="col-md-10">
					
				<div data-datafield="GeneralManagerApprovalOpinion" data-type="SheetComment" id="ctl125644" class="" style=""></div></div>
            </div>
            <div class="row">
				<div id="div244527" class="col-md-2">
					<label data-datafield="OfficeComplete" data-type="SheetLabel" id="ctl349049" class="" style="">综合办公室办结意见
					</label>
				</div>
				<div id="div541854" class="col-md-10">
					<div data-datafield="OfficeComplete" data-type="SheetComment" id="ctl727018" class="" style="">
					</div>
				</div>
			</div>
		    <div class="row hidden">
				<div id="div317630" class="col-md-2">
					<label data-datafield="DepartmentsJointlySignButton" data-type="SheetLabel" id="ctl190870" class="" style="">相关部门会签按钮
					</label>
				</div>
				<div id="div933713" class="col-md-4">
					<input type="text" data-datafield="DepartmentsJointlySignButton" data-type="SheetTextBox" id="ctl47985" class="" style="">
				</div>
				<div id="div509992" class="col-md-2">
					<label data-datafield="TwoLevelCountersignedButton" data-type="SheetLabel" id="ctl137715" class="" style="">二级会签按钮
					</label>
				</div>
				<div id="div286740" class="col-md-4">
					<input type="text" data-datafield="TwoLevelCountersignedButton" data-type="SheetTextBox" id="ctl644035" class="" style="">
				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>