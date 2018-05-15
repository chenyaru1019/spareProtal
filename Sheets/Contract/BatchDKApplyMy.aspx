<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchDKApplyMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchDKApplyMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../css/common.css">
    <script src="BatchDKApplyMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">批量到款申请</label>
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
                <div class="Content_Tab" style="padding-top:10px">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#dklstab" aria-controls="dklstab" role="tab" data-toggle="tab" >到款记录选择</a></li>
                    </ul>
                    <div class="tab-content">

                        <div role="tabpanel" class="tab-pane active" id="dklstab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2">
                                    <span id="Label11" data-type="SheetLabel" data-datafield="DK_Target" style="">请选择要批量到款的业主</span>
                                </div>
                                <div id="div701597" class="col-md-4">
                                    <select data-datafield="DK_Target" data-type="SheetDropDownList" id="ctl570634" class="" style="" data-queryable="false" data-schemacode="GetFinalUser" data-querycode="GetFinalUser" data-datavaluefield="ObjectID" data-datatextfield="FinalUser" data-displayemptyitem="true" data-emptyitemtext="请选择"
                                        data-onchange="Search()">
                                    </select>
                                </div>
                                <div id="div473092" class="col-md-2">
                                </div>
                                <div id="div876934" class="col-md-2">
                                </div>
                            </div>

                            <!-- 分割线 -->
                            <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                            </div>

                            <div class="row tableContent">
                                <div id="control3" class="col-md-12">
                                    <table id="Control12" data-datafield="BatchDKTbl" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false">
                                        <tbody>

                                            <tr class="header">
                                                <td id="Control12_SerialNo" class="rowSerialNo">序号								</td>
                                                <td id="Control12_Header3" data-datafield="BatchDKTbl.IsCheck" style="width:4%">
                                                    <label id="Control12_Label3" data-datafield="BatchDKTbl.IsCheck" data-type="SheetLabel" style="">选择</label>
                                                </td>
                                                <td id="Control12_Header4" data-datafield="BatchDKTbl.ContractNo" style="width:11%">
                                                    <label id="Control12_Label4" data-datafield="BatchDKTbl.ContractNo" data-type="SheetLabel" style="">合同号</label>
                                                </td>
                                                <td id="Control12_Header4" data-datafield="BatchDKTbl.QKSeq" style="width:4%">
                                                    <label id="Control12_Label4" data-datafield="BatchDKTbl.QKSeq" data-type="SheetLabel" style="">批次</label>
                                                </td>
                                                <td id="Control12_Header5" data-datafield="BatchDKTbl.QKType">
                                                    <label id="Control12_Label5" data-datafield="BatchDKTbl.QKType" data-type="SheetLabel" style="">请款类型</label>
                                                </td>
                                                <td id="Control12_Header6" data-datafield="BatchDKTbl.QKTarget" style="width:10%">
                                                    <label id="Control12_Label6" data-datafield="BatchDKTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label>
                                                </td>
                                                <td id="Control12_Header7" data-datafield="BatchDKTbl.QKDate">
                                                    <label id="Control12_Label7" data-datafield="BatchDKTbl.QKDate" data-type="SheetLabel" style="">请款日期</label>
                                                </td>
                                                <td id="Control12_Header8" data-datafield="BatchDKTbl.ZJKX">
                                                    <label id="Control12_Label8" data-datafield="BatchDKTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label>
                                                </td>
                                                <td id="Control12_Header9" data-datafield="BatchDKTbl.ZJMS">
                                                    <label id="Control12_Label9" data-datafield="BatchDKTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label>
                                                </td>
                                                <td id="Control12_Header10" data-datafield="BatchDKTbl.QKAmount">
                                                    <label id="Control12_Label10" data-datafield="BatchDKTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label>
                                                </td>
                                                <td id="Control12_Header11" data-datafield="BatchDKTbl.QKCurrency">
                                                    <label id="Control12_Label11" data-datafield="BatchDKTbl.QKCurrency" data-type="SheetLabel" style="">请款币种</label>
                                                </td>
                                                <td id="Control12_Header12" data-datafield="BatchDKTbl.QKConvertAmount" class="">
                                                    <label id="Control12_Label12" data-datafield="BatchDKTbl.QKConvertAmount" data-type="SheetLabel" style="">折算金额</label>
                                                </td>
                                                <td id="Control12_Header18" data-datafield="BatchDKTbl.LJDKAmount">
                                                    <label id="Control12_Label18" data-datafield="BatchDKTbl.LJDKAmount" data-type="SheetLabel" style="">累计到款<br />人民币</label>
                                                </td>
                                                <td id="Control12_Header18" data-datafield="BatchDKTbl.LJDKAmountWB">
                                                    <label id="Control12_Label18" data-datafield="BatchDKTbl.LJDKAmountWB" data-type="SheetLabel" style="">累计到款<br />外币</label>
                                                </td>
                                                <td id="Control12_Header13" data-datafield="BatchDKTbl.CurDKAmount">
                                                    <label id="Control12_Label13" data-datafield="BatchDKTbl.CurDKAmount" data-type="SheetLabel" style="">本次预计<br />到款金额</label>
                                                </td>
                                                <td id="Control12_Header14" data-datafield="BatchDKTbl.CurDKCurrency" style="width:6%">
                                                    <label id="Control12_Label14" data-datafield="BatchDKTbl.CurDKCurrency" data-type="SheetLabel" style="">到款币种</label>
                                                </td>
                                                <td id="Control12_Header15" data-datafield="BatchDKTbl.Status">
                                                    <label id="Control12_Label15" data-datafield="BatchDKTbl.Status" data-type="SheetLabel" style="">状态</label>
                                                </td>
                                                <td id="Control12_Header16" data-datafield="BatchDKTbl.SeqCnt" class="hidden">
                                                    <label id="Control12_Label16" data-datafield="BatchDKTbl.SeqCnt" data-type="SheetLabel" style="">SeqCnt</label>
                                                </td>
                                                <td id="Control12_Header17" data-datafield="BatchDKTbl.QKCurrencyCode" class="hidden">
                                                    <label id="Control12_Label17" data-datafield="BatchDKTbl.QKCurrencyCode" data-type="SheetLabel" style="">请款币种Code</label>
                                                </td>
                                                <td id="Control12_Header17" data-datafield="BatchDKTbl.QKCurrencyCnt" class="hidden">
                                                    <label id="Control12_Label17" data-datafield="BatchDKTbl.QKCurrencyCnt" data-type="SheetLabel" style="">QKCurrencyCnt</label>
                                                </td>
                                                <td id="Control12_Header19" data-datafield="BatchDKTbl.QKSeqHidden" class="hidden">
                                                    <label id="Control12_Label19" data-datafield="BatchDKTbl.QKSeqHidden" data-type="SheetLabel" style="">请款批次Hidden</label>
                                                </td>
                                                <td id="Control12_Header20" data-datafield="BatchDKTbl.QKTypeCode" class="hidden">
                                                    <label id="Control12_Label20" data-datafield="BatchDKTbl.QKTypeCode" data-type="SheetLabel" style="">请款类型</label>
                                                </td>
                                                <td id="Control12_Header21" data-datafield="BatchDKTbl.QKTargetCode" class="hidden">
                                                    <label id="Control12_Label21" data-datafield="BatchDKTbl.QKTargetCode" data-type="SheetLabel" style="">请款对象</label>
                                                </td>
                                                <td id="Control12_Header22" data-datafield="BatchDKTbl.QKObjectID" class="hidden">
                                                    <label id="Control12_Label22" data-datafield="BatchDKTbl.QKObjectID" data-type="SheetLabel" style="">QKObjectID</label>
                                                </td>
                                                <td class="rowOption hidden">删除								</td>
                                            </tr>
                                            <tr class="template">
                                                <td id="Control12_Option" class="rowOption"></td>
                                                <td data-datafield="BatchDKTbl.IsCheck">
                                                    <div data-datafield="BatchDKTbl.IsCheck" data-type="SheetCheckboxList" id="ctl975831" class="" style="" data-repeatcolumns="1" data-defaultitems="是"
                                                        data-onchange="compute(this)">
                                                    </div>
                                                </td>
                                                <td data-datafield="BatchDKTbl.ContractNo">
                                                    <input id="Control12_ctl4" type="text" data-datafield="BatchDKTbl.ContractNo" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKSeq">
                                                    <input id="Control12_ctl4" type="text" data-datafield="BatchDKTbl.QKSeq" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKType">
                                                    <input id="Control12_ctl5" type="text" data-datafield="BatchDKTbl.QKType" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKTarget">
                                                    <input id="Control12_ctl6" type="text" data-datafield="BatchDKTbl.QKTarget" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKDate">
                                                    <input id="Control12_ctl7" type="text" data-datafield="BatchDKTbl.QKDate" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.ZJKX">
                                                    <input id="Control12_ctl8" type="text" data-datafield="BatchDKTbl.ZJKX" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.ZJMS">
                                                    <input id="Control12_ctl9" type="text" data-datafield="BatchDKTbl.ZJMS" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKAmount">
                                                    <input id="Control12_ctl10" type="text" data-datafield="BatchDKTbl.QKAmount" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKCurrency">
                                                    <input id="Control12_ctl11" type="text" data-datafield="BatchDKTbl.QKCurrency" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKConvertAmount" class="">
                                                    <input id="Control12_ctl12" type="text" data-datafield="BatchDKTbl.QKConvertAmount" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.LJDKAmount">
                                                    <input id="Control12_ctl18" type="text" data-datafield="BatchDKTbl.LJDKAmount" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.LJDKAmountWB">
                                                    <input id="Control12_ctl18" type="text" data-datafield="BatchDKTbl.LJDKAmountWB" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.CurDKAmount">
                                                    <input id="Control12_ctl13" type="text" data-datafield="BatchDKTbl.CurDKAmount" data-type="SheetTextBox" style=""
                                                        data-onchange="compute2()">
                                                </td>
                                                <td data-datafield="BatchDKTbl.CurDKCurrency">
                                                    <select data-datafield="BatchDKTbl.CurDKCurrency" data-type="SheetDropDownList" id="ctl780150" class="" style="" data-queryable="false" data-masterdatacategory="币种"
                                                        data-onchange="compute2()"></select>                                                </td>
                                                <td data-datafield="BatchDKTbl.Status">
                                                    <input id="Control12_ctl15" type="text" data-datafield="BatchDKTbl.Status" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.SeqCnt" class="hidden">
                                                    <input id="Control12_ctl16" type="text" data-datafield="BatchDKTbl.SeqCnt" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKCurrencyCode" class="hidden">
                                                    <input id="Control12_ctl17" type="text" data-datafield="BatchDKTbl.QKCurrencyCode" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKCurrencyCnt" class="hidden">
                                                    <input id="Control12_ctl17" type="text" data-datafield="BatchDKTbl.QKCurrencyCnt" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKSeqHidden" class="hidden">
                                                    <input id="Control12_ctl19" type="text" data-datafield="BatchDKTbl.QKSeqHidden" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKTypeCode" class="hidden">
                                                    <input id="Control12_ctl20" type="text" data-datafield="BatchDKTbl.QKTypeCode" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKTargetCode" class="hidden">
                                                    <input id="Control12_ctl21" type="text" data-datafield="BatchDKTbl.QKTargetCode" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="BatchDKTbl.QKObjectID" class="hidden">
                                                    <input id="Control12_ctl22" type="text" data-datafield="BatchDKTbl.QKObjectID" data-type="SheetTextBox" style="">
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
                                            <tr class="footer">
                                                <td class="rowOption"></td>
                                                <td data-datafield="BatchDKTbl.IsCheck"></td>
                                                <td data-datafield="BatchDKTbl.ContractNo"></td>
                                                <td data-datafield="BatchDKTbl.QKSeq"></td>
                                                <td data-datafield="BatchDKTbl.QKType"></td>
                                                <td data-datafield="BatchDKTbl.QKTarget"></td>
                                                <td data-datafield="BatchDKTbl.QKDate"></td>
                                                <td data-datafield="BatchDKTbl.ZJKX"></td>
                                                <td data-datafield="BatchDKTbl.ZJMS"></td>
                                                <td data-datafield="BatchDKTbl.QKAmount"></td>
                                                <td data-datafield="BatchDKTbl.QKCurrency"></td>
                                                <td data-datafield="BatchDKTbl.QKConvertAmount" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.LJDKAmount"></td>
                                                <td data-datafield="BatchDKTbl.LJDKAmountWB"></td>
                                                <td data-datafield="BatchDKTbl.CurDKAmount"></td>
                                                <td data-datafield="BatchDKTbl.CurDKCurrency"></td>
                                                <td data-datafield="BatchDKTbl.Status"></td>
                                                <td data-datafield="BatchDKTbl.SeqCnt" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.QKCurrencyCode" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.QKSeqHidden" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.QKTypeCode" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.QKTargetCode" class="hidden"></td>
                                                <td data-datafield="BatchDKTbl.QKObjectID" class="hidden"></td>
                                                <td class="rowOption hidden"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="row tableContent">
                                <div id="title5" class="col-md-2">
                                    <span id="Label13" data-type="SheetLabel" data-datafield="DKResult" style="">到款结果</span>
                                </div>
                                <div id="control19" class="col-md-10">
                                    <input id="Control26" type="text" data-datafield="DKResult" data-type="SheetTextBox" >
                                </div>
                            </div>

                            <div class="row tableContent">
                                <div id="div707679" class="col-md-12" style="padding: 5px;text-align: center">
                                    <input id="BatchDKApplyId" type="button" style="padding: 3px 10px" onclick="BatchDKApply()" class="btn btn-primary" value=" 下一步 " />&nbsp;
                                    <input id="ToBackId" type="button" style="padding: 3px 10px" onclick="ToBack()" class="btn btn-primary" value=" 返回 " />
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_BatchDK" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        <input type="text" data-datafield="DKResultCode" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div544852" class="col-md-1">
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
    </div>
</asp:Content>
