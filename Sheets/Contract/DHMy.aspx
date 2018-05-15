﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DHMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.DHMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="DHMy.js"></script>
    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">到货（非航油）子流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent DHApply" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHApply">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">到货申请</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent " id="divSheet">
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
                        <span id="Label14" data-type="SheetLabel" data-datafield="ShippingType" style="">运输方式</span>
                    </div>
                    <div id="control4" class="col-md-4">

                        <select data-datafield="ShippingType" data-type="SheetDropDownList" id="ctl863075" class="" style="" data-masterdatacategory="运输方式" data-queryable="false"></select>
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="DHType" style="">到货类别</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <select data-datafield="DHType" data-type="SheetDropDownList" id="ctl422074" class="" style="" data-masterdatacategory="到货类别" data-queryable="false" data-onchange="DHTypeChange()"></select>
                    </div>
                    <div id="title6" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="DHSeq" style="">到货批次</span>
                    </div>
                    <div id="control6" class="col-md-4">
                        <input type="text" data-datafield="DHSeq" data-type="SheetTextBox" id="ctl808331" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="Supplier" style="">供货商/发货人</span>
                    </div>
                    <div id="control7" class="col-md-4">
                        <input id="Control17" type="text" data-datafield="Supplier" data-type="SheetTextBox" style="">
                    </div>
                    <div id="space8" class="col-md-2">
                    </div>
                    <div id="spaceControl8" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent DHGoodsTbl">
                    <div id="title9" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="DHGoodsTbl" style="">商品信息</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <table id="Control18" data-datafield="DHGoodsTbl" data-type="SheetGridView" class="SheetGridView" data-displaysummary="false" data-displaysequenceno="false" data-defaultrowcount="0">
                            <tbody>

                                <tr class="header">
                                    <td id="Control18_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control18_Header3" data-datafield="DHGoodsTbl.GoodName"  style="width:10%">
                                        <label id="Control18_Label3" data-datafield="DHGoodsTbl.GoodName" data-type="SheetLabel" style="">中英文品名</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="DHGoodsTbl.OrigArea" style="width:10%">
                                        <label id="Control18_Label4" data-datafield="DHGoodsTbl.OrigArea" data-type="SheetLabel" style="">原产地</label>
                                    </td>
                                    <td id="Control18_Header5" data-datafield="DHGoodsTbl.Amount" style="width:8%">
                                        <label id="Control18_Label5" data-datafield="DHGoodsTbl.Amount" data-type="SheetLabel" style="">货物金额</label>
                                    </td>
                                    <td id="Control18_Header6" data-datafield="DHGoodsTbl.Currency" style="width:8%">
                                        <label id="Control18_Label6" data-datafield="DHGoodsTbl.Currency" data-type="SheetLabel" style="">币种</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="DHGoodsTbl.Num" style="width:8%">
                                        <label id="Control18_Label7" data-datafield="DHGoodsTbl.Num" data-type="SheetLabel" style="">货物数量</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="DHGoodsTbl.TaxNo" style="width:8%">
                                        <label id="Control18_Label8" data-datafield="DHGoodsTbl.TaxNo" data-type="SheetLabel" style="">商品编码</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="DHGoodsTbl.Weight" style="width:8%">
                                        <label id="Control18_Label8" data-datafield="DHGoodsTbl.Weight" data-type="SheetLabel" style="">净重</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="DHGoodsTbl.IsMB" style="width:7%">
                                        <label id="Control18_Label9" data-datafield="DHGoodsTbl.IsMB" data-type="SheetLabel" style="">是否免表</label>
                                    </td>
                                    <td id="Control18_Header10" data-datafield="DHGoodsTbl.IsBLBZJ" style="width:10%">
                                        <label id="Control18_Label10" data-datafield="DHGoodsTbl.IsBLBZJ" data-type="SheetLabel" style="">是否办理保证金手续</label>
                                    </td>
                                    <td id="Control18_Header11" data-datafield="DHGoodsTbl.Is3C" style="width:7%">
                                        <label id="Control18_Label11" data-datafield="DHGoodsTbl.Is3C" data-type="SheetLabel" style="">3C认证</label>
                                    </td>
                                    <td id="Control18_Header12" data-datafield="DHGoodsTbl.ImportLicense" style="width:10%">
                                        <label id="Control18_Label12" data-datafield="DHGoodsTbl.ImportLicense" data-type="SheetLabel" style="">进口许可证</label>
                                    </td>
                                    <td class="rowOption">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control18_Option" class="rowOption"></td>
                                    <td data-datafield="DHGoodsTbl.GoodName">
                                        <input id="Control18_ctl3" type="text" data-datafield="DHGoodsTbl.GoodName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.OrigArea">
                                        <input id="Control18_ctl4" type="text" data-datafield="DHGoodsTbl.OrigArea" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.Amount">
                                        <input id="Control18_ctl5" type="text" data-datafield="DHGoodsTbl.Amount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.Currency">

                                        <select data-datafield="DHGoodsTbl.Currency" data-type="SheetDropDownList" id="ctl838770" class="" style="" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-queryable="false"></select></td>
                                    <td data-datafield="DHGoodsTbl.Num">
                                        <input id="Control18_ctl7" type="text" data-datafield="DHGoodsTbl.Num" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.TaxNo">
                                        <input id="Control18_ctl8" type="text" data-datafield="DHGoodsTbl.TaxNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.Weight">
                                        <input id="Control18_ctl8" type="text" data-datafield="DHGoodsTbl.Weight" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="DHGoodsTbl.IsMB">
                                        <select data-datafield="DHGoodsTbl.IsMB" data-type="SheetDropDownList" id="ctl839573" class="" style="" data-masterdatacategory="是否" data-queryable="false"></select></td>
                                    <td data-datafield="DHGoodsTbl.IsBLBZJ">
                                        <select data-datafield="DHGoodsTbl.IsBLBZJ" data-type="SheetDropDownList" id="ctl993600" class="" style="" data-masterdatacategory="是否" data-queryable="false"></select></td>
                                    <td data-datafield="DHGoodsTbl.Is3C">
                                        <select data-datafield="DHGoodsTbl.Is3C" data-type="SheetDropDownList" id="ctl917459" class="" style="" data-masterdatacategory="是否" data-queryable="false"></select></td>
                                    <td data-datafield="DHGoodsTbl.ImportLicense">
                                        <select data-datafield="DHGoodsTbl.ImportLicense" data-type="SheetDropDownList" id="ctl853737" class="" style="" data-displayemptyitem="true" data-emptyitemtext=" " data-schemacode="GetImportLicensesOfDH" data-querycode="GetImportLicensesOfDH" data-filter="ContractNo:ContractNo" data-datavaluefield="GoodName" data-datatextfield="GoodName" data-queryable="false"></select></td>
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
                                    <td data-datafield="DHGoodsTbl.GoodName"></td>
                                    <td data-datafield="DHGoodsTbl.OrigArea"></td>
                                    <td data-datafield="DHGoodsTbl.Amount">
                                        <label id="Control18_stat5" data-datafield="DHGoodsTbl.Amount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td data-datafield="DHGoodsTbl.Currency"></td>
                                    <td data-datafield="DHGoodsTbl.Num">
                                        <label id="Control18_stat7" data-datafield="DHGoodsTbl.Num" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td data-datafield="DHGoodsTbl.TaxNo"></td>
                                    <td data-datafield="DHGoodsTbl.IsMB"></td>
                                    <td data-datafield="DHGoodsTbl.IsBLBZJ"></td>
                                    <td data-datafield="DHGoodsTbl.Is3C"></td>
                                    <td data-datafield="DHGoodsTbl.ImportLicense"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="ShipDate" style="">装运日期</span>
                    </div>
                    <div id="control11" class="col-md-4">
                        <input id="Control19" type="text" data-datafield="ShipDate" data-type="SheetTime" style="" class="" data-defaultvalue="">
                    </div>
                    <div id="title12" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="ExpectShipDate" style="">预计装运日期</span>
                    </div>
                    <div id="control12" class="col-md-4">
                        <input id="Control20" type="text" data-datafield="ExpectShipDate" data-type="SheetTime" style="" data-defaultvalue="" data-onchange="ExpirationDateChange()">
                    </div>
                </div>
                <div class="row">
                    <div id="title13" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="DeliverAddress" style="">货物拟送目的地</span>
                    </div>
                    <div id="control13" class="col-md-4">
                        <input id="Control21" type="text" data-datafield="DeliverAddress" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title14" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="RemindDate" style="">何时提醒到货</span>
                    </div>
                    <div id="control14" class="col-md-4">
                        <input id="Control22" type="text" data-datafield="RemindDate" data-type="SheetTime" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row">
                    <div id="title15" class="col-md-2">
                        <span id="Label23" data-type="SheetLabel" data-datafield="Contacts" style="">联系人</span>
                    </div>
                    <div id="control15" class="col-md-4">
                        <input id="Control23" type="text" data-datafield="Contacts" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title16" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="ContactType" style="">联系方式</span>
                    </div>
                    <div id="control16" class="col-md-4">
                        <input id="Control24" type="text" data-datafield="ContactType" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title17" class="col-md-2">
                        <span id="Label25" data-type="SheetLabel" data-datafield="ShipPort" style="">装运港</span>
                    </div>
                    <div id="control17" class="col-md-4">
                        <input id="Control25" type="text" data-datafield="ShipPort" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title18" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="TradeWord" style="">贸易术语</span>
                    </div>
                    <div id="control18" class="col-md-4">
                        <input id="Control26" type="text" data-datafield="TradeWord" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title19" class="col-md-2">
                        <span id="Label27" data-type="SheetLabel" data-datafield="DHAttachment" style="">到货单据</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <input type="text" data-datafield="DHAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="DHAttachment"></div>
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

            </div>
        </div>
        <div class="ContractContent DHCheck">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHCheck">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">复核</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent " id="divSheet">
                <div class="row tableContent">
                    <div id="title23" class="col-md-2">
                        <span id="Label29" data-type="SheetLabel" data-datafield="CheckComment" style="">复核意见</span>
                    </div>
                    <div id="control23" class="col-md-10">
                        <div id="Control29" data-datafield="CheckComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="ContractContent DHEntrust">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHEntrust">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">报关委托</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent " id="divSheet">
                <div class="row">
                    <div id="div621820" class="col-md-2">
                        <span id="Label30" data-type="SheetLabel" data-datafield="Entruster" style="" class="">委托处理人</span>
                    </div>
                    <div id="div737133" class="col-md-4">
                        <input id="Control30" type="text" data-datafield="Entruster" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div262780" class="col-md-2">
                        <label data-datafield="EntrustApplyDate" data-type="SheetLabel" id="ctl384827" class="hidden" style="">委托申请时间</label>
                    </div>
                    <div id="div292169" class="col-md-4">
                        <input type="text" data-datafield="EntrustApplyDate" data-type="SheetTime" id="ctl144136" class="hidden" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title25" class="col-md-2">

                        <span id="Label31" data-type="SheetLabel" data-datafield="EntrustNo" style="" class="">委托方编号</span>
                    </div>
                    <div id="control25" class="col-md-4">

                        <input id="Control31" type="text" data-datafield="EntrustNo" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title26" class="col-md-2">

                        <span id="Label32" data-type="SheetLabel" data-datafield="EntrustDate" style="" class="">委托时间</span>
                    </div>
                    <div id="control26" class="col-md-4">

                        <input id="Control32" type="text" data-datafield="EntrustDate" data-type="SheetTime" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title27" class="col-md-2">

                        <span id="Label33" data-type="SheetLabel" data-datafield="EntrustCompany" style="" class="">委托单位</span>
                    </div>
                    <div id="control27" class="col-md-4">

                        <input id="Control33" type="text" data-datafield="EntrustCompany" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title28" class="col-md-2">

                        <span id="Label34" data-type="SheetLabel" data-datafield="ContractNo_Entrust" style="" class="">合同号</span>
                    </div>
                    <div id="control28" class="col-md-4">

                        <input id="Control34" type="text" data-datafield="ContractNo_Entrust" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title29" class="col-md-2">

                        <span id="Label35" data-type="SheetLabel" data-datafield="AcceptCompany" style="" class="">受理单位</span>
                    </div>
                    <div id="control29" class="col-md-4">

                        <input id="Control35" type="text" data-datafield="AcceptCompany" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title30" class="col-md-2">

                        <span id="Label36" data-type="SheetLabel" data-datafield="ShipNo" style="" class="">船名航次/航班</span>
                    </div>
                    <div id="control30" class="col-md-4">

                        <input id="Control36" type="text" data-datafield="ShipNo" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title31" class="col-md-2">

                        <span id="Label37" data-type="SheetLabel" data-datafield="AWBNo" style="" class="">提单/运单号</span>
                    </div>
                    <div id="control31" class="col-md-4">

                        <input id="Control37" type="text" data-datafield="AWBNo" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title32" class="col-md-2">

                        <span id="Label38" data-type="SheetLabel" data-datafield="ReceiptNo" style="" class="">发票号</span>
                    </div>
                    <div id="control32" class="col-md-4">

                        <input id="Control38" type="text" data-datafield="ReceiptNo" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title33" class="col-md-2">

                        <span id="Label39" data-type="SheetLabel" data-datafield="DealTotalAmount" style="" class="">成交总金额</span>
                    </div>
                    <div id="control33" class="col-md-4">

                        <input id="Control39" type="text" data-datafield="DealTotalAmount" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title34" class="col-md-2">

                        <span id="Label40" data-type="SheetLabel" data-datafield="HKYFAmount" style="" class="">海/空运费金额</span>
                    </div>
                    <div id="control34" class="col-md-4">

                        <input id="Control40" type="text" data-datafield="HKYFAmount" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title35" class="col-md-2">

                        <span id="Label41" data-type="SheetLabel" data-datafield="BXAmount" style="" class="">保险金额</span>
                    </div>
                    <div id="control35" class="col-md-4">

                        <input id="Control41" type="text" data-datafield="BXAmount" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title36" class="col-md-2">

                        <span id="Label42" data-type="SheetLabel" data-datafield="Quo20" style="" class="">20'</span>
                    </div>
                    <div id="control36" class="col-md-4">

                        <input id="Control42" type="text" data-datafield="Quo20" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title37" class="col-md-2">

                        <span id="Label43" data-type="SheetLabel" data-datafield="Quo40" style="" class="">40'</span>
                    </div>
                    <div id="control37" class="col-md-4">

                        <input id="Control43" type="text" data-datafield="Quo40" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title38" class="col-md-2">

                        <span id="Label44" data-type="SheetLabel" data-datafield="TSBox" style="" class="">特殊规格箱</span>
                    </div>
                    <div id="control38" class="col-md-4">

                        <input id="Control44" type="text" data-datafield="TSBox" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title39" class="col-md-2">

                        <span id="Label45" data-type="SheetLabel" data-datafield="SH" style="" class="">散货</span>
                    </div>
                    <div id="control39" class="col-md-4">

                        <input id="Control45" type="text" data-datafield="SH" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title40" class="col-md-2">

                        <span id="Label46" data-type="SheetLabel" data-datafield="ZG" style="" class="">装港</span>
                    </div>
                    <div id="control40" class="col-md-4">

                        <input id="Control46" type="text" data-datafield="ZG" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title41" class="col-md-2">

                        <span id="Label47" data-type="SheetLabel" data-datafield="UnloadPort" style="" class="">卸货码头</span>
                    </div>
                    <div id="control41" class="col-md-4">

                        <input id="Control47" type="text" data-datafield="UnloadPort" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title42" class="col-md-2">

                        <span id="Label48" data-type="SheetLabel" data-datafield="ShipDate_Entrust" style="" class="">装运时间</span>
                    </div>
                    <div id="control42" class="col-md-4">

                        <input id="Control48" type="text" data-datafield="ShipDate_Entrust" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title43" class="col-md-2">

                        <span id="Label49" data-type="SheetLabel" data-datafield="StopTime" style="" class="">靠泊时间</span>
                    </div>
                    <div id="control43" class="col-md-4">

                        <input id="Control49" type="text" data-datafield="StopTime" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title44" class="col-md-2">
                    </div>
                    <div id="control44" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title45" class="col-md-2">
                        <span id="Label50" data-type="SheetLabel" data-datafield="ShopTable_Entrust" style="">托运商品信息</span>
                    </div>
                    <div id="control45" class="col-md-10">
                        <table id="Control50" data-datafield="ShopTable_Entrust" data-type="SheetGridView" class="SheetGridView" data-displaysequenceno="false" data-defaultrowcount="1" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control50_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control50_Header3" data-datafield="ShopTable_Entrust.GoodNo" style="width:25%">
                                        <label id="Control50_Label3" data-datafield="ShopTable_Entrust.GoodNo" data-type="SheetLabel" style="">商品编码</label>
                                    </td>
                                    <td id="Control50_Header4" data-datafield="ShopTable_Entrust.GoodName" style="width:25%">
                                        <label id="Control50_Label4" data-datafield="ShopTable_Entrust.GoodName" data-type="SheetLabel" style="">中英文品名</label>
                                    </td>
                                    <td id="Control50_Header5" data-datafield="ShopTable_Entrust.Num" style="width:10%">
                                        <label id="Control50_Label5" data-datafield="ShopTable_Entrust.Num" data-type="SheetLabel" style="">件数</label>
                                    </td>
                                    <td id="Control50_Header6" data-datafield="ShopTable_Entrust.MZ" style="width:10%">
                                        <label id="Control50_Label6" data-datafield="ShopTable_Entrust.MZ" data-type="SheetLabel" style="">毛重</label>
                                    </td>
                                    <td id="Control50_Header7" data-datafield="ShopTable_Entrust.JZ" style="width:10%">
                                        <label id="Control50_Label7" data-datafield="ShopTable_Entrust.JZ" data-type="SheetLabel" style="">净重</label>
                                    </td>
                                    <td id="Control50_Header8" data-datafield="ShopTable_Entrust.CM" style="width:10%">
                                        <label id="Control50_Label8" data-datafield="ShopTable_Entrust.CM" data-type="SheetLabel" style="">尺码</label>
                                    </td>
                                    <td class="rowOption">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control50_Option" class="rowOption"></td>
                                    <td data-datafield="ShopTable_Entrust.GoodNo">
                                        <input id="Control50_ctl3" type="text" data-datafield="ShopTable_Entrust.GoodNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="ShopTable_Entrust.GoodName">
                                        <input id="Control50_ctl5" type="text" data-datafield="ShopTable_Entrust.GoodName" data-type="SheetTextBox" style="">
                                        <%--<select data-datafield="ShopTable_Entrust.GoodName" data-type="SheetDropDownList" id="ctl694713" class="" style="" data-emptyitemtext=" " data-schemacode="GetGoodNameOfTY" data-querycode="GetGoodNameOfTY" data-filter="ContractNo:ContractNo,DHSeq:DHSeq" data-datavaluefield="GoodName" data-datatextfield="GoodName"
                                            data-onchange="GoodNameChange(this)" data-queryable="false">
                                        </select>--%></td>
                                    <td data-datafield="ShopTable_Entrust.Num">
                                        <input id="Control50_ctl5" type="text" data-datafield="ShopTable_Entrust.Num" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="ShopTable_Entrust.MZ">
                                        <input id="Control50_ctl6" type="text" data-datafield="ShopTable_Entrust.MZ" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="ShopTable_Entrust.JZ">
                                        <input id="Control50_ctl7" type="text" data-datafield="ShopTable_Entrust.JZ" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="ShopTable_Entrust.CM">
                                        <input id="Control50_ctl8" type="text" data-datafield="ShopTable_Entrust.CM" data-type="SheetTextBox" style="">
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
                                    <td data-datafield="ShopTable_Entrust.GoodNo"></td>
                                    <td data-datafield="ShopTable_Entrust.GoodName"></td>
                                    <td data-datafield="ShopTable_Entrust.Num">
                                        <label id="Control50_stat5" data-datafield="ShopTable_Entrust.Num" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td data-datafield="ShopTable_Entrust.MZ"></td>
                                    <td data-datafield="ShopTable_Entrust.JZ"></td>
                                    <td data-datafield="ShopTable_Entrust.CM"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row">
                    <div id="div698360" class="col-md-2"><span id="Label51" data-type="SheetLabel" data-datafield="ImportEntrustThing" style="" class=""><span class="DHType"></span>委托事项</span></div>
                    <div id="div19959" class="col-md-10">
                        <div data-datafield="ImportEntrustThing" data-type="SheetCheckboxList" id="ctl655428" class="" style="" data-masterdatacategory="进口委托事项"></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div626461" class="col-md-2"><span id="Label52" data-type="SheetLabel" data-datafield="FSDZ" style="" class="">随附单证</span></div>
                    <div id="div698003" class="col-md-10">
                        <div data-datafield="FSDZ" data-type="SheetCheckboxList" id="ctl669683" class="" style="" data-masterdatacategory="随附单证"></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div827137" class="col-md-2"><span id="Label53" data-type="SheetLabel" data-datafield="DZTSRemark" style="" class="">单证特殊要求说明</span></div>
                    <div id="div202106" class="col-md-10">
                        <input id="Control53" type="text" data-datafield="DZTSRemark" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div217557" class="col-md-2"><span id="Label54" data-type="SheetLabel" data-datafield="ReceiptTitle" style="" class="">发票抬头为</span></div>
                    <div id="div422136" class="col-md-10">
                        <input id="Control54" type="text" data-datafield="ReceiptTitle" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div533782" class="col-md-2"><span id="Label55" data-type="SheetLabel" data-datafield="Remark_Entrust" style="" class="">备注</span></div>
                    <div id="div542680" class="col-md-10">
                        <input id="Control55" type="text" data-datafield="Remark_Entrust" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div248437" class="col-md-6">委托单位</div>
                    <div id="div458587" class="col-md-6">送货单位</div>
                </div>
                <div class="row">
                    <div id="title51" class="col-md-2">

                        <span id="Label56" data-type="SheetLabel" data-datafield="Contracts_WT" style="" class="">联系人</span>
                    </div>
                    <div id="control51" class="col-md-4">

                        <input id="Control56" type="text" data-datafield="Contracts_WT" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title52" class="col-md-2">

                        <span id="Label62" data-type="SheetLabel" data-datafield="Contacts_SH" style="" class="">联系人</span>
                    </div>
                    <div id="control52" class="col-md-4">

                        <input id="Control62" type="text" data-datafield="Contacts_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title53" class="col-md-2">
                        <span id="Label57" data-type="SheetLabel" data-datafield="ShipPort_WT" style="">装运港</span>
                    </div>
                    <div id="control53" class="col-md-4">
                        <input id="Control57" type="text" data-datafield="ShipPort_WT" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title54" class="col-md-2">

                        <span id="Label63" data-type="SheetLabel" data-datafield="TradeWord_SH" style="" class="">贸易术语</span>
                    </div>
                    <div id="control54" class="col-md-4">

                        <input id="Control63" type="text" data-datafield="TradeWord_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div566061" class="col-md-2"><span id="Label58" data-type="SheetLabel" data-datafield="Mobile_WT" style="" class="">手机</span></div>
                    <div id="div972888" class="col-md-4">
                        <input id="Control58" type="text" data-datafield="Mobile_WT" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div327912" class="col-md-2"><span id="Label64" data-type="SheetLabel" data-datafield="Mobile_SH" style="" class="">手机</span></div>
                    <div id="div837899" class="col-md-4">
                        <input id="Control64" type="text" data-datafield="Mobile_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title55" class="col-md-2">
                        <span id="Label59" data-type="SheetLabel" data-datafield="Telephone_WT" style="">电话</span>
                    </div>
                    <div id="control55" class="col-md-4">
                        <input id="Control59" type="text" data-datafield="Telephone_WT" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title56" class="col-md-2">

                        <span id="Label65" data-type="SheetLabel" data-datafield="Telephone_SH" style="" class="">电话</span>
                    </div>
                    <div id="control56" class="col-md-4">

                        <input id="Control65" type="text" data-datafield="Telephone_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div115506" class="col-md-2"><span id="Label60" data-type="SheetLabel" data-datafield="Fax_WT" style="" class="">传真</span></div>
                    <div id="div488668" class="col-md-4">
                        <input id="Control60" type="text" data-datafield="Fax_WT" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div513045" class="col-md-2"><span id="Label66" data-type="SheetLabel" data-datafield="Fax_SH" style="" class="">传真</span></div>
                    <div id="div597756" class="col-md-4">
                        <input id="Control66" type="text" data-datafield="Fax_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title57" class="col-md-2">
                        <span id="Label61" data-type="SheetLabel" data-datafield="Address_WT" style="">地址</span>
                    </div>
                    <div id="control57" class="col-md-4">
                        <input id="Control61" type="text" data-datafield="Address_WT" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title58" class="col-md-2">

                        <span id="Label67" data-type="SheetLabel" data-datafield="Address_SH" style="" class="">地址</span>
                    </div>
                    <div id="control58" class="col-md-4">

                        <input id="Control67" type="text" data-datafield="Address_SH" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>

            </div>
        </div>
        <div class="ContractContent DHConfirm">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHConfirm">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">确认</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent " id="divSheet">
                <div class="row">
                    <div id="title63" class="col-md-2">

                        <span id="Label68" data-type="SheetLabel" data-datafield="PassDate" style="" class="">放行日期</span>
                    </div>
                    <div id="control63" class="col-md-4">

                        <input id="Control68" type="text" data-datafield="PassDate" data-type="SheetTime" style="" class="">
                    </div>
                    <div id="title64" class="col-md-2">
                    </div>
                    <div id="control64" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ConfirmRemark" data-type="SheetLabel" id="ctl818667" class="" style="">确认备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="ConfirmRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ContractContent DHComplete">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHComplete">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">报关完成</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent " id="divSheet">
                <div class="row">
                    <div id="title67" class="col-md-2">
                        <span id="Label70" data-type="SheetLabel" data-datafield="BGNo" style="">报关单号</span>
                    </div>
                    <div id="control67" class="col-md-4">
                        <input id="Control70" type="text" data-datafield="BGNo" data-type="SheetTextBox" style="">
                    </div>
                    <div id="space68" class="col-md-2">
                    </div>
                    <div id="spaceControl68" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div752927" class="col-md-2">
                        <label data-datafield="InOutDate" data-type="SheetLabel" id="ctl840247" class="" style=""><span class="DHType"></span>日期</label>
                    </div>
                    <div id="div812706" class="col-md-4">
                        <input type="text" data-datafield="InOutDate" data-type="SheetTime" id="ctl742265" class="" style="">
                    </div>
                    <div id="div994519" class="col-md-2">
                        <label data-datafield="SBDate" data-type="SheetLabel" id="ctl120260" class="" style="">申报日期</label>
                    </div>
                    <div id="div16058" class="col-md-4">
                        <input type="text" data-datafield="SBDate" data-type="SheetTime" id="ctl545041" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="div721464" class="col-md-2">
                        <label data-datafield="TradeType" data-type="SheetLabel" id="ctl156076" class="" style="">贸易方式</label>
                    </div>
                    <div id="div891328" class="col-md-4">
                        <select data-datafield="TradeType" data-type="SheetDropDownList" id="ctl617251" class="" style="" data-masterdatacategory="贸易方式" data-queryable="false"></select>
                    </div>
                    <div id="div69554" class="col-md-2"></div>
                    <div id="div594317" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="title69" class="col-md-2">
                        <span id="Label71" data-type="SheetLabel" data-datafield="BGAttachment" style="">报关单</span>
                    </div>
                    <div id="control69" class="col-md-10">
                        <input type="text" data-datafield="BGAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="BGAttachment"></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title71" class="col-md-2">
                        <span id="Label72" data-type="SheetLabel" data-datafield="BGProcess" style="">报关过程</span>
                    </div>
                    <div id="control71" class="col-md-10">
                        <textarea id="Control72" data-datafield="BGProcess" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title73" class="col-md-2">
                        <span id="Label73" data-type="SheetLabel" data-datafield="BGAmount" style="">报关单金额</span>
                    </div>
                    <div id="control73" class="col-md-4">
                        <input id="Control73" type="text" data-datafield="BGAmount" data-type="SheetTextBox" style="width:80%""><span class="CurrencyWB"></span>
                    </div>
                    <div id="title74" class="col-md-2">
                        <span id="Label74" data-type="SheetLabel" data-datafield="TaxAmount" style="">征税金额</span>
                    </div>
                    <div id="control74" class="col-md-4">
                        <input id="Control74" type="text" data-datafield="TaxAmount" data-type="SheetTextBox" style="width:80%""><span class="CurrencyRMB"></span>
                    </div>
                </div>
                <div class="row">
                    <div id="title75" class="col-md-2">
                        <span id="Label75" data-type="SheetLabel" data-datafield="NoTaxAmount" style="">免税金额</span>
                    </div>
                    <div id="control75" class="col-md-4">
                        <input id="Control75" type="text" data-datafield="NoTaxAmount" data-type="SheetTextBox" style="width:80%""><span class="CurrencyWB"></span>
                    </div>
                    <%--<div id="title76" class="col-md-2">
                        <span id="Label76" data-type="SheetLabel" data-datafield="BGSignDate" style="">报关单签发日期</span>
                    </div>
                    <div id="control76" class="col-md-4">
                        <input id="Control76" type="text" data-datafield="BGSignDate" data-type="SheetTime" style="" data-defaultvalue="" data-onchange="BGSignDateChange()">
                    </div>
                </div>
                <div class="row">
                    <div id="title77" class="col-md-2">
                        <span id="Label77" data-type="SheetLabel" data-datafield="Date90" style="">90天日期</span>
                    </div>
                    <div id="control77" class="col-md-4">
                        <input id="Control77" type="text" data-datafield="Date90" data-type="SheetTime" style="">
                    </div>--%>
                    <div id="title78" class="col-md-2">
                        <%--<span id="Label78" data-type="SheetLabel" data-datafield="HYAmount" style="">航油合同总金额</span>--%>
                    </div>
                    <div id="control78" class="col-md-4">
                        <%--<input id="Control78" type="text" data-datafield="HYAmount" data-type="SheetTextBox" style="">--%>
                    </div>
                </div>
                <%--<div class="row">
                    <div id="title79" class="col-md-2">
                        <span id="Label79" data-type="SheetLabel" data-datafield="TDDate" style="">提单日</span>
                    </div>
                    <div id="control79" class="col-md-4">
                        <input id="Control79" type="text" data-datafield="TDDate" data-type="SheetTime" style="">
                    </div>
                    <div id="title80" class="col-md-2">
                        <span id="Label80" data-type="SheetLabel" data-datafield="HYDun" style="">航油吨数</span>
                    </div>
                    <div id="control80" class="col-md-4">
                        <input id="Control80" type="text" data-datafield="HYDun" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title81" class="col-md-2">
                        <span id="Label81" data-type="SheetLabel" data-datafield="HYPrice" style="">航油实际单价</span>
                    </div>
                    <div id="control81" class="col-md-4">
                        <input id="Control81" type="text" data-datafield="HYPrice" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title82" class="col-md-2">
                        <span id="Label82" data-type="SheetLabel" data-datafield="HYBucketNum" style="">航油桶数</span>
                    </div>
                    <div id="control82" class="col-md-4">
                        <input id="Control82" type="text" data-datafield="HYBucketNum" data-type="SheetTextBox" style="">
                    </div>
                </div>--%>
                <div class="row">
                    <div id="title83" class="col-md-2">
                        <span id="Label83" data-type="SheetLabel" data-datafield="ArrivalDate" style="">到港日</span>
                    </div>
                    <div id="control83" class="col-md-4">
                        <input id="Control83" type="text" data-datafield="ArrivalDate" data-type="SheetTime" style="">
                    </div>
                    <div id="space84" class="col-md-2">
                    </div>
                    <div id="spaceControl84" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title85" class="col-md-2">
                        <span id="Label84" data-type="SheetLabel" data-datafield="Remark_Complete" style="">备注</span>
                    </div>
                    <div id="control85" class="col-md-10">
                        <textarea id="Control84" data-datafield="Remark_Complete" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title87" class="col-md-2">
                        <span id="Label85" data-type="SheetLabel" data-datafield="HasHGBZJ" style="">是否有海关保证金</span>
                    </div>
                    <div id="control87" class="col-md-4">
                        <div data-datafield="HasHGBZJ" data-type="SheetCheckboxList" id="ctl932594" class="" style="" data-masterdatacategory="是"></div>
                    </div>
                    <div id="space88" class="col-md-2">
                    </div>
                    <div id="spaceControl88" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title89" class="col-md-2">
                        <span id="Label86" data-type="SheetLabel" data-datafield="HGBZJTbl" style="">海关保证金</span>
                    </div>
                    <div id="control89" class="col-md-10">
                        <table id="ctl718856" data-datafield="HGBZJTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displaysequenceno="false" data-displaysummary="false" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl718856_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl718856_header0" data-datafield="HGBZJTbl.IsCheck" style="">
                                        <label id="ctl718856_Label0" data-datafield="HGBZJTbl.IsCheck" data-type="SheetLabel" style="">选择</label></td>
                                    <td id="ctl718856_header1" data-datafield="HGBZJTbl.ZJKX" style="">
                                        <label id="ctl718856_Label1" data-datafield="HGBZJTbl.ZJKX" data-type="SheetLabel" style="" class="">资金款项</label></td>
                                    <td id="ctl718856_header2" data-datafield="HGBZJTbl.PayAmount" style="">
                                        <label id="ctl718856_Label2" data-datafield="HGBZJTbl.PayAmount" data-type="SheetLabel" style="" class="">付款</label></td>
                                    <td id="ctl718856_header3" data-datafield="HGBZJTbl.ConvertAmount" style="">
                                        <label id="ctl718856_Label3" data-datafield="HGBZJTbl.ConvertAmount" data-type="SheetLabel" style="" class="">折算</label></td>
                                    <td id="ctl718856_header4" data-datafield="HGBZJTbl.PayContent" style="" class="">
                                        <label id="ctl718856_Label4" data-datafield="HGBZJTbl.PayContent" data-type="SheetLabel" style="" class="">付款内容</label></td>
                                    <td id="ctl718856_header5" data-datafield="HGBZJTbl.PayType" style="">
                                        <label id="ctl718856_Label5" data-datafield="HGBZJTbl.PayType" data-type="SheetLabel" style="" class="">支付方式</label></td>
                                    <td id="ctl718856_header6" data-datafield="HGBZJTbl.Receiver" style="">
                                        <label id="ctl718856_Label6" data-datafield="HGBZJTbl.Receiver" data-type="SheetLabel" style="" class="">收款人</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl718856_control0" data-datafield="HGBZJTbl.IsCheck" style="">
                                        <div data-datafield="HGBZJTbl.IsCheck" data-type="SheetCheckboxList" id="ctl731810" class="" style="height: 50%;" data-defaultitems=" " data-repeatcolumns="1"></div>
                                    </td>
                                    <td id="ctl718856_control1" data-datafield="HGBZJTbl.ZJKX" style="">
                                        <input type="text" data-datafield="HGBZJTbl.ZJKX" data-type="SheetTextBox" id="ctl718856_control1" style=""></td>
                                    <td id="ctl718856_control2" data-datafield="HGBZJTbl.PayAmount" style="">
                                        <input type="text" data-datafield="HGBZJTbl.PayAmount" data-type="SheetTextBox" id="ctl718856_control2" style=""></td>
                                    <td id="ctl718856_control3" data-datafield="HGBZJTbl.ConvertAmount" style="">
                                        <input type="text" data-datafield="HGBZJTbl.ConvertAmount" data-type="SheetTextBox" id="ctl718856_control3" style=""></td>
                                    <td id="ctl718856_control4" data-datafield="HGBZJTbl.PayContent" style="">
                                        <input type="text" data-datafield="HGBZJTbl.PayContent" data-type="SheetTextBox" id="ctl718856_control4" style=""></td>
                                    <td id="ctl718856_control5" data-datafield="HGBZJTbl.PayType" style="">
                                        <input type="text" data-datafield="HGBZJTbl.PayType" data-type="SheetTextBox" id="ctl718856_control5" style=""></td>
                                    <td id="ctl718856_control6" data-datafield="HGBZJTbl.Receiver" style="">
                                        <input type="text" data-datafield="HGBZJTbl.Receiver" data-type="SheetTextBox" id="ctl718856_control6" style=""></td>
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
        <div class="ContractContent DHXB">
            <div class="nav-icon fa  fa-chevron-right bannerTitle DHXB">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">销报</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div id="title91" class="col-md-2">
                        <span id="Label87" data-type="SheetLabel" data-datafield="XBTbl" style="">销保</span>
                    </div>
                    <div id="control91" class="col-md-10">
                        <table id="ctl400672" data-datafield="XBTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl400672_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl400672_header0" data-datafield="XBTbl.ZJKX" style="">
                                        <label id="ctl400672_Label0" data-datafield="XBTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                    <td id="ctl400672_header1" data-datafield="XBTbl.PayAmount" style="">
                                        <label id="ctl400672_Label1" data-datafield="XBTbl.PayAmount" data-type="SheetLabel" style="">付款</label></td>
                                    <td id="ctl400672_header2" data-datafield="XBTbl.ConvertAmount" style="">
                                        <label id="ctl400672_Label2" data-datafield="XBTbl.ConvertAmount" data-type="SheetLabel" style="">折算</label></td>
                                    <td id="ctl400672_header3" data-datafield="XBTbl.PayContent" style="">
                                        <label id="ctl400672_Label3" data-datafield="XBTbl.PayContent" data-type="SheetLabel" style="">付款内容</label></td>
                                    <td id="ctl400672_header4" data-datafield="XBTbl.PayType" style="">
                                        <label id="ctl400672_Label4" data-datafield="XBTbl.PayType" data-type="SheetLabel" style="">支付方式</label></td>
                                    <td id="ctl400672_header5" data-datafield="XBTbl.Receiver" style="">
                                        <label id="ctl400672_Label5" data-datafield="XBTbl.Receiver" data-type="SheetLabel" style="">收款人</label></td>
                                    <td id="ctl400672_header6" data-datafield="XBTbl.XBStatus" style="">
                                        <label id="ctl400672_Label6" data-datafield="XBTbl.XBStatus" data-type="SheetLabel" style="">销保状态</label></td>
                                    <td id="ctl400672_header7" data-datafield="XBTbl.TBAmount" style="">
                                        <label id="ctl400672_Label7" data-datafield="XBTbl.TBAmount" data-type="SheetLabel" style="">退保金额</label></td>
                                    <td id="ctl400672_header8" data-datafield="XBTbl.TBDate" style="">
                                        <label id="ctl400672_Label8" data-datafield="XBTbl.TBDate" data-type="SheetLabel" style="">退保日期</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl400672_control0" data-datafield="XBTbl.ZJKX" style="">
                                        <input type="text" data-datafield="XBTbl.ZJKX" data-type="SheetTextBox" id="ctl400672_control0" style=""></td>
                                    <td id="ctl400672_control1" data-datafield="XBTbl.PayAmount" style="">
                                        <input type="text" data-datafield="XBTbl.PayAmount" data-type="SheetTextBox" id="ctl400672_control1" style=""></td>
                                    <td id="ctl400672_control2" data-datafield="XBTbl.ConvertAmount" style="">
                                        <input type="text" data-datafield="XBTbl.ConvertAmount" data-type="SheetTextBox" id="ctl400672_control2" style=""></td>
                                    <td id="ctl400672_control3" data-datafield="XBTbl.PayContent" style="">
                                        <input type="text" data-datafield="XBTbl.PayContent" data-type="SheetTextBox" id="ctl400672_control3" style=""></td>
                                    <td id="ctl400672_control4" data-datafield="XBTbl.PayType" style="">
                                        <input type="text" data-datafield="XBTbl.PayType" data-type="SheetTextBox" id="ctl400672_control4" style=""></td>
                                    <td id="ctl400672_control5" data-datafield="XBTbl.Receiver" style="">
                                        <input type="text" data-datafield="XBTbl.Receiver" data-type="SheetTextBox" id="ctl400672_control5" style=""></td>
                                    <td id="ctl400672_control6" data-datafield="XBTbl.XBStatus" style="" class="">
                                        <div data-datafield="XBTbl.XBStatus" data-type="SheetRadioButtonList" id="ctl695545" class="" style="" data-masterdatacategory="销保状态" data-repeatcolumns="1"
                                            data-onchange="XBStatusChange(this)">
                                        </div>
                                    </td>
                                    <td id="ctl400672_control7" data-datafield="XBTbl.TBAmount" style="" class="">
                                        <input type="text" data-datafield="XBTbl.TBAmount" data-type="SheetTextBox" id="ctl400672_control7" style=""></td>
                                    <td id="ctl400672_control8" data-datafield="XBTbl.TBDate" style="">
                                        <input type="text" data-datafield="XBTbl.TBDate" data-type="SheetTime" id="ctl400672_control8" style=""></td>
                                    <td class="rowOption hidden"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl400672_Stat0" data-datafield="XBTbl.ZJKX" style=""></td>
                                    <td id="ctl400672_Stat1" data-datafield="XBTbl.PayAmount" style=""></td>
                                    <td id="ctl400672_Stat2" data-datafield="XBTbl.ConvertAmount" style=""></td>
                                    <td id="ctl400672_Stat3" data-datafield="XBTbl.PayContent" style=""></td>
                                    <td id="ctl400672_Stat4" data-datafield="XBTbl.PayType" style=""></td>
                                    <td id="ctl400672_Stat5" data-datafield="XBTbl.Receiver" style=""></td>
                                    <td id="ctl400672_Stat6" data-datafield="XBTbl.XBStatus" style=""></td>
                                    <td id="ctl400672_Stat7" data-datafield="XBTbl.TBAmount" style="">
                                        <label id="ctl400672_StatControl7" data-datafield="XBTbl.TBAmount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td id="ctl400672_Stat8" data-datafield="XBTbl.TBDate" style=""></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title93" class="col-md-2">
                        <span id="Label88" data-type="SheetLabel" data-datafield="NewBGFile" style="">新报关文件</span>
                    </div>
                    <div id="control93" class="col-md-10">
                        <input type="text" data-datafield="NewBGFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="NewBGFile"></div>
                    </div>
                </div>

                <div class="row hidden">
                    <div id="div369928" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl829044" class="hidden" style="">
                    </div>
                    <div id="div760524" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div384861" class="col-md-1">
                        <input type="text" data-datafield="CurrencyRMB" data-type="SheetTextBox" id="ctl829044" class="hidden" style="">
                    </div>
                    <div id="div713448" class="col-md-1">
                        <input type="text" data-datafield="CurrencyWB" data-type="SheetTextBox" id="ctl829044" class="hidden" style="">
                    </div>
                    <div id="div824287" class="col-md-1"></div>
                    <div id="div185906" class="col-md-1"></div>
                    <div id="div315014" class="col-md-1"></div>
                    <div id="div34698" class="col-md-1"></div>
                    <div id="div131629" class="col-md-1"></div>
                    <div id="div717995" class="col-md-1"></div>
                    <div id="div90868" class="col-md-1"></div>
                    <div id="div725859" class="col-md-1"></div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">到货非航油回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackDHTbl" data-type="SheetLabel" id="ctl280690" class="" style="">到货非航油回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackDHTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackDHTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackDHTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackDHTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackDHTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackDHTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackDHTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackDHTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackDHTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackDHTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackDHTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackDHTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackDHTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackDHTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackDHTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackDHTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackDHTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackDHTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackDHTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackDHTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackDHTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackDHTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackDHTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackDHTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackDHTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackDHTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackDHTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
