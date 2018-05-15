<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Mycontract.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Mycontract" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
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
	<label id="lblTitle" class="panel-title">我的合同</label>
</div>
<div class="panel-body sheetContainer">

        <div class="" style="">

            <div class="" >
            <div class="row">
                <div id="title1" class="col-md-2">
                    <span id="Label11" data-type="SheetLabel" data-datafield="contract_sele" style="">合同选择</span>
                </div>
                <div id="control1" class="col-md-4">
                    <div data-datafield="contract_sele" data-type="SheetRadioButtonList" id="ctl288064" class="" style="" data-defaultitems="我的合同;代职合同;全部">
                    </div>
                </div>
                <div id="title2" class="col-md-2">
                    <span id="Label12" data-type="SheetLabel" data-datafield="contract_states" style="">合同状态</span>
                </div>
                <div id="control2" class="col-md-4">

                    <div data-datafield="contract_states" data-type="SheetCheckboxList" id="ctl800586" class="" style="" data-defaultitems="创建合同;合同审签;合同执行;合同完成"></div>
                </div>
            </div>
            <div class="row">
                <div id="title3" class="col-md-2">
                    <span id="Label13" data-type="SheetLabel" data-datafield="my_role" style="">我的角色</span>
                </div>
                <div id="control3" class="col-md-4">

                    <select data-datafield="my_role" data-type="SheetDropDownList" id="ctl73677" class="" style="" data-defaultitems="全部;我是A角;我是B角"
                        data-queryable="false">
                    </select>
                </div>
                <div id="title4" class="col-md-2">
                    <span id="Label14" data-type="SheetLabel" data-datafield="contract_name" style="">合同名称</span>
                </div>
                <div id="control4" class="col-md-4">
                    <input id="Control14" type="text" data-datafield="contract_name" data-type="SheetTextBox" style="">
                    <%--<input type="button" class="btn btn-primary " value="查询" onclick="sel_agreement()">--%>
                </div>

            </div>

            <div id="div30546" class="col-md-12 rightBtn" style="text-align: center;">
                <input id="div30547" type="button" style="padding: 3px 10px" onclick="Search()" class="btn btn-primary" value="查找" />
            </div>
            <div class="myTable">
                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="Mycontract"></table>
            </div>
        </div>
    </div>
	</div>
    <script src="Mycontract.js"></script>
</asp:Content>