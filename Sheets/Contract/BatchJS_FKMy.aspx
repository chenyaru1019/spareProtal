﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchJS_FKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchJS_FKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BatchJS_FKMy.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">批量付款流程</label>
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
                        <span id="Label11" data-type="SheetLabel" data-datafield="Content" style="">支付内容</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="Content" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row BatchJSTblOfFK">
                    <div id="title1" class="col-md-12">
                        <span id="Label21" data-type="SheetLabel" data-datafield="BatchJSTblOfFK" style="">批量结算记录</span>
                    </div>
                </div>
                <div class="row tableContent BatchJSTblOfFK">
                    <div id="control15" class="col-md-12">
                        <table id="Control21" data-datafield="BatchJSTblOfFK" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control21_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control21_Header3" data-datafield="BatchJSTblOfFK.ContractNo">
                                        <label id="Control21_Label3" data-datafield="BatchJSTblOfFK.ContractNo" data-type="SheetLabel" style="">合同号</label>
                                    </td>
                                    <td id="Control21_Header4" data-datafield="BatchJSTblOfFK.ContractName">
                                        <label id="Control21_Label4" data-datafield="BatchJSTblOfFK.ContractName" data-type="SheetLabel" style="">合同名称</label>
                                    </td>
                                    <td id="Control21_Header5" data-datafield="BatchJSTblOfFK.PostAB">
                                        <label id="Control21_Label5" data-datafield="BatchJSTblOfFK.PostAB" data-type="SheetLabel" style="">负责人</label>
                                    </td>
                                    <td id="Control21_Header6" data-datafield="BatchJSTblOfFK.DKAmount">
                                        <label id="Control21_Label6" data-datafield="BatchJSTblOfFK.DKAmount" data-type="SheetLabel" style="">到账金额</label>
                                    </td>
                                    <td id="Control21_Header7" data-datafield="BatchJSTblOfFK.FKAmount">
                                        <label id="Control21_Label7" data-datafield="BatchJSTblOfFK.FKAmount" data-type="SheetLabel" style="">支付金额</label>
                                    </td>
                                    <td id="Control21_Header8" data-datafield="BatchJSTblOfFK.BankFY">
                                        <label id="Control21_Label8" data-datafield="BatchJSTblOfFK.BankFY" data-type="SheetLabel" style="">银行费用</label>
                                    </td>
                                    <td id="Control21_Header9" data-datafield="BatchJSTblOfFK.AgencyFY">
                                        <label id="Control21_Label9" data-datafield="BatchJSTblOfFK.AgencyFY" data-type="SheetLabel" style="">代理费</label>
                                    </td>
                                    <td id="Control21_Header10" data-datafield="BatchJSTblOfFK.OtherFY">
                                        <label id="Control21_Label10" data-datafield="BatchJSTblOfFK.OtherFY" data-type="SheetLabel" style="">其他费用</label>
                                    </td>
                                    <td id="Control21_Header11" data-datafield="BatchJSTblOfFK.JSResult" class="">
                                        <label id="Control21_Label11" data-datafield="BatchJSTblOfFK.JSResult" data-type="SheetLabel" style="">结算结果</label>
                                    </td>
                                    <td id="Control21_Header12" data-datafield="BatchJSTblOfFK.Operate">
                                        <label id="Control21_Label12" data-datafield="BatchJSTblOfFK.Operate" data-type="SheetLabel" style="">操作</label>
                                    </td>
                                    <td id="Control21_Header13" data-datafield="BatchJSTblOfFK.WorkItemId" class="hidden">
                                        <label id="Control21_Label13" data-datafield="BatchJSTblOfFK.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label>
                                    </td>
                                    <td id="Control21_Header14" data-datafield="BatchJSTblOfFK.Cnt" class="hidden">
                                        <label id="Control21_Label14" data-datafield="BatchJSTblOfFK.Cnt" data-type="SheetLabel" style="">合并数量</label>
                                    </td>
                                    <td id="Control21_Header15" data-datafield="BatchJSTblOfFK.ContractNoHidden" class="hidden">
                                        <label id="Control21_Label15" data-datafield="BatchJSTblOfFK.ContractNoHidden" data-type="SheetLabel" style="">合同号Hidden</label>
                                    </td>
                                    <td id="Control21_Header16" data-datafield="BatchJSTblOfFK.JSObjectID" class="hidden">
                                        <label id="Control21_Label16" data-datafield="BatchJSTblOfFK.JSObjectID" data-type="SheetLabel" style="" class="">JSObjectID</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control21_Option" class="rowOption"></td>
                                    <td data-datafield="BatchJSTblOfFK.ContractNo">
                                        <input id="Control21_ctl3" type="text" data-datafield="BatchJSTblOfFK.ContractNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.ContractName">
                                        <input id="Control21_ctl4" type="text" data-datafield="BatchJSTblOfFK.ContractName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.PostAB">
                                        <input id="Control21_ctl5" type="text" data-datafield="BatchJSTblOfFK.PostAB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.DKAmount">
                                        <input id="Control21_ctl6" type="text" data-datafield="BatchJSTblOfFK.DKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.FKAmount">
                                        <input id="Control21_ctl7" type="text" data-datafield="BatchJSTblOfFK.FKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.BankFY">
                                        <input id="Control21_ctl8" type="text" data-datafield="BatchJSTblOfFK.BankFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.AgencyFY">
                                        <input id="Control21_ctl9" type="text" data-datafield="BatchJSTblOfFK.AgencyFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.OtherFY">
                                        <input id="Control21_ctl10" type="text" data-datafield="BatchJSTblOfFK.OtherFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.JSResult">
                                        <input id="Control21_ctl11" type="text" data-datafield="BatchJSTblOfFK.JSResult" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.Operate">
                                        <a class="btn btn-primary viewJS" onclick="viewJS(this)">查看</a>
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.WorkItemId" class="hidden">
                                        <input id="Control21_ctl13" type="text" data-datafield="BatchJSTblOfFK.WorkItemId" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.Cnt" class="hidden">
                                        <input id="Control21_ctl14" type="text" data-datafield="BatchJSTblOfFK.Cnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.ContractNoHidden" class="hidden">
                                        <input id="Control21_ctl15" type="text" data-datafield="BatchJSTblOfFK.ContractNoHidden" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfFK.JSObjectID" class="hidden">
                                        <input id="Control21_ctl16" type="text" data-datafield="BatchJSTblOfFK.JSObjectID" data-type="SheetTextBox" style="">
                                    </td>
                                    <td class="rowOption hidden">
                                        <a class="delete">
                                            <div class="fa fa-minus">
                                            </div>
                                        </a>
                                        <a class="insert">
                                            <div class="fa fa-arrow-down">
                                            </div>
                                        </a>
                                    </td>
                                </tr>
                                <tr class="footer">
                                    <td class="rowOption"></td>
                                    <td data-datafield="BatchJSTblOfFK.ContractNo"></td>
                                    <td data-datafield="BatchJSTblOfFK.ContractName"></td>
                                    <td data-datafield="BatchJSTblOfFK.PostAB"></td>
                                    <td data-datafield="BatchJSTblOfFK.DKAmount"></td>
                                    <td data-datafield="BatchJSTblOfFK.FKAmount"></td>
                                    <td data-datafield="BatchJSTblOfFK.BankFY"></td>
                                    <td data-datafield="BatchJSTblOfFK.AgencyFY"></td>
                                    <td data-datafield="BatchJSTblOfFK.OtherFY"></td>
                                    <td data-datafield="BatchJSTblOfFK.JSResult"></td>
                                    <td data-datafield="BatchJSTblOfFK.Operate"></td>
                                    <td data-datafield="BatchJSTblOfFK.WorkItemId"></td>
                                    <td data-datafield="BatchJSTblOfFK.Cnt"></td>
                                    <td data-datafield="BatchJSTblOfFK.ContractNoHidden"></td>
                                    <td data-datafield="BatchJSTblOfFK.JSObjectID"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="div27768" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="Amount" class="" style="">支付金额</span>
                    </div>
                    <div id="div849139" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="Amount" data-type="SheetTextBox" class="" style="width:70%">人民币
                    </div>
                    <div id="div758901" class="col-md-2">
                    </div>
                    <div id="div215592" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="PayType" style="">支付方式</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <select data-datafield="PayType" data-type="SheetDropDownList" id="ctl704681" class="" style="" data-masterdatacategory="支付方式" data-queryable="false"></select>
                    </div>
                    <div id="title4" class="col-md-2">
                    </div>
                    <div id="control4" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div833683" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="Receiver" class="" style="">收款人</span>
                    </div>
                    <div id="div138762" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="Receiver" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="div187170" class="col-md-2">
                    </div>
                    <div id="div551475" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="BankName" style="">开户银行</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="BankName" data-type="SheetTextBox" style="" class="" data-schemacode="GetBankOfCustomer" data-querycode="GetBankOfCustomer" data-outputmappings="BankAccount:account,BankName:BankName" data-popupwindow="PopupWindow">
                    </div>
                    <div id="title6" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BankAccount" style="">账号</span>
                    </div>
                    <div id="control6" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="BankAccount" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="Attachment2" style="">支付凭证</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <input type="text" data-datafield="Attachment2" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="Attachment2"></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="ApproveRemark" data-type="SheetLabel" id="ctl818667" class="" style="">备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="ApproveRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div466787" class="col-md-2">
                        <label data-datafield="ManagerComment" data-type="SheetLabel" id="ctl773197" class="" style="">项目经理审批意见</label>
                    </div>
                    <div id="div362968" class="col-md-10">
                        <div data-datafield="ManagerComment" data-type="SheetComment" id="ctl815909" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div222339" class="col-md-2">
                        <label data-datafield="CompanyLeaderComment" data-type="SheetLabel" id="ctl651296" class="" style="">公司领导审批意见</label>
                    </div>
                    <div id="div64057" class="col-md-10">
                        <div data-datafield="CompanyLeaderComment" data-type="SheetComment" id="ctl384180" class="" style=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div245237" class="col-md-2">
                        <label data-datafield="IsOperateFK" data-type="SheetLabel" id="ctl469954" class="" style="">执行付款</label>
                    </div>
                    <div id="div997696" class="col-md-4">
                        <div data-datafield="IsOperateFK" data-type="SheetCheckboxList" id="ctl577786" class="" style="" data-defaultitems="是"></div>
                    </div>
                    <div id="div218907" class="col-md-2"></div>
                    <div id="div684979" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="div867176" class="col-md-2">
                        <label data-datafield="FKDate" data-type="SheetLabel" id="ctl583405" class="" style="">付款日期</label>
                    </div>
                    <div id="div428074" class="col-md-4">
                        <input type="text" data-datafield="FKDate" data-type="SheetTime" id="ctl548396" class="" style="">
                    </div>
                    <div id="div692636" class="col-md-2"></div>
                    <div id="div483544" class="col-md-4"></div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="OperateRemark" data-type="SheetLabel" id="ctl818667" class="" style="">执行备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="OperateRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        <textarea data-datafield="JSObjectIDs" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl674230" class="hidden"></textarea>
                    </div>
                    <div id="div544852" class="col-md-1">
                        <input type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div523468" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div315418" class="col-md-1"></div>
                    <div id="div836564" class="col-md-1"></div>
                    <div id="div74315" class="col-md-1"></div>
                    <div id="div895520" class="col-md-1"></div>
                    <div id="div21012" class="col-md-1"></div>
                    <div id="div616170" class="col-md-1"></div>
                    <div id="div411135" class="col-md-1"></div>
                    <div id="div260964" class="col-md-1"></div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">批量付款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackBatchFKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">批量付款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackBatchFKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackBatchFKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackBatchFKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackBatchFKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackBatchFKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackBatchFKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackBatchFKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackBatchFKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackBatchFKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackBatchFKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackBatchFKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackBatchFKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackBatchFKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackBatchFKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackBatchFKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackBatchFKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackBatchFKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackBatchFKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackBatchFKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackBatchFKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackBatchFKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackBatchFKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackBatchFKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackBatchFKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackBatchFKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackBatchFKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
