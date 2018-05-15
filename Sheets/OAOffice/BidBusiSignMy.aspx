<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BidBusiSignMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BidBusiSignMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BidBusiSignMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">招标业务配合登记</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="BidBusiTbl" style="">招标业务配合登记子表</span>
                    </div>
                    <div id="control1" class="col-md-10">
                        <table id="Control11" data-datafield="BidBusiTbl" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="3" data-displaysequenceno="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control11_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control11_Header3" data-datafield="BidBusiTbl.IsCheck">
                                        <label id="Control11_Label3" data-datafield="BidBusiTbl.IsCheck" data-type="SheetLabel" style="">选择</label>
                                    </td>
                                    <td id="Control11_Header4" data-datafield="BidBusiTbl.Resources">
                                        <label id="Control11_Label4" data-datafield="BidBusiTbl.Resources" data-type="SheetLabel" style="">资源</label>
                                    </td>
                                    <td id="Control11_Header5" data-datafield="BidBusiTbl.Num">
                                        <label id="Control11_Label5" data-datafield="BidBusiTbl.Num" data-type="SheetLabel" style="">申请数量</label>
                                    </td>
                                    <td id="Control11_Header6" data-datafield="BidBusiTbl.ApplyFY">
                                        <label id="Control11_Label6" data-datafield="BidBusiTbl.ApplyFY" data-type="SheetLabel" style="">申请费用(元)</label>
                                    </td>
                                    <td id="Control11_Header7" data-datafield="BidBusiTbl.ConfirmFY">
                                        <label id="Control11_Label7" data-datafield="BidBusiTbl.ConfirmFY" data-type="SheetLabel" style="">确认费用(元)</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control11_Option" class="rowOption"></td>
                                    <td data-datafield="BidBusiTbl.IsCheck">
                                        <div data-datafield="BidBusiTbl.IsCheck" data-type="SheetCheckboxList" id="ctl548342" class="" style="" data-defaultitems="是" data-repeatcolumns="1"></div>
                                    </td>
                                    <td data-datafield="BidBusiTbl.Resources">
                                        <input id="Control11_ctl4" type="text" data-datafield="BidBusiTbl.Resources" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BidBusiTbl.Num">
                                        <input id="Control11_ctl5" type="text" data-datafield="BidBusiTbl.Num" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BidBusiTbl.ApplyFY">
                                        <input id="Control11_ctl6" type="text" data-datafield="BidBusiTbl.ApplyFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BidBusiTbl.ConfirmFY">
                                        <input id="Control11_ctl7" type="text" data-datafield="BidBusiTbl.ConfirmFY" data-type="SheetTextBox" style="">
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
                                    <td class="rowOption" >
                                    </td>
                                    <td data-datafield="BidBusiTbl.IsCheck" colspan="3">
                                        费用合计：
                                    </td>
                                    <td data-datafield="BidBusiTbl.ApplyFY">
                                        <label id="Control11_stat6" data-datafield="BidBusiTbl.ApplyFY" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td data-datafield="BidBusiTbl.ConfirmFY">
                                        <label id="Control11_stat7" data-datafield="BidBusiTbl.ConfirmFY" data-type="SheetCountLabel" style="">
                                        </label>
                                    </td>
                                    <td class="rowOption hidden"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title3" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="BusiRemark" style="">业务说明</span>
                    </div>
                    <div id="control3" class="col-md-10">
                        <textarea id="Control12" data-datafield="BusiRemark" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="FGManagerComment" style="">分管领导审批意见</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <div id="Control13" data-datafield="FGManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="div620311" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="Attachment" style="" class="">附件</span>
                    </div>
                    <div id="div250238" class="col-md-10">
                        <div id="Control15" data-datafield="Attachment" data-type="SheetAttachment" style="" class="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="OfficeCompeleteComment" style="">综合办公室办结意见</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <div id="Control14" data-datafield="OfficeCompeleteComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="RLFYComment" style="">人力费用审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control16" data-datafield="RLFYComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title13" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="FGenManagerComment" style="">分管行政副总经理审批意见</span>
                    </div>
                    <div id="control13" class="col-md-10">
                        <div id="Control17" data-datafield="FGenManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="FGManagerFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div903542" class="col-md-2">
                        <input type="text" data-datafield="OfficeCompeleteFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div553758" class="col-md-2">
                        <input type="text" data-datafield="LGFYFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div341245" class="col-md-2">
                        <input type="text" data-datafield="FGenManagerFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div785335" class="col-md-2">
                    </div>
                    <div id="div392071" class="col-md-2">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
