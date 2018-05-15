﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgreeMent_change.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.AgreeMent_change" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script src="AgreeMent_change.js"></script>
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">协议变更</label>
    </div>
    <div class="panel-body sheetContainer">

         <div class="ContractContent ">
        <div class="nav-icon fa  fa-chevron-right bannerTitle">
            <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
        </div>
        <div class="divContent" id="divSheet">
            <div class="row">
                <div id="title1" class="col-md-2">
                    <span id="Label11" data-type="SheetLabel" data-datafield="AgreeMent_number" style="">协议号</span>
                </div>
                <div id="control1" class="col-md-4">
                    <input id="Control11" type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox" style="" class="">
                </div>
                <div id="title2" class="col-md-2">
                    <span id="Label12" data-type="SheetLabel" data-datafield="Agreement_name" style="">协议名称</span>
                </div>
                <div id="control2" class="col-md-4">
                    <input id="Control12" type="text" data-datafield="Agreement_name" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title3" class="col-md-2">
                    <span id="Label13" data-type="SheetLabel" data-datafield="Agreement_entrust" style="">协议委托方</span>
                </div>
                <div id="control3" class="col-md-4">
                    <input id="Control13" type="text" data-datafield="Agreement_entrust" data-type="SheetTextBox" style="">
                </div>
                <div id="title4" class="col-md-2">
					
				<label data-datafield="signing_time" data-type="SheetLabel" id="ctl590018" class="" style="">签约时间</label></div>
				<div id="control4" class="col-md-4">
					
				<input type="text" data-datafield="signing_time" data-type="SheetTime" id="ctl414537" class="" style=""></div>
            </div>
            <div class="row">
                <div id="div209016" class="col-md-1">
                    <label data-datafield="Old_agency_rates" data-type="SheetLabel" id="ctl859323" class="" style="font-weight:bold">原代理费</label></div>
                <div id="div639122" class="col-md-4">
                    <table id="ctl223957" data-datafield="Old_agency_rates" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                        <tbody>
                            <tr class="header">
                                <td id="ctl223957_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl223957_header0" data-datafield="Old_agency_rates.agency_money" style="width:20%">
                                    <label id="ctl223957_Label0" data-datafield="Old_agency_rates.agency_money" data-type="SheetLabel" style="">代理费</label></td>
                                <td id="ctl223957_header1" data-datafield="Old_agency_rates.agency_type" style="width:40%">
                                    <label id="ctl223957_Label1" data-datafield="Old_agency_rates.agency_type" data-type="SheetLabel" style="">代理费类型</label></td>
                                <td id="ctl223957_header2" data-datafield="Old_agency_rates.up_limit" style="width:20%">
                                    <label id="ctl223957_Label2" data-datafield="Old_agency_rates.up_limit" data-type="SheetLabel" style="">上限</label></td>
                                <td id="ctl223957_header3" data-datafield="Old_agency_rates.lower_limit" style="width:20%">
                                    <label id="ctl223957_Label3" data-datafield="Old_agency_rates.lower_limit" data-type="SheetLabel" style="">下限</label></td>
                                <td class="rowOption">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl223957_control0" data-datafield="Old_agency_rates.agency_money" style="">
                                    <input type="text" data-datafield="Old_agency_rates.agency_money" data-type="SheetTextBox" id="ctl223957_control0" style=""></td>
                                <td id="ctl223957_control1" data-datafield="Old_agency_rates.agency_type" style="">
                                    <input type="text" data-datafield="Old_agency_rates.agency_type" data-type="SheetTextBox" id="ctl223957_control1" style=""></td>
                                <td id="ctl223957_control2" data-datafield="Old_agency_rates.up_limit" style="">
                                    <input type="text" data-datafield="Old_agency_rates.up_limit" data-type="SheetTextBox" id="ctl223957_control2" style=""></td>
                                <td id="ctl223957_control3" data-datafield="Old_agency_rates.lower_limit" style="" class="">
                                    <input type="text" data-datafield="Old_agency_rates.lower_limit" data-type="SheetTextBox" id="ctl223957_control3" style=""></td>
                                <td class="rowOption"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl223957_Stat0" data-datafield="Old_agency_rates.agency_money" style="" class="">
                                    <label id="ctl223957_StatControl0" data-datafield="Old_agency_rates.agency_money" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl223957_Stat1" data-datafield="Old_agency_rates.agency_type" style=""></td>
                                <td id="ctl223957_Stat2" data-datafield="Old_agency_rates.up_limit" style="" class=""></td>
                                <td id="ctl223957_Stat3" data-datafield="Old_agency_rates.lower_limit" style=""></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="div190169" class="col-md-1">
                    <label data-datafield="IsChangeRates" data-type="SheetLabel" id="ctl470764" class="" style="font-weight:bold">变更代理费</label></div>
                <div id="div92558" class="col-md-1">
                    <div data-datafield="IsChangeRates" data-type="SheetRadioButtonList" id="ctl522380" class="" style="" data-defaultitems="否;是" data-repeatcolumns="2"
                        data-onchange="RatesChange(this)"></div>
                </div>
                <div id="div885426" class="col-md-1">
                    <label data-datafield="New_agency_rates" data-type="SheetLabel" id="ctl276110" class="" style="font-weight:bold">变更后代理费</label></div>
                <div id="div344897" class="col-md-4">
                    <table id="ctl431747" data-datafield="New_agency_rates" data-type="SheetGridView" class="SheetGridView" style="" data-displaydelete="false" data-displayadd="false" data-displaysequenceno="false" data-displaysummary="false">
                        <tbody>
                            <tr class="header">
                                <td id="ctl431747_SerialNo" class="rowSerialNo">序号</td>
                                <td id="ctl431747_header0" data-datafield="New_agency_rates.agency_money" style="width:20%">
                                    <label id="ctl431747_Label0" data-datafield="New_agency_rates.agency_money" data-type="SheetLabel" style="">代理费</label></td>
                                <td id="ctl431747_header1" data-datafield="New_agency_rates.agency_type" style="width:40%">
                                    <label id="ctl431747_Label1" data-datafield="New_agency_rates.agency_type" data-type="SheetLabel" style="">代理费类型</label></td>
                                <td id="ctl431747_header2" data-datafield="New_agency_rates.up_limit" style="width:20%">
                                    <label id="ctl431747_Label2" data-datafield="New_agency_rates.up_limit" data-type="SheetLabel" style="">上限</label></td>
                                <td id="ctl431747_header3" data-datafield="New_agency_rates.lower_limit" style="width:20%">
                                    <label id="ctl431747_Label3" data-datafield="New_agency_rates.lower_limit" data-type="SheetLabel" style="">下限</label></td>
                                <td class="rowOption">删除</td>
                            </tr>
                            <tr class="template">
                                <td></td>
                                <td id="ctl431747_control0" data-datafield="New_agency_rates.agency_money" style="">
                                    <input type="text" data-datafield="New_agency_rates.agency_money" data-type="SheetTextBox" id="ctl431747_control0" style=""></td>
                                <td id="ctl431747_control1" data-datafield="New_agency_rates.agency_type" style="">
                                    <select data-datafield="New_agency_rates.agency_type" data-type="SheetDropDownList" id="ctl133625" class="" style="" data-queryable="false" data-masterdatacategory="代理费费率／金额"></select></td>
                                <td id="ctl431747_control2" data-datafield="New_agency_rates.up_limit" style="">
                                    <input type="text" data-datafield="New_agency_rates.up_limit" data-type="SheetTextBox" id="ctl431747_control2" style=""></td>
                                <td id="ctl431747_control3" data-datafield="New_agency_rates.lower_limit" style="">
                                    <input type="text" data-datafield="New_agency_rates.lower_limit" data-type="SheetTextBox" id="ctl431747_control3" style=""></td>
                                <td class="rowOption"><a class="delete">
                                    <div class="fa fa-minus"></div>
                                </a><a class="insert">
                                    <div class="fa fa-arrow-down"></div>
                                </a></td>
                            </tr>
                            <tr class="footer">
                                <td></td>
                                <td id="ctl431747_Stat0" data-datafield="New_agency_rates.agency_money" style="">
                                    <label id="ctl431747_StatControl0" data-datafield="New_agency_rates.agency_money" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td id="ctl431747_Stat1" data-datafield="New_agency_rates.agency_type" style=""></td>
                                <td id="ctl431747_Stat2" data-datafield="New_agency_rates.up_limit" style=""></td>
                                <td id="ctl431747_Stat3" data-datafield="New_agency_rates.lower_limit" style=""></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div id="div648472" class="col-md-1">
                    <label data-datafield="PayConditionOld" data-type="SheetLabel" id="ctl564542" class="" style="font-weight:bold">原支付条件</label></div>
                <div id="div838174" class="col-md-4">
                    <textarea data-datafield="PayConditionOld" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl955349" class=""></textarea></div>
                <div id="div719391" class="col-md-1">
                    <label data-datafield="IsChangePayCondition" data-type="SheetLabel" id="ctl288402" class="" style="font-weight:bold">变更支付条件</label></div>
                <div id="div936659" class="col-md-1">
                    <div data-datafield="IsChangePayCondition" data-type="SheetRadioButtonList" id="ctl452153" class="" style="" data-defaultitems="否;是" data-repeatcolumns="2"
                        data-onchange="PayConditionChange(this)"></div>
                </div>
                <div id="div539749" class="col-md-1">
                    <label data-datafield="PayConditionNew" data-type="SheetLabel" id="ctl51382" class="" style="font-weight:bold">变更后支付条件</label></div>
                <div id="div559744" class="col-md-4">
                    <textarea data-datafield="PayConditionNew" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl902688" class=""></textarea></div>
            </div>
            <div class="row">
                <div id="title11" class="col-md-2">
                    <span id="Label20" data-type="SheetLabel" data-datafield="Agent_agreenment_change" style="">代理协议变更书</span>
                </div>
                <div id="control11" class="col-md-10">
                    <input type="text" data-datafield="Agent_agreenment_change" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="Agent_agreenment_change"></div>
                </div>
            </div>
            <div class="row tableContent">
                <div id="title13" class="col-md-2">
                    <span id="Label21" data-type="SheetLabel" data-datafield="Note" style="">备注</span>
                </div>
                <div id="control13" class="col-md-10">

                    <textarea data-datafield="Note" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl330912" class=""></textarea>
                </div>
            </div>
            <div class="row">
                <div id="div517995" class="col-md-2">
                    <label data-datafield="ManagerComment" data-type="SheetLabel" id="ctl61467" class="" style="">部门经理审批意见</label></div>
                <div id="div827452" class="col-md-10">
                    <div data-datafield="ManagerComment" data-type="SheetComment" id="ctl804773" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div426279" class="col-md-2">
                    <label data-datafield="FGManagerComment" data-type="SheetLabel" id="ctl524195" class="" style="">公司领导审批意见</label></div>
                <div id="div764000" class="col-md-10">
                    <div data-datafield="FGManagerComment" data-type="SheetComment" id="ctl640108" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div520664" class="col-md-2">
                    <label data-datafield="BGSignDate" data-type="SheetLabel" id="ctl997621" class="" style="">变更签约日期</label></div>
                <div id="div486391" class="col-md-10">
                    <input type="text" data-datafield="BGSignDate" data-type="SheetTime" id="ctl627121" class="" style=""></div>
            </div>
            <div class="row">
                <div id="div977198" class="col-md-2">
                    <label data-datafield="ConfirmComment" data-type="SheetLabel" id="ctl906516" class="" style="">确认意见</label></div>
                <div id="div51438" class="col-md-10">
                    <div data-datafield="ConfirmComment" data-type="SheetComment" id="ctl397313" class="" style=""></div>
                </div>
            </div>
            <div class="row hidden">
                <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="agency_type" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
            </div>
        </div>
             </div>
    </div>

    <script src="../../js/jquery-ui.min.js"></script>
    <script src="../../js/file2.js"></script>
    <script src="../../js/select2.js"></script>
</asp:Content>
