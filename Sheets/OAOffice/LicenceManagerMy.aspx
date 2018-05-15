<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenceManagerMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.LicenceManagerMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="LicenceManagerMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">证照印章审批流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="LicenceType" style="">证件类型</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <select data-datafield="LicenceType" data-type="SheetDropDownList" id="ctl767851" class="" style="" data-masterdatacategory="OA证件类型" data-queryable="false"></select>
                    </div>
                    <div id="title2" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="LicenceNo" style="">证件编号</span>
                    </div>
                    <div id="control2" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="LicenceNo" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="LicenceName" style="">证件名称</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="LicenceName" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title4" class="col-md-2">
                    </div>
                    <div id="control4" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div202161" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="StartDate" class="" style="">开始日期</span>
                    </div>
                    <div id="div358043" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="StartDate" data-type="SheetTime" class="" style="">
                    </div>
                    <div id="div34449" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="EndDate" class="" style="">结束日期</span>
                    </div>
                    <div id="div723360" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="EndDate" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="NJDate" style="" class="">年检日期</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="NJDate" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                    <div id="title6" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="LicenceStatus" class="" style="">证件状态</span>
                    </div>
                    <div id="control6" class="col-md-4">
                        <select data-datafield="LicenceStatus" data-type="SheetDropDownList" id="ctl839623" class="" style="" data-masterdatacategory="OA证件状态" data-queryable="false"></select>
                    </div>
                </div>
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="ChangeLicDate" class="" style="">换证日期</span>
                    </div>
                    <div id="control7" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="ChangeLicDate" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                    <div id="title8" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="BelongOrg" class="" style="">所属机构</span>
                    </div>
                    <div id="control8" class="col-md-4">
                        <select data-datafield="BelongOrg" data-type="SheetDropDownList" id="ctl251666" class="" style="" data-masterdatacategory="OA所属机构" data-queryable="false"></select>
                    </div>
                </div>
                <div class="row">
                    <div id="title9" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="OrderBy" style="" class="">排序</span>
                    </div>
                    <div id="control9" class="col-md-4">
                        <input id="Control20" type="text" data-datafield="OrderBy" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="title10" class="col-md-2">
                    </div>
                    <div id="control10" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="Attachment" style="">附件</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control21" data-datafield="Attachment" data-type="SheetAttachment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title13" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="Remark" style="">描述</span>
                    </div>
                    <div id="control13" class="col-md-10">
                        <textarea id="Control22" data-datafield="Remark" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>

                <div class="row">
                    <div id="title11" class="col-md-2">
                        <label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyVisiable">创建者</label>
                    </div>
                    <div id="control11" class="col-md-4">
                        <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData"></label>
                    </div>
                    <div id="div836589" class="col-md-2">
                        <label data-datafield="Updator" data-type="SheetLabel" id="ctl36105" class="" style="">修改者</label>
                    </div>
                    <div id="div892058" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="Updator" data-type="SheetTextBox" style="" >
                    </div>
                </div>
                <div class="row">
                    <div id="title17" class="col-md-2">
                        <span id="Label23" data-type="SheetLabel" data-datafield="CreateTime" class="" style="">创建时间</span>
                    </div>
                    <div id="control17" class="col-md-4">
                        <input id="Control23" type="text" data-datafield="CreateTime" data-type="SheetTime" class="" style="" data-timemode="FullTime" >
                    </div>
                    <div id="div898906" class="col-md-2">
                        <label data-datafield="UpdateTime" data-type="SheetLabel" id="ctl358345" class="" style="">修改时间</label>
                    </div>
                    <div id="div278954" class="col-md-4">
                        <input type="text" data-datafield="UpdateTime" data-type="SheetTime" id="ctl610601" class="" style="" data-timemode="FullTime" data-defaultvalue="">
                    </div>
                </div>
                
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <div id="Control26" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title21" class="col-md-2">
                        <span id="Label27" data-type="SheetLabel" data-datafield="FGeneralManagerComment" style="">副总经理审批意见</span>
                    </div>
                    <div id="control21" class="col-md-10">
                        <div id="Control27" data-datafield="FGeneralManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title23" class="col-md-2">
                        <span id="Label28" data-type="SheetLabel" data-datafield="GeneralManagerComment" style="">总经理审批意见</span>
                    </div>
                    <div id="control23" class="col-md-10">
                        <div id="Control28" data-datafield="GeneralManagerComment" data-type="SheetComment" style="">
                        </div>
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
