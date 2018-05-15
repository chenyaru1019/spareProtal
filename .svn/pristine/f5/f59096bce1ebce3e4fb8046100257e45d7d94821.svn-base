<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZJPlanMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.ZJPlanMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="ZJPlanMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">资金计划</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">资金计划</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="ContractNo" style="">合同号</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="ContractNo" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div117186" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="ContractName" style="" class="">合同名称</span>
                    </div>
                    <div id="div761130" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div443589" class="col-md-2">
                    </div>
                    <div id="div440076" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="PostAB" style="">项目负责人AB</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title4" class="col-md-2">
                    </div>
                    <div id="control4" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div972171" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="ContractTotalAmount" style="" class="">合同总金额</span>
                    </div>
                    <div id="div276150" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="ContractTotalAmount" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div753003" class="col-md-2">
                    </div>
                    <div id="div547448" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="PlanTbl" style="">资金计划明细</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <table id="Control15" data-datafield="PlanTbl" data-type="SheetGridView" class="SheetGridView" >
                            <tbody>

                                <tr class="header">
                                    <td id="Control15_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control15_Header3" data-datafield="PlanTbl.Content" style="width:15%">
                                        <label id="Control15_Label3" data-datafield="PlanTbl.Content" data-type="SheetLabel" style="">资金描述</label>
                                    </td>
                                    <td id="Control15_Header4" data-datafield="PlanTbl.Amount" style="width:15%">
                                        <label id="Control15_Label4" data-datafield="PlanTbl.Amount" data-type="SheetLabel" style="">金额（人民币）</label>
                                    </td>
                                    <td id="ctl638577_header2" data-datafield="PlanTbl.QKCurrency" style="width:12%">
                                        <label id="ctl638577_Label2" data-datafield="PlanTbl.QKCurrency" data-type="SheetLabel" style="">请款币种</label></td>
                                    <td id="ctl638577_header3" data-datafield="PlanTbl.QKDetail"  style="width:20%">
                                        <label id="ctl638577_Label3" data-datafield="PlanTbl.QKDetail" data-type="SheetLabel" style="">请款明细详情</label></td>
                                    <td id="Control15_Header5" data-datafield="PlanTbl.ExpirationFrom" style="width:10%">
                                        <label id="Control15_Label5" data-datafield="PlanTbl.ExpirationFrom" data-type="SheetLabel" style="">有效期开始日</label>
                                    </td>
                                    <td id="Control15_Header6" data-datafield="PlanTbl.ExpirationTo" style="width:10%">
                                        <label id="Control15_Label6" data-datafield="PlanTbl.ExpirationTo" data-type="SheetLabel" style="">有效期结束日</label>
                                    </td>
                                    <td id="Control15_Header7" data-datafield="PlanTbl.IsAfterDK" style="width:8%">
                                        <label id="Control15_Label7" data-datafield="PlanTbl.IsAfterDK" data-type="SheetLabel" style="">是否到款后</label>
                                    </td>
                                    <td class="rowOption">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control15_Option" class="rowOption"></td>
                                    <td data-datafield="PlanTbl.Content">
                                        <input id="Control15_ctl3" type="text" data-datafield="PlanTbl.Content" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="PlanTbl.Amount">
                                        <input id="Control15_ctl4" type="text" data-datafield="PlanTbl.Amount" data-type="SheetTextBox" style="" class="AmountFormat">
                                    </td>
                                    <td id="ctl638577_control2" data-datafield="PlanTbl.QKCurrency" style="" class="">
                                        <select data-datafield="PlanTbl.QKCurrency" data-type="SheetDropDownList" id="ctl676303" class="" style="" data-schemacode="GetQKCurrency" data-querycode="GetQKCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="code" data-datatextfield="code" data-queryable="false"  data-emptyitemtext="请选择" data-displayemptyitem="true"
                                            data-onchange="getQKDetailByCurrency(this)"></select></td>
                                    <td id="ctl638577_control3" data-datafield="PlanTbl.QKDetail" style="">
                                        <textarea data-datafield="PlanTbl.QKDetail" style="height: 60px; width: 100%;word-wrap: break-word; word-break: normal; " data-type="SheetRichTextBox" id="ctl862429_control3"></textarea></td>
                                    <td data-datafield="PlanTbl.ExpirationFrom">
                                        <input id="Control15_ctl5" type="text" data-datafield="PlanTbl.ExpirationFrom" data-type="SheetTime" style="">
                                    </td>
                                    <td data-datafield="PlanTbl.ExpirationTo">
                                        <input id="Control15_ctl6" type="text" data-datafield="PlanTbl.ExpirationTo" data-type="SheetTime" style="">
                                    </td>
                                    <td data-datafield="PlanTbl.IsAfterDK">
                                        <div data-datafield="PlanTbl.IsAfterDK" data-type="SheetCheckboxList" id="ctl47534" class="" style="" data-defaultitems="是" data-repeatcolumns="1">
                                        </div>
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
                                    <td class="rowOption"></td>
                                    <td data-datafield="PlanTbl.Content"></td>
                                    <td data-datafield="PlanTbl.Amount">
                                        <label id="Control15_stat4" data-datafield="PlanTbl.Amount" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td id="ctl638577_Stat2" data-datafield="PlanTbl.QKCurrency" style=""></td>
                                    <td id="ctl638577_Stat3" data-datafield="PlanTbl.QKDetail" style=""></td>
                                    <td data-datafield="PlanTbl.ExpirationFrom"></td>
                                    <td data-datafield="PlanTbl.ExpirationTo"></td>
                                    <td data-datafield="PlanTbl.IsAfterDK"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Remark" style="">备注</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <textarea id="Control16" data-datafield="Remark" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
