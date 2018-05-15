<%@ Page Language="C#" AutoEventWireup="true" CodeFile="My_project.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.My_project" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">

</script>
    <style type="text/css">
        #ctl713226 div{
            width:25%!important;
        }
    </style>
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
	<label id="lblTitle" class="panel-title">�ҵ���Ŀ</label>
</div>
<div class="panel-body sheetContainer">
		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">����Ϣ</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<%--<div id="title1" class="col-md-0">
					<span id="Label11" data-type="SheetLabel" data-datafield="Project_sel" style="">��Ŀѡ��</span>
				</div>--%>
				<div id="control1" class="col-md-4">
					
				<div data-datafield="Project_sel" data-type="SheetRadioButtonList" id="ctl979819" class="" style="" data-defaultitems="�ҵ���Ŀ;��ְ��Ŀ;ȫ��"></div></div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Project_state" style="">��Ŀ״̬</span>
				</div>
				<div id="control2" class="col-md-6">
					
				<div data-datafield="Project_state" data-type="SheetCheckboxList" id="ctl713226" class="" style="" data-defaultitems='������Ŀ;�б�׼��;���귢��;����;�б��˱��鵵;�鵵��β;��Ŀ���'></div></div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="Project_role" style="">�ҵĽ�ɫ</span>
				</div>
				<div id="control3" class="col-md-4">
					
				<select data-datafield="Project_role" data-type="SheetDropDownList" id="ctl639314" class="" style="" data-defaultitems="����A��;����B��;ȫ��" data-displayemptyitem="true"></select></div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="bids_code" style="">�б����</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="Control14" type="text" data-datafield="bids_code" data-type="SheetTextBox" style="" class="">
				</div>
			</div>
			<div class="row">
				<div id="title5" class="col-md-2">
					<span id="Label15" data-type="SheetLabel" data-datafield="zb_advice2" style="">�б�֪ͨ��</span>
				</div>
				<div id="control5" class="col-md-4">
					<input id="Control15" type="text" data-datafield="zb_advice2" data-type="SheetTime" style="" class="" data-defaultvalue="">
				</div>
				<div id="title6" class="col-md-2">
					<span id="Label16" data-type="SheetLabel" data-datafield="zb_advice" style="">�б�֪ͨ��</span>
				</div>
				<div id="control6" class="col-md-4">
					<input id="Control16" type="text" data-datafield="zb_advice" data-type="SheetTime" style="" class="" data-defaultvalue="">
                   <%-- <input type="button" class="btn btn-primary " value="��ѯ" onclick="sel_project()">--%>
				</div>
			</div>
            <%--<div class="row">--%>
                <div id="div30546" class="col-md-12 rightBtn" style="text-align: center;">
                    <input id="div30547" type="button" style="padding:3px 10px" onclick="sel_project()" class="btn btn-primary" value="����" />
                </div>
           <%-- </div>--%>
            <div class="myTable">
                  <table data-toggle="table" class="table table-striped table-bordered table-hover" id="My_project"></table>
            </div>
		</div>
	</div>
    <script src="My_project.js"></script>
    	<script type="text/javascript">
            $(document).ready(function () {
                $("#control2 input[type='checkbox']").click(function () {
                    alert(222);
                    //console.log(this > div > input[type = 'checkbox']);
                    //$("#control2 div input[type='checkbox']").attr("checked", false);
                    //$(this).attr("checked", true);
                    //$("#control2 div input[type='checkbox']").not(this).attr("checked", false);
                    //if ($(this).attr("value") == "true") {
                    //    $(":checkbox").not($(this)).attr("checked", "checked");
                    //}
                    //if ($("#control2 div input[type='checkbox']").attr("checked") == true) {
                    //    $("#control2 div input[type='checkbox']").attr("checked", false);
                    //    $(this).attr("checked", true);
                    //}
                    //$('#control2').find('input[type=checkbox]').bind('click', function () {
                    //    alert(23424);
                    //    $('#control2').find('input[type=checkbox]').not(this).attr("checked", false);
                    //});
                });
            });  
</script>
</asp:Content>