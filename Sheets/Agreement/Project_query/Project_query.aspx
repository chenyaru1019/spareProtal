<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Project_query.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.Project_query" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
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
	<label id="lblTitle" class="panel-title">��Ŀ��ѯ</label>
</div>
<div class="panel-body sheetContainer">


		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<%--<label id="divSheetInfo" data-en_us="Sheet information">������Ϣ</label>--%>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="zb_number" style="">�б����</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="zb_number" data-type="SheetTextBox" style="" class="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Project_head" style="">��Ŀ������</span>
				</div>
				<div id="control2" class="col-md-4">
					<input id="Control12" type="text" data-datafield="Project_head" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="fb_time" style="">����ʱ��</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="Control13" type="text" data-datafield="fb_time" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="fb_time2" style="">����ʱ��</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="fb_time2" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="Project_name" style="">��Ŀ����/���</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="Project_name" data-type="SheetTextBox" style="">
				</div>
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="pb_specialist" style="">����ר��</span>
				</div>
				<div id="control6" class="col-md-4">
					<input id="Control16" type="text" data-datafield="pb_specialist" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title7" class="col-md-2">
					<span id="Label17" data-type="SheetLabel" data-datafield="kb_time" style="">����ʱ��</span>
				</div>
				<div id="control7" class="col-md-4">
					<input id="Control17" type="text" data-datafield="kb_time" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
				<div id="title8" class="col-md-2">
					<span id="Label18" data-type="SheetLabel" data-datafield="kb_time2" style="">����ʱ��</span>
				</div>
				<div id="control8" class="col-md-4">
					<input id="Control18" type="text" data-datafield="kb_time2" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
			</div>
			<div class="row">
				<div id="title9" class="col-md-2">
					<span id="Label19" data-type="SheetLabel" data-datafield="bao_number" style="">����</span>
				</div>
				<div id="control9" class="col-md-4">
					<input id="Control19" type="text" data-datafield="bao_number" data-type="SheetTextBox" style="">
				</div>
				<div id="title10" class="col-md-2">
					<span id="Label20" data-type="SheetLabel" data-datafield="Project_state" style="">��Ŀ״̬</span>
				</div>
				<div id="control10" class="col-md-4">
					<select data-datafield="Project_state" data-type="SheetDropDownList" id="ctl120366" class="" style="" data-displayemptyitem="true" data-defaultitems="������Ŀ;�б���Ŀ;������Ŀ;����;�б��˱�;�鵵��β;��Ŀ���">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title11" class="col-md-2">
					<span id="Label21" data-type="SheetLabel" data-datafield="jx_time" style="">��������</span>
				</div>
				<div id="control11" class="col-md-4">
					<input id="Control21" type="text" data-datafield="jx_time" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
				<div id="title12" class="col-md-2">
					<span id="Label22" data-type="SheetLabel" data-datafield="jx_time2" style="">��������</span>
				</div>
				<div id="control12" class="col-md-4">
					<input id="Control22" type="text" data-datafield="jx_time2" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
			</div>
			<div class="row">
				<div id="title13" class="col-md-2">
					<span id="Label23" data-type="SheetLabel" data-datafield="tb_units" style="">Ͷ�굥λ</span>
				</div>
				<div id="control13" class="col-md-4">
					<input id="Control23" type="text" data-datafield="tb_units" data-type="SheetTextBox" style="">
				</div>
				<div id="title14" class="col-md-2">
					<span id="Label24" data-type="SheetLabel" data-datafield="zb_way" style="">�б귽ʽ</span>
				</div>
				<div id="control14" class="col-md-4">
					<select data-datafield="zb_way" data-type="SheetDropDownList" id="ctl746336" class="" style="" data-masterdatacategory="�б귽ʽ" data-displayemptyitem="true">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title15" class="col-md-2">
					<span id="Label25" data-type="SheetLabel" data-datafield="zb_money" style="">�б�۸�</span>
				</div>
				<div id="control15" class="col-md-4">
					<input id="Control25" type="text" data-datafield="zb_money" data-type="SheetTextBox" style="">
				</div>
				<div id="title16" class="col-md-2">
					<span id="Label26" data-type="SheetLabel" data-datafield="zb_money2" style="">�б�۸�</span>
				</div>
				<div id="control16" class="col-md-4">
					<input id="Control26" type="text" data-datafield="zb_money2" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title17" class="col-md-2">
					<span id="Label27" data-type="SheetLabel" data-datafield="zb_units" style="">�б굥λ</span>
				</div>
				<div id="control17" class="col-md-4">
					<input id="Control27" type="text" data-datafield="zb_units" data-type="SheetTextBox" style="">
				</div>
				<div id="title18" class="col-md-2">
					<span id="Label28" data-type="SheetLabel" data-datafield="zb_scope" style="">�б귶Χ</span>
				</div>
				<div id="control18" class="col-md-4">
					<select data-datafield="zb_scope" data-type="SheetDropDownList" id="ctl342209" class="" style="" data-displayemptyitem="true" data-masterdatacategory="�б귶Χ">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title19" class="col-md-2">
					<span id="Label29" data-type="SheetLabel" data-datafield="agency_fee" style="">������</span>
				</div>
				<div id="control19" class="col-md-4">
					<input id="Control29" type="text" data-datafield="agency_fee" data-type="SheetTextBox" style="">
				</div>
				<div id="title20" class="col-md-2">
					<span id="Label30" data-type="SheetLabel" data-datafield="agency_fee2" style="">������</span>
				</div>
				<div id="control20" class="col-md-4">
					<input id="Control30" type="text" data-datafield="agency_fee2" data-type="SheetTextBox" style="">
				</div>
			</div>
			<div class="row">
				<div id="title21" class="col-md-2">
					<span id="Label31" data-type="SheetLabel" data-datafield="zb_people" style="">�б���</span>
				</div>
				<div id="control21" class="col-md-4">
					<input id="Control31" type="text" data-datafield="zb_people" data-type="SheetTextBox" style="">
				</div>
				<div id="title22" class="col-md-2">
					<span id="Label32" data-type="SheetLabel" data-datafield="objection" style="">�Ƿ�������</span>
				</div>
				<div id="control22" class="col-md-4">
					<select data-datafield="objection" data-type="SheetDropDownList" id="ctl225485" class="" style="" data-masterdatacategory="�Ƿ�" data-displayemptyitem="true">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title23" class="col-md-2">
					<span id="Label33" data-type="SheetLabel" data-datafield="zb_time" style="">�б�֪ͨ��</span>
				</div>
				<div id="control23" class="col-md-4">
					<input id="Control33" type="text" data-datafield="zb_time" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
				<div id="title24" class="col-md-2">
					<span id="Label34" data-type="SheetLabel" data-datafield="zb_time2" style="">�б�֪ͨ��</span>
				</div>
				<div id="control24" class="col-md-4">
					<input id="Control34" type="text" data-datafield="zb_time2" data-type="SheetTime" style="" class="" data-defaultvalue="">
                    <%--<input type="button" class="btn btn-primary " value="��ѯ" onclick="sel_project()">--%>
				</div>
			</div>
             
            <div id="div30546" class="col-md-12 rightBtn" style="text-align: center;">
                    <input id="div30547" type="button" style="padding:3px 10px" onclick="sel_project()" class="btn btn-primary" value="����" />
                </div>
             <div class="myTable">
                  <table data-toggle="table" class="table table-striped table-bordered table-hover" id="project_sel"></table>
            </div>
		</div>
	</div>
    <script src="Project_query.js"></script>
</asp:Content>