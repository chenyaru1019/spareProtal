<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SStaffProbationaryPeriod.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SStaffProbationaryPeriod" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="SStaffProbationaryPeriod.js"></script>
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">员工试用期转正</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="StaffName" style="">员工姓名</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="StaffName" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetInformationByStaffName" data-querycode="GetInformationByStaffName" data-outputmappings="StaffName:Name1,Sex:Sex,Organization:Organization,StaffRole:StaffRole,ImmediateSuperior:ManagerID,CantonalLeaders:CantonalLeaders,Hiredate:Hiredate,Telephone:Telephone,Nation:Nation,PoliticalStatus:PoliticalStatus,HealthCondition:HealthCondition,MobilePhone:MobilePhone,NativePlace:NativePlace,MaritalStatus:MaritalStatus,CriminalRecord:CriminalRecord,OrgId:OrgID,StaffObjectId:StaffObjectId">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Sex" style="">性别</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="Sex" data-type="SheetTextBox" style="" readonly>
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="Organization" style="">机构</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="Organization" data-type="SheetTextBox" style="" readonly>
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="StaffRole" style="">角色</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="StaffRole" data-type="SheetTextBox" style="" readonly>
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ImmediateSuperior" style="">直接上级</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="ImmediateSuperior" data-type="SheetTextBox" style="" readonly>
				</div>
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="CantonalLeaders" style="">分管领导</span>
				</div>
				<div id="control6" class="col-md-4">
					<input id="Control16" type="text" data-datafield="CantonalLeaders" data-type="SheetTextBox" style="" readonly>
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Hiredate" style="">入职时间</span>
				</div>
				<div id="control7" class="col-md-4">
					<input id="Control17" type="text" data-datafield="Hiredate" data-type="SheetTextBox" style="" readonly>
				</div>
				<div id="title8" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="Telephone" style="">电话</span>
				</div>
				<div id="control8" class="col-md-4">
					<input id="Control18" type="text" data-datafield="Telephone" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="Nation" style="">民族</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control19" type="text" data-datafield="Nation" data-type="SheetTextBox" style="">
				</div>
				<div id="title10" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="PoliticalStatus" style="">政治面貌</span>
				</div>
				<div id="control10" class="col-md-4">
					<input id="Control20" type="text" data-datafield="PoliticalStatus" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="HealthCondition" style="">健康状况</span>
				</div>
				<div id="control11" class="col-md-4">
					<input id="Control21" type="text" data-datafield="HealthCondition" data-type="SheetTextBox" style="">
				</div>
				<div id="title12" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="MobilePhone" style="">手机</span>
				</div>
				<div id="control12" class="col-md-4">
					<input id="Control22" type="text" data-datafield="MobilePhone" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title13" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="NativePlace" style="">籍贯</span>
				</div>
				<div id="control13" class="col-md-4">
					<input id="Control23" type="text" data-datafield="NativePlace" data-type="SheetTextBox" style="">
				</div>
				<div id="title14" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="MaritalStatus" style="">婚姻状况</span>
				</div>
				<div id="control14" class="col-md-4">
					<input id="Control24" type="text" data-datafield="MaritalStatus" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title15" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="CriminalRecord" style="">有无犯罪记录</span>
				</div>
				<div id="control15" class="col-md-4">
					<input id="Control25" type="text" data-datafield="CriminalRecord" data-type="SheetTextBox" style="">
				</div>
				<div id="space16" class="col-md-2">
				</div>
				<div id="spaceControl16" class="col-md-4">
				</div>
			</div>
			<div class="row">
				<div id="title17" class="col-md-2">
					<span id="Label26" data-type="SheetLabel" data-datafield="Photo" style="">照片</span>
				</div>
				<div id="control17" class="col-md-10">
					<%--<div id="Control26" data-datafield="Photo" data-type="SheetAttachment" style=""></div>--%>
                     <img id="userFace" src="/Portal/img/TempImages/usermale.jpg" height="120" width="100" onerror="imgerror(this)">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title19" class="col-md-2">
					<span id="Label27" data-type="SheetLabel" data-datafield="TalkingAboutGraphsAndTrends" style="">工作小结</span>
				</div>
				<div id="control19" class="col-md-10">
					<textarea id="Control27" data-datafield="TalkingAboutGraphsAndTrends" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
			</div>
			<div class="row DepartmentsJointlySign">
				<div id="title21" class="col-md-2">
					<span id="Label28" data-type="SheetLabel" data-datafield="DepartmentsJointlySign" style="">相关部门会签</span>
				</div>
				<div id="control21" class="col-md-4">
					<div id="Control28" data-datafield="DepartmentsJointlySign" data-type="SheetUser" style=""></div>
				</div>
				<div id="space22" class="col-md-2">
				</div>
				<div id="spaceControl22" class="col-md-4">
				</div>
			</div>
			<div class="row CountersignedOpinion">
				<div id="title23" class="col-md-2">
					<span id="Label29" data-type="SheetLabel" data-datafield="CountersignedOpinion" style="">会签意见</span>
				</div>
				<div id="control23" class="col-md-10">
					<div id="Control29" data-datafield="CountersignedOpinion" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title25" class="col-md-2">
					<span id="Label30" data-type="SheetLabel" data-datafield="ComprehensiveAuditOffice" style="">综合办公室审核</span>
				</div>
				<div id="control25" class="col-md-10">
					<div id="Control30" data-datafield="ComprehensiveAuditOffice" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title27" class="col-md-2">
					<span id="Label31" data-type="SheetLabel" data-datafield="InChargeLeaderApprovalOpinions" style="">分管领导审批意见</span>
				</div>
				<div id="control27" class="col-md-10">
					<div id="Control31" data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title29" class="col-md-2">
					<span id="Label32" data-type="SheetLabel" data-datafield="GeneralManagerApprovalOpinion" style="">总经理审批意见</span>
				</div>
				<div id="control29" class="col-md-10">
					<div id="Control32" data-datafield="GeneralManagerApprovalOpinion" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title31" class="col-md-2">
					<span id="Label33" data-type="SheetLabel" data-datafield="OfficeComplete" style="">综合办公室办结意见</span>
				</div>
				<div id="control31" class="col-md-10">
					<div id="Control33" data-datafield="OfficeComplete" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row hidden">
				<div id="title33" class="col-md-2">
					<span id="Label34" data-type="SheetLabel" data-datafield="DepartmentsJointlySignButton" style="">相关部门会签按钮</span>
				</div>
				<div id="control33" class="col-md-4">
					<input id="Control34" type="text" data-datafield="DepartmentsJointlySignButton" data-type="SheetTextBox" style="">
				</div>
                <div id="div306183" class="col-md-1">
                     <label data-datafield="OrgId" data-type="SheetLabel" id="ctl847322" class="" style="">员工的OrgId
                    </label>
                </div>
                <div id="div645295" class="col-md-1">
                     <input type="text" data-datafield="OrgId" data-type="SheetTextBox" id="ctl975377" class="" style="" >
                </div>
				<div id="space34" class="col-md-1">
				    <label data-datafield="StaffObjectId" data-type="SheetLabel" id="ctl415298" class="" style="">员工的objectId</label>
				</div>
				<div id="spaceControl34" class="col-md-1">
				    <input type="text" data-datafield="StaffObjectId" data-type="SheetTextBox" id="ctl400278" class="" style=""  data-onchange="GetPhoto()">
				</div>
                 
			</div>
		</div>
	</div>
</div>
</asp:Content>