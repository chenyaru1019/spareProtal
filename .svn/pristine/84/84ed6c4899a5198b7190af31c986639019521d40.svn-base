<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerMainMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.CustomerMainMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
        $.MvcSheet.SaveAction.OnActionPreDo = function () {
            var CompanyName = $.MvcSheetUI.GetControlValue("CompanyName");
            var ModelOrDepartment = $.MvcSheetUI.GetControlValue("ModelOrDepartment");
            if (CompanyName == '') {
                alert("企业名称不能为空！");
                return false;
            }
            if (ModelOrDepartment == '') {
                alert("模块和部门不能为空！");
                return false;
            }
        }
</script>
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">客户信息</label>
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
					<span id="Label11" data-type="SheetLabel" data-datafield="CompanyName" style="">企业名称</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="CompanyName" data-type="SheetTextBox" style="" class="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Type" style="">类别</span>
				</div>
				<div id="control2" class="col-md-4">
					<select data-datafield="Type" data-type="SheetDropDownList" id="ctl275183" class="" style="" data-defaultitems="最终用户;卖方;第三方">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="RelationType" style="">是否关联</span>
				</div>
				<div id="control3" class="col-md-4">
					<div data-datafield="RelationType" data-type="SheetRadioButtonList" id="ctl361165" class="" style="" data-defaultitems="关联;非关联" data-repeatcolumns="2"></div>
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="ModelOrDepartment" style="" class="" data-displayrule="{Type}=='最终用户'">模块或部门</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="ModelOrDepartment" data-type="SheetTextBox" style="" class="" data-displayrule="{Type}=='最终用户'">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="Address" style="">企业地址</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="Address" data-type="SheetTextBox" style="">
				</div>
				<div id="space6" class="col-md-2">
				</div>
				<div id="spaceControl6" class="col-md-4">
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="Attachment" style="">客户附件</span>
				</div>
				<div id="control7" class="col-md-10">
					<div id="Control16" data-datafield="Attachment" data-type="SheetAttachment" style=""></div>
				</div>
			</div>
			<div class="row tableContent">
				<div id="title9" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="Remark" style="">描述</span>
				</div>
				<div id="control9" class="col-md-10">
					<textarea id="Control17" data-datafield="Remark" data-type="SheetRichTextBox" style="">					</textarea>
				</div>
			</div>
			<div class="divContent divContent_Tab" id="divSheet">
                 <div class="Content_Tab">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">联系人信息</a></li>
                        <li role="presentation"><a href="#kptab" aria-controls="kptab" role="tab" data-toggle="tab">开票信息</a></li>
                        <li role="presentation"><a href="#xmtab" aria-controls="xmtab" role="tab" data-toggle="tab">项目信息</a></li>
                        <li role="presentation"><a href="#dqpgbgtab" aria-controls="dqpgbgtab" role="tab" data-toggle="tab">定期评估报告</a></li>
                        <li role="presentation"><a href="#bankaccounttab" aria-controls="bankaccounttab" role="tab" data-toggle="tab">银行账号</a></li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="home">
                      
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2"></div>
                            </div>
                           



			<div class="row tableContent">
				
				<div id="control11" class="col-md-10">
					<table id="Control18" data-datafield="ContactsTbl" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control18_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control18_Header3" data-datafield="ContactsTbl.ContactName">
									<label id="Control18_Label3" data-datafield="ContactsTbl.ContactName" data-type="SheetLabel" style="">联系人</label>
								</td>
								<td id="Control18_Header4" data-datafield="ContactsTbl.Telephone">
									<label id="Control18_Label4" data-datafield="ContactsTbl.Telephone" data-type="SheetLabel" style="">电话</label>
								</td>
								<td id="Control18_Header5" data-datafield="ContactsTbl.Fax">
									<label id="Control18_Label5" data-datafield="ContactsTbl.Fax" data-type="SheetLabel" style="">传真</label>
								</td>
								<td id="Control18_Header6" data-datafield="ContactsTbl.Mobile">
									<label id="Control18_Label6" data-datafield="ContactsTbl.Mobile" data-type="SheetLabel" style="">手机</label>
								</td>
								<td id="Control18_Header7" data-datafield="ContactsTbl.Email">
									<label id="Control18_Label7" data-datafield="ContactsTbl.Email" data-type="SheetLabel" style="">邮箱</label>
								</td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control18_Option" class="rowOption">
								</td>
								<td data-datafield="ContactsTbl.ContactName">
									<input id="Control18_ctl3" type="text" data-datafield="ContactsTbl.ContactName" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ContactsTbl.Telephone">
									<input id="Control18_ctl4" type="text" data-datafield="ContactsTbl.Telephone" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ContactsTbl.Fax">
									<input id="Control18_ctl5" type="text" data-datafield="ContactsTbl.Fax" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ContactsTbl.Mobile">
									<input id="Control18_ctl6" type="text" data-datafield="ContactsTbl.Mobile" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ContactsTbl.Email">
									<input id="Control18_ctl7" type="text" data-datafield="ContactsTbl.Email" data-type="SheetTextBox" style="">
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
								<td data-datafield="ContactsTbl.ContactName">
								</td>
								<td data-datafield="ContactsTbl.Telephone">
								</td>
								<td data-datafield="ContactsTbl.Fax">
								</td>
								<td data-datafield="ContactsTbl.Mobile">
								</td>
								<td data-datafield="ContactsTbl.Email">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
                   <div role="tabpanel" class="tab-pane" id="kptab">
                    <div class="row tableContent">
                        <div id="div5095" class="col-md-2"></div>
                        <div id="div701597" class="col-md-2"></div>
                        <div id="div473092" class="col-md-2"></div>
                        <div id="div876934" class="col-md-2"></div>
                        <div id="div334418" class="col-md-2"></div>
                        <div id="div707679" class="col-md-2"></div>
                    </div>     



                            <div class="row tableContent">
				
				<div id="control13" class="col-md-10">
					<table id="Control19" data-datafield="ReceiptTbl" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control19_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control19_Header3" data-datafield="ReceiptTbl.CustomerName" class="">
									
								<label data-datafield="ReceiptTbl.CustomerName" data-type="SheetLabel" id="ctl970373" class="" style="">户名</label></td>
								<td id="Control19_Header4" data-datafield="ReceiptTbl.ReceiptAddress" class="">
								<label data-datafield="ReceiptTbl.ReceiptAddress" data-type="SheetLabel" id="ctl515886" class="" style="">地址</label></td>	
								
								<td id="Control19_Header5" data-datafield="ReceiptTbl.ReceiptPhone" class="">
									
								<label data-datafield="ReceiptTbl.ReceiptPhone" data-type="SheetLabel" id="ctl850802" class="" style="">电话</label></td>
								<td id="Control19_Header6" data-datafield="ReceiptTbl.ReceiptBankOfDeposit" class="">
									
								<label data-datafield="ReceiptTbl.ReceiptBankOfDeposit" data-type="SheetLabel" id="ctl701780" class="" style="">开户行</label></td>
								<td id="Control19_Header7" data-datafield="ReceiptTbl.Account" class="">
									
								<label data-datafield="ReceiptTbl.Account" data-type="SheetLabel" id="ctl320574" class="" style="">账号</label></td>
								<td id="Control19_Header8" data-datafield="ReceiptTbl.DutyParagraph" class="">
									
								<label data-datafield="ReceiptTbl.DutyParagraph" data-type="SheetLabel" id="ctl175807" class="" style="">税号</label></td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control19_Option" class="rowOption">
								</td>
								<td data-datafield="ReceiptTbl.CustomerName">
									<input id="Control19_ctl3" type="text" data-datafield="ReceiptTbl.CustomerName" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptAddress">
									<input id="Control19_ctl4" type="text" data-datafield="ReceiptTbl.ReceiptAddress" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptPhone">
									<input id="Control19_ctl5" type="text" data-datafield="ReceiptTbl.ReceiptPhone" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptBankOfDeposit">
									<input id="Control19_ctl6" type="text" data-datafield="ReceiptTbl.ReceiptBankOfDeposit" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="ReceiptTbl.Account">
									<input id="Control19_ctl7" type="text" data-datafield="ReceiptTbl.Account" data-type="SheetTextBox" style="" class="">
								</td>
								<td data-datafield="ReceiptTbl.DutyParagraph">
									<input id="Control19_ctl7" type="text" data-datafield="ReceiptTbl.DutyParagraph" data-type="SheetTextBox" style="" class="">
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
								<td data-datafield="ReceiptTbl.CustomerName">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptAddress">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptPhone">
								</td>
								<td data-datafield="ReceiptTbl.ReceiptBankOfDeposit">
								</td>
								<td data-datafield="ReceiptTbl.Account">
								</td>
								<td data-datafield="ReceiptTbl.DutyParagraph" class="">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
            <div role="tabpanel" class="tab-pane" id="xmtab">
                    <div class="row tableContent">
                        <div id="div5095" class="col-md-2"></div>
                        <div id="div701597" class="col-md-2"></div>
                        <div id="div473092" class="col-md-2"></div>
                        <div id="div876934" class="col-md-2"></div>
                        <div id="div334418" class="col-md-2"></div>
                        <div id="div707679" class="col-md-2"></div>
                    </div> 

                       <div class="row tableContent">
				
				<div id="control15" class="col-md-10">
					<table id="Control20" data-datafield="ProjectTbl" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control20_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control20_Header3" data-datafield="ProjectTbl.ProjectName">
									<label id="Control20_Label3" data-datafield="ProjectTbl.ProjectName" data-type="SheetLabel" style="">项目名称</label>
								</td>
								<td id="Control20_Header4" data-datafield="ProjectTbl.ProjectShortName">
									<label id="Control20_Label4" data-datafield="ProjectTbl.ProjectShortName" data-type="SheetLabel" style="">简称</label>
								</td>
								<td id="Control20_Header5" data-datafield="ProjectTbl.SubProjectName">
									<label id="Control20_Label5" data-datafield="ProjectTbl.SubProjectName" data-type="SheetLabel" style="">子工程名称</label>
								</td>
								<td id="Control20_Header6" data-datafield="ProjectTbl.SubProjectCode">
									<label id="Control20_Label6" data-datafield="ProjectTbl.SubProjectCode" data-type="SheetLabel" style="">子工程代码</label>
								</td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control20_Option" class="rowOption">
								</td>
								<td data-datafield="ProjectTbl.ProjectName">
									<input id="Control20_ctl3" type="text" data-datafield="ProjectTbl.ProjectName" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ProjectTbl.ProjectShortName">
									<input id="Control20_ctl4" type="text" data-datafield="ProjectTbl.ProjectShortName" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ProjectTbl.SubProjectName">
									<input id="Control20_ctl5" type="text" data-datafield="ProjectTbl.SubProjectName" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="ProjectTbl.SubProjectCode">
									<input id="Control20_ctl6" type="text" data-datafield="ProjectTbl.SubProjectCode" data-type="SheetTextBox" style="" class="">
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
								<td data-datafield="ProjectTbl.ProjectName">
								</td>
								<td data-datafield="ProjectTbl.ProjectShortName">
								</td>
								<td data-datafield="ProjectTbl.SubProjectName">
								</td>
								<td data-datafield="ProjectTbl.SubProjectCode">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
            <div role="tabpanel" class="tab-pane" id="dqpgbgtab">
                    <div class="row tableContent">
                        <div id="div5095" class="col-md-2"></div>
                        <div id="div701597" class="col-md-2"></div>
                        <div id="div473092" class="col-md-2"></div>
                        <div id="div876934" class="col-md-2"></div>
                        <div id="div334418" class="col-md-2"></div>
                        <div id="div707679" class="col-md-2"></div>
                    </div> 
                <div class="row tableContent">
				
				<div id="control17" class="col-md-10">
					<table id="Control21" data-datafield="EvaluateReportTbl" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control21_SerialNo" class="rowSerialNo">
序号								</td>
								 <td id="ctl840399_header0" data-datafield="EvaluateReportTbl.riqi" style=""><label id="ctl840399_Label0" data-datafield="EvaluateReportTbl.riqi" data-type="SheetLabel" style="">日期</label></td>
                                <td id="ctl840399_header1" data-datafield="EvaluateReportTbl.ziduan" style=""><label id="ctl840399_Label1" data-datafield="EvaluateReportTbl.ziduan" data-type="SheetLabel" style="">字段</label></td>
                                
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control21_Option" class="rowOption">
								</td>
								 <td id="ctl840399_control0" data-datafield="EvaluateReportTbl.riqi" style="" class="">
                                    <input type="text" data-datafield="EvaluateReportTbl.riqi" data-type="SheetTime" id="ctl840399_control0" style="" class=""></td>
                                <td id="ctl840399_control1" data-datafield="EvaluateReportTbl.ziduan" style=""><input type="text" data-datafield="EvaluateReportTbl.ziduan" data-type="SheetTextBox" id="ctl840399_control1" style=""></td>
                               
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
								<td data-datafield="EvaluateReportTbl.riqi">
								</td>
								<td data-datafield="EvaluateReportTbl.ziduan">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
                <div role="tabpanel" class="tab-pane" id="bankaccounttab">
                    <div class="row tableContent">
                        <div id="div5095" class="col-md-2"></div>
                        <div id="div701597" class="col-md-2"></div>
                        <div id="div473092" class="col-md-2"></div>
                        <div id="div876934" class="col-md-2"></div>
                        <div id="div334418" class="col-md-2"></div>
                        <div id="div707679" class="col-md-2"></div>
                    </div>
                <div class="row tableContent">
				
				<div id="control19" class="col-md-10">
					<table id="Control22" data-datafield="BankAccountTbl" data-type="SheetGridView" class="SheetGridView">
						<tbody>
							
							<tr class="header">
								<td id="Control22_SerialNo" class="rowSerialNo">
序号								</td>
								<td id="Control22_Header3" data-datafield="BankAccountTbl.BankName">
									<label id="Control22_Label3" data-datafield="BankAccountTbl.BankName" data-type="SheetLabel" style="">开户行</label>
								</td>
								<td id="Control22_Header4" data-datafield="BankAccountTbl.Account">
									<label id="Control22_Label4" data-datafield="BankAccountTbl.Account" data-type="SheetLabel" style="">账号</label>
								</td>
								<td class="rowOption">
删除								</td>
							</tr>
							<tr class="template">
								<td id="Control22_Option" class="rowOption">
								</td>
								<td data-datafield="BankAccountTbl.BankName">
									<input id="Control22_ctl3" type="text" data-datafield="BankAccountTbl.BankName" data-type="SheetTextBox" style="">
								</td>
								<td data-datafield="BankAccountTbl.Account">
									<input id="Control22_ctl4" type="text" data-datafield="BankAccountTbl.Account" data-type="SheetTextBox" style="">
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
								<td data-datafield="BankAccountTbl.BankName">
								</td>
								<td data-datafield="BankAccountTbl.Account">
								</td>
								<td class="rowOption">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
         </div>
        </div>
                </div>
	</div>
</div>
</asp:Content>