﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InviteBids.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.InviteBids"  EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">招标项目主流程</label>
</div>
<div class="panel-body sheetContainer">
	<!--<div class="nav-icon fa fa-chevron-right bannerTitle">
		<label id="divBasicInfo" data-en_us="Basic information">基本信息</label>
	</div>-->
	<div class="divContent">
		<div style="display:none">
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
		<div style="display:none">
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
		<!--<div class="nav-icon fa  fa-chevron-right bannerTitle" style="margin-top:32px">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>-->
		<div class="divContent" id="divSheet">
            <!-- 创建项目 -->
            <div id="create-project" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>创建项目<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                        <div id="title1" class="col-md-2">
                            <span id="Label11" data-type="SheetLabel" data-datafield="ManagerA" style="">A角</span>
                        </div>
                        <div id="control1" class="col-md-4">
                            <div id="Control11" data-datafield="ManagerA" data-type="SheetUser" style=""></div>
                        </div>
                        <div id="title2" class="col-md-2">
                            <span id="Label12" data-type="SheetLabel" data-datafield="ManagerB" style="">B角</span>
                        </div>
                        <div id="control2" class="col-md-4">
                            <div id="Control12" data-datafield="ManagerB" data-type="SheetUser" style=""></div>
                        </div>
                    </div>
                    <div class="row tableContent">
                        <div id="title3" class="col-md-2">
                            <span id="Label13" data-type="SheetLabel" data-datafield="Tenderee" style="">招标人</span>
                        </div>
                        <div id="div452788" class="col-md-4">
                            <input type="text" data-datafield="Tenderee" data-type="SheetTextBox" id="ctl545774" class="" style=""><a href="#" onclick="getFinalUsers()">选择</a>
                        </div>
                        <div id="div654780" class="col-md-2"></div>
                        <div id="div546032" class="col-md-4"></div>
                    </div>
                    <div class="row">
                        <div id="title5" class="col-md-2">
                            <span id="Label14" data-type="SheetLabel" data-datafield="ProjectName" style="">项目名称</span>
                        </div>
                        <div id="control5" class="col-md-4">
                            <input id="Control14" type="text" data-datafield="ProjectName" data-type="SheetTextBox" style="" class="">
                        </div>
                        <div id="title6" class="col-md-2">
                            <span id="Label15" data-type="SheetLabel" data-datafield="ProjectShortName" style="">项目简称</span>
                        </div>
                        <div id="control6" class="col-md-4">
                            <input id="Control15" type="text" data-datafield="ProjectShortName" data-type="SheetTextBox" style="width: 120px;" class="">-<input id="Control16" type="text" data-datafield="TaskShortName" data-type="SheetTextBox" style="width: 120px;" class="">
                        </div>
                    </div>
                    <div class="row">
                        <div id="title7" class="col-md-2">
                            <span id="Label18" data-type="SheetLabel" data-datafield="BiddingMethod" style="" class="">招标方式</span></div>
                        <div id="control7" class="col-md-4">
                            <select data-datafield="BiddingMethod" data-type="SheetDropDownList" id="ctl658542" class="" style="" data-defaultitems="公开招标;邀请招标;竞争性谈判;询价" data-queryable="false"></select></div>
                        <div id="title8" class="col-md-2">
                            <span id="Label17" data-type="SheetLabel" data-datafield="BiddingScope" style="">招标范围</span>
                        </div>
                        <div id="control8" class="col-md-4">
                            
                        <select data-datafield="BiddingScope" data-type="SheetDropDownList" id="ctl429145" class="" style="" data-defaultitems="国内;国外" data-queryable="false"></select></div>
                    </div>
                    <div class="row">
                        <div id="title9" class="col-md-2">                            
                            <label data-datafield="hscode" data-type="SheetLabel" id="ctl919084" class="" style="">税则号</label>
                        </div>
                        <div id="control9" class="col-md-4">                            
                            <input type="text" data-datafield="hscode" data-type="SheetTextBox" id="ctl314953" class="" style="">
                        </div>
                        <div id="title10" class="col-md-2">
                            <span id="Label19" data-type="SheetLabel" data-datafield="BiddingCode" style="">招标编号</span>
                        </div>
                        <div id="control10" class="col-md-4">
                            <input id="Control19" type="text" data-datafield="BiddingCode" data-type="SheetTextBox" style="" class="">
                            <input id="CreateBiddingCodeButton" type="button" value="自动编号" class="btn btn-primary inputMouseOut">
                            <input id="RequestBiddingCodeButton" type="button" value="申请修改" class="btn btn-primary inputMouseOut">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">&nbsp;</div>
                        <div class="col-md-2">招标编号审批单</div>
                        <div class="col-md-4">
                            <table id="bidding-number-audit-state" class="xn-table">
                                <thead>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                </thead>
                                <tbody>
                                    <tr class="template" style="display:none">
                                        <td id="originator"></td>
                                        <td id="request-time"></td>
                                        <td id="state"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div id="div815040" class="col-md-2">
                            <span id="Label20" data-type="SheetLabel" data-datafield="TaxRate" style="" class="">税率%</span>
                        </div>
                        <div id="div173981" class="col-md-4">
                            <input id="Control20" type="text" data-datafield="TaxRate" data-type="SheetTextBox" style="" class="">
                        </div>
                        <div id="div326710" class="col-md-2"><label data-datafield="Require3CCert" data-type="SheetLabel" id="ctl244253" class="" style="">需要3C认证</label></div>
                        <div id="div193394" class="col-md-4">
                            <input type="checkbox" data-datafield="Require3CCert" data-type="SheetCheckBox" id="ctl306997" class="" style="">
                        </div>
                    </div>
                    <div class="row">
                        <div id="div642757" class="col-md-2">&nbsp;</div>
                        <div id="div32698" class="col-md-4">&nbsp;</div>
                        <div id="div948116" class="col-md-2"><label data-datafield="RequireMECert" data-type="SheetLabel" id="ctl532237" class="" style="">需要机电证</label></div>
                        <div id="div880987" class="col-md-4">
                            <input type="checkbox" data-datafield="RequireMECert" data-type="SheetCheckBox" id="ctl568851" class="" style="">
                        </div>
                    </div>                    
                    <div class="row tableContent">            
                        <div id="title13" class="col-md-2">
                            <span id="Label21" data-type="SheetLabel" data-datafield="BudgetBreakDown" style="">分包金额</span>
                        </div>
                        <div id="control13" class="col-md-10">
                            <table id="Control21" data-datafield="BudgetBreakDown" data-type="SheetGridView" class="SheetGridView">
                                <tbody>
                                    
                                    <tr class="header">
                                        <td id="Control21_SerialNo" class="rowSerialNo">
        序号								</td>
                                        <td id="Control21_Header3" data-datafield="BudgetBreakDown.PackageBudget">
                                            <label id="Control21_Label3" data-datafield="BudgetBreakDown.PackageBudget" data-type="SheetLabel" style="">分包金额</label>
                                        </td>
                                        <td class="rowOption">
        删除								</td>
                                    </tr>
                                    <tr class="template">
                                        <td id="Control21_Option" class="rowOption">
                                        </td>
                                        <td data-datafield="BudgetBreakDown.PackageBudget">
                                            <input id="Control21_ctl3" type="text" data-datafield="BudgetBreakDown.PackageBudget" data-type="SheetTextBox" style="">
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
                                        <td data-datafield="BudgetBreakDown.PackageBudget">
                                            <label id="Control21_stat3" data-datafield="BudgetBreakDown.PackageBudget" data-type="SheetCountLabel" style=""></label>
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
            
            <!-- 招标准备 -->
            <div id="prepare-project" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>项目准备<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                        <div class="col-md-12">
                            <p class="xn-notice">☻&nbsp;&nbsp;中国国际招标网上填写招标文件购买记录，电话通知未网上注册的购买人</p>
                            <p class="xn-notice">☻&nbsp;&nbsp;开标后48小时内，开标记录上传国际招标网</p>
                        </div>
                    </div>
                    <div class="row">
                        <div id="title15" class="col-md-2">
                            <span id="Label22" data-type="SheetLabel" data-datafield="AgencyAgreementType" style="">代理协议类型</span>
                        </div>
                        <div id="control15" class="col-md-4">
                            
                        <select data-datafield="AgencyAgreementType" data-type="SheetDropDownList" id="ctl65217" class="" style="" data-defaultitems="已审;不需要;后审" data-queryable="false"></select></div>
                        <div id="space16" class="col-md-2">
                        </div>
                        <div id="spaceControl16" class="col-md-4">
                        </div>
                    </div>
                    <div class="row tableContent">
                        <div id="title17" class="col-md-2">
                            <span id="Label23" data-type="SheetLabel" data-datafield="AgencyAgreements" style="">代理协议</span>
                        </div>
                        <div id="control17" class="col-md-10">
                            <table id="ctl246641" data-datafield="AgencyAgreements" data-type="SheetGridView" class="SheetGridView" style="" data-displaysummary="false">
                                <tbody>
                                    <tr class="header">
                                        <td id="ctl246641_SerialNo" class="rowSerialNo">序号</td>
                                        <td id="ctl246641_header0" data-datafield="AgencyAgreements.AgreementName" style=""><label id="ctl246641_Label0" data-datafield="AgencyAgreements.AgreementName" data-type="SheetLabel" style="">协议名称</label></td>
                                        <td id="ctl246641_header1" data-datafield="AgencyAgreements.AgencyFeeRate" style=""><label id="ctl246641_Label1" data-datafield="AgencyAgreements.AgencyFeeRate" data-type="SheetLabel" style="">代理费</label></td>
                                        <td id="ctl246641_header2" data-datafield="AgencyAgreements.AgreementCode" style=""><label id="ctl246641_Label2" data-datafield="AgencyAgreements.AgreementCode" data-type="SheetLabel" style="">协议号</label></td>
                                        <td id="ctl246641_header3" data-datafield="AgencyAgreements.AgrencyType" style=""><label id="ctl246641_Label3" data-datafield="AgencyAgreements.AgrencyType" data-type="SheetLabel" style="">代理类型</label></td>
                                        <td id="ctl246641_header4" data-datafield="AgencyAgreements.TheNo" style="" class=""><label id="ctl246641_Label4" data-datafield="AgencyAgreements.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                        <td class="rowOption">删除</td>
                                    </tr>
                                    <tr class="template">
                                        <td class=""></td>
                                        <td id="ctl246641_control0" data-datafield="AgencyAgreements.AgreementName" style="" data-popupwindow="PopupWindow" data-schemacode="GetAgencyList" data-querycode="GetAgencyList" data-outputmappings="AgencyAgreements.AgreementName:AgreeMent_name,AgencyAgreements.AgreementCode:AgreeMent_number,AgencyAgreements.AgrencyType:agency_type_name,AgencyAgreements.TheNo:No,AgencyAgreements.AgencyFeeRate:number">
                                            <input type="text" data-datafield="AgencyAgreements.AgreementName" data-type="SheetTextBox" id="ctl246641_control0" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetAgencyList" data-querycode="GetAgencyList" data-outputmappings="AgencyAgreements.AgreementName:AgreeMent_name,AgencyAgreements.AgreementCode:AgreeMent_number,AgencyAgreements.AgrencyType:agency_type_name,AgencyAgreements.TheNo:No,AgencyAgreements.AgencyFeeRate:number">
                                        </td>
                                        <td id="ctl246641_control1" data-datafield="AgencyAgreements.AgencyFeeRate" style="">
                                            <input type="text" data-datafield="AgencyAgreements.AgencyFeeRate" data-type="SheetTextBox" id="ctl246641_control1" style="">
                                        </td>
                                        <td id="ctl246641_control2" data-datafield="AgencyAgreements.AgreementCode" style="">
                                            <input type="text" data-datafield="AgencyAgreements.AgreementCode" data-type="SheetTextBox" id="ctl246641_control2" style="">
                                        </td>
                                        <td id="ctl246641_control3" data-datafield="AgencyAgreements.AgrencyType" style="">
                                            <input type="text" data-datafield="AgencyAgreements.AgrencyType" data-type="SheetTextBox" id="ctl246641_control3" style="">
                                        </td>
                                        <td id="ctl246641_control4" data-datafield="AgencyAgreements.TheNo" style="">
                                            <input type="text" data-datafield="AgencyAgreements.TheNo" data-type="SheetTextBox" id="ctl246641_control4" style="">
                                        </td>
                                        <td class="rowOption">
                                            <a class="delete"><div class="fa fa-minus"></div></a>
                                            <a class="insert"><div class="fa fa-arrow-down"></div></a>
                                        </td>
                                    </tr>
                                    <tr class="footer">
                                        <td></td>
                                        <td id="ctl246641_Stat0" data-datafield="AgencyAgreements.AgreementName" style=""></td>
                                        <td id="ctl246641_Stat1" data-datafield="AgencyAgreements.AgencyFeeRate" style="" class=""><label id="ctl246641_StatControl1" data-datafield="AgencyAgreements.AgencyFeeRate" data-type="SheetCountLabel" style=""></label></td>
                                        <td id="ctl246641_Stat2" data-datafield="AgencyAgreements.AgreementCode" style=""></td>
                                        <td id="ctl246641_Stat3" data-datafield="AgencyAgreements.AgrencyType" style=""></td>
                                        <td id="ctl246641_Stat4" data-datafield="AgencyAgreements.TheNo" style=""></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row tableContent">
                        <div id="title19" class="col-md-2">
                            <span id="Label24" data-type="SheetLabel" data-datafield="PostAuditComment" style="">后审说明</span>
                        </div>
                        <div id="control19" class="col-md-10">
                            <textarea id="Control24" data-datafield="PostAuditComment" data-type="SheetRichTextBox" style="" class="" data-displayrule="{AgencyAgreementType}==&quot;后审&quot;">					</textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div id="title21" class="col-md-2">
                            <span id="Label25" data-type="SheetLabel" data-datafield="BiddingDocPrice" style="">招标文件售价</span>
                        </div>
                        <div id="control21" class="col-md-4">
                            <input id="Control25" type="text" data-datafield="BiddingDocPrice" data-type="SheetTextBox" style="width: 120px;" class=""><select data-datafield="BiddingDocPriceUnit" data-type="SheetDropDownList" id="ctl580149" class="" style="width: 80px;" data-masterdatacategory="币种"></select>
                        </div>
                        <div id="title22" class="col-md-2">
                            
                        <span id="Label27" data-type="SheetLabel" data-datafield="BiddingDoc" style="" class="">招标文件</span></div>
                        <div id="control22" class="col-md-4">
                            <input type="text" data-datafield="BiddingDoc" data-type="SheetTextBox" id="ctl571791" class="hidden" style="display:none">
                            <div id="BiddingDoc"></div>
                        </div>
                    </div>
                    <div class="row tableContent">
                        <div id="title25" class="col-md-2">
                            <span id="Label28" data-type="SheetLabel" data-datafield="BiddingDocAuditExperts" style="">招标文件评审专家</span>
                        </div>
                        <div id="control25" class="col-md-10">
                            <table id="Control28" data-datafield="BiddingDocAuditExperts" data-type="SheetGridView" class="SheetGridView" data-displaysummary="false" data-defaultrowcount="0" data-displayadd="false" data-displaydelete="false">
                                <tbody>
                                    
                                    <tr class="header">
                                        <td id="Control28_SerialNo" class="rowSerialNo">
        序号								</td>
                                        <td id="Control28_Header3" data-datafield="BiddingDocAuditExperts.ExpertName" class="">
                                            <label id="Control28_Label3" data-datafield="BiddingDocAuditExperts.ExpertName" data-type="SheetLabel" style="">姓名</label>
                                        </td>
                                        <td id="Control28_Header4" data-datafield="BiddingDocAuditExperts.Company">
                                            <label id="Control28_Label4" data-datafield="BiddingDocAuditExperts.Company" data-type="SheetLabel" style="">单位</label>
                                        </td>
                                        <td id="Control28_Header5" data-datafield="BiddingDocAuditExperts.Phone">
                                            <label id="Control28_Label5" data-datafield="BiddingDocAuditExperts.Phone" data-type="SheetLabel" style="">电话</label>
                                        </td>
                                        <td class="rowOption" style="display:none;">
        删除								</td>
                                    </tr>
                                    <tr class="template">
                                        <td id="Control28_Option" class="rowOption">
                                        </td>
                                        <td data-datafield="BiddingDocAuditExperts.ExpertName">
                                            <input id="Control28_ctl3" type="text" data-datafield="BiddingDocAuditExperts.ExpertName" data-type="SheetTextBox" style="">
                                        </td>
                                        <td data-datafield="BiddingDocAuditExperts.Company">
                                            <input id="Control28_ctl4" type="text" data-datafield="BiddingDocAuditExperts.Company" data-type="SheetTextBox" style="">
                                        </td>
                                        <td data-datafield="BiddingDocAuditExperts.Phone">
                                            <input id="Control28_ctl5" type="text" data-datafield="BiddingDocAuditExperts.Phone" data-type="SheetTextBox" style="">
                                        </td>
                                        <td class="rowOption" style="display:none;">
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
                                        <td data-datafield="BiddingDocAuditExperts.ExpertName">
                                        </td>
                                        <td data-datafield="BiddingDocAuditExperts.Company">
                                        </td>
                                        <td data-datafield="BiddingDocAuditExperts.Phone">
                                        </td>
                                        <td class="rowOption" style="display:none;">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-default" id="SelectBiddingDocAuditExpertsButton" style="display:none">选择</button>
                        </div>
                    </div>
                    <div class="row" id="BiddingDocAuditRow">
                        <div class="col-md-2">招标文件评审单</div>
                        <div class="col-md-10">
                            <button id="RequestBiddingDocAuditButton" type="button" class="btn btn-default" style="display:none">发起审批</button>
                            <table id="bidding-doc-audit-state" class="xn-table">
                                <thead>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                </thead>
                                <tbody>
                                    <tr class="template" style="display:none">
                                        <td id="originator"></td>
                                        <td id="request-time"></td>
                                        <td id="state"></td>
                                    </tr>
                                </tbody>
                            </table>                        
                        </div>
                    </div>
                    <div class="row">
                        <div id="title27" class="col-md-2">
                            <span id="Label29" data-type="SheetLabel" data-datafield="HasOwnerComment" style="">业主批复</span>
                        </div>
                        <div id="control27" class="col-md-4">
                            <input id="Control29" type="checkbox" data-datafield="HasOwnerComment" data-type="SheetCheckbox" style="">
                        </div>
                        <div id="space28" class="col-md-2">
                        <span id="Label30" data-type="SheetLabel" data-datafield="OwnerComment" style="" class="">业主批复文件</span></div>
                        <div id="spaceControl28" class="col-md-4">
                            <input type="text" data-datafield="OwnerComment" data-type="SheetTextBox" id="ctl319803" class="" style="display:none">
                            <div id="owner-comment"></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 开标发标 -->
            <div id="bid-opening" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>开标发标<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                       <div id="div891887" class="col-md-2"><span id="Label35" data-type="SheetLabel" data-datafield="BidOpeningIssueDate" style="" class="">发标日期</span></div>
                       <div id="div215155" class="col-md-4"><input id="Control35" type="text" data-datafield="BidOpeningIssueDate" data-type="SheetTime" style="" class=""></div>
                       <div id="div107343" class="col-md-2"><span id="Label36" data-type="SheetLabel" data-datafield="BidOpeningOpeningDate" style="" class="">开标日期</span></div>
                       <div id="div176808" class="col-md-4"><input id="Control36" type="text" data-datafield="BidOpeningOpeningDate" data-type="SheetTime" style="" class=""></div>
                    </div>
                    <div class="row">
                       <div id="div602833" class="col-md-2"><span id="Label37" data-type="SheetLabel" data-datafield="BidOpeningTimeAndPlace" style="" class="">评标时间地点</span></div>
                       <div id="div745179" class="col-md-4"><input id="Control37" type="text" data-datafield="BidOpeningTimeAndPlace" data-type="SheetTextBox" style="" class=""></div>
                       <div id="div176160" class="col-md-2"><span id="Label38" data-type="SheetLabel" data-datafield="BidOpeningFinalBiddingDoc" style="" class="">招标文件最终版</span></div>
                       <div id="div416088" class="col-md-4">
                          <input type="text" data-datafield="FinalBiddingDoc" data-type="SheetTextBox" id="ctl833943" class="" style="display:none">
                          <div id="final-bidding-doc"></div>
                       </div>
                    </div>
                    <div class="row">
                       <div id="div199109" class="col-md-2"><span id="Label39" data-type="SheetLabel" data-datafield="BidOpeningBiddingNotice" style="" class="">招标公告</span></div>
                       <div id="div20812" class="col-md-4">
                           <input type="text" data-datafield="BiddingNotice" data-type="SheetTextBox" id="ctl308374" class="" style="display:none">
                           <div id="bidding-notice"></div>
                       </div>
                       <div id="div791842" class="col-md-2"><span id="Label40" data-type="SheetLabel" data-datafield="BidOpeningBiddingFaq" style="" class="">招标答疑</span></div>
                       <div id="div273438" class="col-md-4">
                          <input type="text" data-datafield="BiddingFaq" data-type="SheetTextBox" id="ctl998678" class="" style="display:none">
                          <div id="bidding-faq"></div>
                       </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">招标公告复核记录</div>
                        <div class="col-md-10">
                            <table id="bidding-notice-audit-state" class="xn-table">
                                <thead>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                </thead>
                                <tbody>
                                    <tr class="template" style="display:none">
                                        <td id="originator"></td>
                                        <td id="request-time"></td>
                                        <td id="state"></td>
                                    </tr>
                                </tbody>
                            </table>  
                            <input id="IssueBiddingNoticeButton" type="button" class="btn btn-default" value="发起公告" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" id="BOWrap">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="add"><button type="button" id="AddBidPackageButton" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button></li>
                                <li class="remove"><button type="button" id="RemoveActiveBidPackageButton" class="btn btn-default"><span class="glyphicon glyphicon-minus"></span></button></li>
                            </ul>
                            <div class="tab-content">
                            </div>
                            <div class="template tab-pane" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-2">招投标记录</div>
                                    <div class="col-md-10">
                                        <table id="BiddingRecords" class="xn-table">
                                            <thead>
                                                <th>序号</th>
                                                <th>投标单位 &amp; 保证金</th>
                                                <th>投标价</th>
                                                <th>操作</th>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                        <button id="AddBiddingRecordButton" class="btn btn-default" type="button">增加</button>
                                        <button id="PrintBiddingRecordsButton" class="btn btn-default" type="button">打印</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div id="div45271" class="col-md-2">开标一览表</div>
                                    <div id="div352562" class="col-md-4">
                                        <div id="overview-sheet"></div>
                                    </div>
                                    <div class="col-md-2">已完成</div>
                                    <div class="col-md-4">
                                        <input type="checkbox" id="is-opening-finished">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="position:absolute;top:-1000px;left:-1000px">
                        <div id="title31" class="col-md-2">
                            <span id="Label31" data-type="SheetLabel" data-datafield="BidOpening" style="" class="">发标开标</span>
                        </div>
                        <div id="control31" class="col-md-10">
                            <table id="ctl626143" data-datafield="BidOpening" data-type="SheetGridView" class="SheetGridView" style="">
                               <tbody>
                                  <tr class="header">
                                     <td id="ctl626143_SerialNo" class="rowSerialNo">序号</td>
                                     <td id="ctl626143_header0" data-datafield="BidOpening.OverviewSheet" style=""><label id="ctl626143_Label0" data-datafield="BidOpening.OverviewSheet" data-type="SheetLabel" style="">开标一览表</label></td>
                                     <td id="ctl626143_header1" data-datafield="BidOpening.PackageName" style=""><label id="ctl626143_Label1" data-datafield="BidOpening.PackageName" data-type="SheetLabel" style="">包名</label></td>
                                     <td id="ctl626143_header2" data-datafield="BidOpening.IsFinished" style=""><label id="ctl626143_Label2" data-datafield="BidOpening.IsFinished" data-type="SheetLabel" style="">发标开标完成</label></td>
                                     <td class="rowOption">删除</td>
                                  </tr>
                                  <tr class="template">
                                     <td></td>
                                     <td id="ctl626143_control0" data-datafield="BidOpening.OverviewSheet" style=""><input type="text" data-datafield="BidOpening.OverviewSheet" data-type="SheetTextBox" id="ctl626143_control0" style=""></td>
                                     <td id="ctl626143_control1" data-datafield="BidOpening.PackageName" style=""><input type="text" data-datafield="BidOpening.PackageName" data-type="SheetTextBox" id="ctl626143_control1" style=""></td>
                                     <td id="ctl626143_control2" data-datafield="BidOpening.IsFinished" style=""><input type="checkbox" data-datafield="BidOpening.IsFinished" data-type="SheetCheckBox" id="ctl626143_control2" style=""></td>
                                     <td class="rowOption">
                                        <a class="delete">
                                           <div class="fa fa-minus"></div>
                                        </a>
                                        <a class="insert">
                                           <div class="fa fa-arrow-down"></div>
                                        </a>
                                     </td>
                                  </tr>
                               </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 评标 -->
            <div id="bid-evaluation" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>评标<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                        <div class="col-md-12" id="be-wrap">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="add"><button type="button" id="add-evapkg-btn" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button></li>
                                <li class="remove"><button type="button" id="del-evapkg-btn" class="btn btn-default"><span class="glyphicon glyphicon-minus"></span></button></li>
                            </ul>
                            <div class="tab-content">
                            </div>
                            <div style="display:none" class="template tab-pane" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-2">评标报告</div>
                                    <div class="col-md-4">
                                        <div id="evaluation-report"></div>
                                    </div>
                                    <div class="col-md-2">中标人</div>
                                    <div class="col-md-4">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select id="winner" class="form-control"></select>
                                                <button type="button" id="add-to-db" class="form-control">加入客户信息库</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">评标专家</div>
                                    <div class="col-md-10">
                                        <table id="evaluation-expert-table" class="xn-table">
                                            <thead>
                                                <th>姓名</th>
                                                <th>单位</th>
                                                <th>电话</th>
                                            </thead>
                                            <tbody>
                                                <tr class="template">
                                                    <td class="name"></td>
                                                    <td class="company"></td>
                                                    <td class="mobile-phone"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <button type="button" id="select-expert-btn" class="btn btn-default">选择</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">澄清</div>
                                    <div class="col-md-4">
                                        <div id="clarification"></div>
                                    </div>
                                    <div class="col-md-2">评标结果业主批复</div>
                                    <div class="col-md-4">
                                        <div id="owner-comment"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">公示日期</div>
                                    <div class="col-md-4">
                                         <input id="Control46" type="text" data-datafield="BiddingEvaluationPublicityDate" data-type="SheetTime" style="" class="">
                                    </div>
                                    <div class="col-md-2">公示截屏</div>
                                    <div class="col-md-4">
                                        <div id="notice-screenshot"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div id="bid-prices">
                                            <table class="xn-table bid-price-template margin-8px no-inner-border" style="display:none">
                                                <thead>
                                                    <tr>
                                                        <th>中标价</th>
                                                        <th>关联招标代理</th>
                                                        <th>操作</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr class="compulsory data">
                                                        <td>
                                                            <div class="form-inline">
                                                                <div class="form-group">
                                                                    <label for="bid-price">中标价</label>
                                                                    <input type="number" class="form-control" id="bid-price" value="0" placeholder="中标价" style="width:120px"> 
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="bid-price-unit">币种</label>
                                                                    <select id="bid-price-unit" class="form-control" style="width:100px"></select>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="exchange-rate">汇率</label>
                                                                    <input type="number" class="form-control" id="exchange-rate" value="1" placeholder="汇率" style="width:80px">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="form-inline">
                                                                <div class="form-group">
                                                                    <input type="checkbox" id="has-associated-agreement" class="form-control">按中标价收代理费
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="associated-agreement">关联协议</label>
                                                                    <select id="associated-agreement" class="form-control"></select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-default" onclick="$(this).closest('table').remove()"><span class="glyphicon glyphicon-remove"></span></button>
                                                        </td>
                                                    </tr>
                                                    <tr class="template">
                                                        <td>
                                                            <div class="form-inline">
                                                                <div class="form-group">
                                                                    <label for="bid-price">中标价</label>
                                                                    <input type="number" class="form-control" id="bid-price" value="0" placeholder="中标价" style="width:120px"> 
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="bid-price-unit">币种</label>
                                                                    <select id="bid-price-unit" class="form-control" style="width:100px"></select>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="exchange-rate">汇率</label>
                                                                    <input type="number" class="form-control" id="exchange-rate" value="1" placeholder="汇率" style="width:80px">
                                                                </div>
                                                                <div class="form-group">
                                                                    <button type="button" class="btn btn-default" id="remove-me"><span class="glyphicon glyphicon-remove"></span></button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td colspan="2">
                                                        </td>
                                                    </tr>
                                                    <tr class="toolbar">
                                                        <td colspan="3">
                                                            <button type="button" class="btn btn-default" id="add-bid-price-btn2"><span class="glyphicon glyphicon-plus"></span></button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <button type="button" id="add-bid-price-btn" class="btn btn-default">增加中标价</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <label for="BiddingEvaluationEquivalentRMB">折合RMB</label>
                                    </div>
                                    <div class="col-md-4">
                                      <input id="total-bidding-price" type="number" class="form-control" readonly>
                                    </div>
                                    <div class="col-md-2">已完成</div>
                                    <div class="col-md-4"><input type="checkbox" id="is-finished"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="position:absolute;top:-1000px;left:-1000px">
                        <div id="title33" class="col-md-2">
                            <span id="Label32" data-type="SheetLabel" data-datafield="BiddingEvaluation" style="" class="">评标</span>
                        </div>
                        <div id="control33" class="col-md-10">
                            <table id="ctl358014" data-datafield="BiddingEvaluation" data-type="SheetGridView" class="SheetGridView" style="">
                                   <tbody>
                                  <tr class="header">
                                     <td id="ctl525968_SerialNo" class="rowSerialNo">序号</td>
                                     <td id="ctl525968_header0" data-datafield="BiddingEvaluation.EvaluationReport" style=""><label id="ctl525968_Label0" data-datafield="BiddingEvaluation.EvaluationReport" data-type="SheetLabel" style="">评标报告</label></td>
                                     <td id="ctl525968_header1" data-datafield="BiddingEvaluation.BidWinner" style=""><label id="ctl525968_Label1" data-datafield="BiddingEvaluation.BidWinner" data-type="SheetLabel" style="">中标人</label></td>
                                     <td id="ctl525968_header2" data-datafield="BiddingEvaluation.Clarification" style=""><label id="ctl525968_Label2" data-datafield="BiddingEvaluation.Clarification" data-type="SheetLabel" style="">澄清</label></td>
                                     <td id="ctl525968_header3" data-datafield="BiddingEvaluation.PublicityDate" style=""><label id="ctl525968_Label3" data-datafield="BiddingEvaluation.PublicityDate" data-type="SheetLabel" style="">公示日期</label></td>
                                     <td id="ctl525968_header4" data-datafield="BiddingEvaluation.PublicityScreenShot" style=""><label id="ctl525968_Label4" data-datafield="BiddingEvaluation.PublicityScreenShot" data-type="SheetLabel" style="">公示截屏</label></td>
                                     <td id="ctl525968_header5" data-datafield="BiddingEvaluation.PackageName" style=""><label id="ctl525968_Label5" data-datafield="BiddingEvaluation.PackageName" data-type="SheetLabel" style="">包名</label></td>
                                     <td id="ctl525968_header6" data-datafield="BiddingEvaluation.OwnerComment" style=""><label id="ctl525968_Label6" data-datafield="BiddingEvaluation.OwnerComment" data-type="SheetLabel" style="">评标结果业主批复</label></td>
                                     <td id="ctl525968_header7" data-datafield="BiddingEvaluation.EquivalentRMB" style=""><label id="ctl525968_Label7" data-datafield="BiddingEvaluation.EquivalentRMB" data-type="SheetLabel" style="">折合RMB</label></td>
                                     <td id="ctl525968_header8" data-datafield="BiddingEvaluation.IsFinished" style=""><label id="ctl525968_Label8" data-datafield="BiddingEvaluation.IsFinished" data-type="SheetLabel" style="">评标完成</label></td>
                                     <td class="rowOption">删除</td>
                                  </tr>
                                  <tr class="template">
                                     <td></td>
                                     <td id="ctl525968_control0" data-datafield="BiddingEvaluation.EvaluationReport" style=""><input type="text" data-datafield="BiddingEvaluation.EvaluationReport" data-type="SheetTextBox" id="ctl525968_control0" style=""></td>
                                     <td id="ctl525968_control1" data-datafield="BiddingEvaluation.BidWinner" style=""><input type="text" data-datafield="BiddingEvaluation.BidWinner" data-type="SheetTextBox" id="ctl525968_control1" style=""></td>
                                     <td id="ctl525968_control2" data-datafield="BiddingEvaluation.Clarification" style=""><input type="text" data-datafield="BiddingEvaluation.Clarification" data-type="SheetTextBox" id="ctl525968_control2" style=""></td>
                                     <td id="ctl525968_control3" data-datafield="BiddingEvaluation.PublicityDate" style=""><input type="text" data-datafield="BiddingEvaluation.PublicityDate" data-type="SheetTime" id="ctl525968_control3" style=""></td>
                                     <td id="ctl525968_control4" data-datafield="BiddingEvaluation.PublicityScreenShot" style=""><input type="text" data-datafield="BiddingEvaluation.PublicityScreenShot" data-type="SheetTextBox" id="ctl525968_control4" style=""></td>
                                     <td id="ctl525968_control5" data-datafield="BiddingEvaluation.PackageName" style=""><input type="text" data-datafield="BiddingEvaluation.PackageName" data-type="SheetTextBox" id="ctl525968_control5" style=""></td>
                                     <td id="ctl525968_control6" data-datafield="BiddingEvaluation.OwnerComment" style=""><input type="text" data-datafield="BiddingEvaluation.OwnerComment" data-type="SheetTextBox" id="ctl525968_control6" style=""></td>
                                     <td id="ctl525968_control7" data-datafield="BiddingEvaluation.EquivalentRMB" style=""><input type="text" data-datafield="BiddingEvaluation.EquivalentRMB" data-type="SheetTextBox" id="ctl525968_control7" style=""></td>
                                     <td id="ctl525968_control8" data-datafield="BiddingEvaluation.IsFinished" style=""><input type="checkbox" data-datafield="BiddingEvaluation.IsFinished" data-type="SheetCheckBox" id="ctl525968_control8" style=""></td>
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
                                     <td id="ctl525968_Stat0" data-datafield="BiddingEvaluation.EvaluationReport" style=""></td>
                                     <td id="ctl525968_Stat1" data-datafield="BiddingEvaluation.BidWinner" style=""></td>
                                     <td id="ctl525968_Stat2" data-datafield="BiddingEvaluation.Clarification" style=""></td>
                                     <td id="ctl525968_Stat3" data-datafield="BiddingEvaluation.PublicityDate" style=""></td>
                                     <td id="ctl525968_Stat4" data-datafield="BiddingEvaluation.PublicityScreenShot" style=""></td>
                                     <td id="ctl525968_Stat5" data-datafield="BiddingEvaluation.PackageName" style=""></td>
                                     <td id="ctl525968_Stat6" data-datafield="BiddingEvaluation.OwnerComment" style=""></td>
                                     <td id="ctl525968_Stat7" data-datafield="BiddingEvaluation.EquivalentRMB" style=""><label id="ctl525968_StatControl7" data-datafield="BiddingEvaluation.EquivalentRMB" data-type="SheetCountLabel" style=""></label></td>
                                     <td id="ctl525968_Stat8" data-datafield="BiddingEvaluation.IsFinished" style=""></td>
                                     <td></td>
                                  </tr>
                               </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 中标退保 -->
            <div id="refund" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>中标退保<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                        <div class="col-md-12" id="refund-wrap">
                            <ul class="nav nav-tabs" role="tablist">
                                <!--<li class="add"><button type="button" id="add-refpkg-btn" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button></li>
                                <li class="remove"><button type="button" id="del-refpkg-btn" class="btn btn-default"><span class="glyphicon glyphicon-minus"></span></button></li>-->
                            </ul>
                            <div class="tab-content">
                            </div>
                            <div style="display:none" class="template tab-pane" role="tabpanel">
                                <div class="row">
                                    <div id="title35" class="col-md-4">
                                        <span id="Label33" data-type="SheetLabel" data-datafield="WinnerNoticeDate" style="">中标通知书/未中标通知书日期<br>（无中标人时填写未中标通知书日期）</span>
                                    </div>
                                    <div id="control35" class="col-md-8">
                                        <input id="winner-notice-date" type="text" data-datafield="WinnerNoticeDate" data-type="SheetTime" style="">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="refund-table" class="xn-table">
                                            <thead>
                                                <th>投标单位</th>
                                                <th>中落标</th>
                                                <th>保证金类型</th>
                                                <th>保证金</th>
                                                <th>退保状态</th>
                                                <th>操作</th>
                                            </thead>
                                            <tbody>
                                                <tr class="template">
                                                    <td class="tender"></td>
                                                    <td class="state"></td>
                                                    <td class="cash-deposit-type"></td>
                                                    <td class="cash-deposit"></td>
                                                    <td class="refund-state"></td>
                                                    <td><button type="button" class="btn btn-default operate">编辑</button></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">已完成</div>
                                    <div class="col-md-4">
                                        <input type="checkbox" id="is-finished">
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-4"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="position:absolute;top:-1000px;left:-1000px">
                        <table id="ctl8981" data-datafield="WinnerNotice" data-type="SheetGridView" class="SheetGridView" style="">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl8981_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl8981_header0" data-datafield="WinnerNotice.NoticeDate" style="">
                                        <label id="ctl8981_Label0" data-datafield="WinnerNotice.NoticeDate" data-type="SheetLabel" style="">发中标通知日期</label>
                                    </td>
                                    <td id="ctl8981_header1" data-datafield="WinnerNotice.IsFinished" style="">
                                        <label id="ctl8981_Label1" data-datafield="WinnerNotice.IsFinished" data-type="SheetLabel" style="">中标退保完成</label>
                                    </td>
                                    <td id="ctl8981_header2" data-datafield="WinnerNotice.PackageName" style="">
                                        <label id="ctl8981_Label2" data-datafield="WinnerNotice.PackageName" data-type="SheetLabel" style="">包名</label>
                                    </td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl8981_control0" data-datafield="WinnerNotice.NoticeDate" style="">
                                        <input type="text" data-datafield="WinnerNotice.NoticeDate" data-type="SheetTime" id="ctl8981_control0" style="">
                                    </td>
                                    <td id="ctl8981_control1" data-datafield="WinnerNotice.IsFinished" style="">
                                        <input type="checkbox" data-datafield="WinnerNotice.IsFinished" data-type="SheetCheckBox" id="ctl8981_control1" style="">
                                    </td>
                                    <td id="ctl8981_control2" data-datafield="WinnerNotice.PackageName" style="">
                                        <input type="text" data-datafield="WinnerNotice.PackageName" data-type="SheetTextBox" id="ctl8981_control2" style="">
                                    </td>
                                    <td class="rowOption">
                                        <a class="delete"><div class="fa fa-minus"></div></a>
                                        <a class="insert"><div class="fa fa-arrow-down"></div></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
						
			<!-- 资料归档 -->
            <div id="file" class="xn-group-box">
                <div class="xn-title bannerTitle">
                    <label>归档归尾<span class="project-code"></span></label>
                </div>
                <div class="xn-content">
                    <div class="row">
                        <div id="title47" class="col-md-2"><span id="Label34" data-type="SheetLabel" data-datafield="CapitalSavingRate" style="" class="">节资率</span></div>
                        <div id="control47" class="col-md-4">
                            <input id="Control34" type="text" data-datafield="CapitalSavingRate" data-type="SheetTextBox" style="" class="">%
                        </div>
                        <div class="col-md-2"></div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-default" id="request-file-btn">归档申请</button>
                            <table id="file-audit-table" class="xn-table">
                                <thead>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                </thead>
                                <tbody>
                                    <tr class="template">
                                        <td class="applicant"></td>
                                        <td class="time"></td>
                                        <td class="state"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
			
			
			
			
			
		</div>
	</div>

<!-- 专家查询表单 -->
<div id="QueryExpertsForm" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">抽取专家</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="ExpertDomainInputAddon">专业领域</span>
                                <select id="ExpertDomainInput" class="form-control" aria-describedby="ExpertDomainInputAddon"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="ExpertAreaInputAddon">地　　区</span>
                                <select id="ExpertAreaInput" class="form-control" aria-describedby="ExpertAreaInputAddon"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="ExpertCountInputAddon">人　　数</span>
                                <input id="ExpertCountInput" type="number" class="form-control" aria-describedby="ExpertCountInputAddon" value="1">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <!--add by tiger start-->
                <button type="button" class="btn btn-primary" id="SelectExpertButton">选取专家>></button>                            
                <button type="button" class="btn btn-primary" id="CloseQueryExpertButton">关闭</button>
                <!--add by tiger end-->
                <button type="button" class="btn btn-primary" id="QueryExpertButton">确定</button>                            
            </div>
        </div>
    </div>
</div>

<!-- 抽取专家 -->
<div id="SelectExpertForm" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">抽取专家</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" class="btn" id="RequeryExpertsButton">重新抽取</button>&nbsp;
                            <button type="button" class="btn" id="OpenQueryExpertsButton">修改抽取条件</button>&nbsp;
                            <button type="button" class="btn" id="ExportExpertsButton">导出</button>&nbsp;
                            <button type="button" class="btn btn-primary" id="SaveExpertsButton">保存</button>&nbsp;
                            <button type="button" class="btn btn-warning" id="CloseSelectExpertFormButton">关闭</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-bordered" id="ExpertsTable">
                                <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>抽取时间</th>
                                        <th>专家姓名</th>
                                        <th>地区</th>
                                        <th>单位</th>
                                        <th>专业领域</th>
                                        <th>出生年月</th>
                                        <th>电话</th>
                                        <th>邮箱</th>
                                        <th>关联项目</th>
                                        <th>抽取结果</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 选择专家 -->
<div id="NewSelectExpertForm" class="modal fade fade bs-example-modal-lg" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">选取专家</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <table id="NewSelExpertTable"></table>                                
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="NewSaveExpertsButton">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 抽取专家 -->
<div id="SelectExpertForm" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">抽取专家</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" class="btn" id="RequeryExpertsButton">重新抽取</button>&nbsp;
                            <button type="button" class="btn" id="OpenQueryExpertsButton">修改抽取条件</button>&nbsp;
                            <button type="button" class="btn" id="ExportExpertsButton">导出</button>&nbsp;
                            <button type="button" class="btn btn-primary" id="SaveExpertsButton">保存</button>&nbsp;
                            <button type="button" class="btn btn-warning" id="CloseSelectExpertFormButton">关闭</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-bordered" id="ExpertsTable">
                                <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>抽取时间</th>
                                        <th>专家姓名</th>
                                        <th>地区</th>
                                        <th>单位</th>
                                        <th>专业领域</th>
                                        <th>出生年月</th>
                                        <th>电话</th>
                                        <th>邮箱</th>
                                        <th>关联项目</th>
                                        <th>抽取结果</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 关联专家&项目 -->
<div id="SelectProjectForm" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">关联项目</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="ProjectsInputAddon">项目</span>
                                <select id="ProjectsInput" class="form-control" aria-describedby="ProjectsInputAddon"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="StageInputAddon">阶段</span>
                                <select id="StageInput" class="form-control" aria-describedby="StageInputAddon">
                                    <option value='招标文件审核'>招标文件审核</option>
                                    <option value='评标'>评标</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="SetRelatedProjectButton">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 废弃专家原因 -->
<div id="SetDropReasonForm" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">废弃专家原因</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group padding-8px">
                                <span class="input-group-addon" id="DropReasonInputAddon">原因</span>
                                <input id="DropReasonInput" type="text" class="form-control" aria-describedby="DropReasonInputAddon">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="SetDropReasonButton">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 招投标记录 -->
<div id="BiddingRecordForm" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="BiddingRecordFormLabel">招投标记录</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <button id="AddTenderButton" type="button" class="btn btn-default">增加投标人</button>
                            <table id="Tender" class="table-bordered">
                                <tbody>
                                    <tr class="template" style="display:none">
                                        <td>投标人</td>
                                        <td><input type="text" id="Name" class="form-control"></td>
                                        <td><select id="Country" class="form-control"></select></td>
                                        <td>
                                            <select id="CashType" class="form-control">
                                                <option value="保证金">保证金</option>
                                                <option value="无">无</option>
                                                <option value="保函">保函</option>
                                            </select>
                                        </td>
                                        <td><input type="number" id="Cash" class="form-control" value="0"></td>
                                        <td><select id="CashUnit" class="form-control"></select></td>
                                        <td><button id="DeleteMe" class="btn btn-default" type="button">删除</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">联系地址</div>
                        <div class="col-md-4">
                            <input type="text" id="Address" class="form-control">
                        </div>
                        <div class="col-md-2">联系人</div>
                        <div class="col-md-4">
                            <input type="text" id="Contact" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">电话</div>
                        <div class="col-md-4">
                            <input type="text" id="Telephone" class="form-control">
                        </div>
                        <div class="col-md-2">手机</div>
                        <div class="col-md-4">
                            <input type="text" id="MobilePhone" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">传真</div>
                        <div class="col-md-4">
                            <input type="text" id="Fax" class="form-control">
                        </div>
                        <div class="col-md-2">邮箱</div>
                        <div class="col-md-4">
                            <input type="text" id="Email" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">投标价</div>
                        <div class="col-md-2">
                            <input type="number" id="BidPrice1" class="form-control" value="0">
                        </div>
                        <div class="col-md-2">
                            <select id="BidPrice1Unit" class="form-control"></select>
                        </div>
                        <div class="col-md-6">制造商/研究方/经营方/维护方等</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">&nbsp;</div>
                        <div class="col-md-2">
                            <input type="number" id="BidPrice2" class="form-control" value="0">
                        </div>
                        <div class="col-md-2">
                            <select id="BidPrice2Unit" class="form-control"></select>
                        </div>
                        <div class="col-md-3">
                            <input type="text" id="Supplier" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <select id="SupplierCountry" class="form-control"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">招标文件购买记录表</div>
                        <div class="col-md-4">
                            <div id="BiddingDocPurchaseRecord"></div>
                        </div>
                        <div class="col-md-2">投标文件</div>
                        <div class="col-md-4">
                            <div id="TenderDoc"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">单据</div>
                        <div class="col-md-4">
                            <div id="Receipts"></div>
                        </div>
                        <div class="col-md-2">备注</div>
                        <div class="col-md-4">
                            <textarea id="Remark"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="SaveBiddingRecordButton">增加</button>
                <button type="button" class="btn btn-primary" id="UpdateBiddingRecordButton">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 投标结果 -->
<div id="refund-state-form" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="BiddingRecordFormLabel">招投标记录</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-12">
                            <table id="Tender" class="table-bordered">
                                <tbody>
                                    <tr class="template">
                                        <td>投标人</td>
                                        <td><input type="text" id="name" class="form-control" readonly="readonly"></td>
                                        <td><input type="text" id="country" class="form-control" readonly="readonly"></td>
                                        <td><input type="text" id="cash-type" class="form-control" readonly="readonly"></td>
                                        <td><input type="number" id="cash" class="form-control" readonly="readonly"></td>
                                        <td><input type="text" id="cash-unit" class="form-control" readonly="readonly"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">联系地址</div>
                        <div class="col-md-4">
                            <input type="text" id="address" class="form-control" readonly="readonly">
                            <input type="hidden" id="package-name">
                        </div>
                        <div class="col-md-2">联系人</div>
                        <div class="col-md-4">
                            <input type="text" id="contact" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">电话</div>
                        <div class="col-md-4">
                            <input type="text" id="telephone" class="form-control" readonly="readonly">
                        </div>
                        <div class="col-md-2">手机</div>
                        <div class="col-md-4">
                            <input type="text" id="mobile-phone" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">传真</div>
                        <div class="col-md-4">
                            <input type="text" id="fax" class="form-control" readonly="readonly">
                        </div>
                        <div class="col-md-2">邮箱</div>
                        <div class="col-md-4">
                            <input type="text" id="email" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">投标价</div>
                        <div class="col-md-2">
                            <input type="number" id="bid-price1" class="form-control" value="0" readonly="readonly">
                        </div>
                        <div class="col-md-2">
                            <input type="text" id="bid-price1-unit" class="form-control" readonly="readonly">
                        </div>
                        <div class="col-md-6">制造商/研究方/经营方/维护方等</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">&nbsp;</div>
                        <div class="col-md-2">
                            <input type="number" id="bid-price2" class="form-control" value="0" readonly="readonly">
                        </div>
                        <div class="col-md-2">
                            <input type="text" id="bid-price2-unit" class="form-control" readonly="readonly">
                        </div>
                        <div class="col-md-3">
                            <input type="text" id="supplier" class="form-control" readonly="readonly">
                        </div>
                        <div class="col-md-3">
                            <input type="text" id="supplier-country" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">招标文件购买记录表</div>
                        <div class="col-md-4">
                            <div id="bidding-doc-purchase-record"></div>
                        </div>
                        <div class="col-md-2">投标文件</div>
                        <div class="col-md-4">
                            <div id="tender-doc"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">单据</div>
                        <div class="col-md-4">
                            <div id="receipts"></div>
                        </div>
                        <div class="col-md-2">备注</div>
                        <div class="col-md-4">
                            <textarea id="remark" readonly="readonly"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">中标/落标</div>
                        <div class="col-md-4">
                            <select id="bidding-result" class="form-control">
                                <option value="落标">落标</option>
                                <option value="中标">中标</option>
                            </select>
                        </div>
                        <div class="col-md-2">中标/落标通知书</div>
                        <div class="col-md-4">
                            <div id="notice-of-bidding"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">退保记录</div>
                        <div class="col-md-10">
                            <button type="button" class="btn btn-default" id="request-refund-btn">退保</button>
                            <table id="refund-table" class="xn-table">
                                <thead>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>保证金类型</th>
                                    <th>金额</th>
                                    <th>退保类型</th>
                                    <th>状态</th>
                                </thead>
                                <tbody>
                                    <tr class="template">
                                        <td class="applicant"></td>
                                        <td class="time"></td>
                                        <td class="type"></td>
                                        <td class="amount"></td>
                                        <td>退保</td>
                                        <td class="state"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="save-bidding-result-btn">保存</button>、
            </div>
        </div>
    </div>
</div>

<!-- 取回 -->
<div id="go-back-form" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="BiddingRecordFormLabel">流程取回</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-4">选择活动</div>
                        <div class="col-md-8">
                            <select id="select-go-back-activity" class="form-control"></select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="go-back-btn">确定</button>、
            </div>
        </div>
    </div>
</div>

<!-- 关联协议选择 -->
<div id="AssociatedAgreementForm" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="BiddingRecordFormLabel">关联协议</h4>
            </div>
            <div class="modal-body">
                <div class="container col-md-12" style="padding:16px">
                    <div class="row">
                        <div class="col-md-4">选择关联协议</div>
                        <div class="col-md-8">
                            <input id="tenderPriceIndex" type="hidden" style="display:none"></input>
                            <select id="select-associated-agreement-activity" class="form-control"></select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="AssociatedAgreementSelectOkBtn" onclick="ibs.onSelectAssociatedAgreementFormOk()">确定</button>、
            </div>
        </div>
    </div>
</div>

<input id="pseudo-input" style="display:none" type="text" value="hello">

<link rel="stylesheet" type="text/css" href="InviteBids.css" >
<link rel="stylesheet" type="text/css" href="bootstrap-table.min.css">
<link rel="stylesheet" href="../js/zTree_v3/css/demo.css" type="text/css">
<link rel="stylesheet" href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="jquery-ui.min.js"></script>
<script src="InviteBids.js"></script>
<script src="select2.js"></script>
<script src="file2.js"></script>
<script src="bootstrap-table.min.js"></script>
<script src="bootstrap-table-zh-CN.min.js"></script>
<script src="../js/zTree_v3/js/jquery.ztree.core.js"></script>
<script src="../js/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script src="../Contract/ContractMainTree.js"></script>

</asp:Content>