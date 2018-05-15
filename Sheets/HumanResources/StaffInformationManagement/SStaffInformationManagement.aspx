<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SStaffInformationManagement.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SStaffInformationManagement" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
$.MvcSheet.SaveAction.OnActionPreDo = function () {
    var StaffName = $.MvcSheetUI.GetControlValue("StaffName");
    var Sex = $.MvcSheetUI.GetControlValue("Sex");
    var Organization = $.MvcSheetUI.GetControlValue("Organization");
    var StaffRole = $.MvcSheetUI.GetControlValue("StaffRole");
    var ImmediateSuperior = $.MvcSheetUI.GetControlValue("ImmediateSuperior");
    var CantonalLeaders = $.MvcSheetUI.GetControlValue("CantonalLeaders");
    var Hiredate = $.MvcSheetUI.GetControlValue("Hiredate");
    var OperativeMode = $.MvcSheetUI.GetControlValue("OperativeMode");
    if (StaffName == '') {
        alert("员工姓名不能为空！");
        return false;
    }
    if (Sex == '') {
        alert("性别不能为空！");
        return false;
    }
    if (Organization == '') {
        alert("机构不能为空！");
        return false;
    }
    if (StaffRole == '') {
        alert("角色不能为空！");
        return false;
    }
    if (ImmediateSuperior == '') {
        alert("直接上级不能为空！");
        return false;
    }
    if (CantonalLeaders == '') {
        alert("分管领导不能为空！");
        return false;
    }
    if (Hiredate == '') {
        alert("入职时间不能为空！");
        return false;
    }
}
</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="SStaffInformationManagement.js"></script>
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">员工信息管理</label>
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
					
				<div data-datafield="StaffName" data-type="SheetUser" id="ctl47841" class="" style="" data-mappingcontrols="StaffName:Name,Sex:Gender,OrgID:ParentID,ImmediateSuperior:ManagerID,Hiredate:EntryDate,OperativeMode:ServiceState,Telephone:OfficePhone,MobilePhone:Mobile,RoleId:ObjectID,StaffObjectId:ObjectID" ></div></div>
				
			</div>
			<div class="row">
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Sex" style="">性别</span>
				</div>
				<div id="control2" class="col-md-4">
					
				<select data-datafield="Sex" data-type="SheetDropDownList" id="ctl435058" class="" style="" data-masterdatacategory="性别"></select></div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="Organization" style="">机构</span>
				</div>
				<div id="control3" class="col-md-4">
					
				<select data-datafield="Organization" data-type="SheetDropDownList" id="ctl922752" class="" style="" data-schemacode="GetOrgNameByID" data-querycode="GetOrgNameByID" data-filter="OrgID:id" data-datavaluefield="Name1" data-datatextfield="Name1" ></select></div>
				
			</div>
			<div class="row">
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="StaffRole" style="">角色</span>
				</div>
				<div id="control4" class="col-md-4">
					
				<select data-datafield="StaffRole" data-type="SheetDropDownList" id="ctl102142" class="" style="" data-schemacode="GetRoleByUserObjectId" data-querycode="GetRoleByUserObjectId" data-filter="RoleId:userID" data-datavaluefield="Name1" data-datatextfield="Name1"></select></div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ImmediateSuperior" style="">直接上级</span>
				</div>
				<div id="control5" class="col-md-4">
					<div id="Control15" data-datafield="ImmediateSuperior" data-type="SheetUser" style="" class="" data-uservisible="false" data-groupvisible="true"></div>
				</div>
				
			</div>
			<div class="row">
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="CantonalLeaders" style="">分管领导</span>
				</div>
				<div id="control6" class="col-md-4">
					<div id="Control16" data-datafield="CantonalLeaders" data-type="SheetUser" style=""></div>
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Hiredate" style="">入职时间</span>
				</div>
				<div id="control7" class="col-md-4">
					<input id="Control17" type="text" data-datafield="Hiredate" data-type="SheetTime" style="">
				</div>
				
			</div>
			<div class="row">
				<div id="title8" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="OperativeMode" style="">工作状况</span>
				</div>
				<div id="control8" class="col-md-4">
					
				<select data-datafield="OperativeMode" data-type="SheetDropDownList" id="ctl147305" class="" style="" data-masterdatacategory="工作状况"></select></div>
			</div>
			<div class="row">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="Telephone" style="">电话</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control19" type="text" data-datafield="Telephone" data-type="SheetTextBox" style="">
				</div>
				
			</div>
			<div class="row">
				<div id="title10" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="Nation" style="">民族</span>
				</div>
				<div id="control10" class="col-md-4">
					<input id="Control20" type="text" data-datafield="Nation" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="PoliticalStatus" style="">政治面貌</span>
				</div>
				<div id="control11" class="col-md-4">
					<input id="Control21" type="text" data-datafield="PoliticalStatus" data-type="SheetTextBox" style="">
				</div>
				
			</div>
			<div class="row">
				<div id="title12" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="HealthCondition" style="">健康状况</span>
				</div>
				<div id="control12" class="col-md-4">
					<input id="Control22" type="text" data-datafield="HealthCondition" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title13" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="MobilePhone" style="">手机</span>
				</div>
				<div id="control13" class="col-md-4">
					<input id="Control23" type="text" data-datafield="MobilePhone" data-type="SheetTextBox" style="">
				</div>
				
			</div>
			<div class="row">
				<div id="title14" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="NativePlace" style="">籍贯</span>
				</div>
				<div id="control14" class="col-md-4">
					<input id="Control24" type="text" data-datafield="NativePlace" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title15" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="MaritalStatus" style="">婚姻状况</span>
				</div>
				<div id="control15" class="col-md-4">
					<input id="Control25" type="text" data-datafield="MaritalStatus" data-type="SheetTextBox" style="">
				</div>
				
			</div>
			<div class="row">
				<div id="title16" class="col-md-2">
					<span id="Label26" data-type="SheetLabel" data-datafield="CriminalRecord" style="">有无犯罪记录</span>
				</div>
				<div id="control16" class="col-md-4">
					<input id="Control26" type="text" data-datafield="CriminalRecord" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title17" class="col-md-2">
					<span id="Label27" data-type="SheetLabel" data-datafield="Photo" style="">照片</span>
				</div>
				<div id="control17" class="col-md-10">
					<!--<label class="col-md-10 control-label alignLeft">
						<input type="file" id="fileUserFace" name="fileUserFace" style="display:none">
						<div>
							<img id="userFace" style="" width="100" height="120" src="../WFRes/images/person.gif" alt="点击图片上传" title="点击图片上传">
						</div>
					</label>-->
                    <img id="userFace" src="/Portal/img/TempImages/usermale.jpg" height="120" width="100" onerror="imgerror(this)">
					<!--<img id="userFace" width="100" height="120" src="/Portal/img/TempImages/usermale.jpg">-->
					<!--<div id="Control27" data-datafield="Photo" data-type="SheetAttachment" style=""></div>-->
				</div>
			</div>
			<div class="row">
				<div id="title19" class="col-md-2">
					<span id="Label28" data-type="SheetLabel" data-datafield="Attachment" style="">附件</span>
				</div>
				<div id="control19" class="col-md-10">
					<div id="Control28" data-datafield="Attachment" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row hidden">
				<div id="div487690" class="col-md-1">
					<label data-datafield="OrgID" data-type="SheetLabel" id="ctl104346" class="" style="">机构ID
					</label>
				</div>
				<div id="div444893" class="col-md-1">
					<input type="text" data-datafield="OrgID" data-type="SheetTextBox" id="ctl144441" class="" style="">
				</div>
				<div id="div137662" class="col-md-1">
					<label data-datafield="RoleId" data-type="SheetLabel" id="ctl654571" class="" style="">角色ID
					</label>
				</div>
				<div id="div162648" class="col-md-1">
					<input type="text" data-datafield="RoleId" data-type="SheetTextBox" id="ctl92843" class="" style="" data-onchange="GetPhoto()">
				</div>
				<div id="div162640" class="col-md-1 ControlContainer">
					<input type="text" data-datafield="PhotoStorageDirectory" data-type="SheetTextBox" id="ctl92840" class="" style="">
					
				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>