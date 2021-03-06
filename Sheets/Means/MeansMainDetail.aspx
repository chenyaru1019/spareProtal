﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MeansMainDetail.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.MeansMainDetail" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
    </script>
    <link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" href="pagecss.css"/>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    
<div class="panel-body sheetContainer">
    <div class="ContractContent ">
	<div class="nav-icon fa  fa-chevron-right bannerTitle">
		<label id="divSheetInfo" data-en_us="Sheet information">基本资料</label>
	</div>
    <div class="divContent" id="divSheet">
		<div class="row">
			<div id="title1" class="col-md-2">
				<span id="Label11" data-type="SheetLabel" data-datafield="types" style="">类型</span>
			</div>
			<div id="control1" class="col-md-10">
                 <label id="ctl997450" data-type="SheetLabel" data-datafield="types" data-bindtype="OnlyData" style=""></label>
				<!--<select data-datafield="types" data-type="SheetDropDownList" id="ctl997450" class="" style="" data-defaultitems="法律法规;标准模版;业务管理;其他" disabled="disabled">
				</select>-->
			</div>	
		</div>
		<div class="row">
			<div id="div94717" class="col-md-2"><span id="Label12" data-type="SheetLabel" data-datafield="meansNames" style="" class="">名称</span></div>
		    <div id="div759678" class="col-md-10">
                 <label id="Control12" data-type="SheetLabel" data-datafield="meansNames" data-bindtype="OnlyData" style=""></label>
			    <!--<input id="Control12" type="text" data-datafield="meansNames" data-type="SheetTextBox" style="" class="" readonly="readonly">-->
		    </div>
		</div>
        <div class="row">
            <div id="divFullNameTitle" class="col-md-2">
			<label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-en_us="Originator" data-bindtype="OnlyVisiable" style="">录入人</label>
		    </div>
		    <div id="divFullName" class="col-md-10">
			    <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData" style=""></label>
		    </div>
        </div>
        <div class="row">
            <div id="divOriginateDateTitle" class="col-md-2">
			<label id="lblOriginateDateTitle" data-type="SheetLabel" data-datafield="OriginateTime" data-en_us="Originate Date" data-bindtype="OnlyVisiable" style="">更新时间</label>
		    </div>
		    <div id="divOriginateDate" class="col-md-10">
			    <label id="lblOriginateDate" data-type="SheetLabel" data-datafield="ModifiedTime" data-bindtype="OnlyData" style=""></label>
		    </div>
        </div>
	</div>
    </div>
    <div class="ContractContent ">
    <div class="nav-icon fa  fa-chevron-right bannerTitle">
		<label id="divSheetInfo" data-en_us="Sheet information">资料内容</label>
	</div>
    <div class="divContent" id="divSheet">
		<div class="row">
			<div id="div641725" class="col-md-2"><span id="Label13" data-type="SheetLabel" data-datafield="contents" style="" class="">内容</span>
			</div>
			<div id="div13469" class="col-md-10">
                <label id="ctl156756" data-type="SheetLabel" data-datafield="contents" data-bindtype="OnlyData" style=""></label>
				<!--<textarea data-datafield="contents" style="height: 100px; width: 100%;" data-type="SheetRichTextBox" id="ctl156756" class="" readonly="readonly"></textarea>-->
			</div>
		</div>   
	</div>
        </div>
    <div class="ContractContent ">
    <div class="nav-icon fa  fa-chevron-right bannerTitle">
		<label id="divSheetInfo" data-en_us="Sheet information">相关文件下载</label>
	</div>
    <div class="divContent" id="divSheet">
		<div class="row">
			<div id="div862270" class="col-md-2"><span id="Label14" data-type="SheetLabel" data-datafield="attachments" style="" class="">文件</span>
			</div>
			<div id="div709657" class="col-md-10">
				<!--<div data-datafield="attachments" data-type="SheetAttachment" id="ctl397990" class="" style=""></div>-->
                <div data-datafield="attachments" id="div00000" style=""></div>
			</div>
		</div>
       
	</div>
</div>
</div>
</asp:Content>