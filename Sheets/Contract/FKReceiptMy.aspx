<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FKReceiptMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.FKReceiptMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="FKReceiptMy.js"></script>
    <style type="text/css">
       #lblTitle {
               color: #0725E0;
               border-bottom: 10px double #0725E0;
               line-height: 55px;
           }
           .panelContent {
               border: 2px solid #0725E0;
               margin: 10px 0px;
           }
           .col-md-2, .row {
               background: white;
               border: 0px;
           }
           .col-md-2, .col-md-4, .col-md-6, .col-md-10, .col-md-12 {
               border: 0px;
           }
           .panel-body span {
                color: #0725E0;
           }
            #title4,#title6 {
                border-left: 2px solid  #0725E0;
                border-right: 2px solid  #0725E0;
            }
    </style>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">上海浦东国际机场进出口有限公司付款申请</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="" style="margin-top: 15px">
            <div class="">
                <label id="divSheetInfo" data-en_us="Sheet information"></label>
            </div>
            <div class="" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2" style="color:#0725E0;">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Department" style="">部门</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Department" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2" style="color:#0725E0;">
                        <span id="Label12" data-type="SheetLabel" data-datafield="ApplyDate" style="">申请时间</span>
                    </div>
                    <div id="control2" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="ApplyDateY" data-type="SheetTextBox" style="width:20%">&nbsp;<span>年</span>&nbsp;
                        <input id="Control11" type="text" data-datafield="ApplyDateM" data-type="SheetTextBox" style="width:10%">&nbsp;<span>月</span>&nbsp;
                        <input id="Control11" type="text" data-datafield="ApplyDateD" data-type="SheetTextBox" style="width:10%">&nbsp;<span>日</span>&nbsp;
                    </div>
                </div>
                <div class="panelContent">
                      <div class="row" style="border-bottom:2px solid #0725E0;">
                            <div id="title3" class="col-md-2" style="color:#0725E0;">
                                <span id="Label13" data-type="SheetLabel" data-datafield="Receiver" class="bluecolor">受款人</span>
                            </div>
                            <div id="control3" class="col-md-4">
                                <input id="Control13" type="text" data-datafield="Receiver" data-type="SheetTextBox" style="">
                            </div>
                            <div id="title4" class="col-md-2" style="color:#0725E0;">
                                <span id="Label14" data-type="SheetLabel" data-datafield="BankName" class="bluecolor">开户银行</span>
                            </div>
                            <div id="control4" class="col-md-4">
                                <input id="Control14" type="text" data-datafield="BankName" data-type="SheetTextBox" style="">
                            </div>
                      </div>
                      <div class="row" style="border-bottom:2px solid #0725E0">
                            <div id="title5" class="col-md-2" style="color:#0725E0;">
                                <span id="Label15" data-type="SheetLabel" data-datafield="FKReason" style="">付款事由</span>
                            </div>
                            <div id="control5" class="col-md-4">
                                <input id="Control15" type="text" data-datafield="FKReason" data-type="SheetTextBox" style="">
                            </div>
                            <div id="title6" class="col-md-2" style="color:#0725E0;">
                                <span id="Label16" data-type="SheetLabel" data-datafield="BankAccount" style="">银行账号</span>
                            </div>
                            <div id="control6" class="col-md-4">
                                <input id="Control16" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="">
                            </div>
                      </div>
                      <div class="row tableContent" style="border-bottom:2px solid #0725E0">
                            <div id="control7" class="col-md-8">
                                <textarea id="Control17" data-datafield="LeftRemark" data-type="SheetRichTextBox" style="height: 200px;">					</textarea>
                            </div>
                            <div id="control7" class="col-md-4">
                                <textarea id="Control17" data-datafield="RightRemark" data-type="SheetRichTextBox" style="height: 200px;">					</textarea>
                            </div>
                      </div>
                      <div class="row" >
                            <div id="control9" class="col-md-8">
                            </div>
                            <div id="control9" class="col-md-4">
                                <input id="Control18" type="text" data-datafield="RemarkTip" data-type="SheetTextBox" style="">
                            </div>
                      </div>
                      <div class="row">
                            <div id="title11" class="col-md-2">
                                <span class="">合计&nbsp;</span><input id="Control22" type="text" data-datafield="Currency" data-type="SheetTextBox" style="width:50%">
                            </div>
                            <div id="control11" class="col-md-8">
                                <input id="Control22" type="text" data-datafield="QW" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>仟万</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="BW" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>佰万</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="SW" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>拾万</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="W" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>万</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="Q" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>仟</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="B" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>佰</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="S" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>拾</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="Y" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>元</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="J" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>角</span>&nbsp;
                                <input id="Control22" type="text" data-datafield="F" data-type="SheetTextBox" class="" style="width:4%">&nbsp;<span>分</span>&nbsp;
                            </div>
                            <div id="control12" class="col-md-2">
                                <input id="Control22" type="text" data-datafield="CurrencyCode" data-type="SheetTextBox" style="width:40%">
                                <input id="Control22" type="text" data-datafield="Amount" class="AmountFormat" data-type="SheetTextBox" style="width:50%">
                            </div>
                      </div>
                </div>
                <div class="row">
                    <div id="title23" class="col-md-2">
                        <span id="Label32" data-type="SheetLabel" data-datafield="Manager" style="">主管部门负责人</span>
                    </div>
                    <div id="control23" class="col-md-2">
                        <input id="Control32" type="text" data-datafield="Manager" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title24" class="col-md-2">
                        <span id="Label33" data-type="SheetLabel" data-datafield="Applyer" style="">申请人</span>
                    </div>
                    <div id="control24" class="col-md-2">
                        <input id="Control33" type="text" data-datafield="Applyer" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title25" class="col-md-2">
                        <span id="Label34" data-type="SheetLabel" data-datafield="Financer" style="">财务出纳</span>
                    </div>
                    <div id="control25" class="col-md-2">
                        <input id="Control34" type="text" data-datafield="Financer" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                    </div>
                    <div id="div903542" class="col-md-2">
                    </div>
                    <div id="div553758" class="col-md-2">
                    </div>
                    <div id="div341245" class="col-md-2">
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
