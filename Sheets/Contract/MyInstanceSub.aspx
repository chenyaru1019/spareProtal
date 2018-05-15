<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyInstanceSub.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.MyInstanceSub" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
<style type="text/css">
.col-md-1 {
    padding-left: 3px;
    border-right: 1px solid #CCCBCB;
    min-height: 36px;
}
.divContent .row {
    border:  1px solid #CCCBCB;
    background-color: #E6F3FC;
}

</style>
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
        <label id="lblTitle" class="panel-title">我的子流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="" style="">

            <div class="" >

                <div class="row tableContent" style="background-color: #E6F3FC;">
                    <div id="div5095" class="col-md-1">
                        <span id="Label11" data-type="SheetLabel" data-datafield="SInstanceName" style="">流程名称：</span>
                    </div>
                    <div id="div701597" class="col-md-1">
                        <input type="text" data-datafield="SInstanceName" data-type="SheetTextBox" id="ctl475289" class="" style="">
                    </div>
                    <div id="title4" class="col-md-1">
                        <span id="Label14" data-type="SheetLabel" data-datafield="Type" style="">类型</span>
                    </div>
                    <div id="control4" class="col-md-1">
                        <select data-datafield="Type" data-type="SheetDropDownList" id="ctl97773" class="" style="" data-defaultitems="进行中;已完成" data-queryable="false">
                        </select>
                    </div>
                    <div id="title5" class="col-md-1">
                        <span id="Label15" data-type="SheetLabel" data-datafield="TypeOfMe" style="">与我相关类型</span>
                    </div>
                    <div id="control5" class="col-md-1">
                        <select data-datafield="TypeOfMe" data-type="SheetDropDownList" id="ctl525931" class="" style="" data-defaultitems="我发起的;我参与的" data-queryable="false">
                        </select>
                    </div>
                    <div id="title2" class="col-md-1">
                        <span id="Label12" data-type="SheetLabel" data-datafield="StartTime" style="">开始时间</span>
                    </div>
                    <div id="control2" class="col-md-1">
                        <input id="Control12" type="text" data-datafield="StartTime" data-type="SheetTime" style="" data-minvalue="" data-maxvalue="" data-defaultvalue="">
                    </div>
                    <div id="title3" class="col-md-1">
                        <span id="Label13" data-type="SheetLabel" data-datafield="EndTime" style="">结束时间</span>
                    </div>
                    <div id="control3" class="col-md-1">
                        <input id="Control13" type="text" data-datafield="EndTime" data-type="SheetTime" style="" data-minvalue="" data-maxvalue="" data-defaultvalue="">
                    </div>
                    <div id="div707679" class="col-md-2 rightBtn">
                        <input id="" type="button" style="padding: 3px 10px" onclick="Search()" class="btn btn-primary" value="查找" />
                    </div>
                </div>

                <div class="myTable">
                    <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_MyInstanceSub"></table>
                </div>




            </div>
        </div>
    </div>
    <script src="MyInstanceSub.js"></script>
</asp:Content>
