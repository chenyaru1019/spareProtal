<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contract_query.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Contract_query" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../../css/common.css">
    <script src="../../js/bootstrap-select.min.js"></script>
    <script src="../../js/bootstrap-table.min.js"></script>
    <script src="../../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../js/bootstrap-table.min.css">
<div style="text-align: center;" class="DragContainer">
	<label id="lblTitle" class="panel-title">合同查询</label>
</div>
<div class="panel-body sheetContainer">

        <div class="" style="">

            <div class="" >
            <div class="row">
                <div id="title1" class="col-md-2">
                    <span id="Label11" data-type="SheetLabel" data-datafield="contract_number" style="">合同号</span>
                </div>
                <div id="control1" class="col-md-4">
                    <input id="Control11" type="text" data-datafield="contract_number" data-type="SheetTextBox" style="">
                </div>
                <div id="title2" class="col-md-2">
                    <span id="Label12" data-type="SheetLabel" data-datafield="contract_name" style="">合同名称</span>
                </div>
                <div id="control2" class="col-md-4">
                    <input id="Control12" type="text" data-datafield="contract_name" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title3" class="col-md-2">
                    <span id="Label13" data-type="SheetLabel" data-datafield="qy_time" style="">签约日期</span>
                </div>
                <div id="control3" class="col-md-4">
                    <input id="Control13" type="text" data-datafield="qy_time" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
                <div id="title4" class="col-md-2">
                    <span id="Label14" data-type="SheetLabel" data-datafield="qy_time2" style="">签约日期2</span>
                </div>
                <div id="control4" class="col-md-4">
                    <input id="Control14" type="text" data-datafield="qy_time2" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
            </div>
            <div class="row">
                <div id="title5" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="Project_head" style="">项目负责人</span>
                </div>
                <div id="control5" class="col-md-4">
                    <input id="Control15" type="text" data-datafield="Project_head" data-type="SheetTextBox" style="">
                </div>
                <div id="title6" class="col-md-2">
                    <span id="Label16" data-type="SheetLabel" data-datafield="my_way" style="">贸易方式</span>
                </div>
                <div id="control6" class="col-md-4">
                    <select data-datafield="my_way" data-type="SheetDropDownList" id="ctl711945" class="" style="" data-masterdatacategory="贸易方式" data-displayemptyitem="true">
                    </select>
                </div>
            </div>
            <div class="row">
                <div id="title7" class="col-md-2">
                    <span id="Label17" data-type="SheetLabel" data-datafield="contract_creatime" style="">合同创建日期</span>
                </div>
                <div id="control7" class="col-md-4">
                    <input id="Control17" type="text" data-datafield="contract_creatime" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
                <div id="title8" class="col-md-2">
                    <span id="Label18" data-type="SheetLabel" data-datafield="contract_creatime2" style="">合同创建日期2</span>
                </div>
                <div id="control8" class="col-md-4">
                    <input id="Control18" type="text" data-datafield="contract_creatime2" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
            </div>
            <div class="row">
                <div id="title9" class="col-md-2">
                    <span id="Label19" data-type="SheetLabel" data-datafield="end_user" style="">最终用户</span>
                </div>
                <div id="control9" class="col-md-4">
                    <input id="Control19" type="text" data-datafield="end_user" data-type="SheetTextBox" style="" class="">
                </div>
                <div id="title10" class="col-md-2">
                    <span id="Label20" data-type="SheetLabel" data-datafield="contract_xz" style="">合同性质</span>
                </div>
                <div id="control10" class="col-md-4">
                    <select data-datafield="contract_xz" data-type="SheetDropDownList" id="ctl24771" class="" style="" data-masterdatacategory="合同性质（GN/JK）" data-displayemptyitem="true">
                    </select>
                </div>
            </div>
            <div class="row">
                <div id="title11" class="col-md-2">
                    <span id="Label21" data-type="SheetLabel" data-datafield="contract_bgtime" style="">合同变更日期</span>
                </div>
                <div id="control11" class="col-md-4">
                    <input id="Control21" type="text" data-datafield="contract_bgtime" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
                <div id="title12" class="col-md-2">
                    <span id="Label22" data-type="SheetLabel" data-datafield="contract_bgtime2" style="">合同变更日期2</span>
                </div>
                <div id="control12" class="col-md-4">
                    <input id="Control22" type="text" data-datafield="contract_bgtime2" data-type="SheetTime" style="" class="" data-defaultvalue="">
                </div>
            </div>
            <div class="row">
                <div id="title13" class="col-md-2">
                    <span id="Label23" data-type="SheetLabel" data-datafield="contract_mf" style="">合同卖方</span>
                </div>
                <div id="control13" class="col-md-4">
                    <input id="Control23" type="text" data-datafield="contract_mf" data-type="SheetTextBox" style="">
                </div>
                <div id="title14" class="col-md-2">
                    <span id="Label24" data-type="SheetLabel" data-datafield="contract_type" style="">合同类型</span>
                </div>
                <div id="control14" class="col-md-4">
                    <select data-datafield="contract_type" data-type="SheetDropDownList" id="ctl346183" class="" style="" data-displayemptyitem="true" data-masterdatacategory="合同类型">
                    </select>
                    <%--<input type="button" class="btn btn-primary " value="查询" onclick="sel_agreement()">--%>
                </div>
            </div>

            <div id="div30546" class="col-md-12 rightBtn" style="text-align: center;">
                <input id="div30547" type="button" style="padding: 3px 10px" onclick="Search()" class="btn btn-primary" value="查找" />
            </div>
            <div class="myTable">
                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="Contract_query"></table>
            </div>
        </div>
    </div>
	</div>
    <script src="Contract_query.js"></script>
</asp:Content>