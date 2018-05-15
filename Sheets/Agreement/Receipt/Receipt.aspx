<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Receipt" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">

    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="Receipt.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">收退款流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="AgreeMent_number" style="">代理协议号</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div389294" class="col-md-2"><span id="Label12" data-type="SheetLabel" data-datafield="Agreement_name" style="" class="">代理协议名称</span></div>
                    <div id="div941806" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="Agreement_name" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div389235" class="col-md-2"></div>
                    <div id="div219015" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="Project_head_AB" style="">项目负责人AB</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="Project_head_AB" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title4" class="col-md-2">
                    </div>
                    <div id="control4" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div672469" class="col-md-2"><span id="Label14" data-type="SheetLabel" data-datafield="SKTarget" style="" class="">收款对象</span></div>
                    <div id="div72762" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="SKTarget" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div161335" class="col-md-2"></div>
                    <div id="div457870" class="col-md-4"></div>
                </div>
                <div class="row SKRecords_USD">
                    <div id="title8" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="CurrentSKTotalUSD" style="" class="">本次收款总金额</span>
                    </div>
                    <div id="control8" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="CurrentSKTotalUSD" data-type="SheetTextBox" style="" class="" readonly>
                        USD
                    </div>
                    <div id="space9" class="col-md-2">
                    </div>
                    <div id="spaceControl9" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="CurrentSKTotalRMB" style="" class="">本次收款总金额</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="CurrentSKTotalRMB" data-type="SheetTextBox" style="" class="" readonly>
                        RMB
                    </div>
                    <div id="space6" class="col-md-2">
                    </div>
                    <div id="spaceControl6" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Recipt" style="">发票</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <input type="text" data-datafield="Recipt" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="Recipt"></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title9" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="Remark" style="">备注</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <textarea id="Control17" data-datafield="Remark" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>
                <div class="row tableContent SKRecords_RMB">
                    <div id="div5095" class="col-md-12">收款列表</div>
                </div>
                <div class="row tableContent SKRecords_RMB">
                    <div id="control11" class="col-md-12">
                        <table id="Control18" data-datafield="SKRecords_RMB" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control18_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control18_Header3" data-datafield="SKRecords_RMB.Type">
                                        <label id="Control18_Label3" data-datafield="SKRecords_RMB.Type" data-type="SheetLabel" style="">项目类型</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="SKRecords_RMB.ProjectNo">
                                        <label id="Control18_Label4" data-datafield="SKRecords_RMB.ProjectNo" data-type="SheetLabel" style="">项目编号</label>
                                    </td>
                                    <td id="Control18_Header5" data-datafield="SKRecords_RMB.ProjectName" style="width: 25%">
                                        <label id="Control18_Label5" data-datafield="SKRecords_RMB.ProjectName" data-type="SheetLabel">项目名称</label>
                                    </td>
                                    <td id="Control18_Header6" data-datafield="SKRecords_RMB.YSAgencyFee">
                                        <label id="Control18_Label6" data-datafield="SKRecords_RMB.YSAgencyFee" data-type="SheetLabel" style="">应收代理费(RMB)</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="SKRecords_RMB.ReceiveAgencyFee">
                                        <label id="Control18_Label7" data-datafield="SKRecords_RMB.ReceiveAgencyFee" data-type="SheetLabel" style="">已收代理费(RMB)</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="SKRecords_RMB.AgencyFeeRemain">
                                        <label id="Control18_Label8" data-datafield="SKRecords_RMB.AgencyFeeRemain" data-type="SheetLabel" style="">代理费余额(RMB)</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="SKRecords_RMB.CurrentSKTotalRMB">
                                        <label id="Control18_Label9" data-datafield="SKRecords_RMB.CurrentSKTotalRMB" data-type="SheetLabel" style="">本次收款金额(RMB)</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control18_Option" class="rowOption"></td>
                                    <td data-datafield="SKRecords_RMB.Type">
                                        <input id="Control18_ctl3" type="text" data-datafield="SKRecords_RMB.Type" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.ProjectNo">
                                        <input id="Control18_ctl4" type="text" data-datafield="SKRecords_RMB.ProjectNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.ProjectName">
                                        <input id="Control18_ctl5" type="text" data-datafield="SKRecords_RMB.ProjectName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.YSAgencyFee">
                                        <input id="Control18_ctl6" type="text" data-datafield="SKRecords_RMB.YSAgencyFee" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.ReceiveAgencyFee">
                                        <input id="Control18_ctl7" type="text" data-datafield="SKRecords_RMB.ReceiveAgencyFee" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.AgencyFeeRemain">
                                        <input id="Control18_ctl8" type="text" data-datafield="SKRecords_RMB.AgencyFeeRemain" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_RMB.CurrentSKTotalRMB">
                                        <input id="Control18_ctl9" type="text" data-datafield="SKRecords_RMB.CurrentSKTotalRMB" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalRMB(this)">
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
                                    <td data-datafield="SKRecords_RMB.Type"></td>
                                    <td data-datafield="SKRecords_RMB.ProjectNo"></td>
                                    <td data-datafield="SKRecords_RMB.ProjectName"></td>
                                    <td data-datafield="SKRecords_RMB.YSAgencyFee">
                                        <label id="Control18_stat6" data-datafield="SKRecords_RMB.YSAgencyFee" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_RMB.ReceiveAgencyFee">
                                        <label id="Control18_stat7" data-datafield="SKRecords_RMB.ReceiveAgencyFee" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_RMB.AgencyFeeRemain">
                                        <label id="Control18_stat8" data-datafield="SKRecords_RMB.AgencyFeeRemain" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_RMB.CurrentSKTotalRMB">
                                        <label id="Control18_stat9" data-datafield="SKRecords_RMB.CurrentSKTotalRMB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td class="rowOption hidden"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent SKRecords_USD">
                    <div id="div5095" class="col-md-12">收款列表</div>
                </div>
                <div class="row tableContent SKRecords_USD">
                    <div id="control11" class="col-md-12">
                        <table id="Control18" data-datafield="SKRecords_USD" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control18_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control18_Header3" data-datafield="SKRecords_USD.Type">
                                        <label id="Control18_Label3" data-datafield="SKRecords_USD.Type" data-type="SheetLabel" style="">项目类型</label>
                                    </td>
                                    <td id="Control18_Header4" data-datafield="SKRecords_USD.ProjectNo">
                                        <label id="Control18_Label4" data-datafield="SKRecords_USD.ProjectNo" data-type="SheetLabel" style="">项目编号</label>
                                    </td>
                                    <td id="Control18_Header5" data-datafield="SKRecords_USD.ProjectName" style="width: 25%">
                                        <label id="Control18_Label5" data-datafield="SKRecords_USD.ProjectName" data-type="SheetLabel">项目名称</label>
                                    </td>
                                    <td id="Control18_Header6" data-datafield="SKRecords_USD.YSAgencyFee">
                                        <label id="Control18_Label6" data-datafield="SKRecords_USD.YSAgencyFee" data-type="SheetLabel" style="">应收代理费</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="SKRecords_USD.ReceiveAgencyFee">
                                        <label id="Control18_Label7" data-datafield="SKRecords_USD.ReceiveAgencyFee" data-type="SheetLabel" style="">已收代理费</label>
                                    </td>
                                    <td id="Control18_Header7" data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB">
                                        <label id="Control18_Label7" data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB" data-type="SheetLabel" style="">已收代理费(RMB)</label>
                                    </td>
                                    <td id="Control18_Header8" data-datafield="SKRecords_USD.AgencyFeeRemain">
                                        <label id="Control18_Label8" data-datafield="SKRecords_USD.AgencyFeeRemain" data-type="SheetLabel" style="">代理费余额</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="SKRecords_USD.CurrentSKWB">
                                        <label id="Control18_Label9" data-datafield="SKRecords_USD.CurrentSKWB" data-type="SheetLabel" style="">本次收款金额</label>
                                    </td>
                                    <td id="Control18_Header9" data-datafield="SKRecords_USD.WBRate">
                                        <label id="Control18_Label9" data-datafield="SKRecords_USD.WBRate" data-type="SheetLabel" style="">汇率</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control18_Option" class="rowOption"></td>
                                    <td data-datafield="SKRecords_USD.Type">
                                        <input id="Control18_ctl3" type="text" data-datafield="SKRecords_USD.Type" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.ProjectNo">
                                        <input id="Control18_ctl4" type="text" data-datafield="SKRecords_USD.ProjectNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.ProjectName">
                                        <input id="Control18_ctl5" type="text" data-datafield="SKRecords_USD.ProjectName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.YSAgencyFee">
                                        <input id="Control18_ctl6" type="text" data-datafield="SKRecords_USD.YSAgencyFee" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.ReceiveAgencyFee">
                                        <input id="Control18_ctl7" type="text" data-datafield="SKRecords_USD.ReceiveAgencyFee" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB">
                                        <input id="Control18_ctl7" type="text" data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.AgencyFeeRemain">
                                        <input id="Control18_ctl8" type="text" data-datafield="SKRecords_USD.AgencyFeeRemain" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_USD.CurrentSKWB">
                                        <input id="Control18_ctl9" type="text" data-datafield="SKRecords_USD.CurrentSKWB" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalUSD()">
                                    </td>
                                    <td data-datafield="SKRecords_USD.WBRate">
                                        <input id="Control18_ctl9" type="text" data-datafield="SKRecords_USD.WBRate" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalUSD()">
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
                                    <td data-datafield="SKRecords_USD.Type"></td>
                                    <td data-datafield="SKRecords_USD.ProjectNo"></td>
                                    <td data-datafield="SKRecords_USD.ProjectName"></td>
                                    <td data-datafield="SKRecords_USD.YSAgencyFee">
                                        <label id="Control18_stat6" data-datafield="SKRecords_USD.YSAgencyFee" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_USD.ReceiveAgencyFee">
                                        <label id="Control18_stat7" data-datafield="SKRecords_USD.ReceiveAgencyFee" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB">
                                        <label id="Control18_stat7" data-datafield="SKRecords_USD.ReceiveAgencyFeeRMB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_USD.AgencyFeeRemain">
                                        <label id="Control18_stat8" data-datafield="SKRecords_USD.AgencyFeeRemain" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_USD.CurrentSKWB">
                                        <label id="Control18_stat9" data-datafield="SKRecords_USD.CurrentSKWB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_USD.WBRate">
                                        <label id="Control18_stat9" data-datafield="SKRecords_USD.WBRate" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td class="rowOption hidden"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent SKRecords_Percent">
                    <div id="div5095" class="col-md-12">收款列表</div>
                </div>
                <div class="row tableContent SKRecords_Percent">
                    <div id="control13" class="col-md-12">
                        <table id="Control19" data-datafield="SKRecords_Percent" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control19_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control19_Header3" data-datafield="SKRecords_Percent.Type">
                                        <label id="Control19_Label3" data-datafield="SKRecords_Percent.Type" data-type="SheetLabel" style="">项目类型</label>
                                    </td>
                                    <td id="Control19_Header4" data-datafield="SKRecords_Percent.ProjectNo">
                                        <label id="Control19_Label4" data-datafield="SKRecords_Percent.ProjectNo" data-type="SheetLabel" style="">项目编号</label>
                                    </td>
                                    <td id="Control19_Header5" data-datafield="SKRecords_Percent.ProjectName">
                                        <label id="Control19_Label5" data-datafield="SKRecords_Percent.ProjectName" data-type="SheetLabel" style="">项目名称</label>
                                    </td>
                                    <td id="Control19_Header6" data-datafield="SKRecords_Percent.YSAgencyFeeRMB">
                                        <label id="Control19_Label6" data-datafield="SKRecords_Percent.YSAgencyFeeRMB" data-type="SheetLabel" style="">应收代理费<br>RMB</label>
                                    </td>
                                    <td id="Control19_Header7" data-datafield="SKRecords_Percent.YSAgencyFeeWB">
                                        <label id="Control19_Label7" data-datafield="SKRecords_Percent.YSAgencyFeeWB" data-type="SheetLabel" style="">应收代理费<br>外币</label>
                                    </td>
                                    <td id="Control19_Header8" data-datafield="SKRecords_Percent.Currency">
                                        <label id="Control19_Label8" data-datafield="SKRecords_Percent.Currency" data-type="SheetLabel" style="">外币币种</label>
                                    </td>
                                    <td id="Control19_Header9" data-datafield="SKRecords_Percent.ReceiveAgencyFee">
                                        <label id="Control19_Label9" data-datafield="SKRecords_Percent.ReceiveAgencyFee" data-type="SheetLabel" style="">已收代理费<br>RMB</label>
                                    </td>
                                    <td id="Control19_Header10" data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB">
                                        <label id="Control19_Label10" data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB" data-type="SheetLabel" style="">已收代理费<br>外币</label>
                                    </td>
                                    <td id="Control19_Header11" data-datafield="SKRecords_Percent.ReceiveTotalRMB">
                                        <label id="Control19_Label11" data-datafield="SKRecords_Percent.ReceiveTotalRMB" data-type="SheetLabel" style="">已收折合RMB金额</label>
                                    </td>
                                    <td id="Control19_Header12" data-datafield="SKRecords_Percent.AgencyFeeRemainRMB">
                                        <label id="Control19_Label12" data-datafield="SKRecords_Percent.AgencyFeeRemainRMB" data-type="SheetLabel" style="">代理费余额<br>RMB</label>
                                    </td>
                                    <td id="Control19_Header13" data-datafield="SKRecords_Percent.AgencyFeeRemainWB">
                                        <label id="Control19_Label13" data-datafield="SKRecords_Percent.AgencyFeeRemainWB" data-type="SheetLabel" style="">代理费余额<br>外币</label>
                                    </td>
                                    <td id="Control19_Header14" data-datafield="SKRecords_Percent.CurrentSKRMB">
                                        <label id="Control19_Label14" data-datafield="SKRecords_Percent.CurrentSKRMB" data-type="SheetLabel" style="">本次收款<br>RMB</label>
                                    </td>
                                    <td id="Control19_Header15" data-datafield="SKRecords_Percent.CurrentSKWB">
                                        <label id="Control19_Label15" data-datafield="SKRecords_Percent.CurrentSKWB" data-type="SheetLabel" style="">本次收款<br>外币</label>
                                    </td>
                                    <td id="Control19_Header16" data-datafield="SKRecords_Percent.WBRate">
                                        <label id="Control19_Label16" data-datafield="SKRecords_Percent.WBRate" data-type="SheetLabel" style="">外币汇率</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control19_Option" class="rowOption"></td>
                                    <td data-datafield="SKRecords_Percent.Type">
                                        <input id="Control19_ctl3" type="text" data-datafield="SKRecords_Percent.Type" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ProjectNo">
                                        <input id="Control19_ctl4" type="text" data-datafield="SKRecords_Percent.ProjectNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ProjectName">
                                        <input id="Control19_ctl5" type="text" data-datafield="SKRecords_Percent.ProjectName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.YSAgencyFeeRMB">
                                        <input id="Control19_ctl6" type="text" data-datafield="SKRecords_Percent.YSAgencyFeeRMB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.YSAgencyFeeWB">
                                        <input id="Control19_ctl7" type="text" data-datafield="SKRecords_Percent.YSAgencyFeeWB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.Currency">
                                        <input id="Control19_ctl8" type="text" data-datafield="SKRecords_Percent.Currency" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ReceiveAgencyFee">
                                        <input id="Control19_ctl9" type="text" data-datafield="SKRecords_Percent.ReceiveAgencyFee" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB">
                                        <input id="Control19_ctl10" type="text" data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ReceiveTotalRMB">
                                        <input id="Control19_ctl11" type="text" data-datafield="SKRecords_Percent.ReceiveTotalRMB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.AgencyFeeRemainRMB">
                                        <input id="Control19_ctl12" type="text" data-datafield="SKRecords_Percent.AgencyFeeRemainRMB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.AgencyFeeRemainWB">
                                        <input id="Control19_ctl13" type="text" data-datafield="SKRecords_Percent.AgencyFeeRemainWB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.CurrentSKRMB">
                                        <input id="Control19_ctl14" type="text" data-datafield="SKRecords_Percent.CurrentSKRMB" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalPercent()">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.CurrentSKWB">
                                        <input id="Control19_ctl15" type="text" data-datafield="SKRecords_Percent.CurrentSKWB" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalPercent()">
                                    </td>
                                    <td data-datafield="SKRecords_Percent.WBRate">
                                        <input id="Control19_ctl16" type="text" data-datafield="SKRecords_Percent.WBRate" data-type="SheetTextBox" style="" data-onchange="SetCurrentSKTotalPercent()">
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
                                    <td data-datafield="SKRecords_Percent.Type"></td>
                                    <td data-datafield="SKRecords_Percent.ProjectNo"></td>
                                    <td data-datafield="SKRecords_Percent.ProjectName"></td>
                                    <td data-datafield="SKRecords_Percent.YSAgencyFeeRMB">
                                        <label id="Control19_stat6" data-datafield="SKRecords_Percent.YSAgencyFeeRMB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.YSAgencyFeeWB">
                                        <label id="Control19_stat7" data-datafield="SKRecords_Percent.YSAgencyFeeWB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.Currency"></td>
                                    <td data-datafield="SKRecords_Percent.ReceiveAgencyFee">
                                        <label id="Control19_stat9" data-datafield="SKRecords_Percent.ReceiveAgencyFee" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB">
                                        <label id="Control19_stat10" data-datafield="SKRecords_Percent.ReceiveAgencyFeeWB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.ReceiveTotalRMB"></td>
                                    <td data-datafield="SKRecords_Percent.AgencyFeeRemainRMB">
                                        <label id="Control19_stat12" data-datafield="SKRecords_Percent.AgencyFeeRemainRMB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.AgencyFeeRemainWB">
                                        <label id="Control19_stat13" data-datafield="SKRecords_Percent.AgencyFeeRemainWB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.CurrentSKRMB">
                                        <label id="Control19_stat14" data-datafield="SKRecords_Percent.CurrentSKRMB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.CurrentSKWB">
                                        <label id="Control19_stat15" data-datafield="SKRecords_Percent.CurrentSKWB" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="SKRecords_Percent.WBRate">
                                        <label id="Control19_stat16" data-datafield="SKRecords_Percent.WBRate" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td class="rowOption hidden"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title15" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control15" class="col-md-10">
                        <div id="Control20" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title17" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="FGManagerComment" style="">公司领导审批意见</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <div id="Control21" data-datafield="FGManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="div393958" class="col-md-2"><span id="Label23" data-type="SheetLabel" data-datafield="SKDate" style="" class="">收款日期</span></div>
                    <div id="div590010" class="col-md-4">
                        <input id="Control23" type="text" data-datafield="SKDate" data-type="SheetTime" style="" class="">
                    </div>
                    <div id="div543232" class="col-md-2"></div>
                    <div id="div3013" class="col-md-4"></div>
                </div>
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="FinanceComment" style="">财务审批意见</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <div id="Control22" data-datafield="FinanceComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="agency_type" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        
                        <input type="text" data-datafield="agency_money" data-type="SheetTextBox" id="ctl341858" class="hidden" style="">
                    </div>
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
    </div>

    <script src="../../js/jquery-ui.min.js"></script>
    <script src="../../js/ContractFile2.js"></script>
    <script src="../../js/select2.js"></script>
</asp:Content>
