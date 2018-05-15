<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.FKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

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

    <script src="FKMy.js"></script>

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">付款子流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display: none"></i>
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
                <div id="title4" class="col-md-2">
                    <span id="Label14" data-type="SheetLabel" data-datafield="FinalUser" style="">最终用户</span>
                </div>
                <div id="control4" class="col-md-4">
                    <input id="Control14" type="text" data-datafield="FinalUser" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title5" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="ZKType" style="">支付类型</span>
                </div>
                <div id="control5" class="col-md-4">
                    <select data-datafield="ZKType" data-type="SheetDropDownList" id="ctl351452" class="" style="" data-queryable="false" data-masterdatacategory="付款类型"
                        data-onchange="compute();">
                    </select>
                </div>
                <div id="title6" class="col-md-2">
                    <span id="Label16" data-type="SheetLabel" data-datafield="Currency" style="">支付币种</span>
                </div>
                <div id="control6" class="col-md-4">
                    <select data-datafield="Currency" data-type="SheetDropDownList" id="ctl569829" class="" style="" data-queryable="false" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v"
                        data-onchange="CurrencyChange();compute();">
                    </select>
                </div>
            </div>
            <div class="row tableContent">
                <div id="title7" class="col-md-2">
                    <span id="Label17" data-type="SheetLabel" data-datafield="Content" style="">支付内容</span>
                </div>
                <div id="control7" class="col-md-10 RowHeight">
                    <textarea id="Control17" data-datafield="Content" data-type="SheetRichTextBox" style="">					</textarea>
                </div>
            </div>

            <div class="row">
                <div id="div347253" class="col-md-2">
                    <span id="Label18" data-type="SheetLabel" data-datafield="ContractTotalAmount" style="display: block">合同总金额</span>
                </div>
                <div id="div538101" class="col-md-2 normal">
                    <input type="text" data-datafield="ContractTotalPrice" data-type="SheetTextBox" id="ctl185481" class="AmountFormat" style="width: 60%"><span class="CurrencyRMB"></span>
                </div>
                <div id="div849192" class="col-md-2 normal">
                    <input type="text" data-datafield="JKTotalAmount" data-type="SheetTextBox" id="ctl195122" class="AmountFormat" style="width: 60%"><span class="CurrencyWB"></span>
                </div>
                <div id="div706280" class="col-md-6"></div>
            </div>
            <div class="row">
                <div id="div230454" class="col-md-2"><span id="Label19" data-type="SheetLabel" data-datafield="ApplyZJAmountRMB" style="" class="">已申请支付金额</span></div>
                <div id="div971270" class="col-md-2 normal">
                    <input id="Control19" type="text" data-datafield="ApplyZJAmountRMB" data-type="SheetTextBox" style="width: 60%" class="AmountFormat"><span class="CurrencyRMB"></span>
                </div>
                <div id="div969884" class="col-md-2 normal">
                    <input id="Control20" type="text" data-datafield="ApplyZJAmountWB" data-type="SheetTextBox" style="width: 60%" class="AmountFormat"><span class="CurrencyWB"></span>
                </div>
                <div id="div780762" class="col-md-2"><span id="Label23" data-type="SheetLabel" data-datafield="CurZJAmount" style="" class="">本次支付金额</span></div>
                <div id="div599830" class="col-md-2 normal">
                    <input id="Control23" type="text" data-datafield="CurZJAmount" data-type="SheetTextBox" style="width: 60%" class="AmountFormat"><span class="CurrencyCur"></span>
                </div>
                <div id="div63201" class="col-md-2"></div>
            </div>
            <div class="row">
                <div id="div941668" class="col-md-2"><span id="Label25" data-type="SheetLabel" data-datafield="ApplyZJPercentRMB" style="" class="">已申请支付比例</span></div>
                <div id="div926413" class="col-md-2 normal">
                    <span class="CurrencyRMB"></span>&nbsp;<input id="Control25" type="text" data-datafield="ApplyZJPercentRMB" data-type="SheetTextBox" style="width: 60%" class="">
                </div>
                <div id="div657669" class="col-md-2 normal">
                    <span class="CurrencyWB"></span>&nbsp;<input id="Control26" type="text" data-datafield="ApplyZJPercentWB" data-type="SheetTextBox" style="width: 60%" class="">
                </div>
                <div id="div483606" class="col-md-2"><span id="Label27" data-type="SheetLabel" data-datafield="CurZJPercent" style="" class="">本次支付后比例</span></div>
                <div id="div171105" class="col-md-2 normal">
                    <span class="CurrencyRMB"></span>&nbsp;<input id="Control27" type="text" data-datafield="CurZJPercent" data-type="SheetTextBox" style="width: 60%" class="">
                </div>
                <div id="div415582" class="col-md-2 normal">
                    <span class="CurrencyWB"></span>&nbsp;<input type="text" data-datafield="CurZJPercentWB" data-type="SheetTextBox" id="ctl234987" class="" style="width: 60%">
                </div>
            </div>

            <div class="row tableContent">
                <div id="title19" class="col-md-2">
                    <span id="Label28" data-type="SheetLabel" data-datafield="FKTbl" style="">付款金额明细</span>
                </div>
                <div id="control19" class="col-md-10">

                    <table id="ctl1898" data-datafield="FKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="1" data-displaysequenceno="false" data-displaysummary="false" data-onremoved="compute()">
                        <tbody>
                            <tr class="header">
                                <td id="ctl1898_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl1898_header0" data-datafield="FKTbl.ZJKX" style="">
                                    <label id="ctl1898_Label0" data-datafield="FKTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                <td id="ctl1898_header1" data-datafield="FKTbl.Amount" style="">
                                    <label id="ctl1898_Label1" data-datafield="FKTbl.Amount" data-type="SheetLabel" style="">金额</label></td>
                                <td id="ctl1898_header1" data-datafield="FKTbl.OutTaxAmount" style="">
                                    <label id="ctl1898_Label1" data-datafield="FKTbl.OutTaxAmount" data-type="SheetLabel" style="">代扣外税</label></td>
                                <td id="ctl1898_header2" data-datafield="FKTbl.ZKMS" style="">
                                    <label id="ctl1898_Label2" data-datafield="FKTbl.ZKMS" data-type="SheetLabel" style="">支付描述</label></td>
                                <td id="ctl1898_header3" data-datafield="FKTbl.QKDetail" style="">
                                    <label id="ctl1898_Label3" data-datafield="FKTbl.QKDetail" data-type="SheetLabel" style="">请款明细</label></td>
                                <td class="rowOption">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl1898_control0" data-datafield="FKTbl.ZJKX" style="">
                                    <select data-datafield="FKTbl.ZJKX" data-type="SheetDropDownList" id="ctl879622" class="" style="" data-queryable="false" data-schemacode="GetZJKXByQKType" data-querycode="GetZJKX" data-filter="ZKType:Type" data-datavaluefield="Code" data-datatextfield="EnumValue" data-onchange="ZJKXChange(this)"></select></td>
                                <td id="ctl1898_control1" data-datafield="FKTbl.Amount" style="">
                                    <input type="text" data-datafield="FKTbl.Amount" data-type="SheetTextBox" id="ctl1898_control1" style="" class="AmountFormat" data-onchange="compute()"></td>
                                <td id="ctl1898_control1" data-datafield="FKTbl.OutTaxAmount" style="">
                                    <input type="text" data-datafield="FKTbl.OutTaxAmount" data-type="SheetTextBox" id="ctl1898_control1" style="" class="AmountFormat" data-onchange="compute()"></td>
                                <td id="ctl1898_control2" data-datafield="FKTbl.ZKMS" style="">
                                    <input type="text" data-datafield="FKTbl.ZKMS" data-type="SheetTextBox" id="ctl1898_control2" style="width: 90%"></td>
                                <td id="ctl1898_control3" data-datafield="FKTbl.QKDetail" style="">
                                    <select data-datafield="FKTbl.QKDetail" data-type="SheetDropDownList" id="ctl305289" class="" style="" data-queryable="false" data-schemacode="GetQKDetail" data-querycode="GetQKDetail" data-filter="ContractNo:ContractNo" data-datavaluefield="ObjectID1" data-datatextfield="QKDetail"></select></td>
                                <td class="rowOption"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl1898_Stat0" data-datafield="FKTbl.ZJKX" style=""></td>
                                <td id="ctl1898_Stat1" data-datafield="FKTbl.Amount" style="">
                                    <label id="ctl1898_StatControl1" data-datafield="FKTbl.Amount" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl1898_Stat1" data-datafield="FKTbl.OutTaxAmount" style="">
                                    <label id="ctl1898_StatControl1" data-datafield="FKTbl.OutTaxAmount" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl1898_Stat2" data-datafield="FKTbl.ZKMS" style=""></td>
                                <td id="ctl1898_Stat3" data-datafield="FKTbl.QKDetail" style=""></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div id="title21" class="col-md-2">
                    <span id="Label29" data-type="SheetLabel" data-datafield="PayType" style="">支付方式</span>
                </div>
                <div id="control21" class="col-md-4">
                    <select data-datafield="PayType" data-type="SheetDropDownList" id="ctl673110" class="" style="" data-queryable="false" data-schemacode="GetPayType" data-querycode="GetPayType" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-onchange="GetPayTypeChange()"></select>
                    <%--<select data-datafield="PayType" data-type="SheetDropDownList" id="ctl673110" class="" style="" data-masterdatacategory="支付方式" data-queryable="false"></select>--%>
                </div>
                <div id="title22" class="col-md-2 ZFOperate">
                    <label data-datafield="ZFOperate" data-type="SheetLabel" id="ctl850920" class="" style="">支付操作</label>
                </div>
                <div id="control22" class="col-md-4 ZFOperate">
                    <select data-datafield="ZFOperate" data-type="SheetDropDownList" id="ctl226978" class="" style="" data-masterdatacategory="支付操作" data-queryable="false" data-displayemptyitem="true" data-emptyitemtext="请选择"></select>
                </div>
            </div>
            <div class="row">
                <div id="div277073" class="col-md-2"><span id="Label30" data-type="SheetLabel" data-datafield="Receiver" style="" class="">收款人</span></div>
                <div id="div802196" class="col-md-4">
                    <select data-datafield="Receiver" data-type="SheetDropDownList" id="ctl563097" class="" style="" data-schemacode="GetQKTarget2" data-querycode="GetQKTarget2" data-filter="ContractNo:ContractNo" data-datavaluefield="TargetName" data-datatextfield="TargetName" data-queryable="false" data-onchange="ChangeReceiver()"></select>
                </div>
                <div id="div601027" class="col-md-2 OtherReceiver">
                    <label data-datafield="OtherReceiver" data-type="SheetLabel" id="ctl1934" class="" style="">请输入其他收款人</label></div>
                <div id="div204669" class="col-md-4 OtherReceiver">
                    <input type="text" data-datafield="OtherReceiver" data-type="SheetTextBox" id="ctl182447" class="" style=""></div>
            </div>
            <div class="row">
                <div id="title23" class="col-md-2">
                    <span id="Label31" data-type="SheetLabel" data-datafield="BankName" style="">开户银行</span>
                </div>
                <div id="control23" class="col-md-4">
                    <input id="Control31" type="text" data-datafield="BankName" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetBankOfCustomer" data-querycode="GetBankOfCustomer" data-outputmappings="BankName:BankName,BankAccount:account">
                </div>
                <div id="title24" class="col-md-2">
                    <span id="Label32" data-type="SheetLabel" data-datafield="BankAccount" style="">账号</span>
                </div>
                <div id="control24" class="col-md-4">
                    <input id="Control32" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title25" class="col-md-2">
                    <span id="Label33" data-type="SheetLabel" data-datafield="ZJAttachment" style="">支付凭证</span>
                </div>
                <div id="control25" class="col-md-10">
                    <input type="text" data-datafield="ZJAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="ZJAttachment"></div>
                </div>
            </div>
            <div class="row tableContent">
                <div id="title25" class="col-md-2">
                    <span id="Label33" data-type="SheetLabel" data-datafield="DKRemarkTbl" style="">到款情况</span>
                </div>
                <div id="div688558" class="col-md-10">
                    <table id="ctl646883" data-datafield="DKRemarkTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                        <tbody>
                            <tr class="header">
                                <td id="ctl646883_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl646883_header0" data-datafield="DKRemarkTbl.QKSeq" style="">
                                    <label id="ctl646883_Label0" data-datafield="DKRemarkTbl.QKSeq" data-type="SheetLabel" style="">请款批次</label></td>
                                <td id="ctl646883_header0" data-datafield="DKRemarkTbl.SeqCnt" style="" class="hidden">
                                    <label id="ctl646883_Label0" data-datafield="DKRemarkTbl.SeqCnt" data-type="SheetLabel" style="">批次数量</label></td>
                                <td id="ctl646883_header0" data-datafield="DKRemarkTbl.QKCurrencyCnt" style="" class="hidden">
                                    <label id="ctl646883_Label0" data-datafield="DKRemarkTbl.QKCurrencyCnt" data-type="SheetLabel" style="">批次币种数量</label></td>
                                <td id="ctl646883_header1" data-datafield="DKRemarkTbl.ZJKX" style="">
                                    <label id="ctl646883_Label1" data-datafield="DKRemarkTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                <td id="ctl646883_header2" data-datafield="DKRemarkTbl.ZJMS" style="">
                                    <label id="ctl646883_Label2" data-datafield="DKRemarkTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label></td>
                                <td id="ctl646883_header3" data-datafield="DKRemarkTbl.QKAmount" style="">
                                    <label id="ctl646883_Label3" data-datafield="DKRemarkTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label></td>
                                <td id="ctl646883_header4" data-datafield="DKRemarkTbl.QKCurrency" style="">
                                    <label id="ctl646883_Label4" data-datafield="DKRemarkTbl.QKCurrency" data-type="SheetLabel" style="">请款币种</label></td>
                                <td id="ctl646883_header5" data-datafield="DKRemarkTbl.QKConvertAmount" style="">
                                    <label id="ctl646883_Label5" data-datafield="DKRemarkTbl.QKConvertAmount" data-type="SheetLabel" style="">折算金额(RMB)</label></td>
                                <td id="ctl646883_header6" data-datafield="DKRemarkTbl.QKTarget" style="">
                                    <label id="ctl646883_Label6" data-datafield="DKRemarkTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                <td id="ctl646883_header7" data-datafield="DKRemarkTbl.LJDKTotalAmount" style="">
                                    <label id="ctl646883_Label7" data-datafield="DKRemarkTbl.LJDKTotalAmount" data-type="SheetLabel" style="">累计到款</label></td>
                                <td id="ctl646883_header8" data-datafield="DKRemarkTbl.Status" style="" class="hidden">
                                    <label id="ctl646883_Label8" data-datafield="DKRemarkTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                <td id="ctl646883_header9" data-datafield="DKRemarkTbl.DisplayName" style="">
                                    <label id="ctl646883_Label9" data-datafield="DKRemarkTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                <td id="ctl646883_header8" data-datafield="DKRemarkTbl.QKObjectID" style="" class="hidden">
                                    <label id="ctl646883_Label8" data-datafield="DKRemarkTbl.QKObjectID" data-type="SheetLabel" style="" class="">QKObjectID</label></td>
                                <td id="ctl646883_header8" data-datafield="DKRemarkTbl.QKType" style="" class="hidden">
                                    <label id="ctl646883_Label8" data-datafield="DKRemarkTbl.QKType" data-type="SheetLabel" style="" class="">QKType</label></td>
                                <td class="rowOption hidden">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl646883_control0" data-datafield="DKRemarkTbl.QKSeq" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.QKSeq" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                <td id="ctl646883_control0" data-datafield="DKRemarkTbl.SeqCnt" style="" class="hidden">
                                    <input type="text" data-datafield="DKRemarkTbl.SeqCnt" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                <td id="ctl646883_control0" data-datafield="DKRemarkTbl.QKCurrencyCnt" style="" class="hidden">
                                    <input type="text" data-datafield="DKRemarkTbl.QKCurrencyCnt" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                <td id="ctl646883_control1" data-datafield="DKRemarkTbl.ZJKX" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.ZJKX" data-type="SheetTextBox" id="ctl646883_control1" style=""></td>
                                <td id="ctl646883_control2" data-datafield="DKRemarkTbl.ZJMS" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.ZJMS" data-type="SheetTextBox" id="ctl646883_control2" style=""></td>
                                <td id="ctl646883_control3" data-datafield="DKRemarkTbl.QKAmount" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.QKAmount" data-type="SheetTextBox" id="ctl646883_control3" style=""></td>
                                <td id="ctl646883_control4" data-datafield="DKRemarkTbl.QKCurrency" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.QKCurrency" data-type="SheetTextBox" id="ctl646883_control4" style=""></td>
                                <td id="ctl646883_control5" data-datafield="DKRemarkTbl.QKConvertAmount" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.QKConvertAmount" data-type="SheetTextBox" id="ctl646883_control5" style=""></td>
                                <td id="ctl646883_control6" data-datafield="DKRemarkTbl.QKTarget" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.QKTarget" data-type="SheetTextBox" id="ctl646883_control6" style=""></td>
                                <td id="ctl646883_control7" data-datafield="DKRemarkTbl.LJDKTotalAmount" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.LJDKTotalAmount" data-type="SheetTextBox" id="ctl646883_control7" style=""></td>
                                <td id="ctl646883_control8" data-datafield="DKRemarkTbl.Status" style="" class="hidden">
                                    <input type="text" data-datafield="DKRemarkTbl.Status" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
                                <td id="ctl646883_control9" data-datafield="DKRemarkTbl.DisplayName" style="">
                                    <input type="text" data-datafield="DKRemarkTbl.DisplayName" data-type="SheetTextBox" id="ctl646883_control9" style=""></td>
                                <td id="ctl646883_control8" data-datafield="DKRemarkTbl.QKObjectID" style="" class="hidden">
                                    <input type="text" data-datafield="DKRemarkTbl.QKObjectID" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
                                <td id="ctl646883_control8" data-datafield="DKRemarkTbl.QKType" style="" class="hidden">
                                    <input type="text" data-datafield="DKRemarkTbl.QKType" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
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
                <div id="title27" class="col-md-2">
                    <span id="Label34" data-type="SheetLabel" data-datafield="DKRemark" style="">申请备注</span>
                </div>
                <div id="control27" class="col-md-10 RowHeight">
                    <textarea id="Control34" data-datafield="DKRemark" data-type="SheetRichTextBox" style="">					</textarea>
                </div>
            </div>
            <div class="row">
                <div id="div140288" class="col-md-2">
                    <label data-datafield="FKCheckBox" data-type="SheetLabel" id="ctl679536" class="" style="">开发票</label></div>
                <div id="div700719" class="col-md-4">
                    <div data-datafield="FKCheckBox" data-type="SheetCheckboxList" id="ctl706168" class="" style="" data-defaultitems="银行费;代理费;其他" data-onchange="FKCheckBoxChange()"></div>
                </div>
                <div id="div617516" class="col-md-1 RowHeight AgencyFee">
                    <label data-datafield="AgencyFee" data-type="SheetLabel" id="ctl348511" class="" style="">代理费</label></div>
                <div id="div462051" class="col-md-2 normal AgencyFee">
                    <input type="text" data-datafield="AgencyFee" data-type="SheetTextBox" id="ctl721548" class="AmountFormat" style=""></div>
                <div id="div326513" class="col-md-1 RowHeight OtherContent">
                    <label data-datafield="OtherContent" data-type="SheetLabel" id="ctl149458" class="" style="">其他内容</label></div>
                <div id="div196705" class="col-md-2 normal OtherContent">
                    <input type="text" data-datafield="OtherContent" data-type="SheetTextBox" id="ctl43276" class="" style=""></div>
            </div>
            <div class="row tableContent">
                <div id="div507309" class="col-md-2">
                    <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">付款单备注</label>
                </div>
                <div id="div203297" class="col-md-10">
                    <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                </div>
            </div>
            <div class="row tableContent">
                <div id="title31" class="col-md-2">
                    <span id="Label36" data-type="SheetLabel" data-datafield="ManagerComment" style="">项目经理审批意见</span>
                </div>
                <div id="control31" class="col-md-10">
                    <div id="Control36" data-datafield="ManagerComment" data-type="SheetComment" style="">
                    </div>
                </div>
            </div>
            <div class="row tableContent">
                <div id="title33" class="col-md-2">
                    <span id="Label37" data-type="SheetLabel" data-datafield="CompanyLeaderComment" style="">公司领导审批意见</span>
                </div>
                <div id="control33" class="col-md-10">
                    <div id="Control37" data-datafield="CompanyLeaderComment" data-type="SheetComment" style="">
                    </div>
                </div>
            </div>
            <div class="row">
                <div id="title35" class="col-md-2">
                    <span id="Label38" data-type="SheetLabel" data-datafield="IsOperateFK" style="">执行付款</span>
                </div>
                <div id="control35" class="col-md-4">

                    <div data-datafield="IsOperateFK" data-type="SheetCheckboxList" id="ctl394100" class="" style="" data-defaultitems="是"></div>
                </div>
                <div id="title36" class="col-md-6">
                </div>
            </div>
            <div class="row ZFRMB">
                <div id="div233872" class="col-md-2">
                    <label data-datafield="ZJRMBType" data-type="SheetLabel" id="ctl18505" class="" style="">支付人民币</label>
                </div>
                <div id="div961296" class="col-md-1">
                    <select data-datafield="ZJRMBType" data-type="SheetDropDownList" id="ctl490935" class="" style="" data-masterdatacategory="支付人民币方式" data-queryable="false"
                        data-onchange="ZJRMBTypeChange()">
                    </select>
                </div>
                <div id="div959870" class="col-md-2 GHDiv">
                    <input type="text" data-datafield="ConvertAmount" data-type="SheetTextBox" id="ctl270004" class="" style="width: 80%" data-onchange="ConvertAmountChange()">RMB
                </div>
                <div id="div287700" class="col-md-2 GHDiv">
                    汇率：<input type="text" data-datafield="Rate" data-type="SheetTextBox" id="ctl447345" class="" style="width: 60%">
                </div>
                <div id="div763488" class="col-md-5"></div>
            </div>
            <div class="row">
                <div id="div182798" class="col-md-2"><span id="Label39" data-type="SheetLabel" data-datafield="FKDate" style="" class="">付款日期</span></div>
                <div id="div42188" class="col-md-4">
                    <input id="Control39" type="text" data-datafield="FKDate" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
                <div id="div309721" class="col-md-6"></div>
            </div>
            <div class="row">
                <div id="div873770" class="col-md-2 BankFee">
                    <label data-datafield="BankFee" data-type="SheetLabel" id="ctl137667" class="" style="">银行费</label></div>
                <div id="div68822" class="col-md-4 BankFee">
                    <input type="text" data-datafield="BankFee" data-type="SheetTextBox" id="ctl392411" class="AmountFormat" style=""></div>
                <div id="div129419" class="col-md-2 AgencyFee">
                    <label data-datafield="AgencyFeeConfirmChkbox" data-type="SheetLabel" id="ctl148503" class="" style="">代理费金额复核正确</label></div>
                <div id="div859694" class="col-md-4 AgencyFee">
                    <div data-datafield="AgencyFeeConfirmChkbox" data-type="SheetCheckboxList" id="ctl80091" class="" style="" data-defaultitems="正确" data-repeatcolumns="1"></div>
                </div>
            </div>
            <div class="row">
                <div id="div507309" class="col-md-2">
                    <label data-datafield="OperateRemark" data-type="SheetLabel" id="ctl818667" class="" style="">执行备注</label>
                </div>
                <div id="div203297" class="col-md-10">
                    <div data-datafield="OperateRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div497236" class="col-md-2">
                    <label data-datafield="ConfirmReceiptComment" data-type="SheetLabel" id="ctl156489" class="" style="">确认上传发票</label></div>
                <div id="div748561" class="col-md-10">
                    <div data-datafield="ConfirmReceiptComment" data-type="SheetComment" id="ctl103419" class="" style=""></div>
                </div>
            </div>
            <div class="row hidden">
                <div id="div552950" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="RejectFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div903542" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="CurrencyRMB" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div553758" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="CurrencyWB" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div341245" class="col-md-2">
                    <input id="Control20" type="text" data-datafield="JSObjectID" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div553758" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="QKSubObjectIDs" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div785335" class="col-md-2">
                    <input id="Control20" type="text" data-datafield="WorkflowVersion_FKReceipt" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div392071" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div392071" class="col-md-1">
                    <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                </div>
                <div id="div552950" class="col-md-1">
                    <select data-datafield="ZKTypeHidden" data-type="SheetDropDownList" id="ctl351452" class="" style="" data-queryable="false" data-masterdatacategory="付款类型"
                        data-onchange="ZKTypeHiddenChange();">
                    </select>
                </div>
                <div id="div552950" class="col-md-1">
                    <select data-datafield="CurrencyHidden" data-type="SheetDropDownList" id="ctl569829" class="" style="" data-queryable="false" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v"
                        data-onchange="CurrencyHiddenChange();">
                    </select>
                </div>
            </div>
        </div>
        </div>
        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">付款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display: none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackFKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">付款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackFKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackFKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackFKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackFKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackFKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackFKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackFKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackFKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackFKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackFKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackFKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackFKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackFKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackFKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackFKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackFKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackFKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackFKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackFKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackFKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackFKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackFKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackFKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackFKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackFKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackFKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackFKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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

    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/file2.js"></script>
    <script src="../js/select2.js"></script>


    <script src="../js/ApprovalTbl.js"></script>
</asp:Content>
