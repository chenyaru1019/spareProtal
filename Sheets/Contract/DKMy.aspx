﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.DKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../css/common.css">
        <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <script src="DKMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">到款子流程</label>
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
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div798147" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="ContractName" class="" style="">合同名称</span>
                    </div>
                    <div id="div510672" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="width:70%">
                        <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                    </div>
                    <div id="div780750" class="col-md-2">
                    </div>
                    <div id="div683020" class="col-md-4">
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
                    <div id="div996486" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="DKAmount" class="" style="">到款金额</span>
                    </div>
                    <div id="div807572" class="col-md-2 normal">
                        <input id="Control15" type="text" data-datafield="DKAmount" data-type="SheetTextBox" class="AmountFormat" style="">
                    </div>
                    <div id="div341630" class="col-md-2 normal">
                        <select data-datafield="DKCurrency" data-type="SheetDropDownList" id="ctl860608" class="" style="" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-queryable="false"
                            data-onchange="DKCurrencyChange()"></select>
                    </div>
                    <div id="div960215" class="col-md-2">
                    </div>
                    <div id="div383326" class="col-md-4">
                    </div>
                </div>
                
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">申请备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-12">
                        <span id="Label18" data-type="SheetLabel" data-datafield="DKTbl" style="">到款列表</span>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="control9" class="col-md-12">
                        <table id="Control18" data-datafield="DKTbl" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control18_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control18_Header3" data-datafield="DKTbl.QKSeq" style="width:3%">
                                        <label id="Control18_Label3" data-datafield="DKTbl.QKSeq" data-type="SheetLabel" style="">请款批次</label>
                                    </td>
                                    <td id="Control18_Header3" data-datafield="DKTbl.QKSeqHidden" class="hidden">
                                        <label id="Control18_Label3" data-datafield="DKTbl.QKSeqHidden" data-type="SheetLabel" style="">请款批次Hidden</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="DKTbl.QKTypeCode" style="" class="hidden">
                                        <label id="Control18_Label4" data-datafield="DKTbl.QKTypeCode" data-type="SheetLabel" style="">请款类型Code</label>
                                    </td>
                                    <td id="Control18_Header5" data-datafield="DKTbl.QKTarget" style="width:8%">
                                        <label id="Control18_Label5" data-datafield="DKTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="DKTbl.QKTargetCode" style="" class="hidden">
                                        <label id="Control18_Label4" data-datafield="DKTbl.QKTargetCode" data-type="SheetLabel" style="">请款对象Code</label>
                                    </td>
                                    <td id="Control18_Header6" data-datafield="DKTbl.QKDate"  style="width:7%">
                                        <label id="Control18_Label6" data-datafield="DKTbl.QKDate" data-type="SheetLabel" style="">请款日期</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="DKTbl.QKType" style="width:5%">
                                        <label id="Control18_Label4" data-datafield="DKTbl.QKType" data-type="SheetLabel" style="">请款类型</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="DKTbl.ZJKX"  style="width:5%">
                                        <label id="Control18_Label7" data-datafield="DKTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="DKTbl.ZJMS"  style="width:7%">
                                        <label id="Control18_Label8" data-datafield="DKTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="DKTbl.QKAmount"  style="width:8%">
                                        <label id="Control18_Label9" data-datafield="DKTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DKTbl.QKCurrencyName"  style="width:4%">
                                        <label id="Control18_Label10" data-datafield="DKTbl.QKCurrencyName" data-type="SheetLabel" style="">请款<br />币种</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DKTbl.QKRate"  style="width:4%">
                                        <label id="Control18_Label10" data-datafield="DKTbl.QKRate" data-type="SheetLabel" style="">请款<br />汇率</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DKTbl.QKCurrency"  class="hidden">
                                        <label id="Control18_Label10" data-datafield="DKTbl.QKCurrency" data-type="SheetLabel" style="">请款币种Code</label>
                                    </td>
                                    <td id="Control18_Header11" data-datafield="DKTbl.QKConvertAmount"  style="width:8%">
                                        <label id="Control18_Label11" data-datafield="DKTbl.QKConvertAmount" data-type="SheetLabel" style="">折算金额</label>
                                    </td>
                                    <%--<td id="Control18_Header12" data-datafield="DKTbl.LJDKAmount_RMB" class="hidden">
                                        <label id="Control18_Label12" data-datafield="DKTbl.LJDKAmount_RMB" data-type="SheetLabel" style="" class="">已累积到款(RMB)</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTbl.LJDKAmount_WB" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTbl.LJDKAmount_WB" data-type="SheetLabel" style="" class="">已累计到款（外币）</label>
                                    </td>--%>
                                    <td id="Control18_Header13" data-datafield="DKTbl.SeqCnt" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTbl.SeqCnt" data-type="SheetLabel" style="" class="">SeqCnt</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTbl.QKCurrencyCnt" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTbl.QKCurrencyCnt" data-type="SheetLabel" style="" class="">QKCurrencyCnt</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTbl.QKObjectID" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTbl.QKObjectID" data-type="SheetLabel" style="" class="">QKObjectID</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTbl.QKSubObjectID" class="hidden">
                                        <label id="Control18_Label13" data-datafield="DKTbl.QKSubObjectID" data-type="SheetLabel" style="" class="">QKSubObjectID</label>
                                    </td>
                                    <td id="Control18_Header14" data-datafield="DKTbl.DKType"  style="width:5%">
                                        <label id="Control18_Label14" data-datafield="DKTbl.DKType" data-type="SheetLabel" style="">到款类型</label>
                                    </td>
                                    <td id="Control18_Header14" data-datafield="DKTbl.LJDKAmount"  style="width:7%">
                                        <label id="Control18_Label14" data-datafield="DKTbl.LJDKAmount" data-type="SheetLabel" style="">累计人民币</label>
                                    </td>
                                    <td id="Control18_Header13" data-datafield="DKTbl.LJDKAmountWB" class="width:7%">
                                        <label id="Control18_Label13" data-datafield="DKTbl.LJDKAmountWB" data-type="SheetLabel" style="" class="">累计外币</label>
                                    </td>
                                    <td id="Control18_Header15" data-datafield="DKTbl.CurDKAmount"  style="width:8%">
                                        <label id="Control18_Label15" data-datafield="DKTbl.CurDKAmount" data-type="SheetLabel" style="">本次金额</label>
                                    </td>
                                    <td id="Control18_Header15" data-datafield="DKTbl.CurDKAmountHidden" class="hidden">
                                        <label id="Control18_Label15" data-datafield="DKTbl.CurDKAmountHidden" data-type="SheetLabel" style="">本次金额Hidden</label>
                                    </td>
                                    <td id="Control18_Header16" data-datafield="DKTbl.CurDKCurrency"  style="width:6%">
                                        <label id="Control18_Label16" data-datafield="DKTbl.CurDKCurrency" data-type="SheetLabel" style="">本次币种</label>
                                    </td>
                                    <td id="Control18_Header15" data-datafield="DKTbl.CurDKRate"  style="width:4%">
                                        <label id="Control18_Label15" data-datafield="DKTbl.CurDKRate" data-type="SheetLabel" style="">汇率</label>
                                    </td>
                                    <td id="Control18_Header17" data-datafield="DKTbl.Status"  style="width:5%">
                                        <label id="Control18_Label17" data-datafield="DKTbl.Status" data-type="SheetLabel" style="">状态</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control18_Option" class="rowOption"></td>
                                    <td data-datafield="DKTbl.QKSeq">
                                        <input id="Control18_ctl3" type="text" data-datafield="DKTbl.QKSeq" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKSeqHidden"  class="hidden">
                                        <input id="Control18_ctl3" type="text" data-datafield="DKTbl.QKSeqHidden" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKTypeCode" class="hidden">
                                        <input id="Control18_ctl4" type="text" data-datafield="DKTbl.QKTypeCode" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKTarget">
                                        <input id="Control18_ctl5" type="text" data-datafield="DKTbl.QKTarget" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKTargetCode" class="hidden">
                                        <input id="Control18_ctl4" type="text" data-datafield="DKTbl.QKTargetCode" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKDate">
                                        <input id="Control18_ctl6" type="text" data-datafield="DKTbl.QKDate" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKType">
                                        <input id="Control18_ctl4" type="text" data-datafield="DKTbl.QKType" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.ZJKX">
                                        <input id="Control18_ctl7" type="text" data-datafield="DKTbl.ZJKX" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.ZJMS">
                                        <input id="Control18_ctl8" type="text" data-datafield="DKTbl.ZJMS" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKAmount">
                                        <input id="Control18_ctl9" type="text" data-datafield="DKTbl.QKAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                                    </td>
                                    <td data-datafield="DKTbl.QKCurrency">
                                        <input id="Control18_ctl10" type="text" data-datafield="DKTbl.QKCurrencyName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKRate">
                                        <input id="Control18_ctl9" type="text" data-datafield="DKTbl.QKRate" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKCurrencyCode" class="hidden">
                                        <input id="Control18_ctl10" type="text" data-datafield="DKTbl.QKCurrency" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKConvertAmount">
                                        <input id="Control18_ctl11" type="text" data-datafield="DKTbl.QKConvertAmount" data-type="SheetTextBox" style="" class="">
                                    </td>
                                    <%--<td data-datafield="DKTbl.LJDKAmount_RMB" class="hidden">
                                        <input id="Control18_ctl12" type="text" data-datafield="DKTbl.LJDKAmount_RMB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.LJDKAmount_WB" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.LJDKAmount_WB" data-type="SheetTextBox" style="">
                                    </td>--%>
                                    <td data-datafield="DKTbl.SeqCnt" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.SeqCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKCurrencyCnt" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.QKCurrencyCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKObjectID" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.QKObjectID" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.QKSubObjectID" class="hidden">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.QKSubObjectID" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.DKType">
                                        <input id="Control18_ctl13" type="text" data-datafield="DKTbl.DKType" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DKTbl.LJDKAmount">
                                        <input id="Control18_ctl14" type="text" data-datafield="DKTbl.LJDKAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                                    </td>
                                    <td data-datafield="DKTbl.LJDKAmountWB">
                                        <input id="Control18_ctl14" type="text" data-datafield="DKTbl.LJDKAmountWB" data-type="SheetTextBox" style="" class="AmountFormat">
                                    </td>
                                    <td data-datafield="DKTbl.CurDKAmount">
                                        <input id="Control18_ctl15" type="text" data-datafield="DKTbl.CurDKAmount" data-type="SheetTextBox" style="" class="AmountFormat" data-onchange="setCurDKAmountHidden(this);compute()">
                                    </td>
                                    <td data-datafield="DKTbl.CurDKAmountHidden" class="hidden">
                                        <input id="Control18_ctl15" type="text" data-datafield="DKTbl.CurDKAmountHidden" data-type="SheetTextBox" style="" class="AmountFormat" data-onchange="compute()">
                                    </td>
                                    <td data-datafield="DKTbl.CurDKCurrency">
                                        <select data-datafield="DKTbl.CurDKCurrency" data-type="SheetDropDownList" id="ctl97153" class="" style="" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v"   data-queryable="false"
                                            data-onchange="setCurCurrency(this)"></select>
                                    </td>
                                    <td data-datafield="DKTbl.CurDKRate">
                                        <input id="Control18_ctl15" type="text" data-datafield="DKTbl.CurDKRate" data-type="SheetTextBox" style="" class="AmountFormat5" data-onchange="compute()">
                                    </td>
                                    <td data-datafield="DKTbl.Status">
                                        <input id="Control18_ctl17" type="text" data-datafield="DKTbl.Status" data-type="SheetTextBox" style="">
                                    </td>
                                    <td class="rowOption hidden">
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
                                <%--<tr class="footer">
                                    <td class="rowOption"></td>
                                    <td data-datafield="DKTbl.QKSeq"></td>
                                    <td data-datafield="DKTbl.QKSeqHidden" class="hidden"></td>
                                    <td data-datafield="DKTbl.QKType"></td>
                                    <td data-datafield="DKTbl.QKTypeCode" class="hidden"></td>
                                    <td data-datafield="DKTbl.QKTarget"></td>
                                    <td data-datafield="DKTbl.QKTargetCode" class="hidden"></td>
                                    <td data-datafield="DKTbl.QKDate"></td>
                                    <td data-datafield="DKTbl.ZJKX"></td>
                                    <td data-datafield="DKTbl.ZJMS"></td>
                                    <td data-datafield="DKTbl.QKAmount"></td>
                                    <td data-datafield="DKTbl.QKCurrency"></td>
                                    <td data-datafield="DKTbl.QKRate"></td>
                                    <td data-datafield="DKTbl.QKConvertAmount"></td>
                                    <td data-datafield="DKTbl.SeqCnt" class="hidden"></td>
                                    <td data-datafield="DKTbl.QKObjectID" class="hidden"></td>
                                    <td data-datafield="DKTbl.LJDKAmount"></td>
                                    <td data-datafield="DKTbl.LJDKAmountWB"></td>
                                    <td data-datafield="DKTbl.CurDKAmount">
                                        <label id="Control18_stat15" data-datafield="DKTbl.CurDKAmount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td data-datafield="DKTbl.CurDKCurrency"></td>
                                    <td data-datafield="DKTbl.CurDKRate"></td>
                                    <td data-datafield="DKTbl.Status"></td>
                                    <td class="rowOption"></td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="div335983" class="col-md-2">
                        <label data-datafield="DKDate" data-type="SheetLabel" id="ctl126811" class="" style="">到款日期</label>
                    </div>
                    <div id="div881792" class="col-md-4">
                        <input type="text" data-datafield="DKDate" data-type="SheetTime" id="ctl273185" class="" style="" data-defaultvalue="">
                    </div>
                    <div id="div234741" class="col-md-2"></div>
                    <div id="div965249" class="col-md-4"></div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="ManagerComment" style="">审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control19" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="RejectFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div903542" class="col-md-2">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div553758" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="DKCurrencyTmp" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div341245" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="QKTypeTmp" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div785335" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div392071" class="col-md-2">
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">到款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackDKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">到款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackDKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackDKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackDKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackDKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackDKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackDKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackDKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackDKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackDKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackDKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackDKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackDKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackDKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackDKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackDKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackDKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackDKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackDKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackDKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackDKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackDKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackDKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackDKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackDKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackDKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackDKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackDKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
