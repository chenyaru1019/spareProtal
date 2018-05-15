﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SQK.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SQK" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">请款子流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="nav-icon fa fa-chevron-right bannerTitle">
            <label id="divBasicInfo" data-en_us="Basic information">基本信息</label>
        </div>
        <div class="divContent">
            <div class="row">
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
            <div class="row">
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
        <div class="nav-icon fa  fa-chevron-right bannerTitle">
            <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
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
                    <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="">
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

                    <span id="Label14" data-type="SheetLabel" data-datafield="QKSeq" style="" class="">请款批次</span>
                </div>
                <div id="control4" class="col-md-4">

                    <input id="Control14" type="text" data-datafield="QKSeq" data-type="SheetTextBox" style="" class="">
                </div>
            </div>
            <div class="row">
                <div id="title5" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="QKTarget" style="">请款对象</span>
                </div>
                <div id="control5" class="col-md-4">

                    <select data-datafield="QKTarget" data-type="SheetDropDownList" id="ctl412324" class="" style="" data-schemacode="GetQKTarget" data-querycode="GetQKTarget" data-filter="ContractNo:ContractNo" data-datavaluefield="FinalUser" data-datatextfield="FinalUser" data-queryable="false"></select>
                </div>
                <div id="title6" class="col-md-2">
                    <label data-datafield="Dun" data-type="SheetLabel" id="ctl633779" class="" style="">航油吨数</label>
                </div>
                <div id="control6" class="col-md-4">
                    <input type="text" data-datafield="Dun" data-type="SheetTextBox" id="ctl53664" class="" style="">
                </div>
            </div>
            <div class="row">
                <div id="div217155" class="col-md-2">
                    <span id="Label16" data-type="SheetLabel" data-datafield="QKContent" class="" style="">请款内容</span>
                </div>
                <div id="div725078" class="col-md-4">
                    <input id="Control16" type="text" data-datafield="QKContent" data-type="SheetTextBox" class="" style="">
                </div>
                <div id="div584374" class="col-md-2">
                    <label data-datafield="Tong" data-type="SheetLabel" id="ctl743383" class="" style="">航油桶数</label>
                </div>
                <div id="div655164" class="col-md-4">
                    <input type="text" data-datafield="Tong" data-type="SheetTextBox" id="ctl479185" class="" style="">
                </div>
            </div>
            <div class="row">
                <div id="div862700" class="col-md-2"><span id="Label17" data-type="SheetLabel" data-datafield="QKTotalAmoutRMB" class="" style="">请款金额</span></div>
                <div id="div678489" class="col-md-1">
                    <input id="Control17" type="text" data-datafield="QKTotalAmoutRMB" data-type="SheetTextBox" class="" style="width: 100%;"></div>
                <div id="div438633" class="col-md-1">
                    <input type="text" data-datafield="QKRMBCurrency" data-type="SheetTextBox" id="ctl213262" class="" style=""></div>
                <div id="div62334" class="col-md-1">
                    <input id="Control18" type="text" data-datafield="QKTotalAmoutWB" data-type="SheetTextBox" class="" style="width: 100%;"></div>
                <div id="div406470" class="col-md-1">
                    <input type="text" data-datafield="QKWBCurrency" data-type="SheetTextBox" id="ctl28827" class="" style=""></div>
                <div id="div811131" class="col-md-6"></div>
            </div>
            <div class="row tableContent">
                <div id="title9" class="col-md-2">
                    <span id="Label19" data-type="SheetLabel" data-datafield="QKSubTbl" style="">请款明细</span>
                </div>
                <div id="control9" class="col-md-10">

                    <table id="ctl383289" data-datafield="QKSubTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-onremoved="compute()">
                        <tbody>
                            <tr class="header">
                                <td id="ctl383289_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl383289_header0" data-datafield="QKSubTbl.QKType" style="">
                                    <label id="ctl383289_Label0" data-datafield="QKSubTbl.QKType" data-type="SheetLabel" style="">请款类型</label></td>
                                <td id="ctl383289_header1" data-datafield="QKSubTbl.ZJKX" style="">
                                    <label id="ctl383289_Label1" data-datafield="QKSubTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                <td id="ctl383289_header2" data-datafield="QKSubTbl.ZJMS" style="" class="">
                                    <label id="ctl383289_Label2" data-datafield="QKSubTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label></td>
                                <td id="ctl383289_header3" data-datafield="QKSubTbl.Amount" style="" class="">
                                    <label id="ctl383289_Label3" data-datafield="QKSubTbl.Amount" data-type="SheetLabel" style="">金额</label></td>
                                <td id="ctl383289_header4" data-datafield="QKSubTbl.Currency" style="">
                                    <label id="ctl383289_Label4" data-datafield="QKSubTbl.Currency" data-type="SheetLabel" style="">币种</label></td>
                                <td id="ctl383289_header5" data-datafield="QKSubTbl.Rate" style="">
                                    <label id="ctl383289_Label5" data-datafield="QKSubTbl.Rate" data-type="SheetLabel" style="">汇率</label></td>
                                <td id="ctl383289_header6" data-datafield="QKSubTbl.ConvertAmount" style="">
                                    <label id="ctl383289_Label6" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetLabel" style="">折算金额（人民币）</label></td>
                                <td class="rowOption">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl383289_control0" data-datafield="QKSubTbl.QKType" style="" class="">
                                    <select data-datafield="QKSubTbl.QKType" data-type="SheetDropDownList" id="ctl786150" class="" style="" data-masterdatacategory="请款类型" data-emptyitemtext="请选择" data-displayemptyitem="true"></select></td>
                                <td id="ctl383289_control1" data-datafield="QKSubTbl.ZJKX" style="" class="">
                                    <select data-datafield="QKSubTbl.ZJKX" data-type="SheetDropDownList" id="ctl592019" class="" style="" data-schemacode="GetZJKXByQKType" data-querycode="GetZJKX" data-filter="QKSubTbl.QKType:Type" data-datavaluefield="Code" data-datatextfield="EnumValue"></select></td>
                                <td id="ctl383289_control2" data-datafield="QKSubTbl.ZJMS" style="" class="">
                                    <input type="text" data-datafield="QKSubTbl.ZJMS" data-type="SheetTextBox" id="ctl383289_control2" style="" class=""></td>
                                <td id="ctl383289_control3" data-datafield="QKSubTbl.Amount" style="" class="" data-onchange="compute()" data-formatrule="{0:N2}">
                                    <input type="text" data-datafield="QKSubTbl.Amount" data-type="SheetTextBox" id="ctl383289_control3" style="" class="" data-onchange="compute()" data-formatrule="{0:N2}"></td>
                                <td id="ctl383289_control4" data-datafield="QKSubTbl.Currency" style="" class="">
                                    <select data-datafield="QKSubTbl.Currency" data-type="SheetDropDownList" id="ctl18966" class="" style="" data-onchange="checkCurrency();compute();" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-emptyitemtext="请选择" data-displayemptyitem="true"></select></td>
                                <td id="ctl383289_control5" data-datafield="QKSubTbl.Rate" style="" class="" data-onchange="compute()">
                                    <input type="text" data-datafield="QKSubTbl.Rate" data-type="SheetTextBox" id="ctl383289_control5" style="" class="" data-onchange="compute()"></td>
                                <td id="ctl383289_control6" data-datafield="QKSubTbl.ConvertAmount" style="" class="" data-computationrule="{QKSubTbl.Amount}*{QKSubTbl.Rate}">
                                    <input type="text" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetTextBox" id="ctl383289_control6" style="" class="" data-computationrule="{QKSubTbl.Amount}*{QKSubTbl.Rate}"></td>
                                <td class="rowOption"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl383289_Stat0" data-datafield="QKSubTbl.QKType" style="" class=""></td>
                                <td id="ctl383289_Stat1" data-datafield="QKSubTbl.ZJKX" style="" class=""></td>
                                <td id="ctl383289_Stat2" data-datafield="QKSubTbl.ZJMS" style=""></td>
                                <td id="ctl383289_Stat3" data-datafield="QKSubTbl.Amount" style="" class=""></td>
                                <td id="ctl383289_Stat4" data-datafield="QKSubTbl.Currency" style=""></td>
                                <td id="ctl383289_Stat5" data-datafield="QKSubTbl.Rate" style="" class=""></td>
                                <td id="ctl383289_Stat6" data-datafield="QKSubTbl.ConvertAmount" style="" class="">
                                    <label id="ctl383289_StatControl6" data-datafield="QKSubTbl.ConvertAmount" data-type="SheetCountLabel" style="" class="" data-formatrule="{0:N2}"></label>
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
                    <div id="Control20" data-datafield="QKUploadFile" data-type="SheetAttachment" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div507309" class="col-md-2">
                    <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">申请备注</label></div>
                <div id="div203297" class="col-md-10">
                    <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div430823" class="col-md-2">
                    <label data-datafield="ManagerSuggest" data-type="SheetLabel" id="ctl828321" class="" style="">项目经理审批意见</label></div>
                <div id="div823598" class="col-md-10">
                    <div data-datafield="ManagerSuggest" data-type="SheetComment" id="ctl925541" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div665888" class="col-md-2">
                    <label data-datafield="CompanyLeaderSuggest" data-type="SheetLabel" id="ctl964917" class="" style="">公司领导审批意见</label></div>
                <div id="div304842" class="col-md-10">
                    <div data-datafield="CompanyLeaderSuggest" data-type="SheetComment" id="ctl202182" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div556621" class="col-md-2">
                    <label data-datafield="OtherFee" data-type="SheetLabel" id="ctl313417" class="" style="">其他费</label></div>
                <div id="div46277" class="col-md-10">
                    <table id="ctl902668" data-datafield="OtherFee" data-type="SheetGridView" class="SheetGridView" style="" data-displaysummary="false">
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
                                    <input type="text" data-datafield="OtherFee.FeeName" data-type="SheetTextBox" id="ctl902668_control0" style=""></td>
                                <td id="ctl902668_control1" data-datafield="OtherFee.Amount" style="">
                                    <input type="text" data-datafield="OtherFee.Amount" data-type="SheetTextBox" id="ctl902668_control1" style=""></td>
                                <td id="ctl902668_control2" data-datafield="OtherFee.AmountRMB" style="" data-computationrule="{OtherFee.Amount}*{Rate}">
                                    <input type="text" data-datafield="OtherFee.AmountRMB" data-type="SheetTextBox" id="ctl902668_control2" style="" class="" data-computationrule="{OtherFee.Amount}*{Rate}"></td>
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
            <div class="row">
                <div id="div102397" class="col-md-2">
                    <label data-datafield="OtherContext" data-type="SheetLabel" id="ctl781579" class="" style="">其他</label></div>
                <div id="div875995" class="col-md-4">
                    <input type="text" data-datafield="OtherContext" data-type="SheetTextBox" id="ctl180961" class="" style=""></div>
                <div id="div90157" class="col-md-2">
                    <label data-datafield="CurDate" data-type="SheetLabel" id="ctl717356" class="" style="">日期</label></div>
                <div id="div790435" class="col-md-4">
                    <input type="text" data-datafield="CurDate" data-type="SheetTime" id="ctl881635" class="" style=""></div>
            </div>
            <div class="row">
                <div id="div763365" class="col-md-2">
                    <label data-datafield="OtherBankFee" data-type="SheetLabel" id="ctl405549" class="" style="">银行费（人民币元）</label></div>
                <div id="div843326" class="col-md-4">
                    <input type="text" data-datafield="OtherBankFee" data-type="SheetTextBox" id="ctl241881" class="" style=""></div>
                <div id="div625981" class="col-md-2">
                    <label data-datafield="TDDate" data-type="SheetLabel" id="ctl907230" class="" style="">提单日</label></div>
                <div id="div479722" class="col-md-4">
                    <input type="text" data-datafield="TDDate" data-type="SheetTime" id="ctl82423" class="" style="" data-defaultvalue=""></div>
            </div>
            <div class="row">
                <div id="div375493" class="col-md-2">
                    <label data-datafield="TotalAmount" data-type="SheetLabel" id="ctl521858" class="" style="">总计（人民币元）</label></div>
                <div id="div67447" class="col-md-4">
                    <input type="text" data-datafield="TotalAmount" data-type="SheetTextBox" id="ctl206570" class="" style=""></div>
                <div id="div545676" class="col-md-2"></div>
                <div id="div891617" class="col-md-4"></div>
            </div>
            <div class="row tableContent">
                <div id="title13" class="col-md-2">
                </div>
                <div id="control13" class="col-md-10">
                </div>
            </div>
            <div class="row">
                <div id="div963974" class="col-md-2">
                    <label data-datafield="SDDate" data-type="SheetLabel" id="ctl268724" class="" style="">请款送达时间</label></div>
                <div id="div316085" class="col-md-4">
                    <input type="text" data-datafield="SDDate" data-type="SheetTime" id="ctl143916" class="" style=""></div>
                <div id="div245687" class="col-md-2"></div>
                <div id="div532090" class="col-md-4"></div>
            </div>
            <div class="row">
                <div id="div684506" class="col-md-2">
                    <label data-datafield="SignFile" data-type="SheetLabel" id="ctl211673" class="" style="">请款文件签字版</label></div>
                <div id="div407211" class="col-md-4">
                    <div data-datafield="SignFile" data-type="SheetAttachment" id="ctl296137" class="" style=""></div>
                </div>
                <div id="div380748" class="col-md-2"></div>
                <div id="div558889" class="col-md-4"></div>
            </div>
            <div class="row">
                <div id="div454238" class="col-md-1">
                    <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style=""></div>
                <div id="div562910" class="col-md-1"></div>
                <div id="div544852" class="col-md-1"></div>
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
</asp:Content>
