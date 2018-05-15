<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BHMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BHMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BHMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">保函</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent ApplyBH">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">申请</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="div121221" class="col-md-2">
                        <label data-datafield="ContractNo" data-type="SheetLabel" id="ctl891884" class="" style="">合同号</label>
                    </div>
                    <div id="div437584" class="col-md-4">
                        <input type="text" data-datafield="ContractNo" data-type="SheetTextBox" id="ctl979276" class="" style="">
                    </div>
                    <div id="div726490" class="col-md-2"><span id="Label25" data-type="SheetLabel" data-datafield="ContractName" style="" class="">合同名称</span></div>
                    <div id="div739488" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="width:70%">
                        <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                    </div>
                </div>
                <div class="row">
                    <div id="title19" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="PostAB" style="" class="">项目负责人AB</span>
                    </div>
                    <div id="control19" class="col-md-4">
                        <input id="Control26" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="BHTarget2" class="" style="">保函方</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="BHTarget2" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetProjectOfCustomer2" data-querycode="GetProjectOfCustomer2" data-outputmappings="BHTarget:FinalUser"
                            >
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div577754" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="BHType2" class="" style="">保函类型</span>
                    </div>
                    <div id="div784206" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="BHType2" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="div794614" class="col-md-2 BHDiv">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BHNo" class="" style="">保函流水号</span>
                    </div>
                    <div id="div410071" class="col-md-2 normal BHDiv">
                        <input id="Control16" type="text" data-datafield="BHNo" data-type="SheetTextBox" class="" style=""
                           >
                    </div>
                </div>
                <div class="row">
                    <div id="div188333" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="BHProperty2" class="" style="">保函性质</span>
                    </div>
                    <div id="div928290" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="BHProperty2" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div838046" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="ReceiveDate2" class="" style="">接受日期</span>
                    </div>
                    <div id="div2485" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="ReceiveDate2" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div794614" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BHAmount2" class="" style="">保函金额</span>
                    </div>
                    <div id="div410071" class="col-md-2 normal">
                        <input id="Control16" type="text" data-datafield="BHAmount2" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="div228095" class="col-md-2 normal">
                        <input id="Control16" type="text" data-datafield="Currency2" data-type="SheetTextBox" class="" style="">
                    </div>
                </div>
                <%--<div class="row tableContent BZJDiv">
                    <div id="title9" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="BHReceiptTbl2" style="display: block">收据子表</span>
                    </div>
                    <div id="control9" class="col-md-10">

                        <table id="ctl577511" data-datafield="BHReceiptTbl2" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-defaultrowcount="0" data-displaysequenceno="false"
                            >
                            <tbody>
                                <tr class="header">
                                    <td id="ctl577511_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl577511_header0" data-datafield="BHReceiptTbl2.ReceiptNo" style="">
                                        <label id="ctl577511_Label0" data-datafield="BHReceiptTbl2.ReceiptNo" data-type="SheetLabel" style="">收据编号</label></td>
                                    <td id="ctl577511_header1" data-datafield="BHReceiptTbl2.PayTarget" style="">
                                        <label id="ctl577511_Label1" data-datafield="BHReceiptTbl2.PayTarget" data-type="SheetLabel" style="">交款单位</label></td>
                                    <td id="ctl577511_header2" data-datafield="BHReceiptTbl2.Amount" style="">
                                        <label id="ctl577511_Label2" data-datafield="BHReceiptTbl2.Amount" data-type="SheetLabel" style="">金额</label></td>
                                    <td id="ctl577511_header3" data-datafield="BHReceiptTbl2.Currency" style="">
                                        <label id="ctl577511_Label3" data-datafield="BHReceiptTbl2.Currency" data-type="SheetLabel" style="">币种</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl577511_control0" data-datafield="BHReceiptTbl2.ReceiptNo" style="">
                                        <input type="text" data-datafield="BHReceiptTbl2.ReceiptNo" data-type="SheetTextBox" id="ctl577511_control0" style=""></td>
                                    <td id="ctl577511_control1" data-datafield="BHReceiptTbl2.PayTarget" style="">
                                        <input type="text" data-datafield="BHReceiptTbl2.PayTarget" data-type="SheetTextBox" id="ctl577511_control1" style=""></td>
                                    <td id="ctl577511_control2" data-datafield="BHReceiptTbl2.Amount" style="">
                                        <input type="text" data-datafield="BHReceiptTbl2.Amount" data-type="SheetTextBox" id="ctl577511_control2" style=""></td>
                                    <td id="ctl577511_control3" data-datafield="BHReceiptTbl2.Currency" style="">
                                        <input type="text" data-datafield="BHReceiptTbl2.Currency" data-type="SheetTextBox" id="ctl577511_control3" style=""></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl577511_Stat0" data-datafield="BHReceiptTbl2.ReceiptNo" style=""></td>
                                    <td id="ctl577511_Stat1" data-datafield="BHReceiptTbl2.PayTarget" style=""></td>
                                    <td id="ctl577511_Stat2" data-datafield="BHReceiptTbl2.Amount" style="">
                                        <label id="ctl577511_StatControl2" data-datafield="BHReceiptTbl2.Amount" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td id="ctl577511_Stat3" data-datafield="BHReceiptTbl2.Currency" style=""></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>--%>
                <div class="row BHDiv">
                    <div id="title11" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="BHGDQX2" style="">保函固定期限</span>
                    </div>
                    <div id="control11" class="col-md-4">

                        <select data-datafield="BHGDQX2" data-type="SheetDropDownList" id="ctl216457" class="" style="" data-defaultitems="有;无"  data-queryable="false"></select>
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div651719" class="col-md-2 BHDiv">
                        <span id="Label20" data-type="SheetLabel" data-datafield="ExpirationDate2" class="" style="">保函到期日</span>
                    </div>
                    <div id="div452353" class="col-md-4 BHDiv">
                        <input id="Control20" type="text" data-datafield="ExpirationDate2" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                    <div id="div588509" class="col-md-2">
                        <span id="Label22" data-type="SheetLabel" data-datafield="ReturnAmountDate2" class="" style="">预计退款日期</span>
                    </div>
                    <div id="div825017" class="col-md-4">
                        <input id="Control22" type="text" data-datafield="ReturnAmountDate2" data-type="SheetTime" class="" style="" data-defaultvalue="">
                    </div>
                </div>
                <div class="row BHDiv">
                    <div id="title13" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="RemindDate2" style="">何时提醒到期</span>
                    </div>
                    <div id="control13" class="col-md-4">
                        <input id="Control21" type="text" data-datafield="RemindDate2" data-type="SheetTime" style="" data-defaultvalue="">
                    </div>
                    <div id="title14" class="col-md-6">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ApproveRemark2" data-type="SheetLabel" id="ctl818667" class="" style="">申请备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <textarea id="Control29" data-datafield="ApproveRemark2" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title17" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="Attachment2" style="display:block">附件</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <input type="text" data-datafield="Attachment2" data-type="SheetTextBox" id="ctl697315" class="hidden" style="">
                        <div id="Attachment2"></div>
                    </div>
                </div>
                <div class="row">
                    <div id="title21" class="col-md-2">
                        <span id="Label27" data-type="SheetLabel" data-datafield="TBType" style="">退保类型</span>
                    </div>
                    <div id="control21" class="col-md-4">
                        <select data-datafield="TBType" data-type="SheetDropDownList" id="ctl453820" class="" style="" data-masterdatacategory="退保类型"  data-queryable="false"
                             data-onchange="TBTypeChange()"></select>
                    </div>
                </div>
                <div class="row TBDiv">
                    <div id="div606915" class="col-md-2"><span id="Label31" data-type="SheetLabel" data-datafield="Receiver" style="" class="">收款人</span></div>
                    <div id="div560521" class="col-md-4">
                        <select data-datafield="Receiver" data-type="SheetDropDownList" id="ctl705726" class="" style="" data-schemacode="GetContactsByContractNo" data-querycode="GetContactsByContractNo" data-filter="ContractNo:ContractNo" data-datavaluefield="ContactName" data-datatextfield="ContactName" data-queryable="false"></select>
                    </div>
                                        <div id="div382550" class="col-md-2"><span id="Label29" data-type="SheetLabel" data-datafield="BankAccount" style="" class="">账号</span></div>
                    <div id="div818823" class="col-md-4">
                        <input id="Control29" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row TBDiv">
                    <div id="div100896" class="col-md-2"><span id="Label30" data-type="SheetLabel" data-datafield="BankName" style="" class="">开户银行</span></div>
                    <div id="div858909" class="col-md-4">
                        <input id="Control30" type="text" data-datafield="BankName" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title26" class="col-md-2">
                        <span id="Label32" data-type="SheetLabel" data-datafield="PayAttachment" style="" class="">支付凭证</span>
                    </div>
                    <div id="control26" class="col-md-4">
                        <input type="text" data-datafield="PayAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="PayAttachment"></div>
                    </div>
                </div>
                
                <div class="row">
                    <div id="div896434" class="col-md-2"><span id="Label28" data-type="SheetLabel" data-datafield="TBApproveComment" style="" class="">退保说明</span></div>
                    <div id="div675332" class="col-md-10">
                        <div data-datafield="TBApproveComment" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="ContractContent ApplyBH">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">申请</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">

                <div class="row">
                    <div id="div121221" class="col-md-2">
                        <label data-datafield="ContractNo" data-type="SheetLabel" id="ctl891884" class="" style="">合同号</label>
                    </div>
                    <div id="div437584" class="col-md-4">
                        <input type="text" data-datafield="ContractNo" data-type="SheetTextBox" id="ctl979276" class="" style="">
                    </div>
                    <div id="div726490" class="col-md-2"><span id="Label25" data-type="SheetLabel" data-datafield="ContractName" style="" class="">合同名称</span></div>
                    <div id="div739488" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="width:70%">
                        <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                    </div>
                </div>
                <div class="row">
                    <div id="title19" class="col-md-2">

                        <span id="Label26" data-type="SheetLabel" data-datafield="PostAB" style="" class="">项目负责人AB</span>
                    </div>
                    <div id="control19" class="col-md-4">

                        <input id="Control26" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="title20" class="col-md-2">

                        <label data-datafield="BHType2" data-type="SheetLabel" id="ctl848218" class="" style="">保函类型</label>
                    </div>
                    <div id="control20" class="col-md-4">

                        <input type="text" data-datafield="BHType2" data-type="SheetTextBox" id="ctl716018" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="div632426" class="col-md-2">
                        <label data-datafield="BHProperty2" data-type="SheetLabel" id="ctl248320" class="" style="">保函性质</label>
                    </div>
                    <div id="div413950" class="col-md-4">
                        <input type="text" data-datafield="BHProperty2" data-type="SheetTextBox" id="ctl262340" class="" style="">
                    </div>
                    <div id="div356344" class="col-md-2">
                        <label data-datafield="ReceiveDate2" data-type="SheetLabel" id="ctl842166" class="" style="">接受日期</label>
                    </div>
                    <div id="div728286" class="col-md-4">
                        <input type="text" data-datafield="ReceiveDate2" data-type="SheetTime" id="ctl157549" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="div253546" class="col-md-2">
                        <label data-datafield="BHAmount2" data-type="SheetLabel" id="ctl54063" class="" style="">保函金额</label>
                    </div>
                    <div id="div832832" class="col-md-4">
                        <input type="text" data-datafield="BHAmount2" data-type="SheetTextBox" id="ctl79374" class="" style="">
                    </div>
                    <div id="div492390" class="col-md-2">
                        <label data-datafield="ExpirationDate2" data-type="SheetLabel" id="ctl723279" class="" style="">保函到期日</label>
                    </div>
                    <div id="div219601" class="col-md-4">
                        <input type="text" data-datafield="ExpirationDate2" data-type="SheetTime" id="ctl282695" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title21" class="col-md-2">
                        <span id="Label27" data-type="SheetLabel" data-datafield="TBType" style="">退保类型</span>
                    </div>
                    <div id="control21" class="col-md-4">

                        <select data-datafield="TBType" data-type="SheetDropDownList" id="ctl453820" class="" style="" data-masterdatacategory="退保类型"  data-queryable="false"></select>
                    </div>
                    <div id="space22" class="col-md-2">
                        <label data-datafield="BHTarget2" data-type="SheetLabel" id="ctl258176" class="" style="">保函方</label>
                    </div>
                    <div id="spaceControl22" class="col-md-4">
                        <input type="text" data-datafield="BHTarget2" data-type="SheetTextBox" id="ctl782562" class="" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="div985232" class="col-md-2">
                        <label data-datafield="Remark2" data-type="SheetLabel" id="ctl610509" class="" style="">备注</label>
                    </div>
                    <div id="div404953" class="col-md-4">
                        <textarea data-datafield="Remark2" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl56691" class=""></textarea>
                    </div>
                    <div id="div606915" class="col-md-2"><span id="Label31" data-type="SheetLabel" data-datafield="Receiver" style="" class="">受款人</span></div>
                    <div id="div560521" class="col-md-4">
                        <select data-datafield="Receiver" data-type="SheetDropDownList" id="ctl705726" class="" style="" data-schemacode="GetContactsByContractNo" data-querycode="GetContactsByContractNo" data-filter="ContractNo:ContractNo" data-datavaluefield="ContactName" data-datatextfield="ContactName" data-queryable="false"></select>
                    </div>
                    
                </div>
                <div class="row">
                    <div id="div583093" class="col-md-2">
                        <label data-datafield="AttachmentFile" data-type="SheetLabel" id="ctl115757" class="" style="display:block">附件</label>
                    </div>
                    <div id="div133080" class="col-md-4">*参照录保中附件</div>
                    <div id="div382550" class="col-md-2"><span id="Label29" data-type="SheetLabel" data-datafield="BankAccount" style="" class="">账号</span></div>
                    <div id="div818823" class="col-md-4">
                        <input id="Control29" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="" class="">
                    </div>
                    
                </div>
                <div class="row">
                    <div id="div896434" class="col-md-2"><span id="Label28" data-type="SheetLabel" data-datafield="TBRemark" style="" class="">退保说明</span></div>
                    <div id="div675332" class="col-md-4">
                        <textarea id="Control28" data-datafield="TBRemark" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                    <div id="div100896" class="col-md-2"><span id="Label30" data-type="SheetLabel" data-datafield="BankName" style="" class="">开户银行</span></div>
                    <div id="div858909" class="col-md-4">
                        <input id="Control30" type="text" data-datafield="BankName" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="title25" class="col-md-2">
                    </div>
                    <div id="control25" class="col-md-4">
                    </div>
                    <div id="title26" class="col-md-2">

                        <span id="Label32" data-type="SheetLabel" data-datafield="PayAttachment" style="" class="">支付凭证</span>
                    </div>
                    <div id="control26" class="col-md-4">
                        <input type="text" data-datafield="PayAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="PayAttachment"></div>
                    </div>
                </div>

            </div>
        </div>--%>

        <div class="ContractContent ApproveBH">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">审批</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div id="title31" class="col-md-2">
                        <span id="Label33" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control31" class="col-md-10">
                        <div id="Control33" data-datafield="ManagerComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>

                <div class="row tableContent">
                    <div id="title33" class="col-md-2">
                        <span id="Label34" data-type="SheetLabel" data-datafield="CompanyLeaderComment" style="">公司领导审批意见</span>
                    </div>
                    <div id="control33" class="col-md-10">
                        <div id="Control34" data-datafield="CompanyLeaderComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>

            </div>
        </div>


        <div class="ContractContent ConfirmBH">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information" class="">确认退保</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title35" class="col-md-2">
                        <span id="Label35" data-type="SheetLabel" data-datafield="IsConfirmTB" style="">确认退保</span>
                    </div>
                    <div id="control35" class="col-md-4">
                        <div data-datafield="IsConfirmTB" data-type="SheetCheckboxList" id="ctl638325" class="" style="" data-defaultitems="是" data-repeatcolumns="1"></div>
                    </div>
                    <div id="title36" class="col-md-2">
                    </div>
                    <div id="control36" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div548777" class="col-md-2"><span id="Label36" data-type="SheetLabel" data-datafield="TBDate" style="" class="">退保日期</span></div>
                    <div id="div12950" class="col-md-4">
                        <input id="Control36" type="text" data-datafield="TBDate" data-type="SheetTime" style="" class="">
                    </div>
                    <div id="div31261" class="col-md-2"></div>
                    <div id="div916232" class="col-md-4"></div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="TBConfirmRemark" data-type="SheetLabel" id="ctl818667" class="" style="">退保备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="TBConfirmRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div139843" class="col-md-1">
                        <input type="text" data-datafield="CurrencyChangeFlg" data-type="SheetTextBox" id="ctl587537" class="hidden" style="">
                    </div>
                    <div id="div84396" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl740256" class="hidden" style="">
                    </div>
                    <div id="div190277" class="col-md-1">
                        <input type="text" data-datafield="BHFlg" data-type="SheetTextBox" id="ctl270578" class="hidden" style="">
                    </div>
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
                    <div id="div456889" class="col-md-1">
                        <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div57941" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div719163" class="col-md-1">
                        <input type="text" data-datafield="PostA" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                    <div id="div361357" class="col-md-1">
                        <input type="text" data-datafield="PostB" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                    <div id="div277222" class="col-md-1">
                        <input type="text" data-datafield="InputBizObjectID" data-type="SheetTextBox" id="ctl217905" class="hidden" style="">
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">保函回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackBHTbl" data-type="SheetLabel" id="ctl280690" class="" style="">保函回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackBHTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackBHTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackBHTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackBHTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackBHTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackBHTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackBHTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackBHTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackBHTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackBHTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackBHTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackBHTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackBHTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackBHTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackBHTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackBHTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackBHTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackBHTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackBHTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackBHTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackBHTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackBHTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackBHTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackBHTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackBHTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackBHTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackBHTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
                                    <td class="rowOption hidden"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/file2.js"></script>
    <script src="../js/select2.js"></script>
</asp:Content>
