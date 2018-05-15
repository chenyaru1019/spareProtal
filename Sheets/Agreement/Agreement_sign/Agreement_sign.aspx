<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agreement_sign.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Agreement_sign" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<script src="Agreement_sign.js"></script>
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">协议审签</label>
</div>
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
            <div class="row">
				<div id="title17" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="apply_peo" style="">申请人</span>
				</div>
				<div id="control17" class="col-md-4">
					<input id="Control25" type="text" data-datafield="apply_peo" data-type="SheetTextBox" style="">
				</div>
				<div id="title18" class="col-md-2">
					<span id="Label26" data-type="SheetLabel" data-datafield="apply_time" style="">申请时间</span>
				</div>
				<div id="control18" class="col-md-4">
					<input id="Control26" type="text" data-datafield="apply_time" data-type="SheetTextBox" style="" readonly="readonly">
				</div>
			</div>
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="Project_head_A" style="">项目负责人A</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="Project_head_A" data-type="SheetTextBox" class="" style="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Project_head_B" style="">项目负责人B</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="Project_head_B" data-type="SheetTextBox" class="" style="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="AgreeMent_name" style="">协议名称</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="AgreeMent_name" data-type="SheetTextBox" class="" style="">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="Agreement_client" style="">协议委托方</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="Agreement_client" data-type="SheetTextBox" class="" style="">
				</div>
			</div>

			<div class="row">
				<div id="title11" class="col-md-2">

                    <label data-datafield="agency_rates_inApprove" data-type="SheetLabel" id="ctl696896" class="" style="">代理费表</label>
                </div>
                <div id="control11" class="col-md-4">

                    <table id="ctl590869" data-datafield="agency_rates_inApprove" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-displayadd="false" data-displaydelete="false" data-displaysummary="false">
                        <tbody>
                            <tr class="header">
                                <td id="ctl590869_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl590869_header0" data-datafield="agency_rates_inApprove.agency_money" style="">
                                    <label id="ctl590869_Label0" data-datafield="agency_rates_inApprove.agency_money" data-type="SheetLabel" style="">代理费</label></td>
                                <td id="ctl590869_header1" data-datafield="agency_rates_inApprove.agency_type" style="">
                                    <label id="ctl590869_Label1" data-datafield="agency_rates_inApprove.agency_type" data-type="SheetLabel" style="">代理费类型</label></td>
                                <td id="ctl590869_header2" data-datafield="agency_rates_inApprove.up_limit" style="">
                                    <label id="ctl590869_Label2" data-datafield="agency_rates_inApprove.up_limit" data-type="SheetLabel" style="">上限</label></td>
                                <td id="ctl590869_header3" data-datafield="agency_rates_inApprove.lower_limit" style="">
                                    <label id="ctl590869_Label3" data-datafield="agency_rates_inApprove.lower_limit" data-type="SheetLabel" style="">下限</label></td>
                                <td class="rowOption hidden">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl590869_control0" data-datafield="agency_rates_inApprove.agency_money" style="">
                                    <input type="text" data-datafield="agency_rates_inApprove.agency_money" data-type="SheetTextBox" id="ctl590869_control0" style=""></td>
                                <td id="ctl590869_control1" data-datafield="agency_rates_inApprove.agency_type" style="">
                                    <input type="text" data-datafield="agency_rates_inApprove.agency_type" data-type="SheetTextBox" id="ctl590869_control1" style=""></td>
                                <td id="ctl590869_control2" data-datafield="agency_rates_inApprove.up_limit" style="">
                                    <input type="text" data-datafield="agency_rates_inApprove.up_limit" data-type="SheetTextBox" id="ctl590869_control2" style=""></td>
                                <td id="ctl590869_control3" data-datafield="agency_rates_inApprove.lower_limit" style="">
                                    <input type="text" data-datafield="agency_rates_inApprove.lower_limit" data-type="SheetTextBox" id="ctl590869_control3" style=""></td>
                                <td class="rowOption hidden"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl590869_Stat0" data-datafield="agency_rates_inApprove.agency_money" style="">
                                    <label id="ctl590869_StatControl0" data-datafield="agency_rates_inApprove.agency_money" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl590869_Stat1" data-datafield="agency_rates_inApprove.agency_type" style=""></td>
                                <td id="ctl590869_Stat2" data-datafield="agency_rates_inApprove.up_limit" style=""></td>
                                <td id="ctl590869_Stat3" data-datafield="agency_rates_inApprove.lower_limit" style=""></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
				<div id="title12" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="AgreeMent_number" style="">协议号</span>
				</div>
				<div id="control12" class="col-md-4">
					<input id="Control22" type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox" class="" style="">
				</div>
			</div>
			<div class="row">
				<div id="title13" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="Pay_conditions" style="">支付条件</span>
				</div>
				<div id="control13" class="col-md-4">
					<input id="Control23" type="text" data-datafield="Pay_conditions" data-type="SheetTextBox" class="" style="">
				</div>
				<div id="space14" class="col-md-2">
				</div>
				<div id="spaceControl14" class="col-md-4">
				</div>
			</div>
            <div class="row">
				<div id="title19" class="col-md-2">
					<span id="Label27" data-type="SheetLabel" data-datafield="Agency_Pro_approval" style="">协议稿文件</span>
				</div>
				<div id="control19" class="col-md-10">
                    <input type="text" data-datafield="Agency_Pro_approval" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="Agency_Pro_approval"></div>
				</div>
			</div>
            <div class="row">
				<div id="div613543" class="col-md-2">
					<label data-datafield="remark" data-type="SheetLabel" id="ctl866986" class="" style="">备注</label>
				</div>
				<div id="div726641" class="col-md-10">
					<textarea data-datafield="remark" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl86547" class="">
					</textarea>
				</div>
			</div>
            
			<div class="row tableContent">
				<div id="title15" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="Advice" style="">部门经理审批建议</span>
				</div>
				<div id="control15" class="col-md-10">
					<div id="Control24" data-datafield="Advice" data-type="SheetComment" style="">
						
					</div>
				</div>
			</div>
            <div class="row tableContent">
				<div id="title16" class="col-md-2">
					<span id="Label36" data-type="SheetLabel" data-datafield="GenManagerAdvice" style="">领导审批意见</span>
				</div>
				<div id="control16" class="col-md-10">
					<div id="Control36" data-datafield="GenManagerAdvice" data-type="SheetComment" style="">
						
					</div>
				</div>
			</div>
           
		</div>
        </div>
	</div>

    <script src="../../js/jquery-ui.min.js"></script>
    <script src="../../js/file2.js"></script>
    <script src="../../js/select2.js"></script>
</asp:Content>