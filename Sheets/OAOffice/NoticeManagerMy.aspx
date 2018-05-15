﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NoticeManagerMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.NoticeManagerMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../css/common.css">
    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">公司公告管理页面</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div id="div707679" class="col-md-12 rightBtn">
                        <input id="NoticeId" type="button" style="padding: 3px 10px" onclick="NewNotice()" class="btn btn-primary" value=" + 新增公司公告" />
                    </div>
                </div>
                <div class="row">
                    <div id="title1" class="col-md-1">
                        <span id="Label11" data-type="SheetLabel" data-datafield="Title" style="">标题</span>
                    </div>
                    <div id="control1" class="col-md-2">
                        <input id="Control11" type="text" data-datafield="Title" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-1">
                        <span id="Label12" data-type="SheetLabel" data-datafield="NoticeType" style="">公告类型</span>
                    </div>
                    <div id="control2" class="col-md-2">
                        <select data-datafield="NoticeType" data-type="SheetDropDownList" id="ctl9872" class="" style="" data-displayemptyitem="true" data-emptyitemtext="全部" data-masterdatacategory="OA公告类型" data-queryable="false">
                        </select>
                    </div>
<%--                    <div id="title3" class="col-md-1">
                        <span id="Label13" data-type="SheetLabel" data-datafield="Content" style="">信息内容</span>
                    </div>
                    <div id="control3" class="col-md-2">
                        <input id="Control13" type="text" data-datafield="Content" data-type="SheetTextBox" style="">
                    </div>--%>
                    <div id="div30546" class="col-md-6 rightBtn">
                        <input id="NoticeQueryId" type="button" style="padding:3px 10px" onclick="NoticeQuery()" class="btn btn-primary" value="查找" />
                    </div>
                </div>


                <!-- 分割线 -->
                <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                </div>

                <div class="myTable">
                    <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_NoticeManager"></table>
                </div>

                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="WorkflowVersion_Notice" data-type="SheetTextBox" class="hidden" style="" > 
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
    <script src="NoticeManagerMy.js"></script>
</asp:Content>
