<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NoBusiContractMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.NoBusiContractMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="NoBusiContractMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">非业务类合同审批流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Title" style="">标题</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Title" data-type="SheetTextBox" style="">
                    </div>
                    <div id="div812984" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="TheYear" style="" class="">所属年份</span>
                    </div>
                    <div id="div338269" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="TheYear" data-type="SheetTextBox" class="" style="" data-defaultvalue="" data-wdatepickerjson="WdatePicker({dateFmt:'yyyy'})" onclick="WdatePicker(WdatePicker({ dateFmt: 'yyyy' }))">

                    </div>
                </div>
                
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="ContractName" style="">合同名称</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="">
                    </div>
                    <div id="div51225" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="SignDW" style="" class="">签订单位</span>
                    </div>
                    <div id="div702228" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="SignDW" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetSupplierManager" data-querycode="GetSupplierManager" data-outputmappings="SignDW:SupplierName">
                    </div>
                </div>
                
                <div class="row">
                    <div id="div704872" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="ContractRemark" style="" class="">合同概述</span>
                    </div>
                    <div id="div243440" class="col-md-4">
                        <textarea id="Control15" data-datafield="ContractRemark" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                     <div id="div18628" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Attachment" style="" class="">附件上传</span>
                    </div>
                    <div id="div997569" class="col-md-4">
                        <div id="Control16" data-datafield="Attachment" data-type="SheetAttachment" style="" class="">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div id="div318323" class="col-md-12">
                        附加信息 
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyVisiable">申请人</label>
                    </div>
                    <div id="control11" class="col-md-4">
                        <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData"></label>
                    </div>
                    <div id="title9" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="ApplyDate" style="">申请日期</span>
                    </div>
                    <div id="control9" class="col-md-4">
                        <input id="Control17" type="text" data-datafield="ApplyDate" data-type="SheetTime" style="">
                    </div>
                </div>
                
                <div class="row">
                    <div id="div623040" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="ApplyNo" style="" class="">申请单号</span>
                    </div>
                    <div id="div644278" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="ApplyNo" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div817612" class="col-md-2">
                    </div>
                    <div id="div727872" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control19" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="title13" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="OtherDepApprover" style="">相关部门审批人</span>
                    </div>
                    <div id="control13" class="col-md-4">
                        <div id="Control20" data-datafield="OtherDepApprover" data-type="SheetUser" style="">
                        </div>
                    </div>
                    <div id="space14" class="col-md-2">
                    </div>
                    <div id="spaceControl14" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title15" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="OtherDepComment" style="">相关部门审批意见</span>
                    </div>
                    <div id="control15" class="col-md-10">
                        <div id="Control21" data-datafield="OtherDepComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title17" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="FGManagerComment" style="">分管领导审批意见</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <div id="Control22" data-datafield="FGManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label23" data-type="SheetLabel" data-datafield="GeneralManagerComment" style="">总经理审批意见</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <div id="Control23" data-datafield="GeneralManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title21" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="OrigComplete" style="">发起人办结意见</span>
                    </div>
                    <div id="control21" class="col-md-10">
                        <div id="Control24" data-datafield="OrigComplete" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title23" class="col-md-2">
                        <span id="Label25" data-type="SheetLabel" data-datafield="OfficeComplete" style="">综合办公室归档意见</span>
                    </div>
                    <div id="control23" class="col-md-10">
                        <div id="Control25" data-datafield="OfficeComplete" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="ToOtherDep" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div903542" class="col-md-2">
                        <input type="text" data-datafield="ToGenManager" data-type="SheetTextBox" class="hidden" style="">
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
