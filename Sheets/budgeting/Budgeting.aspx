<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Budgeting.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.Budgeting" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
<div class="panel-body sheetContainer">
    <div class="tabContent">
        <div class="row">
            <div class="col-md-12"><h3>预算编制</h3></div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline">
                    <div class="form-group">
                        <button id="last-year-btn" type="button" class="btn btn-default form-control">&lt;上一年</button>
                        <select id="year-select" class="form-control"></select>
                        <button id="next-year-btn" type="button" class="btn btn-default form-control">下一年&gt;</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="btn-toolbar" role='toolbar' aria-label='预算工具栏'>
                    <div class='btn-group' role='group' aria-label=''>
                        <button id='load-prev-btn' type='button' class='btn btn-default'>从往年导入</button>
                        <button id='save-btn' type='button' class='btn btn-default'>保存预算</button>
                        <button id='confirm-btn' type='button' class='btn btn-default'>预算确认</button>
                        <button id='confirm-cancel-btn' type='button' class='btn btn-default'>确认取消</button>
                        <!--<button id='expert-btn' type='button' class='btn btn-default'>导出Excel</button>-->
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div id="budgeting-table"></div>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" type="text/css" href="Budgeting.css" >
<script src="jquery-ui.min.js"></script>
<script src="xntable.js"></script>
<script src="Budgeting.js"></script>
</asp:Content>