<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agreement_pigeonhole.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Agreement_pigeonhole" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script src="Agreement_pigeonhole.js"></script>
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">协议归档</label>
</div>
<div class="panel-body sheetContainer">
	<div class="ContractContent ">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			
			
            <div class="row">
                <div id="div190809" class="col-md-2">
                    <label data-datafield="AgreeMent_number" data-type="SheetLabel" id="ctl820253" class="" style="">协议编号</label></div>
                <div id="div620348" class="col-md-4">
                    <input type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox" id="ctl144337" class="" style=""></div>
                <div id="div243534" class="col-md-2">
                    <label data-datafield="Agreement_name" data-type="SheetLabel" id="ctl947451" class="" style="">协议名称</label></div>
                <div id="div872109" class="col-md-4">
                    <input type="text" data-datafield="Agreement_name" data-type="SheetTextBox" id="ctl252165" class="" style=""></div>
            </div>
            <div class="row">
                <div id="div536373" class="col-md-2">
                    <label data-datafield="Project_man" data-type="SheetLabel" id="ctl103882" class="" style="">项目负责人</label></div>
                <div id="div976854" class="col-md-4">
                    <input type="text" data-datafield="Project_man" data-type="SheetTextBox" id="ctl533703" class="" style=""></div>
                <div id="div322625" class="col-md-2">
                    <label data-datafield="Agreement_clint" data-type="SheetLabel" id="ctl335298" class="" style="">协议委托人</label></div>
                <div id="div962362" class="col-md-4">
                    <input type="text" data-datafield="Agreement_clint" data-type="SheetTextBox" id="ctl931617" class="" style=""></div>
            </div>
            <%--<div class="row">
                <div id="div641273" class="col-md-2">
                    <label data-datafield="Agency_rate" data-type="SheetLabel" id="ctl618669" class="" style="">代理费率/金额</label></div>
                <div id="div102385" class="col-md-10">
                    <input type="text" data-datafield="Agency_rate" data-type="SheetTextBox" id="ctl906543" class="" style=""></div>
            </div>--%>
            <div class="row">
                <div id="div209016" class="col-md-2">
                    <label data-datafield="agency_rates_gd" data-type="SheetLabel" id="ctl859323" class="" >代理费率/金额</label></div>
                <div id="div639122" class="col-md-4">
                    <table id="ctl223957" data-datafield="agency_rates_gd" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                        <tbody>
                            <tr class="header">
                                <td id="ctl223957_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl223957_header0" data-datafield="agency_rates_gd.agency_money" style="width:20%">
                                    <label id="ctl223957_Label0" data-datafield="agency_rates_gd.agency_money" data-type="SheetLabel" style="">代理费</label></td>
                                <td id="ctl223957_header1" data-datafield="agency_rates_gd.agency_type" style="width:40%">
                                    <label id="ctl223957_Label1" data-datafield="agency_rates_gd.agency_type" data-type="SheetLabel" style="">代理费类型</label></td>
                                <td id="ctl223957_header2" data-datafield="agency_rates_gd.up_limit" style="width:20%">
                                    <label id="ctl223957_Label2" data-datafield="agency_rates_gd.up_limit" data-type="SheetLabel" style="">上限</label></td>
                                <td id="ctl223957_header3" data-datafield="agency_rates_gd.lower_limit" style="width:20%">
                                    <label id="ctl223957_Label3" data-datafield="agency_rates_gd.lower_limit" data-type="SheetLabel" style="">下限</label></td>
                                <td class="rowOption">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl223957_control0" data-datafield="agency_rates_gd.agency_money" style="">
                                    <input type="text" data-datafield="agency_rates_gd.agency_money" data-type="SheetTextBox" id="ctl223957_control0" style=""></td>
                                <td id="ctl223957_control1" data-datafield="agency_rates_gd.agency_type" style="">
                                    <input type="text" data-datafield="agency_rates_gd.agency_type" data-type="SheetTextBox" id="ctl223957_control1" style=""></td>
                                <td id="ctl223957_control2" data-datafield="agency_rates_gd.up_limit" style="">
                                    <input type="text" data-datafield="agency_rates_gd.up_limit" data-type="SheetTextBox" id="ctl223957_control2" style=""></td>
                                <td id="ctl223957_control3" data-datafield="agency_rates_gd.lower_limit" style="" class="">
                                    <input type="text" data-datafield="agency_rates_gd.lower_limit" data-type="SheetTextBox" id="ctl223957_control3" style=""></td>
                                <td class="rowOption"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl223957_Stat0" data-datafield="agency_rates_gd.agency_money" style="" class="">
                                    <label id="ctl223957_StatControl0" data-datafield="agency_rates_gd.agency_money" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl223957_Stat1" data-datafield="agency_rates_gd.agency_type" style=""></td>
                                <td id="ctl223957_Stat2" data-datafield="agency_rates_gd.up_limit" style="" class=""></td>
                                <td id="ctl223957_Stat3" data-datafield="agency_rates_gd.lower_limit" style=""></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            <div class="row">
                <div id="div298397" class="col-md-2">
                    <label data-datafield="Pay_condition" data-type="SheetLabel" id="ctl377944" class="" style="">支付条件</label></div>
                <div id="div73931" class="col-md-4">
                    <input type="text" data-datafield="Pay_condition" data-type="SheetTextBox" id="ctl403387" class="" style=""></div>
            </div>
            <div class="row">
                <div id="div249349" class="col-md-2">
                    <label data-datafield="Remarks" data-type="SheetLabel" id="ctl681368" class="" style="">备注</label></div>
                <div id="div870868" class="col-md-10">
                    <textarea data-datafield="Remarks" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl512723" class=""></textarea></div>
            </div>
            <div class="row">
                <div id="div404508" class="col-md-2">
                    <label data-datafield="Agency_original" data-type="SheetLabel" id="ctl325477" class="" style="">代理协议正本</label></div>
                <div id="div674165" class="col-md-10">
                    <input type="text" data-datafield="Agency_original" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="Agency_original"></div>
                </div>
            </div>
            <div class="row">
                <div id="div499777" class="col-md-2">
                    <label data-datafield="Agency_change" data-type="SheetLabel" id="ctl764560" class="" style="">代理协议变更书</label></div>
                <div id="div112258" class="col-md-10">
                    <input type="text" data-datafield="Agency_change" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="Agency_change"></div>
                </div>
            </div>
            <div class="row">
                <div id="div848940" class="col-md-2">
                    <label data-datafield="GDComment" data-type="SheetLabel" id="ctl293431" class="" style="">审批意见</label></div>
                <div id="div641673" class="col-md-10">
                    <div data-datafield="GDComment" data-type="SheetComment" id="ctl837478" class="" style=""></div>
                </div>
            </div>
            <div class="row hidden">
                <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="agency_type" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
            </div>
		</div>
        </div>
	</div>

    <script src="../../js/jquery-ui.min.js"></script>
    <script src="../../js/file2.js"></script>
    <script src="../../js/select2.js"></script>
</asp:Content>
