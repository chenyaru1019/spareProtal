<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.QKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="QKMy.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">请款子流程</label>
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
                <div class="row NoHYDiv">
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
                <div class="row NoHYDiv">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="PostAB" style="">项目负责人AB</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title4" class="col-md-2">

                        <span id="Label14" data-type="SheetLabel" data-datafield="QKSeq" style="" class="">请款批次</span>
                    </div>
                    <div id="control4" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="QKSeq" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row NoHYDiv">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="QKTarget" style="">请款对象</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <select data-datafield="QKTarget" data-type="SheetDropDownList" id="ctl412324" class="" style="" data-schemacode="GetQKTarget2" data-querycode="GetQKTarget2" data-filter="ContractNo:ContractNo" data-datavaluefield="TargetName" data-datatextfield="TargetName" data-queryable="false"></select>
                    </div>
                </div>
                <div class="row NoHYDiv">
                    <div id="div217155" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="QKContent" class="" style="">请款内容</span>
                    </div>
                    <div id="div725078" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="QKContent" data-type="SheetTextBox" class="" style="">
                    </div>
                </div>
                <div class="row NoHYDiv">
                    <div id="div862700" class="col-md-2"><span id="Label17" data-type="SheetLabel" data-datafield="QKTotalAmoutRMB" class="" style="">请款金额</span></div>
                    <div id="div678489" class="col-md-1 RowHeight">
                        <input id="Control17" type="text" data-datafield="QKTotalAmoutRMB" data-type="SheetTextBox" class="AmountFormat" style="width: 100%;">
                    </div>
                    <div id="div438633" class="col-md-1 RowHeight">
                        <input type="text" data-datafield="QKRMBCurrency" data-type="SheetTextBox" id="ctl213262" class="" style="">
                    </div>
                    <div id="div62334" class="col-md-1 RowHeight">
                        <input id="Control18" type="text" data-datafield="QKTotalAmoutWB" data-type="SheetTextBox" class="AmountFormat" style="width: 100%;">
                    </div>
                    <div id="div406470" class="col-md-1 RowHeight">
                        <input type="text" data-datafield="QKWBCurrency" data-type="SheetTextBox" id="ctl28827" class="" style="">
                    </div>
                    <div id="div811131" class="col-md-6"></div>
                </div>

                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="ImportHYCompany" style="">进口油公司</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="ImportHYCompany" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title11" class="col-md-2">
                        <label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyVisiable">发件人</label>
                    </div>
                    <div id="control11" class="col-md-4">
                        <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData"></label>
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Contacter" style="">收件人</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Contacter" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title11" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="PageNumber" style="">页数</span>
                    </div>
                    <div id="control11" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="PageNumber" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Fax" style="">传真</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Fax" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title11" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="CurDate" style="">日期</span>
                    </div>
                    <div id="control11" class="col-md-4">
                        <input type="text" data-datafield="CurDate" data-type="SheetTime" id="ctl881635" class="" style="">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Tel" style="">电话</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Tel" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title11" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="ContractNo" style="">合同号</span>
                    </div>
                    <div id="control11" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="ContractNo" data-type="SheetTextBox" style="width:70%">
                        <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-12" style="padding-left:0px">
                        我公司代理贵公司进口的航空煤油（代理协议号：<input type="text" data-datafield="ContractNo" data-type="SheetTextBox" style="width:20%">）
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="TDDate" style="text-align:left">提单日</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="TDDate" data-type="SheetTime" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="DGDate" style="text-align:left">到港日</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="DGDate" data-type="SheetTime" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Tong" style="text-align:left;padding-left:40px">提单量（桶）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Tong" data-type="SheetTextBox" style="" class="AmountFormat" data-onchange="computerHY()">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Dun" style="text-align:left;padding-left:40px">提单量（吨）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Dun" data-type="SheetTextBox" style="" class="AmountFormat3">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="BaseOilPrice" style="text-align:left;padding-left:40px">基准油价（<span class="CurrencyRMB"></span>/桶）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="ValuationType" data-type="SheetTextBox" style="width:40%">
                        <input id="Control11" type="text" data-datafield="BaseOilPrice" data-type="SheetTextBox" style="width:40%" class="AmountFormat3" data-onchange="computerHY()">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Agio" style="text-align:left;padding-left:40px">贴水+运费等（<span class="CurrencyRMB"></span>/桶）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Agio" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Price" style="text-align:left;padding-left:40px">单价（<span class="CurrencyRMB"></span>/桶）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Price" data-type="SheetTextBox" style="" class="AmountFormat3">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="HKAmount" style="text-align:left">货款金额（<span class="CurrencyRMB"></span>）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="HKAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="AgencyComputerNum" style="text-align:left;padding-left:40px">单位代理费（<span class="CurrencyRMB"></span>/桶）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="AgencyComputerNum" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="AgencyAmount" style="text-align:left">代理费（<span class="CurrencyRMB"></span>）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="AgencyAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Rate" style="text-align:left;padding-left:40px">汇率（暂按代理协议约定）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Rate" data-type="SheetTextBox" style="" class="AmountFormat5" data-onchange="computerHY()">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="HKAmountRMB" style="text-align:left">货款金额（人民币元）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="HKAmountRMB" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="AgencyAmountRMB" style="text-align:left">代理费（人民币元）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="AgencyAmountRMB" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="HKAndAgencyAmountRMB" style="text-align:left">合计（人民币元）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="HKAndAgencyAmountRMB" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="DelayAmount" style="text-align:left">滞期费（<span class="CurrencyRMB"></span>）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="DelayAmount" data-type="SheetTextBox" style="" class="AmountFormat" data-onchange="computerHY()">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="DelayAmountRMB" style="text-align:left">滞期费折合人民币（元）</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="DelayAmountRMB" data-type="SheetTextBox" style="" class="AmountFormat">
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="div556621" class="col-md-2">
                        <label data-datafield="OtherFee" data-type="SheetLabel" id="ctl313417" class="" style="text-align:left">其他费</label>
                    </div>
                    <div id="div46277" class="col-md-10">
                        <table id="ctl902668" data-datafield="OtherFee" data-type="SheetGridView" class="SheetGridView" style="" data-displaysummary="false" data-onremoved="computerHY()" data-defaultrowcount="0">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl902668_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl902668_header0" data-datafield="OtherFee.FeeName" style="">
                                        <label id="ctl902668_Label0" data-datafield="OtherFee.FeeName" data-type="SheetLabel" style="">费用名称</label></td>
                                    <td id="ctl902668_header1" data-datafield="OtherFee.Amount" style="">
                                        <label id="ctl902668_Label1" data-datafield="OtherFee.Amount" data-type="SheetLabel" style="">金额</label></td>
                                    <td id="ctl902668_header2" data-datafield="OtherFee.AmountRMB" style="">
                                        <label id="ctl902668_Label2" data-datafield="OtherFee.AmountRMB" data-type="SheetLabel" style="">折合人民币（元）</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl902668_control0" data-datafield="OtherFee.FeeName" style="">
                                        <input type="text" data-datafield="OtherFee.FeeName" data-type="SheetTextBox" id="ctl902668_control0" style="" data-onchange="computerHY()"></td>
                                    <td id="ctl902668_control1" data-datafield="OtherFee.Amount" style="">
                                        <input type="text" data-datafield="OtherFee.Amount" data-type="SheetTextBox" id="ctl902668_control1" style="" class="AmountFormat" data-onchange="computerHY()"></td>
                                    <td id="ctl902668_control2" data-datafield="OtherFee.AmountRMB" style="">
                                        <input type="text" data-datafield="OtherFee.AmountRMB" data-type="SheetTextBox" id="ctl902668_control2" style="" class="AmountFormat" data-computationrule="{OtherFee.Amount}*{Rate}"></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl902668_Stat0" data-datafield="OtherFee.FeeName" style=""></td>
                                    <td id="ctl902668_Stat1" data-datafield="OtherFee.Amount" style="">
                                        <label id="ctl902668_StatControl1" data-datafield="OtherFee.Amount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td id="ctl902668_Stat2" data-datafield="OtherFee.AmountRMB" style="">
                                        <label id="ctl902668_StatControl2" data-datafield="OtherFee.AmountRMB" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row HYDiv">
                    <div id="div102397" class="col-md-2">
                        <label data-datafield="OtherContext" data-type="SheetLabel" id="ctl781579" class="" style="text-align:left">其他</label>
                    </div>
                    <div id="div875995" class="col-md-4">
                        <input type="text" data-datafield="OtherContext" data-type="SheetTextBox" id="ctl180961" class="" style="">
                    </div>
                    <div id="div90157" class="col-md-2"></div>
                    <div id="div790435" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div763365" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="OtherBankFee" style="text-align:left;padding-left:40px">银行费（人民币元）</span>
                    </div>
                    <div id="div843326" class="col-md-4">
                        <input type="text" data-datafield="OtherBankFee" data-type="SheetTextBox" id="ctl241881" style="" class="AmountFormat" data-onchange="computerHY()">
                    </div>
                    <div id="div625981" class="col-md-2"></div>
                    <div id="div479722" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div375493" class="col-md-2">
                        <label data-datafield="TotalAmount" data-type="SheetLabel" id="ctl521858" class="" style="text-align:left">总计（人民币元）</label>
                    </div>
                    <div id="div67447" class="col-md-4">
                        <input type="text" data-datafield="TotalAmount" data-type="SheetTextBox" id="ctl206570" style="" class="AmountFormat">
                    </div>
                    <div id="div545676" class="col-md-2"></div>
                    <div id="div891617" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="OtherRemark" style="">其他说明</span>
                    </div>
                    <div id="control1" class="col-md-10">
                        <textarea id="Control29" data-datafield="OtherRemark" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title9" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="QKSubTbl" style="">请款明细</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <table id="ctl383289" data-datafield="QKSubTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="1" data-onremoved="compute()"  data-onadded="AddedRender()">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl383289_SerialNo" class="rowSerialNo" style="width:5%">序号</td>
                                    <td id="ctl383289_header0" data-datafield="QKSubTbl.QKType" style="width:10%">
                                        <label id="ctl383289_Label0" data-datafield="QKSubTbl.QKType" data-type="SheetLabel" style="">请款类型</label></td>
                                    <td id="ctl383289_header1" data-datafield="QKSubTbl.ZJKX" style="width:10%">
                                        <label id="ctl383289_Label1" data-datafield="QKSubTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                    <td id="ctl383289_header2" data-datafield="QKSubTbl.ZJMS" style="width:20%">
                                        <label id="ctl383289_Label2" data-datafield="QKSubTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label></td>
                                    <td id="ctl383289_header3" data-datafield="QKSubTbl.Amount" style="width:15%">
                                        <label id="ctl383289_Label3" data-datafield="QKSubTbl.Amount" data-type="SheetLabel" style="">金额</label></td>
                                    <td id="ctl383289_header4" data-datafield="QKSubTbl.Currency" style="width:10%">
                                        <label id="ctl383289_Label4" data-datafield="QKSubTbl.Currency" data-type="SheetLabel" style="">币种</label></td>
                                    <td id="ctl383289_header5" data-datafield="QKSubTbl.Rate" style="width:10%">
                                        <label id="ctl383289_Label5" data-datafield="QKSubTbl.Rate" data-type="SheetLabel" style="">汇率</label></td>
                                    <td id="ctl383289_header6" data-datafield="QKSubTbl.ConvertAmount" style="width:20%">
                                        <label id="ctl383289_Label6" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetLabel" style="">折算金额（人民币）</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl383289_control0" data-datafield="QKSubTbl.QKType" style="" class="">
                                        <select data-datafield="QKSubTbl.QKType" data-type="SheetDropDownList" id="ctl786150" class="" style="" data-masterdatacategory="请款类型" data-queryable="false" data-emptyitemtext="请选择" data-displayemptyitem="true"></select></td>
                                    <td id="ctl383289_control1" data-datafield="QKSubTbl.ZJKX" style="" class="">
                                        <select data-datafield="QKSubTbl.ZJKX" data-type="SheetDropDownList" id="ctl592019" class="" style="" data-schemacode="GetZJKXByQKType" data-querycode="GetZJKX" data-filter="QKSubTbl.QKType:Type" data-datavaluefield="Code" data-datatextfield="EnumValue" data-queryable="false" data-onchange="ZJKXChange(this)" data-emptyitemtext="请选择" data-displayemptyitem="true"></select></td>
                                    <td id="ctl383289_control2" data-datafield="QKSubTbl.ZJMS" style="" class="">
                                        <input type="text" data-datafield="QKSubTbl.ZJMS" data-type="SheetTextBox" id="ctl383289_control2" style="width:95%" class=""></td>
                                    <td id="ctl383289_control3" data-datafield="QKSubTbl.Amount" style="" class="">
                                        <input type="text" data-datafield="QKSubTbl.Amount" data-type="SheetTextBox" id="ctl383289_control3" style="" class="AmountFormat" data-onchange="compute()" ></td>
                                    <td id="ctl383289_control4" data-datafield="QKSubTbl.Currency" style="" class="">
                                        <select data-datafield="QKSubTbl.Currency" data-type="SheetDropDownList" id="ctl18966" class="" style="width:80%" data-onchange="CurrencyChange(this);compute();" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-queryable="false"  data-emptyitemtext="请选择" data-displayemptyitem="true"></select></td>
                                    <td id="ctl383289_control5" data-datafield="QKSubTbl.Rate" style="" class="" >
                                        <input type="text" data-datafield="QKSubTbl.Rate" data-type="SheetTextBox" id="ctl383289_control5" style="" class="AmountFormat5" data-onchange="compute()"></td>
                                    <td id="ctl383289_control6" data-datafield="QKSubTbl.ConvertAmount" style="" class="" data-computationrule="{QKSubTbl.Amount}*{QKSubTbl.Rate}">
                                        <input type="text" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetTextBox" id="ctl383289_control6" style="" class="AmountFormat" data-computationrule="{QKSubTbl.Amount}*{QKSubTbl.Rate}"></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl383289_Stat0" data-datafield="QKSubTbl.QKType" style=""></td>
                                    <td id="ctl383289_Stat1" data-datafield="QKSubTbl.ZJKX" style=""></td>
                                    <td id="ctl383289_Stat2" data-datafield="QKSubTbl.ZJMS" style=""></td>
                                    <td id="ctl383289_Stat3" data-datafield="QKSubTbl.Amount" style="" class=""></td>
                                    <td id="ctl383289_Stat4" data-datafield="QKSubTbl.Currency" style=""></td>
                                    <td id="ctl383289_Stat5" data-datafield="QKSubTbl.Rate" style="" class=""></td>
                                    <td id="ctl383289_Stat6" data-datafield="QKSubTbl.ConvertAmount" style="">
                                        <label id="ctl383289_StatControl6" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetCountLabel" data-formatrule="{0:N2}" style=""></label>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="QKUploadFile" style="">请款上传文件</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <input type="text" data-datafield="QKUploadFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="QKUploadFile"></div>
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
                    <div id="div430823" class="col-md-2">
                        <label data-datafield="ManagerSuggest" data-type="SheetLabel" id="ctl828321" class="" style="">项目经理审批意见</label>
                    </div>
                    <div id="div823598" class="col-md-10">
                        <div data-datafield="ManagerSuggest" data-type="SheetComment" id="ctl925541" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div665888" class="col-md-2">
                        <label data-datafield="CompanyLeaderSuggest" data-type="SheetLabel" id="ctl964917" class="" style="">公司领导审批意见</label>
                    </div>
                    <div id="div304842" class="col-md-10">
                        <div data-datafield="CompanyLeaderSuggest" data-type="SheetComment" id="ctl202182" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div963974" class="col-md-2">
                        <label data-datafield="SDDate" data-type="SheetLabel" id="ctl268724" class="" style="">请款送达时间</label>
                    </div>
                    <div id="div316085" class="col-md-4">
                        <input type="text" data-datafield="SDDate" data-type="SheetTime" id="ctl143916" class="" style="">
                    </div>
                    <div id="div245687" class="col-md-2"></div>
                    <div id="div532090" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="div684506" class="col-md-2">
                        <label data-datafield="SignFile" data-type="SheetLabel" id="ctl211673" class="" style="">请款文件签字版</label>
                    </div>
                    <div id="div407211" class="col-md-4">
                        <input type="text" data-datafield="SignFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="SignFile"></div>
                    </div>
                    <div id="div380748" class="col-md-2"></div>
                    <div id="div558889" class="col-md-4"></div>
                </div>
                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        <input id="Control20" type="text" data-datafield="JSObjectID" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div544852" class="col-md-1">
                        <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div523468" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div315418" class="col-md-1">
                        <input type="text" data-datafield="QKWBCurrencyCode" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div836564" class="col-md-1">
                        <select data-datafield="DemoSelect" data-type="SheetDropDownList" id="ctl257452" class="" style="" data-onchange="DemoSelectChange()"></select>
                    </div>
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
                <label id="divSheetInfo" data-en_us="Sheet information">请款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackQKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">请款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackQKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackQKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackQKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackQKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackQKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackQKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackQKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackQKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackQKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackQKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackQKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackQKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackQKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackQKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackQKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackQKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackQKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackQKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackQKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackQKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackQKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackQKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackQKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackQKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackQKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackQKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackQKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
