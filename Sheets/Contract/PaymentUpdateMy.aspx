﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentUpdateMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.PaymentUpdateMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="PaymentUpdateMy.js"></script>
     <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">信用证改证子流程</label>
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
            <div class="row">
                <div id="title1" class="col-md-2">
                    <span id="Label11" data-type="SheetLabel" data-datafield="ContractNo" style="">合同号</span>
                </div>
                <div id="control1" class="col-md-4">
                    <input id="Control11" type="text" data-datafield="ContractNo" data-type="SheetTextBox" style="">
                </div>
                <div id="title2" class="col-md-2">
                    <span id="Label12" data-type="SheetLabel" data-datafield="ContractName" style="">合同名称</span>
                </div>
                <div id="control2" class="col-md-4">
                    <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="width:70%">
                    <input type="button" onclick="viewContractF()" value="查看合同" class="btn btn-primary" >
                </div>
            </div>
            <div class="row">
                <div id="title3" class="col-md-2">
                    <span id="Label13" data-type="SheetLabel" data-datafield="PostAB" style="">项目负责人AB</span>
                </div>
                <div id="control3" class="col-md-4">
                    <input id="Control13" type="text" data-datafield="PostAB" data-type="SheetTextBox" style="">
                </div>
                <div id="title4" class="col-md-2">
                    <span id="Label14" data-type="SheetLabel" data-datafield="PaymentType" style="">信用证申请类型</span>
                </div>
                <div id="control4" class="col-md-4">
                    <input id="Control14" type="text" data-datafield="PaymentType" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title5" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="PaymentNo" style="">信用证编号</span>
                </div>
                <div id="control5" class="col-md-4">
                    <input id="Control15" type="text" data-datafield="PaymentNo" data-type="SheetTextBox" style="">
                </div>
                <div id="title6" class="col-md-2">
                </div>
                <div id="control6" class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div id="div789183" class="col-md-2">
                    <span id="Label16" data-type="SheetLabel" data-datafield="PaymentAmount" style="" class="">信用证金额</span>
                </div>
                <div id="div73597" class="col-md-2">
                    <input id="Control16" type="text" data-datafield="PaymentAmount" data-type="SheetTextBox" style="" class="">
                </div>
                <div id="div302176" class="col-md-2">
                    <select data-datafield="Currency" data-type="SheetDropDownList" id="ctl719843" class="" style="" data-schemacode="GetWBCurrency" data-querycode="GetWBCurrency" data-filter="ContractNo:ContractNo" data-datavaluefield="c" data-datatextfield="v" data-queryable="false"></select>

                </div>
                <div id="div867991" class="col-md-6">
                    <input id="Control18" type="text" data-datafield="CurrencyChangeFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
            </div>
            <div class="row">
                <div id="title9" class="col-md-2">
                    <span id="Label19" data-type="SheetLabel" data-datafield="Attachment" style="">附件</span>
                </div>
                <div id="control9" class="col-md-10">
                    <input type="text" data-datafield="Attachment" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="Attachment"></div>
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
            <div class="row tableContent ManagerApprove">
                <div id="title13" class="col-md-2">
                    <span id="Label21" data-type="SheetLabel" data-datafield="ManagerSuggest" style="">审批意见</span>
                </div>
                <div id="control13" class="col-md-10">
                    <div id="Control21" data-datafield="ManagerSuggest" data-type="SheetComment" style="">
                    </div>
                </div>
            </div>
            <div class="row tableContent CompanyLeaderApprove">
                <div id="title15" class="col-md-2">
                    <span id="Label22" data-type="SheetLabel" data-datafield="ComanyLeadSuggest" style="">审批意见</span>
                </div>
                <div id="control15" class="col-md-10">
                    <div id="Control22" data-datafield="ComanyLeadSuggest" data-type="SheetComment" style="">
                    </div>
                </div>
            </div>
            <div class="row PaymentOperate">
                <div id="title17" class="col-md-2">
                    <span id="Label23" data-type="SheetLabel" data-datafield="PaymentUpdateDate" style="">改证日期</span>
                </div>
                <div id="control17" class="col-md-4">
                    <input id="Control23" type="text" data-datafield="PaymentUpdateDate" data-type="SheetTime" style="">
                </div>
                <div id="title18" class="col-md-2">
                    <span id="Label24" data-type="SheetLabel" data-datafield="ExpirationDate" style="">信用证到期日</span>
                </div>
                <div id="control18" class="col-md-4">
                    <input id="Control24" type="text" data-datafield="ExpirationDate" data-type="SheetTime" style="" data-onchange=" ExpirationDateChange()">
                </div>
            </div>
            <div class="row PaymentOperate">
                <div id="title19" class="col-md-2">
                    <span id="Label25" data-type="SheetLabel" data-datafield="RemindDate" style="">何时提醒到期</span>
                </div>
                <div id="control19" class="col-md-4">
                    <input id="Control25" type="text" data-datafield="RemindDate" data-type="SheetTime" style="">
                </div>
                <div id="space20" class="col-md-2">
                </div>
                <div id="spaceControl20" class="col-md-4">
                </div>
            </div>
            <div class="row PaymentOperate">
                <div id="title21" class="col-md-2">
                    <span id="Label26" data-type="SheetLabel" data-datafield="PaymentAttachment" style="">信用证副本</span>
                </div>
                <div id="control21" class="col-md-10">
                    <input type="text" data-datafield="PaymentAttachment" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="PaymentAttachment"></div>
                </div>
            </div>
            <div class="row tableContent PaymentOperate">
                <div id="div507309" class="col-md-2">
                    <label data-datafield="OperateRemark" data-type="SheetLabel" id="ctl818667" class="" style="">执行备注</label>
                </div>
                <div id="div203297" class="col-md-10">
                    <div data-datafield="OperateRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                </div>
            </div>
            <div class="row hidden">
                <div id="div76683" class="col-md-2">
                    <input type="text" data-datafield="ChangePaymentFlg" data-type="SheetTextBox" id="ctl967829" class="hidden" style=""></div>
                <div id="div874750" class="col-md-2">
                    <input type="text" data-datafield="PaymentObjectID" data-type="SheetTextBox" id="ctl584749" class="hidden" style=""></div>
                <div id="div571848" class="col-md-2">
                    <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl183594" class="hidden" style=""></div>
                <div id="div470691" class="col-md-2">
                    <input type="text" data-datafield="CurrencyWBCode" data-type="SheetTextBox" id="ctl183594" class="hidden" style="">
                </div>
                <div id="div436947" class="col-md-2">
                    <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div618823" class="col-md-1">
                    <select data-datafield="ChangeDemo" data-type="SheetDropDownList" id="ctl781450" class="hidden" style="" data-masterdatacategory="是" data-queryable="false" data-onchange="ChangeDemo()"></select>
                </div>
                <div id="div562422" class="col-md-1">
                    <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                </div>
            </div>
        </div>
        </div>


        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">信用证改证回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackPaymentUpdateSubTbl" data-type="SheetLabel" id="ctl280690" class="" style="">信用证改证回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackPaymentUpdateSubTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackPaymentUpdateSubTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackPaymentUpdateSubTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackPaymentUpdateSubTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackPaymentUpdateSubTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackPaymentUpdateSubTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackPaymentUpdateSubTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackPaymentUpdateSubTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackPaymentUpdateSubTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackPaymentUpdateSubTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackPaymentUpdateSubTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackPaymentUpdateSubTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackPaymentUpdateSubTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackPaymentUpdateSubTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackPaymentUpdateSubTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackPaymentUpdateSubTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackPaymentUpdateSubTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackPaymentUpdateSubTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackPaymentUpdateSubTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackPaymentUpdateSubTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackPaymentUpdateSubTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackPaymentUpdateSubTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackPaymentUpdateSubTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackPaymentUpdateSubTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackPaymentUpdateSubTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackPaymentUpdateSubTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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

        <div class="ContractContent">
            <label data-en_us="Sheet information">处理记录</label>
            <div class="myTable">
                <table data-toggle="table" class="table table-striped table-bordered table-hover ApprovalTbl"></table>
            </div>
        </div>
    </div>

    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/file2.js"></script>
    <script src="../js/select2.js"></script>
    <script src="../js/ApprovalTbl.js"></script>
</asp:Content>
