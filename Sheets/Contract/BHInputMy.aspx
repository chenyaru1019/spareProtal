<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BHInputMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BHInputMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BHInputMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">保函录保</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent NewBH">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">录保</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="BHTarget" class="" style="">保函方</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="BHTarget" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetProjectOfCustomer2" data-querycode="GetProjectOfCustomer2" data-outputmappings="BHTarget:FinalUser"
                            >
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div577754" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="BHType" class="" style="">保函类型</span>
                    </div>
                    <div id="div784206" class="col-md-4">
                        <select data-datafield="BHType" data-type="SheetDropDownList" id="ctl26628" class="" style="" data-masterdatacategory="保函类型"
                            data-onchange="BHTypeChange()"  data-queryable="false">
                        </select>
                    </div>
                    <div id="div794614" class="col-md-2 BHNo">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BHNo" class="" style="">保函流水号</span>
                    </div>
                    <div id="div410071" class="col-md-2 normal BHNo">
                        <input id="Control16" type="text" data-datafield="BHNo" data-type="SheetTextBox" class="" style=""
                           >
                    </div>
                </div>
                <div class="row">
                    <div id="div188333" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="BHProperty" class="" style="">保函性质</span>
                    </div>
                    <div id="div928290" class="col-md-4">

                        <select data-datafield="BHProperty" data-type="SheetDropDownList" id="ctl126394" class="" style="" data-masterdatacategory="保函性质"
                             data-queryable="false">
                        </select>
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div838046" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="ReceiveDate" class="" style="">接受日期</span>
                    </div>
                    <div id="div2485" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="ReceiveDate" data-type="SheetTime" class="" style="" data-defaultvalue=""
                           >
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div794614" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BHAmount" class="" style="">保函金额</span>
                    </div>
                    <div id="div410071" class="col-md-2 normal">
                        <input id="Control16" type="text" data-datafield="BHAmount" data-type="SheetTextBox" class="" style=""
                           >
                    </div>
                    <div id="div228095" class="col-md-2 normal">
                        <select data-datafield="Currency" data-type="SheetDropDownList" id="ctl719843" class="" style="" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-queryable="false"></select>
                    </div>
                    <div id="title14" class="col-md-6">
                        <input type="text" data-datafield="LoadRept" data-type="SheetTextBox" id="ctl387023" class="hidden" style="" data-schemacode="GetRept" data-querycode="GetRept" data-outputmappings="ReceiptNoHidden:ReceiptNo,PayTargetHidden:PayTarget,AmountHidden:Amount,CurrencyHidden:Currency" data-popupwindow="PopupWindow" data-displaytext="添加收据">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title9" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="BHReceiptTbl" style="">收据子表</span>
                    </div>
                    <div id="control9" class="col-md-10">

                        <table id="ctl577511" data-datafield="BHReceiptTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-defaultrowcount="0" data-displaysequenceno="false"
                            data-onpreremove="rowPreRemoved(this,arguments);">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl577511_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl577511_header0" data-datafield="BHReceiptTbl.ReceiptNo" style="">
                                        <label id="ctl577511_Label0" data-datafield="BHReceiptTbl.ReceiptNo" data-type="SheetLabel" style="">收据编号</label></td>
                                    <td id="ctl577511_header1" data-datafield="BHReceiptTbl.PayTarget" style="">
                                        <label id="ctl577511_Label1" data-datafield="BHReceiptTbl.PayTarget" data-type="SheetLabel" style="">交款单位</label></td>
                                    <td id="ctl577511_header2" data-datafield="BHReceiptTbl.Amount" style="">
                                        <label id="ctl577511_Label2" data-datafield="BHReceiptTbl.Amount" data-type="SheetLabel" style="">金额</label></td>
                                    <td id="ctl577511_header3" data-datafield="BHReceiptTbl.Currency" style="">
                                        <label id="ctl577511_Label3" data-datafield="BHReceiptTbl.Currency" data-type="SheetLabel" style="">币种</label></td>
                                    <td id="ctl577511_header4" data-datafield="BHReceiptTbl.Operate" style="">
                                        <label id="ctl577511_Label4" data-datafield="BHReceiptTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl577511_control0" data-datafield="BHReceiptTbl.ReceiptNo" style="">
                                        <input type="text" data-datafield="BHReceiptTbl.ReceiptNo" data-type="SheetTextBox" id="ctl577511_control0" style=""></td>
                                    <td id="ctl577511_control1" data-datafield="BHReceiptTbl.PayTarget" style="">
                                        <input type="text" data-datafield="BHReceiptTbl.PayTarget" data-type="SheetTextBox" id="ctl577511_control1" style=""></td>
                                    <td id="ctl577511_control2" data-datafield="BHReceiptTbl.Amount" style="">
                                        <input type="text" data-datafield="BHReceiptTbl.Amount" data-type="SheetTextBox" id="ctl577511_control2" style=""></td>
                                    <td id="ctl577511_control3" data-datafield="BHReceiptTbl.Currency" style="">
                                        <input type="text" data-datafield="BHReceiptTbl.Currency" data-type="SheetTextBox" id="ctl577511_control3" style=""></td>
                                    <td id="ctl577511_control4" data-datafield="BHReceiptTbl.Operate" style="">
                                        <a class="btn btn-primary" onclick="">查看</a></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl577511_Stat0" data-datafield="BHReceiptTbl.ReceiptNo" style=""></td>
                                    <td id="ctl577511_Stat1" data-datafield="BHReceiptTbl.PayTarget" style=""></td>
                                    <td id="ctl577511_Stat2" data-datafield="BHReceiptTbl.Amount" style="">
                                        <label id="ctl577511_StatControl2" data-datafield="BHReceiptTbl.Amount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td id="ctl577511_Stat3" data-datafield="BHReceiptTbl.Currency" style=""></td>
                                    <td id="ctl577511_Stat4" data-datafield="BHReceiptTbl.Operate" style=""></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="BHGDQX" style="">保函固定期限</span>
                    </div>
                    <div id="control11" class="col-md-4">

                        <select data-datafield="BHGDQX" data-type="SheetDropDownList" id="ctl216457" class="" style="" data-defaultitems="有;无"  data-queryable="false"></select>
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div651719" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="ExpirationDate" class="" style="">保函到期日</span>
                    </div>
                    <div id="div452353" class="col-md-4">
                        <input id="Control20" type="text" data-datafield="ExpirationDate" data-type="SheetTime" class="" style="" data-defaultvalue=""
                            data-onchange="ExpirationDateChange()">
                    </div>
                    <div id="div588509" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="ReturnAmountDate" class="" style="">预计退款日期</span>
                    </div>
                    <div id="div825017" class="col-md-4">
                        <input id="Control22" type="text" data-datafield="ReturnAmountDate" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row">
                    <div id="title13" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="RemindDate" style="">何时提醒到期</span>
                    </div>
                    <div id="control13" class="col-md-4">
                        <input id="Control21" type="text" data-datafield="RemindDate" data-type="SheetTime" style="" data-defaultvalue="">
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">申请备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="title17" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="Attachment2" style="display:block">附件</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <input type="text" data-datafield="Attachment" data-type="SheetTextBox" id="ctl697315" class="hidden" style="">
                        <div id="Attachment"></div>
                    </div>
                </div>

                 <div class="row hidden">
                     <div id="div828030" class="col-md-1">
                        <input type="text" data-datafield="ReceiptNoHidden" data-type="SheetTextBox" id="ctl48600" class="hidden" style="">
                    </div>
                    <div id="div746660" class="col-md-1">
                        <input type="text" data-datafield="PayTargetHidden" data-type="SheetTextBox" id="ctl313324" class="hidden" style="">
                    </div>
                    <div id="div86935" class="col-md-1">
                        <input type="text" data-datafield="AmountHidden" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                    <div id="div652520" class="col-md-1">
                        <input type="text" data-datafield="CurrencyHidden" data-type="SheetTextBox" id="ctl562550" class="hidden" style=""
                            data-onchange=" CurrencyHiddenChange()">
                    </div>
                    <div id="div719163" class="col-md-1">
                        <input type="text" data-datafield="PostA" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                    <div id="div361357" class="col-md-1">
                        <input type="text" data-datafield="PostB" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                    <div id="div277222" class="col-md-1">
                        <input type="text" data-datafield="ContractNo" data-type="SheetTextBox" id="ctl979276" class="hidden" style="">
                    </div>
                </div>

            </div>
        </div>

    </div>

    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/file2.js"></script>
    <script src="../js/select2.js"></script>
</asp:Content>
