<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SEmployeeTurnoverQuery.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SEmployeeTurnoverQuery" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
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
	<label id="lblTitle" class="panel-title">员工离职申请查询</label>
</div>
<div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">

		<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
		</div>
		<div class="divContent" id="divSheet">
			<div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="StaffName" style="">员工姓名</span>
				</div>
				<div id="control1" class="col-md-4">
					<input id="Control11" type="text" data-datafield="StaffName" data-type="SheetTextBox" style="">
				</div>
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Organization" style="">员工部门</span>
				</div>
				<div id="control2" class="col-md-4">
					<select data-datafield="Organization" data-type="SheetDropDownList" id="ctl399580" class="" style="" data-schemacode="SelectAllOrgName" data-querycode="SelectAllOrgName" data-datavaluefield="Name1" data-datatextfield="Name1"  data-displayemptyitem="true" data-emptyitemtext="全部">
					</select>
				</div>
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="ApplicationDateFrom" style="">申请日期From</span>
				</div>
				<div id="control3" class="col-md-4">
					<input id="ApplicationDateFrom" type="text" data-datafield="ApplicationDateFrom" data-type="SheetTime" style="" data-defaultvalue="" onFocus="WdatePicker({ dateFmt: 'yyyy-MM-dd', minDate: '2010-01-01', maxDate: '#F{$dp.$D(\'ApplicationDateTo\')}' })">
				</div>
				<div id="title4" class="col-md-2">
					<span id="Label14" data-type="SheetLabel" data-datafield="ApplicationDateTo" style="">申请日期To</span>
				</div>
				<div id="control4" class="col-md-4">
					<input id="ApplicationDateTo" type="text" data-datafield="ApplicationDateTo" data-type="SheetTime" style="" data-defaultvalue="" onFocus="WdatePicker({ dateFmt: 'yyyy-MM-dd', minDate: '#F{$dp.$D(\'ApplicationDateFrom\')}', maxDate: '2050-12-31' } )" >
				</div>
                 <div id="div30546" class="col-md-1 rightBtn">
                    <input id="EmployeeTurnoverQueryId" type="button" style="padding:3px 10px" onclick="EmployeeTurnoverQuery()" class="btn btn-primary" value="查找" />
                </div>
			</div>
 <!-- 分割线 -->
                <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                </div>

                <div class="myTable">
                    <table data-toggle="table" class="table table-striped table-bordered table-hover" id="table_EmployeeTurnoverQuery"></table>
                </div>

                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
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
     <script src="SEmployeeTurnoverQuery.js"></script>
</asp:Content>