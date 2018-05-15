﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Update_AgreementNumber.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Update_AgreementNumber" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="Update_AgreementNumber.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">协议号修改</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="AgreeMent_name" style="">协议名称</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="AgreeMent_name" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="AgreeMent_head" style="">协议负责人AB</span>
                    </div>
                    <div id="control2" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="AgreeMent_head" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="AgreenMent_client" style="">协议委托方</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="AgreenMent_client" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title4" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="Self_agreeMent_number" style="">自动生成协议号</span>
                    </div>
                    <div id="control4" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="Self_agreeMent_number" data-type="SheetTextBox" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="Update_agreeMent_number" style="">修改后的协议号</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="Update_agreeMent_number" data-type="SheetTextBox" style="">
                    </div>
                    <div id="space6" class="col-md-2">
                    </div>
                    <div id="spaceControl6" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Remark" style="">备注</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <textarea id="Control16" data-datafield="Remark" data-type="SheetRichTextBox" class="" style="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="div220049" class="col-md-2">
                        <label data-datafield="AuditComment" data-type="SheetLabel" id="ctl621205" class="" style="">审批意见</label>
                    </div>
                    <div id="div138207" class="col-md-10">
                        <div data-datafield="AuditComment" data-type="SheetComment" id="ctl572839" class="" style=""></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
