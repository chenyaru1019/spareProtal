<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NoticeMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.NoticeMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="NoticeMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">公司公告流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Title" style="">信息标题</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Title" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="PublishDate" style="">发布日期</span>
                    </div>
                    <div id="control2" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="PublishDate" data-type="SheetTime" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="Status" style="">状态</span>
                    </div>
                    <div id="control3" class="col-md-4">

                        <select data-datafield="Status" data-type="SheetDropDownList" id="ctl68304" class="" style="" data-queryable="false" data-masterdatacategory="OA公告状态"></select>
                    </div>
                    <div id="title4" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="ExpireDate" style="">过期日期</span>
                    </div>
                    <div id="control4" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="ExpireDate" data-type="SheetTime" style="" class="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="IsTop" style="">置顶</span>
                    </div>
                    <div id="control5" class="col-md-4">

                        <div data-datafield="IsTop" data-type="SheetCheckboxList" id="ctl60820" class="" style="" data-defaultitems="是"></div>
                    </div>
                    <div id="title6" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="NoticeType" style="">公告类型</span>
                    </div>
                    <div id="control6" class="col-md-4">

                        <select data-datafield="NoticeType" data-type="SheetDropDownList" id="ctl955821" class="" style="" data-masterdatacategory="OA公告类型" data-queryable="false"></select>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="Content" style="">信息内容</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <textarea data-datafield="Content" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl586623" class="" data-richtextbox="true">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title9" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="Attachment" style="">附件</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <div id="Control18" data-datafield="Attachment" data-type="SheetAttachment" style="">
                        </div>
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
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control19" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="div321617" class="col-md-2">
                        <label data-datafield="FGeneralManagerComment" data-type="SheetLabel" id="ctl890971" class="" style="">副总经理审批意见</label>
                    </div>
                    <div id="div855770" class="col-md-10">
                        <div data-datafield="FGeneralManagerComment" data-type="SheetComment" id="ctl500336" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div420130" class="col-md-2">
                        <label data-datafield="GeneralManagerComment" data-type="SheetLabel" id="ctl814685" class="" style="">总经理审批意见</label>
                    </div>
                    <div id="div907725" class="col-md-10">
                        <div data-datafield="GeneralManagerComment" data-type="SheetComment" id="ctl685987" class="" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="YesNoFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div903542" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="RejectFlg" data-type="SheetTextBox" class="hidden" style="">
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
