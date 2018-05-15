﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SEmployeeOvertimeApplication.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SEmployeeOvertimeApplication" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">员工加班申请</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="StartTime" style="">开始时间</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="StartTime" data-type="SheetTextBox" style="" class="" data-wdatepickerjson="{dateFmt:'yyyy-MM'}" onclick="WdatePicker({ dateFmt: 'yyyy-MM' })" data-defaultvalue="">
				</div>
				<div id="space2" class="col-md-2">
				</div>
				<div id="spaceControl2" class="col-md-4">
				</div>
			</div>
			<div class="row tableContent">
				<div id="title3" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="OvertimeWork" style="">加班事由</span>
				</div>
				<div id="control3" class="col-md-4">
					<textarea id="Control12" data-datafield="OvertimeWork" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
                <div class ="col-md-6">
                    <span id="Labela" data-type="SheetLabel">
                    加班补偿类型3种：<br />
                    1、法定节日加班：按规定支付3倍加班费补偿 <br />
                    2、双休日加班：按规定给予补休补偿 <br />
                    3、延长工作时间加班：员工自行选择补休或者选择1.5倍加班费补偿 <br />
                    </span>
                </div>
			</div>
			<div class="row tableContent">
				<div id="title5" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="OvertimeDetail" style="">加班详细</span>
				</div>
				<div id="control5" class="col-md-10">
					<table id="Control13" data-datafield="OvertimeDetail" data-type="SheetGridView" class="SheetGridView" data-defaultrowcount="0">
						<tbody>
							
							<tr class="header">
								<td id="Control13_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control13_Header3" data-datafield="OvertimeDetail.OvertimeDate">
									<label id="Control13_Label3" data-datafield="OvertimeDetail.OvertimeDate" data-type="SheetLabel" style="">加班日期</label>
								</td>
								<td id="Control13_Header4" data-datafield="OvertimeDetail.StartTime">
									<label id="Control13_Label4" data-datafield="OvertimeDetail.StartTime" data-type="SheetLabel" style="">开始时间</label>
								</td>
								<td id="Control13_Header5" data-datafield="OvertimeDetail.EndTime">
									<label id="Control13_Label5" data-datafield="OvertimeDetail.EndTime" data-type="SheetLabel" style="">结束时间</label>
								</td>
								<td id="Control13_Header6" data-datafield="OvertimeDetail.OvertimeHours">
									<label id="Control13_Label6" data-datafield="OvertimeDetail.OvertimeHours" data-type="SheetLabel" style="">加班小时</label>
								</td>
								<td id="Control13_Header7" data-datafield="OvertimeDetail.OvertimeType">
									<label id="Control13_Label7" data-datafield="OvertimeDetail.OvertimeType" data-type="SheetLabel" style="">加班类型</label>
								</td>
								<td id="Control13_Header8" data-datafield="OvertimeDetail.CompensationMode">
									<label id="Control13_Label8" data-datafield="OvertimeDetail.CompensationMode" data-type="SheetLabel" style="">补偿方式</label>
								</td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control13_Option" class="rowOption">
								</td>
								<td data-datafield="OvertimeDetail.OvertimeDate">
									<input id="Control13_ctl3" type="text" data-datafield="OvertimeDetail.OvertimeDate" data-type="SheetTime" style="">
								</td>
								<td data-datafield="OvertimeDetail.StartTime">
									<input id="Control13_ctl4" type="text" data-datafield="OvertimeDetail.StartTime" data-type="SheetTextBox" style=""  data-wdatepickerjson="{dateFmt:'HH:mm'}" onclick="WdatePicker({ dateFmt: 'HH:mm', onpicked: function () { EditOvertimeHours(this)} });" data-defaultvalue="17:00"  readonly>
                                    <%--$dp.cal.getP('H', 'HH'), $dp.cal.getP('m', 'mm')--%>
								</td>
								<td data-datafield="OvertimeDetail.EndTime">
									<input id="Control13_ctl5" type="text" data-datafield="OvertimeDetail.EndTime" data-type="SheetTextBox" style="" data-wdatepickerjson="{dateFmt:'HH:mm'}" onclick="WdatePicker({ dateFmt: 'HH:mm', onpicked: function () { EditOvertimeHours(this) } }); " data-defaultvalue="21:00" readonly>
								</td>
								<td data-datafield="OvertimeDetail.OvertimeHours">
									<input id="Control13_ctl6" type="text" data-datafield="OvertimeDetail.OvertimeHours" data-type="SheetTextBox" style="" data-defaultvalue="4">
								</td>
								<td data-datafield="OvertimeDetail.OvertimeType">
									
								<select data-datafield="OvertimeDetail.OvertimeType" data-type="SheetDropDownList" id="ctl715877" class="" style="" data-masterdatacategory="员工加班类型"></select></td>
								<td data-datafield="OvertimeDetail.CompensationMode">
									
								<select data-datafield="OvertimeDetail.CompensationMode" data-type="SheetDropDownList" id="ctl959033" class="" style="" data-masterdatacategory="员工加班补偿方式"></select>
								</td>
								
								<td class="rowOption">
									<a class="delete">
										<div class="fa fa-minus">
										</div>
									</a>
									<a class="insert">
										<div class="fa fa-arrow-down">
										</div>
									</a>
								</td>
							</tr>
							<tr class="footer">
								<td class="rowOption">
								</td>
								<td data-datafield="OvertimeDetail.OvertimeDate">
								</td>
								<td data-datafield="OvertimeDetail.StartTime">
								</td>
								<td data-datafield="OvertimeDetail.EndTime">
								</td>
								<td data-datafield="OvertimeDetail.OvertimeHours">
									<label id="Control13_stat6" data-datafield="OvertimeDetail.OvertimeHours" data-type="SheetCountLabel" style=""></label>
								</td>
								<td data-datafield="OvertimeDetail.OvertimeType">
								</td>
								<td data-datafield="OvertimeDetail.CompensationMode">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
            <div class="row">

				<div id="titlea" class="col-md-2">
					
				</div>
				<div id="controla" class="col-md-10">
					<span id="Labelb" data-type="SheetLabel">
                    加班记录的添加和保存使用说明：<br />
                    1、点击添加按钮增加一条加班记录 <br />
                    2、点击单元格编辑修改 <br />
                    3、点击删除按钮可删除对应的一条加班记录<br /> 
                    4、开始时间和结束时间必须为时间格式 xx:xx（例如 ： 18:00）<br />

					</span>
				</div>
				
			</div>
			<div class="row">

				<div id="title7" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="Applicant" style="">申请人</span>
				</div>
				<div id="control7" class="col-md-4">
					<div id="Control14" data-datafield="Applicant" data-type="SheetUser" style=""></div>
				</div>
				
			</div>
			<div class="row">
                <div id="title8" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="ApplicationDate" style="">申请日期</span>
				</div>
				<div id="control8" class="col-md-4">
					<input id="Control15" type="text" data-datafield="ApplicationDate" data-type="SheetTime" style="">
				</div>
				<div id="title9" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="ApplicationNumber" style="">申请编号</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control16" type="text" data-datafield="ApplicationNumber" data-type="SheetTextBox" style="">
				</div>
				
			</div>
			<div class="row tableContent">
				<div id="title11" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="DepartmentHeadsOpinions" style="">部门负责人意见</span>
				</div>
				<div id="control11" class="col-md-10">
					<div id="Control17" data-datafield="DepartmentHeadsOpinions" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title13" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="GeneralOfficeDirectorOpinion" style="">综合办公室主任意见</span>
				</div>
				<div id="control13" class="col-md-10">
					<div id="Control18" data-datafield="GeneralOfficeDirectorOpinion" data-type="SheetComment" style=""></div>
				</div>
			</div>
			<div class="row TriagePersonnel">
				<div id="title15" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="TriagePersonnel" style="">会审人员</span>
				</div>
				<div id="control15" class="col-md-4">
					<div id="Control19" data-datafield="TriagePersonnel" data-type="SheetUser" style=""></div>
				</div>
				<div id="space16" class="col-md-2">
				</div>
				<div id="spaceControl16" class="col-md-4">
				</div>
			</div>
			<div class="row FirstGradeCountersignedOpinion">
				<div id="title17" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="FirstGradeCountersignedOpinion" style="">会审意见</span>
				</div>
				<div id="control17" class="col-md-10">
					<div id="Control20" data-datafield="FirstGradeCountersignedOpinion" data-type="SheetComment" style=""></div>
				</div>
			</div>
            <div class="row">
				<div id="div244087" class="col-md-2">
					<label data-datafield="HumanResourcesApprovalOpinions" data-type="SheetLabel" id="ctl649026" class="" style="">人力资源副总审批意见
					</label>
				</div>
				<div id="div494077" class="col-md-10">
					<div data-datafield="HumanResourcesApprovalOpinions" data-type="SheetComment" id="ctl914157" class="" style="">
					</div>
				</div>
			</div>
			<div class="row">
				<div id="div975608" class="col-md-2">
					<label data-datafield="GenManagerApprovalOpinion" data-type="SheetLabel" id="ctl511827" class="" style="">总经理审批意见
					</label>
				</div>
				<div id="div441097" class="col-md-10">
					<div data-datafield="GenManagerApprovalOpinion" data-type="SheetComment" id="ctl90664" class="" style="">
					</div>
				</div>
			</div>
			<div class="row hidden">
				<div id="title19" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="DepartmentsJointlySignButton" style="">提请会审按钮</span>
				</div>
				<div id="control19" class="col-md-4">
					<input id="Control21" type="text" data-datafield="DepartmentsJointlySignButton" data-type="SheetTextBox" style="">
				</div>
				<div id="space20" class="col-md-2">
				</div>
				<div id="spaceControl20" class="col-md-4">
				</div>
			</div>
		</div>
	</div>
</div>
    <script src="SEmployeeOvertimeApplication.js"></script>
</asp:Content>