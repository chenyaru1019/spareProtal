<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SEmployeeLeaveRequest.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SEmployeeLeaveRequest" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
        
</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">员工请假申请</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="ParticularYear" style="">年份</span>
				</div>
				<div id="control1" class="col-md-7">
					<input id="Control11" type="text" data-datafield="ParticularYear" data-type="SheetTextBox" style="">
				</div>
				<div id="control2" class="col-md-3">
					<input type="text" data-datafield="SurplusDaysBeforeApplying" data-type="SheetTextBox" id="ctl280941" class="" style="">
				</div>
			</div>
			<div class="row">
				<div id="div346333" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="HolidayType" style="" class="">假期类型</span>
				</div>
				<div id="div401341" class="col-md-7">
					<select data-datafield="HolidayType" data-type="SheetDropDownList" id="ctl788456" class="" style="" data-masterdatacategory="员工假期类型" data-displayemptyitem="true" data-onchange="ChangeHolidayType()">
					</select>
				</div>
				<div id="div982279" class="col-md-3">
				</div>
			</div>
         
			<div class="row">
				<div id="div298671" class="col-md-2">
					<label data-datafield="LeaveDetails" data-type="SheetLabel" id="ctl794432" class="" style="">请假明细</label>
				</div>
				<div id="div998471" class="col-md-7">
					<table id="ctl170713" data-datafield="LeaveDetails" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0">
						<tbody>
							<tr class="header">
								<td id="ctl170713_SerialNo" class="rowSerialNo" style="width:10%">序号</td>
								<td id="ctl170713_header0" data-datafield="LeaveDetails.LeaveDate" style="width:20%">
									<label id="ctl170713_Label0" data-datafield="LeaveDetails.LeaveDate" data-type="SheetLabel" style="">请假日期
									</label>
								</td>
								<td id="ctl170713_header1" data-datafield="LeaveDetails.Type" style="width:25%">
									<label id="ctl170713_Label1" data-datafield="LeaveDetails.Type" data-type="SheetLabel" style="">类型</label>
								</td>
								<td id="ctl170713_header2" data-datafield="LeaveDetails.NumberOfDays" style="width:10%">
									<label id="ctl170713_Label2" data-datafield="LeaveDetails.NumberOfDays" data-type="SheetLabel" style="">天数</label>
								</td>
								<td id="ctl170713_header3" data-datafield="LeaveDetails.Years" style="width:15%">
									<label id="ctl170713_Label3" data-datafield="LeaveDetails.Years" data-type="SheetLabel" style="">年度</label>
								</td>
								<td class="rowOption" style="width:20%">删除</td>
							</tr>
							<tr class="template">
								<td></td>
								<td id="ctl170713_control0" data-datafield="LeaveDetails.LeaveDate" style="">
									<input type="text" data-datafield="LeaveDetails.LeaveDate" data-type="SheetTime" id="ctl170713_contro1l0" style="" data-defaultvalue=""  data-onchange="ChangeLeaveDate(this)" onfocus="FocusHolidayType()">
								</td>
								<td id="ctl170713_control1" data-datafield="LeaveDetails.Type" style="">
									<select data-datafield="LeaveDetails.Type" data-type="SheetDropDownList" id="SelectType" class="" style="" data-masterdatacategory="员工请假周期类型"  onchange="ChangeType(this)">
									</select>
								</td>
								<td id="ctl170713_control2" data-datafield="LeaveDetails.NumberOfDays" style="">
									<input type="text" data-datafield="LeaveDetails.NumberOfDays" data-type="SheetTextBox" id="ctl170713_control12" style="" readonly>
								</td>
								<td id="ctl170713_control3" data-datafield="LeaveDetails.Years" style="">
									<input type="text" data-datafield="LeaveDetails.Years" data-type="SheetTextBox" id="ctl170713_control13" style="" readonly>
								</td>
								<td class="rowOption">
									<a class="delete">
										<div class="fa fa-minus"></div>
									</a>
									<a class="insert">
										<div class="fa fa-arrow-down"></div>
									</a>
								</td>
							</tr>
							<tr class="footer">
								<td></td>
								<td id="ctl170713_Stat0" data-datafield="LeaveDetails.LeaveDate" style="" class="">
								</td>
								<td id="ctl170713_Stat1" data-datafield="LeaveDetails.Type" style="" class="">
								</td>
								<td id="ctl170713_Stat2" data-datafield="LeaveDetails.NumberOfDays" style="" class="">
									<label id="ctl170713_StatControl2" data-datafield="LeaveDetails.NumberOfDays" data-type="SheetCountLabel" style=""></label>
								</td>
								<td id="ctl170713_Stat3" data-datafield="LeaveDetails.Years" style="" class="">
								</td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="div100393" class="col-md-3">
				</div>
			</div>
			
			<div class="row">
				<div id="div502951" class="col-md-2">
					<label data-datafield="AskForLeave" data-type="SheetLabel" id="ctl604832" class="" style="">请假开始</label>
				</div>
				<div id="div872511" class="col-md-7">
					<input type="text" data-datafield="AskForLeave" data-type="SheetTextBox" id="ctl261991" class="" style="width: 40%;" >至
					<input type="text" data-datafield="EndTime" data-type="SheetTextBox" id="ctl967501" class="" style="width: 40%;" data-defaultvalue="" >结束
				</div>
				<div id="div125774" class="col-md-3">
					<input type="text" data-datafield="SurplusDaysAfterApplying" data-type="SheetTextBox" id="ctl941941" class="" style="">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="ReasonForLeave" style="">请假事由</span>
				</div>
				<div id="control9" class="col-md-7">
					<textarea id="Control19" data-datafield="ReasonForLeave" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
				<div id="div100394" class="col-md-3">
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="AttachmentUpload" style="">附件上传</span>
				</div>
				<div id="control11" class="col-md-7">
					<div id="Control20" data-datafield="AttachmentUpload" data-type="SheetAttachment" style=""></div>
				</div>
				<div id="div100395" class="col-md-3">
				</div>
			</div>
			<div class="row">
				
				<div id="title14" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="ApplicationDate" style="">申请日期</span>
				</div>
				<div id="control14" class="col-md-4">
					<input id="Control22" type="text" data-datafield="ApplicationDate" data-type="SheetTime" style="">
				</div>
                <div id="title15" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="ApplicationNumber" style="">申请编号</span>
				</div>
				<div id="control15" class="col-md-4">
					<input id="Control23" type="text" data-datafield="ApplicationNumber" data-type="SheetTextBox" style="" readonly="">
				</div>
			</div>
			
			<div class="row tableContent">
				<div id="title17" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="DepartmentHeadsOpinions" style="">部门负责人意见</span>
				</div>
				<div id="control17" class="col-md-7">
					<div id="Control24" data-datafield="DepartmentHeadsOpinions" data-type="SheetComment" style=""></div>
				</div>
				<div id="spaceControl17" class="col-md-3">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title19" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="InChargeLeaderApprovalOpinions" style="">分管领导审批意见</span>
				</div>
				<div id="control19" class="col-md-7">
					<div id="Control25" data-datafield="InChargeLeaderApprovalOpinions" data-type="SheetComment" style=""></div>
				</div>
				<div id="spaceControl18" class="col-md-3">
				</div>
			</div>
			<div class="row">
                <div id="title13" class="col-md-2">
					
				<label data-datafield="Applicant" data-type="SheetLabel" id="ctl974221" class="" style="">申请人</label>
				</div>
				<div id="control13" class="col-md-4">
					<div data-datafield="Applicant" data-type="SheetUser" id="ctl105321" class="" style="" ></div>
				</div>
				
				<div id="div309045" class="col-md-2">
				</div>
				<div id="div608945" class="col-md-4">
				</div>
			</div>
            <div class="row hidden">
                <div id="div521376" class="col-md-1">
					<label data-datafield="SumApplyDays" data-type="SheetLabel" id="ctl745200" class="" style="">本次申请的天数
					</label>
				</div>
				<div id="div282873" class="col-md-3">
					<input type="text" data-datafield="SumApplyDays" data-type="SheetTextBox" id="ctl500673" class="" style="" data-computationrule="1,SUM({LeaveDetails.NumberOfDays})" data-onchange="ChangeSumApplyDays()">
				</div>
            </div>
         </div>
	</div>
</div>
	<script src="SEmployeeLeaveRequest.js"></script>
</asp:Content>