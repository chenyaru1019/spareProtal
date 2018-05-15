<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agreement_execute.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Agreement_execute" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script src="Agreement_execute.js"></script>
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">协议执行</label>
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
            <div class="Content_Tab">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">协议执行</a></li>
                    <li role="presentation"><a href="#xybgtab" aria-controls="xybgtab" role="tab" data-toggle="tab">协议变更</a></li>
                    <li role="presentation"><a href="#glhtab" aria-controls="glhtab" role="tab" data-toggle="tab">关联协议/合同</a></li>
                    <li role="presentation"><a href="#xwtab" aria-controls="xwtab" role="tab" data-toggle="tab">协议文件</a></li>
                    

                </ul>
                <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="home">协议执行
                   
			            <div class="row">
				            <div id="title1" class="col-md-2">
					            <span id="Label11" data-type="SheetLabel" data-datafield="project_number" style="">项目编号</span>
				            </div>
				            <div id="control1" class="col-md-4">
					            <input id="Control11" type="text" data-datafield="project_number" data-type="SheetTextBox" style="">
				            </div>
				            <div id="title2" class="col-md-2">
					            <span id="Label12" data-type="SheetLabel" data-datafield="project_name" style="">项目名称</span>
				            </div>
				            <div id="control2" class="col-md-4">
					            <input id="Control12" type="text" data-datafield="project_name" data-type="SheetTextBox" style="">
				            </div>
			            </div>
			            <div class="row">
				            <div id="title3" class="col-md-2">
					            <span id="Label13" data-type="SheetLabel" data-datafield="signing_time" style="">签约时间</span>
				            </div>
				            <div id="control3" class="col-md-4">
					            <input id="Control13" type="text" data-datafield="signing_time" data-type="SheetTime" style="">
				            </div>
				            <div id="space4" class="col-md-2">
				            </div>
				            <div id="spaceControl4" class="col-md-4">
				            </div>
			            </div>
			            <div class="row tableContent">
				            <div id="title5" class="col-md-2">
					            <span id="Label14" data-type="SheetLabel" data-datafield="Project" style="">项目</span>
				            </div>
				            <div id="control5" class="col-md-10">
					            <table id="Control14" data-datafield="Project" data-type="SheetGridView" class="SheetGridView">
						            <tbody>
							
							            <tr class="header">
								            <td id="Control14_SerialNo" class="rowSerialNo">
            序号								</td>
								            <td id="Control14_Header3" data-datafield="Project.Project_type">
									            <label id="Control14_Label3" data-datafield="Project.Project_type" data-type="SheetLabel" style="">项目类型</label>
								            </td>
								            <td id="Control14_Header4" data-datafield="Project.Project_Numbers">
									            <label id="Control14_Label4" data-datafield="Project.Project_Numbers" data-type="SheetLabel" style="">项目编号</label>
								            </td>
								            <td id="Control14_Header5" data-datafield="Project.Project_names">
									            <label id="Control14_Label5" data-datafield="Project.Project_names" data-type="SheetLabel" style="">项目名称</label>
								            </td>
								            <td id="Control14_Header6" data-datafield="Project.Should_money">
									            <label id="Control14_Label6" data-datafield="Project.Should_money" data-type="SheetLabel" style="">应收代理费</label>
								            </td>
								            <td id="Control14_Header7" data-datafield="Project.Received_money">
									            <label id="Control14_Label7" data-datafield="Project.Received_money" data-type="SheetLabel" style="">已收代理费</label>
								            </td>
								            <td id="Control14_Header8" data-datafield="Project.Received_RMB">
									            <label id="Control14_Label8" data-datafield="Project.Received_RMB" data-type="SheetLabel" style="">已收RMB代理费</label>
								            </td>
								            <td id="Control14_Header9" data-datafield="Project.Agency_balance">
									            <label id="Control14_Label9" data-datafield="Project.Agency_balance" data-type="SheetLabel" style="">代理费余额</label>
								            </td>
								            <td class="rowOption">
            删除								</td>
							            </tr>
							            <tr class="template">
								            <td id="Control14_Option" class="rowOption">
								            </td>
								            <td data-datafield="Project.Project_type">
									            <input id="Control14_ctl3" type="text" data-datafield="Project.Project_type" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Project_Numbers">
									            <input id="Control14_ctl4" type="text" data-datafield="Project.Project_Numbers" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Project_names">
									            <input id="Control14_ctl5" type="text" data-datafield="Project.Project_names" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Should_money">
									            <input id="Control14_ctl6" type="text" data-datafield="Project.Should_money" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Received_money">
									            <input id="Control14_ctl7" type="text" data-datafield="Project.Received_money" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Received_RMB">
									            <input id="Control14_ctl8" type="text" data-datafield="Project.Received_RMB" data-type="SheetTextBox" style="" class="">
								            </td>
								            <td data-datafield="Project.Agency_balance">
									            <input id="Control14_ctl9" type="text" data-datafield="Project.Agency_balance" data-type="SheetTextBox" style="" class="">
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
								            <td data-datafield="Project.Project_type">
								            </td>
								            <td data-datafield="Project.Project_Numbers">
								            </td>
								            <td data-datafield="Project.Project_names">
								            </td>
								            <td data-datafield="Project.Should_money">
								            </td>
								            <td data-datafield="Project.Received_money">
								            </td>
								            <td data-datafield="Project.Received_RMB">
								            </td>
								            <td data-datafield="Project.Agency_balance">
								            </td>
								            <td class="rowOption">
								            </td>
							            </tr>
						            </tbody>
					            </table>
				            </div>
			            </div>
			            <div class="row tableContent">
				            <div id="title7" class="col-md-2">
					            <span id="Label15" data-type="SheetLabel" data-datafield="Receipt_receipt" style="">收款记录</span>
				            </div>
				            <div id="control7" class="col-md-10">
					            <table id="Control15" data-datafield="Receipt_receipt" data-type="SheetGridView" class="SheetGridView">
						            <tbody>
							
							            <tr class="header">
								            <td id="Control15_SerialNo" class="rowSerialNo">
            序号								</td>
								            <td id="Control15_Header3" data-datafield="Receipt_receipt.Receipt_Number">
									            <label id="Control15_Label3" data-datafield="Receipt_receipt.Receipt_Number" data-type="SheetLabel" style="">序号</label>
								            </td>
								            <td id="Control15_Header4" data-datafield="Receipt_receipt.Application_Date">
									            <label id="Control15_Label4" data-datafield="Receipt_receipt.Application_Date" data-type="SheetLabel" style="">申请时间</label>
								            </td>
								            <td id="Control15_Header5" data-datafield="Receipt_receipt.Receivable_money">
									            <label id="Control15_Label5" data-datafield="Receipt_receipt.Receivable_money" data-type="SheetLabel" style="">应收金额</label>
								            </td>
								            <td id="Control15_Header6" data-datafield="Receipt_receipt.Account_time">
									            <label id="Control15_Label6" data-datafield="Receipt_receipt.Account_time" data-type="SheetLabel" style="">到账日期</label>
								            </td>
								            <td id="Control15_Header7" data-datafield="Receipt_receipt.Receipt_State">
									            <label id="Control15_Label7" data-datafield="Receipt_receipt.Receipt_State" data-type="SheetLabel" style="">状态</label>
								            </td>
								            <td id="Control15_Header8" data-datafield="Receipt_receipt.receipt_operation">
									            <label id="Control15_Label8" data-datafield="Receipt_receipt.receipt_operation" data-type="SheetLabel" style="">操作</label>
								            </td>
								            <td class="rowOption">
            删除								</td>
							            </tr>
							            <tr class="template">
								            <td id="Control15_Option" class="rowOption">
								            </td>
								            <td data-datafield="Receipt_receipt.Receipt_Number">
									            <input id="Control15_ctl3" type="text" data-datafield="Receipt_receipt.Receipt_Number" data-type="SheetTextBox" style="">
								            </td>
								            <td data-datafield="Receipt_receipt.Application_Date">
									            <input id="Control15_ctl4" type="text" data-datafield="Receipt_receipt.Application_Date" data-type="SheetTextBox" style="">
								            </td>
								            <td data-datafield="Receipt_receipt.Receivable_money">
									            <input id="Control15_ctl5" type="text" data-datafield="Receipt_receipt.Receivable_money" data-type="SheetTextBox" style="">
								            </td>
								            <td data-datafield="Receipt_receipt.Account_time">
									            <input id="Control15_ctl6" type="text" data-datafield="Receipt_receipt.Account_time" data-type="SheetTextBox" style="">
								            </td>
								            <td data-datafield="Receipt_receipt.Receipt_State">
									            <input id="Control15_ctl7" type="text" data-datafield="Receipt_receipt.Receipt_State" data-type="SheetTextBox" style="">
								            </td>
								            <td data-datafield="Receipt_receipt.receipt_operation">
									            <input id="Control15_ctl8" type="text" data-datafield="Receipt_receipt.receipt_operation" data-type="SheetTextBox" style="">
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
								            <td data-datafield="Receipt_receipt.Receipt_Number">
								            </td>
								            <td data-datafield="Receipt_receipt.Application_Date">
								            </td>
								            <td data-datafield="Receipt_receipt.Receivable_money">
								            </td>
								            <td data-datafield="Receipt_receipt.Account_time">
								            </td>
								            <td data-datafield="Receipt_receipt.Receipt_State">
								            </td>
								            <td data-datafield="Receipt_receipt.receipt_operation">
								            </td>
								            <td class="rowOption">
								            </td>
							            </tr>
						            </tbody>
					            </table>
				            </div>
			            </div>
                    </div>
            <div role="tabpanel" class="tab-pane" id="xybgtab">
			    <div class="row tableContent">
                    <div>  
                        <input type="button" value="协议变更申请" onclick="Agreement_change()" class="">
                        <input type="hidden" value="" name="Agreenment_changeNo" id="Agreenment_changeNo">
                    </div>
				    <div id="title9" class="col-md-2">
                    
					    <span id="Label16" data-type="SheetLabel" data-datafield="Agreement_alteration" style="">协议变更</span>
				    </div>
				    <div id="control9" class="col-md-10">
                    
					    <table id="Control16" data-datafield="Agreement_alteration" data-type="SheetGridView" class="SheetGridView">
						    <tbody>
							
							    <tr class="header">
								    <td id="Control16_SerialNo" class="rowSerialNo">
    序号								</td>
								    <td id="Control16_Header3" data-datafield="Agreement_alteration.old_agency_money">
									    <label id="Control16_Label3" data-datafield="Agreement_alteration.old_agency_money" data-type="SheetLabel" style="">原代理费费率/金额</label>
								    </td>
								    <td id="Control16_Header4" data-datafield="Agreement_alteration.new_agency_money">
									    <label id="Control16_Label4" data-datafield="Agreement_alteration.new_agency_money" data-type="SheetLabel" style="">变更后代理费费率/金额</label>
								    </td>
								    <td id="Control16_Header5" data-datafield="Agreement_alteration.old_pay_condition">
									    <label id="Control16_Label5" data-datafield="Agreement_alteration.old_pay_condition" data-type="SheetLabel" style="">原支付条件</label>
								    </td>
								    <td id="Control16_Header6" data-datafield="Agreement_alteration.new_agency_conditon">
									    <label id="Control16_Label6" data-datafield="Agreement_alteration.new_agency_conditon" data-type="SheetLabel" style="">变更后支付条件</label>
								    </td>
								    <td id="Control16_Header7" data-datafield="Agreement_alteration.ag_state">
									    <label id="Control16_Label7" data-datafield="Agreement_alteration.ag_state" data-type="SheetLabel" style="">状态</label>
								    </td>
								    <td id="Control16_Header8" data-datafield="Agreement_alteration.Agreement_operation">
									    <label id="Control16_Label8" data-datafield="Agreement_alteration.Agreement_operation" data-type="SheetLabel" style="">操作</label>
								    </td>
								    <td class="rowOption">
    删除								</td>
							    </tr>                              
							    <tr class="template">
								    <td id="Control16_Option" class="rowOption">
								    </td>
								    <td data-datafield="Agreement_alteration.old_agency_money">
									    <input id="Control16_ctl3" type="text" data-datafield="Agreement_alteration.old_agency_money" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="Agreement_alteration.new_agency_money">
									    <input id="Control16_ctl4" type="text" data-datafield="Agreement_alteration.new_agency_money" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="Agreement_alteration.old_pay_condition">
									    <input id="Control16_ctl5" type="text" data-datafield="Agreement_alteration.old_pay_condition" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="Agreement_alteration.new_agency_conditon">
									    <input id="Control16_ctl6" type="text" data-datafield="Agreement_alteration.new_agency_conditon" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="Agreement_alteration.ag_state">
									    <input id="Control16_ctl7" type="text" data-datafield="Agreement_alteration.ag_state" data-type="SheetTextBox" style="" class="">
								    </td>
								    <td data-datafield="Agreement_alteration.Agreement_operation">
									    <input id="Control16_ctl8" type="text" data-datafield="Agreement_alteration.Agreement_operation" data-type="SheetTextBox" style="">
								    </td>
								    <td class="rowOption">
									    <a class="delete">
										    <div class="fa fa-minus">
										    </div>
									    </a>
									    <%--<a class="insert">
										    <div class="fa fa-arrow-down">
										    </div>
									    </a>--%>
								    </td>
							    </tr>
							    <tr class="footer">
								    <td class="rowOption">
								    </td>
								    <td data-datafield="Agreement_alteration.old_agency_money">
								    </td>
								    <td data-datafield="Agreement_alteration.new_agency_money">
								    </td>
								    <td data-datafield="Agreement_alteration.old_pay_condition">
								    </td>
								    <td data-datafield="Agreement_alteration.new_agency_conditon">
								    </td>
								    <td data-datafield="Agreement_alteration.ag_state">
								    </td>
								    <td data-datafield="Agreement_alteration.Agreement_operation">
								    </td>
								    <td class="rowOption">
								    </td>
							    </tr>
						    </tbody>
					    </table>
				    </div>
			    </div>
            </div>
             <div role="tabpanel" class="tab-pane" id="glhtab">
			<div class="row tableContent">
				<div id="title11" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Project_contract" style="">关联项目/合同</span>
				</div>
				<div id="control11" class="col-md-10">
					<table id="Control17" data-datafield="Project_contract" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control17_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control17_Header3" data-datafield="Project_contract.project_names">
									<label id="Control17_Label3" data-datafield="Project_contract.project_names" data-type="SheetLabel" style="">项目简称</label>
								</td>
								<td id="Control17_Header4" data-datafield="Project_contract.tender_number">
									<label id="Control17_Label4" data-datafield="Project_contract.tender_number" data-type="SheetLabel" style="">招标编号</label>
								</td>
								<td id="Control17_Header5" data-datafield="Project_contract.contact_no">
									<label id="Control17_Label5" data-datafield="Project_contract.contact_no" data-type="SheetLabel" style="">合同号</label>
								</td>
								<td id="Control17_Header6" data-datafield="Project_contract.contact_name">
									<label id="Control17_Label6" data-datafield="Project_contract.contact_name" data-type="SheetLabel" style="">合同名称</label>
								</td>
								<td id="Control17_Header7" data-datafield="Project_contract.contract_type">
									<label id="Control17_Label7" data-datafield="Project_contract.contract_type" data-type="SheetLabel" style="">合同类型</label>
								</td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control17_Option" class="rowOption">
								</td>
								<td data-datafield="Project_contract.project_names">
									<input id="Control17_ctl3" type="text" data-datafield="Project_contract.project_names" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="Project_contract.tender_number">
									<input id="Control17_ctl4" type="text" data-datafield="Project_contract.tender_number" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="Project_contract.contact_no">
									<input id="Control17_ctl5" type="text" data-datafield="Project_contract.contact_no" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="Project_contract.contact_name">
									<input id="Control17_ctl6" type="text" data-datafield="Project_contract.contact_name" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="Project_contract.contract_type">
									<input id="Control17_ctl7" type="text" data-datafield="Project_contract.contract_type" data-type="SheetTextBox" style="" class="">
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
								<td data-datafield="Project_contract.project_names">
								</td>
								<td data-datafield="Project_contract.tender_number">
								</td>
								<td data-datafield="Project_contract.contact_no">
								</td>
								<td data-datafield="Project_contract.contact_name">
								</td>
								<td data-datafield="Project_contract.contract_type">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
            
            <div role="tabpanel" class="tab-pane" id="xwtab">
			    <div class="row tableContent">
				    <div id="title13" class="col-md-2">
					    <span id="Label18" data-type="SheetLabel" data-datafield="agreement_files" style="">协议文件</span>
				    </div>
				    <div id="control13" class="col-md-10">
					    <table id="Control18" data-datafield="agreement_files" data-type="SheetGridView" class="SheetGridView" data-displayadd="false">
						    <tbody>
							
							    <tr class="header">
								    <td id="Control18_SerialNo" class="rowSerialNo">
    序号								</td>
								    <td id="Control18_Header3" data-datafield="agreement_files.Application_people">
									    <label id="Control18_Label3" data-datafield="agreement_files.Application_people" data-type="SheetLabel" style="">申请人</label>
								    </td>
								    <td id="Control18_Header4" data-datafield="agreement_files.Application_time">
									    <label id="Control18_Label4" data-datafield="agreement_files.Application_time" data-type="SheetLabel" style="">申请时间</label>
								    </td>
								    <td id="Control18_Header5" data-datafield="agreement_files.file_state">
									    <label id="Control18_Label5" data-datafield="agreement_files.file_state" data-type="SheetLabel" style="">状态</label>
								    </td>
								    <td id="Control18_Header6" data-datafield="agreement_files.files_operation">
									    <label id="Control18_Label6" data-datafield="agreement_files.files_operation" data-type="SheetLabel" style="">操作</label>
								    </td>
								    <td class="rowOption">
    删除								</td>
							    </tr>
							    <tr class="template">
								    <td id="Control18_Option" class="rowOption">
								    </td>
								    <td data-datafield="agreement_files.Application_people">
									    <input id="Control18_ctl3" type="text" data-datafield="agreement_files.Application_people" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="agreement_files.Application_time">
									    <input id="Control18_ctl4" type="text" data-datafield="agreement_files.Application_time" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="agreement_files.file_state">
									    <input id="Control18_ctl5" type="text" data-datafield="agreement_files.file_state" data-type="SheetTextBox" style="">
								    </td>
								    <td data-datafield="agreement_files.files_operation">
									    <input id="Control18_ctl6" type="text" data-datafield="agreement_files.files_operation" data-type="SheetTextBox" style="">
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
								    <td data-datafield="agreement_files.Application_people">
								    </td>
								    <td data-datafield="agreement_files.Application_time">
								    </td>
								    <td data-datafield="agreement_files.file_state">
								    </td>
								    <td data-datafield="agreement_files.files_operation">
								    </td>
								    <td class="rowOption">
								    </td>
							    </tr>
						    </tbody>
					    </table>
				    </div>
			    </div>
                
                    <div id="div898708" class="col-md-2">
                        <label data-datafield="files" data-type="SheetLabel" id="ctl597438" class="" style="">文件</label></div>
                    <div id="div394137" class="col-md-10">
                        <table id="ctl854182" data-datafield="files" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl854182_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl854182_header0" data-datafield="files.files_link" style="">
                                        <label id="ctl854182_Label0" data-datafield="files.files_link" data-type="SheetLabel" style="">协议文件</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl854182_control0" data-datafield="files.files_link" style="">
                                        <div data-datafield="files.files_link" data-type="SheetAttachment" id="ctl854182_control0" style=""></div>
                                    </td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                
                
                    <div id="div874123" class="col-md-2">
                        <label data-datafield="files_two" data-type="SheetLabel" id="ctl711724" class="" style="">其他文件</label></div>
                    <div id="div587047" class="col-md-10">
                        <table id="ctl906110" data-datafield="files_two" data-type="SheetGridView" class="SheetGridView" style="" data-displaysequenceno="false" data-displayadd="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl906110_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl906110_header0" data-datafield="files_two.files_url" style="" class="">
                                        <label id="ctl906110_Label0" data-datafield="files_two.files_url" data-type="SheetLabel" style="">其他文件</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl906110_control0" data-datafield="files_two.files_url" style="">
                                        <div data-datafield="files_two.files_url" data-type="SheetAttachment" id="ctl906110_control0" style="" class=""></div>
                                    </td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                
			</div>
            </div>
        </div>
            
		</div>
	</div>
</asp:Content>