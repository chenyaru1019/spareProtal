<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SEmployeeTurnoverApplication.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SEmployeeTurnoverApplication" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="SEmployeeTurnoverApplication.js"></script>
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">员工离职申请审批</label>
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
					
				<input type="text" data-datafield="Hiredate" data-type="SheetTextBox" id="ctl394186" class="" style="" readonly></div>
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
					<%--<div id="Control26" data-datafield="Photo" data-type="SheetAttachment" style="">
					</div>--%>
					 <img id="userFace" src="/Portal/img/TempImages/usermale.jpg" height="120" width="100" onerror="imgerror(this)">	
				</div>
			</div>
			<div class="row tableContent">
				<div id="title19" class="col-md-2">
					<span id="Label27" data-type="SheetLabel" data-datafield="ReasonsForLeaving" style="">离职原因</span>
				</div>
				<div id="control19" class="col-md-10">
					<textarea id="Control27" data-datafield="ReasonsForLeaving" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
			</div>
           	<div class="row DepartmentsJointlySign">
				<div id="div383006" class="col-md-2">
					<label data-datafield="DepartmentsJointlySign" data-type="SheetLabel" id="ctl67881" class="" style="">相关部门会签
					</label>
				</div>
				<div id="div554084" class="col-md-10">
					<div data-datafield="DepartmentsJointlySign" data-type="SheetUser" id="ctl192110" class="" style="">
					</div>
				</div>
			</div>
			<div class="row FirstGradeCountersignedOpinion">
				<div id="div320044" class="col-md-2">
					<label data-datafield="FirstGradeCountersignedOpinion" data-type="SheetLabel" id="ctl742420" class="" style="">一级会签意见
					</label>
				</div>
				<div id="div615529" class="col-md-10">
					<div data-datafield="FirstGradeCountersignedOpinion" data-type="SheetComment" id="ctl780591" class="" style="">
					</div>
				</div>
			</div>
			<div class="row TwoLevelCountersignedPersonnel">
				<div id="div955467" class="col-md-2">
					<label data-datafield="TwoLevelCountersignedPersonnel" data-type="SheetLabel" id="ctl986345" class="" style="">二级会签人员
					</label>
				</div>
				<div id="div328702" class="col-md-10">
					<div data-datafield="TwoLevelCountersignedPersonnel" data-type="SheetUser" id="ctl322634" class="" style="">
					</div>
				</div>
			</div>
			<div class="row TwoLevelCountersignedOpinion">
				<div id="div474122" class="col-md-2">
					<label data-datafield="TwoLevelCountersignedOpinion" data-type="SheetLabel" id="ctl601057" class="" style="">二级会签意见
					</label>
				</div>
				<div id="div988796" class="col-md-10">
					<div data-datafield="TwoLevelCountersignedOpinion" data-type="SheetComment" id="ctl625072" class="" style="">
					</div>
				</div>
			</div>
			<div class="row">
				<div id="div217175" class="col-md-2">
					<label data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetLabel" id="ctl120365" class="" style="">分管领导审批意见
					</label>
				</div>
				<div id="div493795" class="col-md-10">
					<div data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetComment" id="ctl732212" class="" style="">
					</div>
				</div>
			</div>
			<div class="row">
				<div id="div490111" class="col-md-2">
					<label data-datafield="GeneralManagerApprovalOpinion" data-type="SheetLabel" id="ctl991707" class="" style="">总经理审批意见
					</label>
				</div>
				<div id="div319606" class="col-md-10">
					<div data-datafield="GeneralManagerApprovalOpinion" data-type="SheetComment" id="ctl677946" class="" style="">
					</div>
				</div>
			</div>
			<div class="row">
				<div id="div739635" class="col-md-2">
					<label data-datafield="OfficeComplete" data-type="SheetLabel" id="ctl593961" class="" style="">综合办公室办结意见
					</label>
				</div>
				<div id="div876671" class="col-md-10">
					<div data-datafield="OfficeComplete" data-type="SheetComment" id="ctl68691" class="" style="">
					</div>
				</div>
			</div>
			<div class="row hidden">
				<div id="div798896" class="col-md-2">
					<label data-datafield="DepartmentsJointlySignButton" data-type="SheetLabel" id="ctl167352" class="" style="">相关部门会签按钮
					</label>
				</div>
				<div id="div55858" class="col-md-4">
					<input type="text" data-datafield="DepartmentsJointlySignButton" data-type="SheetTextBox" id="ctl693037" class="" style="">
				</div>
				<div id="div918444" class="col-md-2">
					<label data-datafield="TwoLevelCountersignedButton" data-type="SheetLabel" id="ctl543124" class="" style="">二级会签按钮
					</label>
				</div>
				<div id="div128083" class="col-md-4">
					<input type="text" data-datafield="TwoLevelCountersignedButton" data-type="SheetTextBox" id="ctl241608" class="" style="">
				</div>
			</div>
            <div class="row hidden">
                 <div id="div306183" class="col-md-2">
                     <label data-datafield="OrgId" data-type="SheetLabel" id="ctl847322" class="" style="">员工的OrgId

                    </label>
                </div>
                <div id="div645295" class="col-md-4">
                     <input type="text" data-datafield="OrgId" data-type="SheetTextBox" id="ctl975377" class="" style="" >

                </div>
                <div id="div335832" class="col-md-2">
                    <label data-datafield="StaffObjectId" data-type="SheetLabel" id="ctl847321" class="" style="">员工的objectId

                    </label>

                </div>
                <div id="div770980" class="col-md-4">
                    <input type="text" data-datafield="StaffObjectId" data-type="SheetTextBox" id="ctl975376" class="" style="" data-onchange="GetPhoto()">

                </div>
               

            </div>
			
		</div>
	</div>
</div>
</asp:Content>