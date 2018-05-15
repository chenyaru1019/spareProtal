<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectionExperts.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SelectionExperts" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>
<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
	<script type="text/javascript">
       
    </script>
    <script src="SelectionExperts.js"></script>
    <link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" href="SelectionExperts.css"/>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
   
<div class="panel-body sheetContainer">

     <div id="ShowSelectResultWindow" class="modal fade in" tabindex="-1" role="dialog"  style="display: none;">
     <div class="modal-dialog">
     <div class="modal-content" style="width:600px;">
     <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" onclick="CloseWindow()">
     <span aria-hidden="true">&times;</span></button>
     <h4 class="modal-title">专家抽取结果 </h4>
     </div><div class="modal-body">
     <iframe id="frm_2" src="/Portal/Sheets/ExpertDatabase/ExtractTheFruitProcess.html" scrolling="no" frameborder="0" width="100%" height="500px">




     </iframe>
     </div></div></div></div>
		<!--<div class="nav-icon fa  fa-chevron-right bannerTitle">
			<label id="divSheetInfo" data-en_us="Sheet information">抽取专家</label>
		</div>-->
		<div class="divContent" id="divSheet">
            <div class="row">
				<div id="title1" class="col-md-2">
					<span id="Label11" data-type="SheetLabel" data-datafield="ProfessionalField" style="">专业领域</span>
				</div>
				<div id="control1" class="col-md-10">
					
				<select data-datafield="ProfessionalField" data-type="SheetDropDownList" id="ctl319324" class="" style="" data-masterdatacategory="专家的专业领域"></select></div>
				
			</div>
			<div class="row">
				<div id="title2" class="col-md-2">
					<span id="Label12" data-type="SheetLabel" data-datafield="Region" style="">地区</span>
				</div>
				<div id="control2" class="col-md-4">	
				    <select data-datafield="Region" data-type="SheetDropDownList" id="ctl850181" class="" style="" data-masterdatacategory="地区">
				    </select>
				</div>
			
			</div>
			<div class="row">
				<div id="title3" class="col-md-2">
					<span id="Label13" data-type="SheetLabel" data-datafield="NumberOfPeople" style="">人数</span>
				</div>
				<div id="control3" class="col-md-10">
					<input id="Control13" type="text" data-datafield="NumberOfPeople" data-type="SheetTextBox" style="">
				</div>
			</div>
         
			
            <div style="text-align: center;">
	           <input type="button" onclick="Selection()" value="确定"/>
               <input type="button" onclick="closedWindow()" value="取消"/>
            </div>
		</div>
        
	</div>
</asp:Content>