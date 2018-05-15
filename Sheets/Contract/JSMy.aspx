﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JSMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.JSMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="JSMy.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">结算子流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
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
                        <span id="Label12" data-type="SheetLabel" data-datafield="ContractName" style="">合同名称</span>
                    </div>
                    <div id="control2" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="width:70%">
                        <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="PostAB" style="">项目负责人AB</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="">
                    </div>
                    <div id="space4" class="col-md-2">
                    </div>
                    <div id="spaceControl4" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="DKTblOfJS" style="">到款记录</span>
                    </div>
                    <div id="control5" class="col-md-10">

                        <table id="ctl784745" data-datafield="DKTblOfJS" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl784745_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl784745_header0" data-datafield="DKTblOfJS.IsCheck" style="width: 5%">
                                        <label id="ctl784745_Label0" data-datafield="DKTblOfJS.IsCheck" data-type="SheetLabel" style="">选择</label></td>
                                    <%--<td id="ctl784745_header1" data-datafield="DKTblOfJS.TheNo" style="width: 5%">
                                        <label id="ctl784745_Label1" data-datafield="DKTblOfJS.TheNo" data-type="SheetLabel" style="">序号</label></td>--%>
                                    <td id="ctl784745_header2" data-datafield="DKTblOfJS.QKTarget" style="width: 10%">
                                        <label id="ctl784745_Label2" data-datafield="DKTblOfJS.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                    <td id="Control18_Header4" data-datafield="DKTblOfJS.QKType" style="width: 6%">
                                        <label id="Control18_Label4" data-datafield="DKTblOfJS.QKType" data-type="SheetLabel" style="">请款类型</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="DKTblOfJS.ZJKX" style="width: 6%">
                                        <label id="Control18_Label7" data-datafield="DKTblOfJS.ZJKX" data-type="SheetLabel" style="">资金款项</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="DKTblOfJS.ZJMS" style="width: 8%">
                                        <label id="Control18_Label8" data-datafield="DKTblOfJS.ZJMS" data-type="SheetLabel" style="">资金描述</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="DKTblOfJS.QKAmount" style="width: 8%">
                                        <label id="Control18_Label9" data-datafield="DKTblOfJS.QKAmount" data-type="SheetLabel" style="">请款金额</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DKTblOfJS.QKCurrencyName" style="width: 6%">
                                        <label id="Control18_Label10" data-datafield="DKTblOfJS.QKCurrencyName" data-type="SheetLabel" style="">请款币种</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DKTblOfJS.QKCurrency" class="hidden">
                                        <label id="Control18_Label10" data-datafield="DKTblOfJS.QKCurrency" data-type="SheetLabel" style="">请款币种Code</label>
                                    </td>
                                    <td id="Control18_Header11" data-datafield="DKTblOfJS.QKConvertAmount" style="width: 8%">
                                        <label id="Control18_Label11" data-datafield="DKTblOfJS.QKConvertAmount" data-type="SheetLabel" style="">折算金额</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTblOfJS.SeqCnt" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTblOfJS.SeqCnt" data-type="SheetLabel" style="" class="">SeqCnt</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTblOfJS.QKCurrencyCnt" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTblOfJS.QKCurrencyCnt" data-type="SheetLabel" style="" class="">QKCurrencyCnt</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTblOfJS.QKObjectID" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTblOfJS.QKObjectID" data-type="SheetLabel" style="" class="">QKObjectID</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTblOfJS.QKSubObjectID" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTblOfJS.QKSubObjectID" data-type="SheetLabel" style="" class="">QKSubObjectID</label>
                                    </td>
                                    <td id="ctl784745_header3" data-datafield="DKTblOfJS.DKType" style="width: 6%">
                                        <label id="ctl784745_Label3" data-datafield="DKTblOfJS.DKType" data-type="SheetLabel" style="">到款类型</label></td>
                                    <td id="ctl784745_header4" data-datafield="DKTblOfJS.CurDKAmount" style="width: 8%">
                                        <label id="ctl784745_Label4" data-datafield="DKTblOfJS.CurDKAmount" data-type="SheetLabel" style="">到款金额</label></td>
                                    <td id="ctl784745_header7" data-datafield="DKTblOfJS.CurDKCurrency" style="width: 6%" class="">
                                        <label id="ctl784745_Label7" data-datafield="DKTblOfJS.CurDKCurrency" data-type="SheetLabel" style="">到款币种</label></td>
                                    <td id="ctl784745_header5" data-datafield="DKTblOfJS.DKDate" style="width: 8%">
                                        <label id="ctl784745_Label5" data-datafield="DKTblOfJS.DKDate" data-type="SheetLabel" style="">到款日期</label></td>
                                    <td id="ctl784745_header6" data-datafield="DKTblOfJS.Operate" style="width: 8%">
                                        <label id="ctl784745_Label6" data-datafield="DKTblOfJS.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl784745_header7" data-datafield="DKTblOfJS.WorkItemId" style="" class="hidden">
                                        <label id="ctl784745_Label7" data-datafield="DKTblOfJS.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                    <td id="ctl784745_header7" data-datafield="DKTblOfJS.DKObjectID" style="" class="hidden">
                                        <label id="ctl784745_Label7" data-datafield="DKTblOfJS.DKObjectID" data-type="SheetLabel" style="">DKObjectID</label></td>

                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl784745_control0" data-datafield="DKTblOfJS.IsCheck" style="">
                                        <div data-datafield="DKTblOfJS.IsCheck" data-type="SheetCheckboxList" id="ctl401830" class="" style="" data-defaultitems="是" data-repeatcolumns="1" data-onchange="compute()"></div>
                                    </td>
                                    <%--<td id="ctl784745_control1" data-datafield="DKTblOfJS.TheNo" style="">
                                        <input type="text" data-datafield="DKTblOfJS.TheNo" data-type="SheetTextBox" id="ctl784745_control1" style=""></td>--%>
                                    <td id="ctl784745_control2" data-datafield="DKTblOfJS.QKTarget" style="">
                                        <input type="text" data-datafield="DKTblOfJS.QKTarget" data-type="SheetTextBox" id="ctl784745_control2" style=""></td>
                                    <td data-datafield="DKTblOfJS.QKType">
                                        <input id="Control18_ctl4" type="text" data-datafield="DKTblOfJS.QKType" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.ZJKX">
                                        <input id="Control18_ctl7" type="text" data-datafield="DKTblOfJS.ZJKX" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.ZJMS">
                                        <input id="Control18_ctl8" type="text" data-datafield="DKTblOfJS.ZJMS" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKAmount">
                                        <input id="Control18_ctl9" type="text" data-datafield="DKTblOfJS.QKAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKCurrency">
                                        <input id="Control18_ctl10" type="text" data-datafield="DKTblOfJS.QKCurrencyName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKCurrencyCode" class="hidden">
                                        <input id="Control18_ctl10" type="text" data-datafield="DKTblOfJS.QKCurrency" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKConvertAmount">
                                        <input id="Control18_ctl11" type="text" data-datafield="DKTblOfJS.QKConvertAmount" data-type="SheetTextBox" style="" class="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.SeqCnt" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTblOfJS.SeqCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKCurrencyCnt" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTblOfJS.QKCurrencyCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKObjectID" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTblOfJS.QKObjectID" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTblOfJS.QKSubObjectID" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTblOfJS.QKSubObjectID" data-type="SheetTextBox" style="">
                                    </td>
                                    <td id="ctl784745_control3" data-datafield="DKTblOfJS.DKType" style="">
                                        <input type="text" data-datafield="DKTblOfJS.DKType" data-type="SheetTextBox" id="ctl784745_control3" style=""></td>
                                    <td id="ctl784745_control4" data-datafield="DKTblOfJS.CurDKAmount" style="">
                                        <input type="text" data-datafield="DKTblOfJS.CurDKAmount" data-type="SheetTextBox" class="AmountFormat" id="ctl784745_control4" style=""></td>
                                    <td id="ctl784745_control7" data-datafield="DKTblOfJS.CurDKCurrency" style="">
                                        <input type="text" data-datafield="DKTblOfJS.CurDKCurrency" data-type="SheetTextBox" id="ctl784745_control7" style=""></td>
                                    <td id="ctl784745_control5" data-datafield="DKTblOfJS.DKDate" style="">
                                        <input type="text" data-datafield="DKTblOfJS.DKDate" data-type="SheetTextBox" id="ctl784745_control5" style=""></td>
                                    <td id="ctl784745_control6" data-datafield="DKTblOfJS.Operate" style="" align="center">
                                        <a class="btn btn-primary viewDK" onclick="viewDK(this)">查看</a></td>
                                    <td id="ctl784745_control7" data-datafield="DKTblOfJS.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="DKTblOfJS.WorkItemId" data-type="SheetTextBox" id="ctl784745_control7" style=""></td>
                                    <td id="ctl784745_control7" data-datafield="DKTblOfJS.DKObjectID" style="" class="hidden">
                                        <input type="text" data-datafield="DKTblOfJS.DKObjectID" data-type="SheetTextBox" id="ctl784745_control7" style=""></td>

                                    <td class="rowOption hidden"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="FKTblOfJS" style="">付款记录</span>
                    </div>
                    <div id="control7" class="col-md-10">

                        <table id="ctl605304" data-datafield="FKTblOfJS" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl605304_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl605304_header0" data-datafield="FKTblOfJS.IsCheck" style="width:5%">
                                        <label id="ctl605304_Label0" data-datafield="FKTblOfJS.IsCheck" data-type="SheetLabel" style="">选择</label></td>
                                    <td id="ctl605304_header1" data-datafield="FKTblOfJS.TheNo" style="width:5%">
                                        <label id="ctl605304_Label1" data-datafield="FKTblOfJS.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                    <td id="ctl605304_header2" data-datafield="FKTblOfJS.Receiver" style="width:20%">
                                        <label id="ctl605304_Label2" data-datafield="FKTblOfJS.Receiver" data-type="SheetLabel" style="">受款人</label></td>
                                    <td id="ctl605304_header3" data-datafield="FKTblOfJS.ZKMS" style="width:15%">
                                        <label id="ctl605304_Label3" data-datafield="FKTblOfJS.ZKMS" data-type="SheetLabel" style="">支付描述</label></td>
                                    <td id="ctl605304_header4" data-datafield="FKTblOfJS.FKAmount" style="width:10%">
                                        <label id="ctl605304_Label4" data-datafield="FKTblOfJS.FKAmount" data-type="SheetLabel" style="">付款金额</label></td>
                                    <td id="ctl605304_header4" data-datafield="FKTblOfJS.FKCurrency" style="width:10%">
                                        <label id="ctl605304_Label4" data-datafield="FKTblOfJS.FKCurrency" data-type="SheetLabel" style="">付款币种</label></td>
                                    <td id="ctl605304_header5" data-datafield="FKTblOfJS.ConvertAmount" style="width:10%">
                                        <label id="ctl605304_Label5" data-datafield="FKTblOfJS.ConvertAmount" data-type="SheetLabel" style="">折算金额</label></td>
                                    <td id="ctl605304_header6" data-datafield="FKTblOfJS.FKDate" style="width:10%">
                                        <label id="ctl605304_Label6" data-datafield="FKTblOfJS.FKDate" data-type="SheetLabel" style="">付款日期</label></td>
                                    <td id="ctl605304_header7" data-datafield="FKTblOfJS.Operate" style="width:10%">
                                        <label id="ctl605304_Label7" data-datafield="FKTblOfJS.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl605304_header8" data-datafield="FKTblOfJS.WorkItemId" style="" class="hidden">
                                        <label id="ctl605304_Label8" data-datafield="FKTblOfJS.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                    <td id="ctl605304_header8" data-datafield="FKTblOfJS.FKObjectID" style="" class="hidden">
                                        <label id="ctl605304_Label8" data-datafield="FKTblOfJS.FKObjectID" data-type="SheetLabel" style="">FKObjectID</label></td>
                                    <td id="ctl605304_header8" data-datafield="FKTblOfJS.Cnt" style="" class="hidden">
                                        <label id="ctl605304_Label8" data-datafield="FKTblOfJS.Cnt" data-type="SheetLabel" style="">Cnt</label></td>
                                    <td id="ctl605304_header8" data-datafield="FKTblOfJS.BankFee" style="" class="hidden">
                                        <label id="ctl605304_Label8" data-datafield="FKTblOfJS.BankFee" data-type="SheetLabel" style="">BankFee</label></td>
                                    <td id="ctl605304_header8" data-datafield="FKTblOfJS.AgencyFee" style="" class="hidden">
                                        <label id="ctl605304_Label8" data-datafield="FKTblOfJS.AgencyFee" data-type="SheetLabel" style="">AgencyFee</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl605304_control0" data-datafield="FKTblOfJS.IsCheck" style="" class="">
                                        <div data-datafield="FKTblOfJS.IsCheck" data-type="SheetCheckboxList" id="ctl27866" class="" style="" data-defaultitems="是" data-repeatcolumns="1" data-onchange="FKRowChange()"></div>
                                    </td>
                                    <td id="ctl605304_control1" data-datafield="FKTblOfJS.TheNo" style="">
                                        <input type="text" data-datafield="FKTblOfJS.TheNo" data-type="SheetTextBox" id="ctl605304_control1" style=""></td>
                                    <td id="ctl605304_control2" data-datafield="FKTblOfJS.Receiver" style="">
                                        <input type="text" data-datafield="FKTblOfJS.Receiver" data-type="SheetTextBox" id="ctl605304_control2" style=""></td>
                                    <td id="ctl605304_control3" data-datafield="FKTblOfJS.ZKMS" style="">
                                        <input type="text" data-datafield="FKTblOfJS.ZKMS" data-type="SheetTextBox" id="ctl605304_control3" style=""></td>
                                    <td id="ctl605304_control4" data-datafield="FKTblOfJS.FKAmount" style="">
                                        <input type="text" data-datafield="FKTblOfJS.FKAmount" data-type="SheetTextBox" class="AmountFormat" id="ctl605304_control4" style=""></td>
                                    <td id="ctl605304_control4" data-datafield="FKTblOfJS.FKCurrency" style="">
                                        <input type="text" data-datafield="FKTblOfJS.FKCurrency" data-type="SheetTextBox" id="ctl605304_control4" style=""></td>
                                    <td id="ctl605304_control5" data-datafield="FKTblOfJS.ConvertAmount" style="">
                                        <input type="text" data-datafield="FKTblOfJS.ConvertAmount" data-type="SheetTextBox" id="ctl605304_control5" style=""></td>
                                    <td id="ctl605304_control6" data-datafield="FKTblOfJS.FKDate" style="">
                                        <input type="text" data-datafield="FKTblOfJS.FKDate" data-type="SheetTextBox" id="ctl605304_control6" style=""></td>
                                    <td id="ctl605304_control7" data-datafield="FKTblOfJS.Operate" style="" align="center">
                                        <a class="btn btn-primary viewFK" onclick="viewFK(this)">查看</a></td>
                                    <td id="ctl605304_control8" data-datafield="FKTblOfJS.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="FKTblOfJS.WorkItemId" data-type="SheetTextBox" id="ctl605304_control8" style=""></td>
                                    <td id="ctl605304_control8" data-datafield="FKTblOfJS.FKObjectID" style="" class="hidden">
                                        <input type="text" data-datafield="FKTblOfJS.FKObjectID" data-type="SheetTextBox" id="ctl605304_control8" style=""></td>
                                    <td id="ctl605304_control8" data-datafield="FKTblOfJS.Cnt" style="" class="hidden">
                                        <input type="text" data-datafield="FKTblOfJS.Cnt" data-type="SheetTextBox" id="ctl605304_control8" style=""></td>
                                    <td id="ctl605304_control8" data-datafield="FKTblOfJS.BankFee" style="" class="hidden">
                                        <input type="text" data-datafield="FKTblOfJS.BankFee" data-type="SheetTextBox" id="ctl605304_control8" style=""></td>
                                    <td id="ctl605304_control8" data-datafield="FKTblOfJS.AgencyFee" style="" class="hidden">
                                        <input type="text" data-datafield="FKTblOfJS.AgencyFee" data-type="SheetTextBox" id="ctl605304_control8" style=""></td>
                                    <td class="rowOption hidden"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="div634011" class="col-md-2"><span id="Label16" data-type="SheetLabel" data-datafield="LJDKAmountRMB" style="" class="">本次结算累计到款金额</span></div>
                    <div id="div262534" class="col-md-2 normal">
                        <input id="Control16" type="text" data-datafield="LJDKAmountRMB" data-type="SheetTextBox" style="width:70%" class="AmountFormat" ><span class="CurrencyRMB"></span>
                    </div>
                    <div id="div232038" class="col-md-2 normal">
                        <input id="Control17" type="text" data-datafield="LJDKAmountWB" data-type="SheetTextBox" style="width:70%" class="AmountFormat" ><span class="CurrencyWB"></span>
                    </div>
                    <div id="div902917" class="col-md-2"><span id="Label20" data-type="SheetLabel" data-datafield="LJFKAmountRMB" style="" class="">本次结算累计付款金额</span></div>
                    <div id="div341416" class="col-md-2 normal">
                        <input id="Control20" type="text" data-datafield="LJFKAmountRMB" data-type="SheetTextBox" style="width:70%" class="AmountFormat" ><span class="CurrencyRMB"></span>
                    </div>
                    <div id="div318922" class="col-md-2 normal">
                        <input id="Control21" type="text" data-datafield="LJFKAmountWB" data-type="SheetTextBox" style="width:70%" class="AmountFormat" ><span class="CurrencyWB"></span>
                    </div>
                </div>


                <div class="row">
                    <div id="div565401" class="col-md-2"><label style="display: block;">额外付款费用</label></div>
                </div>
                <div class="row">
                    <div id="div745262" class="col-md-2"><span id="Label22" data-type="SheetLabel" data-datafield="BankFY" style="" class="">银行费用</span></div>
                    <div id="div881164" class="col-md-2 normal">
                        <input id="Control22" type="text" data-datafield="BankFY" data-type="SheetTextBox" style="width:70%" class="AmountFormat"  readonly><span class="CurrencyRMB"></span>
                    </div>
                    <div id="div667272" class="col-md-8"></div>
                </div>
                <div class="row">
                    <div id="div310994" class="col-md-2"><span id="Label23" data-type="SheetLabel" data-datafield="AgencyFY" style="" class="">代理费</span></div>
                    <div id="div902597" class="col-md-2 normal">
                        <input id="Control23" type="text" data-datafield="AgencyFY" data-type="SheetTextBox" style="width:70%" class="AmountFormat"  readonly><span class="CurrencyRMB"></span>
                    </div>
                    <div id="div493115" class="col-md-2 normal">
                        （<input id="Control24" type="text" data-datafield="AgencyFYWB" data-type="SheetTextBox" style="width:70%" class="AmountFormat" ><span class="CurrencyWB"></span>）
                    </div>
                    <div id="div878255" class="col-md-6"></div>
                </div>
                <div class="row">
                    <div id="div14343" class="col-md-2"><span id="Label25" data-type="SheetLabel" data-datafield="OtherFY" style="" class="">其他费用</span></div>
                    <div id="div503210" class="col-md-2 normal">
                        <input id="Control25" type="text" data-datafield="OtherFY" data-type="SheetTextBox" style="width:70%" class="AmountFormat"  data-onchange="compute()"><span class="CurrencyRMB"></span>
                    </div>
                    <div id="div306048" class="col-md-8"></div>
                </div>
                <div class="row">
                    <div id="title19" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="JSResult" style="">结算结果</span>
                    </div>
                    <div id="control18" class="col-md-1 RowHeight">
                        <input id="Control25" type="text" data-datafield="JSStatus" data-type="SheetTextBox" style="">
                    </div>
                    <div id="control19" class="col-md-3 RowHeight">
                        <input id="Control26" type="text" data-datafield="JSResult" data-type="SheetTextBox" style="width:70%"><span class="CurrencyRMB"></span>
                    </div>
                    <div id="space20" class="col-md-6">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title23" class="col-md-2">
                        <span id="Label28" data-type="SheetLabel" data-datafield="ConfirmComment" style="">复核备注</span>
                    </div>
                    <div id="control23" class="col-md-10">
                        <div id="Control28" data-datafield="ConfirmComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div7798" class="col-md-2">
                        <input id="Control29" type="text" data-datafield="RejectFlg" data-type="SheetTextBox" style="" class="hidden">
                    </div>
                    <div id="div163771" class="col-md-2">
                        <input id="Control18" type="text" data-datafield="CurrencyRMB" data-type="SheetTextBox" style="" class="hidden">
                    </div>
                    <div id="div492017" class="col-md-2">
                        <input id="Control19" type="text" data-datafield="CurrencyWB" data-type="SheetTextBox" style="" class="hidden">
                    </div>
                    <div id="div940854" class="col-md-2">
                        <input id="Control19" type="text" data-datafield="QK_FK_Status" data-type="SheetTextBox" style="" class="hidden">
                    </div>
                    <div id="div432485" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div734259" class="col-md-2">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">结算回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackJSTbl" data-type="SheetLabel" id="ctl280690" class="" style="">结算回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackJSTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackJSTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackJSTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackJSTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackJSTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackJSTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackJSTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackJSTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackJSTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackJSTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackJSTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackJSTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackJSTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackJSTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackJSTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackJSTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackJSTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackJSTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackJSTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackJSTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackJSTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackJSTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackJSTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackJSTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackJSTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackJSTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackJSTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
                                    <td class="rowOption hidden"><a class="delete">
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

        <div class="ContractContent">
            <label data-en_us="Sheet information">处理记录</label>
            <div class="myTable">
                <table data-toggle="table" class="table table-striped table-bordered table-hover ApprovalTbl"></table>
            </div>
        </div>
    </div>

    <script src="../js/ApprovalTbl.js"></script>
</asp:Content>
