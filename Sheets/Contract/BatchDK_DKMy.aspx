﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchDK_DKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchDK_DKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../css/common.css">
    <script src="BatchDK_DKMy.js"></script>
        <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">批量到款流程</label>
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
                        <span id="Label11" data-type="SheetLabel" data-datafield="DK_Target" style="">到款对象</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="DK_Target" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title1" class="col-md-12">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BatchDKTblOfDK" style="" class="">批量到款子表</span>
                    </div>
                </div>
                <div class="row BatchDKTblOfDK">
                    <div id="div996425" class="col-md-12">
                        <table id="Control16" data-datafield="BatchDKTblOfDK" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control16_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control16_Header3" data-datafield="BatchDKTblOfDK.ContractNo" style="width:11%">
                                        <label id="Control16_Label3" data-datafield="BatchDKTblOfDK.ContractNo" data-type="SheetLabel" style="">合同号</label>
                                    </td>
                                    <td id="Control16_Header4" data-datafield="BatchDKTblOfDK.QKSeq" style="width:4%">
                                        <label id="Control16_Label4" data-datafield="BatchDKTblOfDK.QKSeq" data-type="SheetLabel" style="">请款批次</label>
                                    </td>
                                    <td id="Control16_Header5" data-datafield="BatchDKTblOfDK.QKType">
                                        <label id="Control16_Label5" data-datafield="BatchDKTblOfDK.QKType" data-type="SheetLabel" style="">请款类型</label>
                                    </td>
                                    <td id="Control16_Header6" data-datafield="BatchDKTblOfDK.QKTarget">
                                        <label id="Control16_Label6" data-datafield="BatchDKTblOfDK.QKTarget" data-type="SheetLabel" style="">请款对象</label>
                                    </td>
                                    <td id="Control16_Header7" data-datafield="BatchDKTblOfDK.QKDate">
                                        <label id="Control16_Label7" data-datafield="BatchDKTblOfDK.QKDate" data-type="SheetLabel" style="">请款日期</label>
                                    </td>
                                    <td id="Control16_Header8" data-datafield="BatchDKTblOfDK.ZJKX">
                                        <label id="Control16_Label8" data-datafield="BatchDKTblOfDK.ZJKX" data-type="SheetLabel" style="">资金款项</label>
                                    </td>
                                    <td id="Control16_Header9" data-datafield="BatchDKTblOfDK.ZJMS">
                                        <label id="Control16_Label9" data-datafield="BatchDKTblOfDK.ZJMS" data-type="SheetLabel" style="">资金描述</label>
                                    </td>
                                    <td id="Control16_Header10" data-datafield="BatchDKTblOfDK.QKAmount">
                                        <label id="Control16_Label10" data-datafield="BatchDKTblOfDK.QKAmount" data-type="SheetLabel" style="">请款金额</label>
                                    </td>
                                    <td id="Control16_Header11" data-datafield="BatchDKTblOfDK.QKCurrency" style="width:4%">
                                        <label id="Control16_Label11" data-datafield="BatchDKTblOfDK.QKCurrency" data-type="SheetLabel" style="">请款<br />币种</label>
                                    </td>
                                    <td id="Control16_Header10" data-datafield="BatchDKTblOfDK.QKRate" style="width:4%">
                                        <label id="Control16_Label10" data-datafield="BatchDKTblOfDK.QKRate" data-type="SheetLabel" style="">请款<br />汇率</label>
                                    </td>
                                    <td id="Control16_Header12" data-datafield="BatchDKTblOfDK.QKConvertAmount" class="hidden">
                                        <label id="Control16_Label12" data-datafield="BatchDKTblOfDK.QKConvertAmount" data-type="SheetLabel" style="">折算金额</label>
                                    </td>
                                    <td id="Control16_Header18" data-datafield="BatchDKTblOfDK.LJDKAmount" class="">
                                        <label id="Control16_Label18" data-datafield="BatchDKTblOfDK.LJDKAmount" data-type="SheetLabel" style="">累计人民币</label>
                                    </td>
                                    <td id="Control16_Header18" data-datafield="BatchDKTblOfDK.LJDKAmountWB" class="">
                                        <label id="Control16_Label18" data-datafield="BatchDKTblOfDK.LJDKAmountWB" data-type="SheetLabel" style="">累计外币</label>
                                    </td>
                                    <td id="Control16_Header13" data-datafield="BatchDKTblOfDK.CurDKAmount">
                                        <label id="Control16_Label13" data-datafield="BatchDKTblOfDK.CurDKAmount" data-type="SheetLabel" style="">本次金额</label>
                                    </td>
                                    <td id="Control16_Header14" data-datafield="BatchDKTblOfDK.CurDKCurrency" style="width:6%">
                                        <label id="Control16_Label14" data-datafield="BatchDKTblOfDK.CurDKCurrency" data-type="SheetLabel" style="">本次币种</label>
                                    </td>
                                    <td id="Control16_Header13" data-datafield="BatchDKTblOfDK.CurDKRate">
                                        <label id="Control16_Label13" data-datafield="BatchDKTblOfDK.CurDKRate" data-type="SheetLabel" style="">汇率</label>
                                    </td>
                                    <td id="Control16_Header15" data-datafield="BatchDKTblOfDK.Status">
                                        <label id="Control16_Label15" data-datafield="BatchDKTblOfDK.Status" data-type="SheetLabel" style="">状态</label>
                                    </td>
                                    <td id="Control16_Header16" data-datafield="BatchDKTblOfDK.SeqCnt" class="hidden">
                                        <label id="Control16_Label16" data-datafield="BatchDKTblOfDK.SeqCnt" data-type="SheetLabel" style="">SeqCnt</label>
                                    </td>
                                    <td id="Control16_Header17" data-datafield="BatchDKTblOfDK.QKCurrencyCode" class="hidden">
                                        <label id="Control16_Label17" data-datafield="BatchDKTblOfDK.QKCurrencyCode" data-type="SheetLabel" style="">请款币种Code</label>
                                    </td>
                                    <td id="Control16_Header17" data-datafield="BatchDKTblOfDK.QKCurrencyCnt" class="hidden">
                                        <label id="Control16_Label17" data-datafield="BatchDKTblOfDK.QKCurrencyCnt" data-type="SheetLabel" style="">QKCurrencyCnt</label>
                                    </td>
                                    <td id="Control16_Header19" data-datafield="BatchDKTblOfDK.QKSeqHidden" class="hidden">
                                        <label id="Control16_Label19" data-datafield="BatchDKTblOfDK.QKSeqHidden" data-type="SheetLabel" style="">请款批次Hidden</label>
                                    </td>
                                    <td id="Control16_Header20" data-datafield="BatchDKTblOfDK.QKTypeCode" class="hidden">
                                        <label id="Control16_Label20" data-datafield="BatchDKTblOfDK.QKTypeCode" data-type="SheetLabel" style="">请款类型</label>
                                    </td>
                                    <td id="Control16_Header21" data-datafield="BatchDKTblOfDK.QKTargetCode" class="hidden">
                                        <label id="Control16_Label21" data-datafield="BatchDKTblOfDK.QKTargetCode" data-type="SheetLabel" style="">请款对象</label>
                                    </td>
                                    <td id="Control16_Header22" data-datafield="BatchDKTblOfDK.QKObjectID" class="hidden">
                                        <label id="Control16_Label22" data-datafield="BatchDKTblOfDK.QKObjectID" data-type="SheetLabel" style="">QKObjectID</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control16_Option" class="rowOption"></td>
                                    <td data-datafield="BatchDKTblOfDK.ContractNo">
                                        <input id="Control16_ctl3" type="text" data-datafield="BatchDKTblOfDK.ContractNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKSeq">
                                        <input id="Control16_ctl4" type="text" data-datafield="BatchDKTblOfDK.QKSeq" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKType">
                                        <input id="Control16_ctl5" type="text" data-datafield="BatchDKTblOfDK.QKType" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKTarget">
                                        <input id="Control16_ctl6" type="text" data-datafield="BatchDKTblOfDK.QKTarget" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKDate">
                                        <input id="Control16_ctl7" type="text" data-datafield="BatchDKTblOfDK.QKDate" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.ZJKX">
                                        <input id="Control16_ctl8" type="text" data-datafield="BatchDKTblOfDK.ZJKX" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.ZJMS">
                                        <input id="Control16_ctl9" type="text" data-datafield="BatchDKTblOfDK.ZJMS" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKAmount">
                                        <input id="Control16_ctl10" type="text" data-datafield="BatchDKTblOfDK.QKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKCurrency">
                                        <input id="Control16_ctl11" type="text" data-datafield="BatchDKTblOfDK.QKCurrency" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKRate">
                                        <input id="Control16_ctl10" type="text" data-datafield="BatchDKTblOfDK.QKRate" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKConvertAmount" class="hidden">
                                        <input id="Control16_ctl12" type="text" data-datafield="BatchDKTblOfDK.QKConvertAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.LJDKAmount" class="">
                                        <input id="Control16_ctl18" type="text" data-datafield="BatchDKTblOfDK.LJDKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.LJDKAmountWB" class="">
                                        <input id="Control16_ctl18" type="text" data-datafield="BatchDKTblOfDK.LJDKAmountWB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.CurDKAmount">
                                        <input id="Control16_ctl13" type="text" data-datafield="BatchDKTblOfDK.CurDKAmount" data-type="SheetTextBox" style=""
                                            data-onchange="compute(this)">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.CurDKCurrency">
                                        <select data-datafield="BatchDKTblOfDK.CurDKCurrency" data-type="SheetDropDownList" id="ctl780150" class="" style="" data-queryable="false" data-masterdatacategory="币种"
                                            data-onchange="compute(this)"></select>
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.CurDKRate">
                                        <input id="Control16_ctl13" type="text" data-datafield="BatchDKTblOfDK.CurDKRate" data-type="SheetTextBox" style=""
                                            data-onchange="compute(this)">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.Status">
                                        <input id="Control16_ctl15" type="text" data-datafield="BatchDKTblOfDK.Status" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.SeqCnt" class="hidden">
                                        <input id="Control16_ctl16" type="text" data-datafield="BatchDKTblOfDK.SeqCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKCurrencyCode" class="hidden">
                                        <input id="Control16_ctl17" type="text" data-datafield="BatchDKTblOfDK.QKCurrencyCode" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKCurrencyCnt" class="hidden">
                                        <input id="Control16_ctl17" type="text" data-datafield="BatchDKTblOfDK.QKCurrencyCnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKSeqHidden" class="hidden">
                                        <input id="Control16_ctl19" type="text" data-datafield="BatchDKTblOfDK.QKSeqHidden" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKTypeCode" class="hidden">
                                        <input id="Control16_ctl20" type="text" data-datafield="BatchDKTblOfDK.QKTypeCode" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKTargetCode" class="hidden">
                                        <input id="Control16_ctl21" type="text" data-datafield="BatchDKTblOfDK.QKTargetCode" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchDKTblOfDK.QKObjectID" class="hidden">
                                        <input id="Control16_ctl22" type="text" data-datafield="BatchDKTblOfDK.QKObjectID" data-type="SheetTextBox" style="">
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
                                    <td data-datafield="BatchDKTblOfDK.ContractNo"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKSeq"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKType"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKTarget"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKDate"></td>
                                    <td data-datafield="BatchDKTblOfDK.ZJKX"></td>
                                    <td data-datafield="BatchDKTblOfDK.ZJMS"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKAmount"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKCurrency"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKConvertAmount" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.CurDKAmount"></td>
                                    <td data-datafield="BatchDKTblOfDK.CurDKCurrency"></td>
                                    <td data-datafield="BatchDKTblOfDK.Status"></td>
                                    <td data-datafield="BatchDKTblOfDK.SeqCnt" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKCurrencyCode" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.LJDKAmount" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKSeqHidden" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKTypeCode" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKTargetCode" class="hidden"></td>
                                    <td data-datafield="BatchDKTblOfDK.QKObjectID" class="hidden"></td>
                                    <td class="rowOption hidden"></td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="div538703" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="Amount" style="" class="">到款金额</span>
                    </div>
                    <div id="div738174" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="Amount" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div605208" class="col-md-2">
                    </div>
                    <div id="div896260" class="col-md-4">
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
                <div class="row">
                    <div id="div722622" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="DKDate" style="" class="">到款日期</span>
                    </div>
                    <div id="div633378" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="DKDate" data-type="SheetTime" style="" class="">
                    </div>
                    <div id="div293022" class="col-md-2">
                    </div>
                    <div id="div501078" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="ConfirmComment" style="">审批意见</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <div id="Control15" data-datafield="ConfirmComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        <textarea data-datafield="QKObjectIDs" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl674230" class="hidden"></textarea>
                    </div>
                    <div id="div544852" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div523468" class="col-md-1"></div>
                    <div id="div315418" class="col-md-1"></div>
                    <div id="div836564" class="col-md-1"></div>
                    <div id="div74315" class="col-md-1"></div>
                    <div id="div895520" class="col-md-1"></div>
                    <div id="div21012" class="col-md-1"></div>
                    <div id="div616170" class="col-md-1"></div>
                    <div id="div411135" class="col-md-1"></div>
                    <div id="div260964" class="col-md-1"></div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">批量到款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackBatchDKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">批量到款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackBatchDKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackBatchDKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackBatchDKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackBatchDKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackBatchDKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackBatchDKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackBatchDKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackBatchDKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackBatchDKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackBatchDKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackBatchDKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackBatchDKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackBatchDKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackBatchDKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackBatchDKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackBatchDKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackBatchDKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackBatchDKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackBatchDKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackBatchDKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackBatchDKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackBatchDKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackBatchDKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackBatchDKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackBatchDKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackBatchDKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
