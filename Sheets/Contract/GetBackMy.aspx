﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetBackMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.GetBackMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="GetBackMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">回退流程</label>
    </div>
    <div class="panel-body sheetContainer">
       <div class="ContractContent" style="margin-top: 15px">
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
                </div>
                <div id="control2" class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div id="title2" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="OldInstanceActivityName" class="" style="">当前节点名称</span>
                </div>
                <div id="control2" class="col-md-4">
                    <input id="Control15" type="text" data-datafield="OldInstanceActivityName" data-type="SheetTextBox" style="" class="">
                </div>
                <div id="title2" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="InstanceActivityName" class="" style="">回退节点名称</span>
                </div>
                <div id="control2" class="col-md-4">
                    <input id="Control15" type="text" data-datafield="InstanceActivityName" data-type="SheetTextBox" style="" class="">
                </div>
            </div>
            <div class="row">
                <div id="div507309" class="col-md-2">
                    <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">申请备注</label>
                </div>
                <div id="div203297" class="col-md-10">
                    <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div364574" class="col-md-2">
                    <label data-datafield="ManagerApproveSuggest" data-type="SheetLabel" id="ctl244331" class="" style="">项目经理审批意见</label></div>
                <div id="div236711" class="col-md-10">
                    <div data-datafield="ManagerApproveSuggest" data-type="SheetComment" id="ctl626742" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div683438" class="col-md-2">
                    <label data-datafield="AdminApproveSuggest" data-type="SheetLabel" id="ctl840231" class="" style="">管理员审批意见</label></div>
                <div id="div158618" class="col-md-10">
                    <div data-datafield="AdminApproveSuggest" data-type="SheetComment" id="ctl512027" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="title3" class="col-md-2">
                </div>
                <div id="control3" class="col-md-4">
                </div>
                <div id="title4" class="col-md-2">
                </div>
                <div id="control4" class="col-md-4">
                </div>
            </div>
            <div class="row hidden">
                <div id="div655622" class="col-md-1">

                    <input type="text" data-datafield="NeedInstanceId" data-type="SheetTextBox" id="ctl683532" class="hidden" style="">
                </div>
                <div id="div308202" class="col-md-1">

                    <input type="text" data-datafield="NeedInstanceActivity" data-type="SheetTextBox" id="ctl123965" class="hidden" style="">
                </div>
                <div id="div497501" class="col-md-1">
                    <input id="Control14" type="text" data-datafield="Participants" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div83358" class="col-md-1">
                    <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div307049" class="col-md-1">
                </div>
                <div id="div337417" class="col-md-1">
                </div>
                <div id="div651461" class="col-md-1">
                </div>
                <div id="div227508" class="col-md-1">
                </div>
                <div id="div252648" class="col-md-1">
                </div>
                <div id="div837834" class="col-md-1">
                </div>
                <div id="div302291" class="col-md-1">
                </div>
                <div id="div557852" class="col-md-1">
                </div>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
