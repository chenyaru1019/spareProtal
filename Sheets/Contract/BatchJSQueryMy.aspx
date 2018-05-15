﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchJSQueryMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchJSQueryMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

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
    <%--<script src="BatchJSQueryMy.js"></script>--%>
    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title"><span class="BatchJSQueryMy_Title"></span></label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div id="div707679" class="col-md-12 rightBtn">
                        <input id="ToBatchJSApplyId" type="button" style="padding: 3px 10px" onclick="ToBatchJSApply()" class="btn btn-primary" value=" + 新增批量结算" />
                    </div>
                </div>
                <div class="Content_Tab" style="padding-top:10px">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#batchqktab" aria-controls="batchqktab" role="tab" data-toggle="tab" onclick="setTitle('批量结算（请款）')">批量请款</a></li>
                        <li role="presentation"><a href="#batchfktab" aria-controls="batchfktab" role="tab" data-toggle="tab" onclick="setTitle('批量结算（付款）')">批量付款</a></li>
                        <li role="presentation"><a href="#batchjqtab" aria-controls="batchjqtab" role="tab" data-toggle="tab" onclick="setTitle('批量结算（结清）')">批量结清</a></li>
                    </ul>
                    <div class="tab-content">

                        <div role="tabpanel" class="tab-pane active" id="batchqktab">
                            <div class="row tableContent" style="background-color: #E6F3FC;">
                                <div id="div5095" class="col-md-1">
                                    <span id="Label11" data-type="SheetLabel" data-datafield="QK_Target" style="">业主：</span>
                                </div>
                                <div id="div701597" class="col-md-3">
                                    <select data-datafield="QK_Target" data-type="SheetDropDownList" id="ctl421615" class="" style="" data-displayemptyitem="true" data-emptyitemtext="全部" data-schemacode="GetFinalUser" data-querycode="GetFinalUser" data-datavaluefield="FinalUser" data-datatextfield="FinalUser" data-queryable="false"></select>
                                </div>
                                <div id="div473092" class="col-md-1">
                                    <span id="Label12" data-type="SheetLabel" data-datafield="QK_Status" style="">状态：</span>
                                </div>
                                <div id="div876934" class="col-md-5">
                                    <div data-datafield="QK_Status" data-type="SheetCheckboxList" id="ctl115105" class="" style="" data-defaultitems="草稿;审批中;送达确认中;到款确认中;完成;驳回" data-repeatcolumns="6">
                                    </div>
                                </div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="BatchQKSearchId" type="button" style="padding:3px 10px" onclick="BatchQKSearch()" class="btn btn-primary" value="查找" />
                                </div>
                            </div>

                            <!-- 分割线 -->
                            <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                            </div>

                            <div class="myTable">
                                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_BatchJS_QK"></table>
                            </div>

                        </div>


                        <div role="tabpanel" class="tab-pane" id="batchfktab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-1">
                                    <span id="Label11" data-type="SheetLabel" data-datafield="FK_Target" style="">业主：</span>
                                </div>
                                <div id="div701597" class="col-md-3">
                                    <select data-datafield="FK_Target" data-type="SheetDropDownList" id="ctl421615" class="" style="" data-displayemptyitem="true" data-emptyitemtext="全部" data-schemacode="GetFinalUser" data-querycode="GetFinalUser" data-datavaluefield="FinalUser" data-datatextfield="FinalUser" data-queryable="false"></select>
                                </div>
                                <div id="div473092" class="col-md-1">
                                    <span id="Label12" data-type="SheetLabel" data-datafield="FK_Status" style="">状态：</span>
                                </div>
                                <div id="div876934" class="col-md-3" style="line-height: 36px">
                                    <div data-datafield="FK_Status" data-type="SheetCheckboxList" id="ctl115105" class="" style="" data-defaultitems="草稿;审批中;确认中;完成;驳回">
                                    </div>
                                </div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="BatchFKSearchId" type="button" style="padding:3px 10px" onclick="BatchFKSearch()" class="btn btn-primary" value="查找" />
                                </div>
                            </div>

                            <!-- 分割线 -->
                            <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                            </div>

                            <div class="myTable">
                                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_BatchJS_FK"></table>
                            </div>
                        </div>


                        <div role="tabpanel" class="tab-pane" id="batchjqtab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-1">
                                    <span id="Label11" data-type="SheetLabel" data-datafield="JQ_Target" style="">业主：</span>
                                </div>
                                <div id="div701597" class="col-md-3">
                                    <select data-datafield="JQ_Target" data-type="SheetDropDownList" id="ctl421615" class="" style="" data-displayemptyitem="true" data-emptyitemtext="全部" data-schemacode="GetFinalUser" data-querycode="GetFinalUser" data-datavaluefield="FinalUser" data-datatextfield="FinalUser" data-queryable="false"></select>
                                </div>
                                <div id="div473092" class="col-md-1">
                                    <span id="Label12" data-type="SheetLabel" data-datafield="JQ_Status" style="">状态：</span>
                                </div>
                                <div id="div876934" class="col-md-3" style="line-height: 36px">
                                    <div data-datafield="JQ_Status" data-type="SheetCheckboxList" id="ctl115105" class="" style="" data-defaultitems="草稿;审批中;完成;驳回">
                                    </div>
                                </div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="BatchJQSearchId" type="button" style="padding:3px 10px" onclick="BatchJQSearch()" class="btn btn-primary" value="查找" />
                                </div>
                            </div>

                            <!-- 分割线 -->
                            <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                            </div>

                            <div class="myTable">
                                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_BatchJS_JQ"></table>
                            </div>

                        </div>

                    </div>
                </div>

                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input id="Control20" type="text" data-datafield="WorkflowVersion_BatchJSApply" data-type="SheetTextBox" class="hidden" style="">
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
    <script src="BatchJSQueryMy.js"></script>
</asp:Content>
