﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FWMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.FWMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="FWMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">公司发文处理流程</label>
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
                    <div id="div775697" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="FileType" class="" style="">文件类型</span>
                    </div>
                    <div id="div136827" class="col-md-4">

                        <select data-datafield="FileType" data-type="SheetDropDownList" id="ctl461606" class="" style="" data-masterdatacategory="OA文件类型" data-queryable="false"></select>
                    </div>
                    
                </div>
                <div class="row">
                    
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="ImportLevel" style="">重要程度</span>
                    </div>
                    <div id="control3" class="col-md-4">

                        <select data-datafield="ImportLevel" data-type="SheetDropDownList" id="ctl293927" class="" style="" data-masterdatacategory="OA重要程度" data-queryable="false"></select>
                    </div>
                    <div id="div637879" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="ZTC" class="" style="">主题词</span>
                    </div>
                    <div id="div129649" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="ZTC" data-type="SheetTextBox" class="" style="">
                    </div>
                </div>
                <div class="row">

                    
                    <div id="title7" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Attachment" style="">附件上传</span>
                    </div>
                    <div id="control7" class="col-md-4">
                        <div id="Control16" data-datafield="Attachment" data-type="SheetAttachment" style="">
                        </div>
                    </div>
                    <div id="title7" class="col-md-2">
                    </div>
                    <div id="control7" class="col-md-4">
                    </div>
                </div>
                
                <div class="row">
                    <div id="div729577" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="Remark" class="" style="">协办意见</span>
                    </div>
                    <div id="div995123" class="col-md-10">
                        <textarea data-datafield="Remark" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl449752" class=""></textarea>
                    </div>

                </div>
                <div class="row">
                    <div id="div318323" class="col-md-12">
                        附加信息 
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyVisiable">综合部经办人</label>
                    </div>
                    <div id="control11" class="col-md-4">
                        <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData"></label>
                    </div>
                    <div id="title7" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="FWDate" style="">发文日期</span>
                    </div>
                    <div id="control7" class="col-md-4">
                        <input id="Control19" type="text" data-datafield="FWDate" data-type="SheetTime" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="div503161" class="col-md-2"><span id="Label18" data-type="SheetLabel" data-datafield="FWNo" style="" class="">发文编号</span></div>
                    <div id="div811210" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="FWNo" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title7" class="col-md-2">
                    </div>
                    <div id="control7" class="col-md-4">
                    </div>
                </div>
                
                <div class="row tableContent">
                    <div id="title9" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <div id="Control19" data-datafield="ManagerComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="FGeneralManagerComment" style="">副总经理审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control20" data-datafield="FGeneralManagerComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title13" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="GeneralManagerComment" style="">总经理审批意见</span>
                    </div>
                    <div id="control13" class="col-md-10">
                        <div id="Control21" data-datafield="GeneralManagerComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title15" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="OfficeComment_Yes" style="">综合办公室审批意见</span>
                    </div>
                    <div id="control15" class="col-md-10">
                        <div id="Control22" data-datafield="OfficeComment_Yes" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title17" class="col-md-2">
                        <span id="Label23" data-type="SheetLabel" data-datafield="OfficeProduceComment_Yes" style="">综合办公室制作审批意见</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <div id="Control23" data-datafield="OfficeProduceComment_Yes" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="OfficeConfirmComment_Yes" style="">综合办公室确认审批意见</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <div id="Control24" data-datafield="OfficeConfirmComment_Yes" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title21" class="col-md-2">
                        <span id="Label25" data-type="SheetLabel" data-datafield="OfficeCompleteComment_Yes" style="">综合办公室办结</span>
                    </div>
                    <div id="control21" class="col-md-10">
                        <div id="Control25" data-datafield="OfficeCompleteComment_Yes" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title23" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="OfficeComment_No" style="">综合办公室审批意见</span>
                    </div>
                    <div id="control23" class="col-md-10">
                        <div id="Control26" data-datafield="OfficeComment_No" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title25" class="col-md-2">
                        <span id="Label27" data-type="SheetLabel" data-datafield="OfficeCompleteComment_No" style="">综合办公室办结</span>
                    </div>
                    <div id="control25" class="col-md-10">
                        <div id="Control27" data-datafield="OfficeCompleteComment_No" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="YesNoFlg" data-type="SheetTextBox" class="hidden" style="">
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
