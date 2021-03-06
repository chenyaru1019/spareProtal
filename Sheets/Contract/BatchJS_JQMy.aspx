﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchJS_JQMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchJS_JQMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BatchJS_JQMy.js"></script>
    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">批量结清流程</label>
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
                <div class="row BatchJSTblOfJQ">
                    <div id="div54679" class="col-md-12">
                        <span id="Label16" data-type="SheetLabel" data-datafield="BatchJSTblOfJQ" class="" style="">批量结算记录</span>
                    </div>
                </div>
                <div class="row BatchJSTblOfJQ">

                    <div id="div688677" class="col-md-12">
                        <table id="Control16" data-datafield="BatchJSTblOfJQ" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control16_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control16_Header3" data-datafield="BatchJSTblOfJQ.ContractNo">
                                        <label id="Control16_Label3" data-datafield="BatchJSTblOfJQ.ContractNo" data-type="SheetLabel" style="">合同号</label>
                                    </td>
                                    <td id="Control16_Header4" data-datafield="BatchJSTblOfJQ.ContractName">
                                        <label id="Control16_Label4" data-datafield="BatchJSTblOfJQ.ContractName" data-type="SheetLabel" style="">合同名称</label>
                                    </td>
                                    <td id="Control16_Header5" data-datafield="BatchJSTblOfJQ.PostAB">
                                        <label id="Control16_Label5" data-datafield="BatchJSTblOfJQ.PostAB" data-type="SheetLabel" style="">负责人</label>
                                    </td>
                                    <td id="Control16_Header6" data-datafield="BatchJSTblOfJQ.DKAmount">
                                        <label id="Control16_Label6" data-datafield="BatchJSTblOfJQ.DKAmount" data-type="SheetLabel" style="">到账金额</label>
                                    </td>
                                    <td id="Control16_Header7" data-datafield="BatchJSTblOfJQ.FKAmount">
                                        <label id="Control16_Label7" data-datafield="BatchJSTblOfJQ.FKAmount" data-type="SheetLabel" style="">支付金额</label>
                                    </td>
                                    <td id="Control16_Header8" data-datafield="BatchJSTblOfJQ.BankFY">
                                        <label id="Control16_Label8" data-datafield="BatchJSTblOfJQ.BankFY" data-type="SheetLabel" style="">银行费用</label>
                                    </td>
                                    <td id="Control16_Header9" data-datafield="BatchJSTblOfJQ.AgencyFY">
                                        <label id="Control16_Label9" data-datafield="BatchJSTblOfJQ.AgencyFY" data-type="SheetLabel" style="">代理费</label>
                                    </td>
                                    <td id="Control16_Header10" data-datafield="BatchJSTblOfJQ.OtherFY">
                                        <label id="Control16_Label10" data-datafield="BatchJSTblOfJQ.OtherFY" data-type="SheetLabel" style="">其他费用</label>
                                    </td>
                                    <td id="Control16_Header11" data-datafield="BatchJSTblOfJQ.JSResult">
                                        <label id="Control16_Label11" data-datafield="BatchJSTblOfJQ.JSResult" data-type="SheetLabel" style="">结算结果</label>
                                    </td>
                                    <td id="Control16_Header12" data-datafield="BatchJSTblOfJQ.Operate">
                                        <label id="Control16_Label12" data-datafield="BatchJSTblOfJQ.Operate" data-type="SheetLabel" style="">操作</label>
                                    </td>
                                    <td id="Control16_Header13" data-datafield="BatchJSTblOfJQ.WorkItemId" class="hidden">
                                        <label id="Control16_Label13" data-datafield="BatchJSTblOfJQ.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label>
                                    </td>
                                    <td id="Control16_Header14" data-datafield="BatchJSTblOfJQ.Cnt" class="hidden">
                                        <label id="Control16_Label14" data-datafield="BatchJSTblOfJQ.Cnt" data-type="SheetLabel" style="">合并数量</label>
                                    </td>
                                    <td id="Control16_Header15" data-datafield="BatchJSTblOfJQ.ContractNoHidden" class="hidden">
                                        <label id="Control16_Label15" data-datafield="BatchJSTblOfJQ.ContractNoHidden" data-type="SheetLabel" style="">合同号Hidden</label>
                                    </td>
                                    <td id="Control16_Header16" data-datafield="BatchJSTblOfJQ.JSObjectID" class="hidden">
                                        <label id="Control16_Label16" data-datafield="BatchJSTblOfJQ.JSObjectID" data-type="SheetLabel" style="">JSObjectID</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control16_Option" class="rowOption"></td>
                                    <td data-datafield="BatchJSTblOfJQ.ContractNo">
                                        <input id="Control16_ctl3" type="text" data-datafield="BatchJSTblOfJQ.ContractNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.ContractName">
                                        <input id="Control16_ctl4" type="text" data-datafield="BatchJSTblOfJQ.ContractName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.PostAB">
                                        <input id="Control16_ctl5" type="text" data-datafield="BatchJSTblOfJQ.PostAB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.DKAmount">
                                        <input id="Control16_ctl6" type="text" data-datafield="BatchJSTblOfJQ.DKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.FKAmount">
                                        <input id="Control16_ctl7" type="text" data-datafield="BatchJSTblOfJQ.FKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.BankFY">
                                        <input id="Control16_ctl8" type="text" data-datafield="BatchJSTblOfJQ.BankFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.AgencyFY">
                                        <input id="Control16_ctl9" type="text" data-datafield="BatchJSTblOfJQ.AgencyFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.OtherFY">
                                        <input id="Control16_ctl10" type="text" data-datafield="BatchJSTblOfJQ.OtherFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.JSResult">
                                        <input id="Control16_ctl11" type="text" data-datafield="BatchJSTblOfJQ.JSResult" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.Operate">
                                        <a class="btn btn-primary viewJS" onclick="viewJS(this)">查看</a>
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.WorkItemId" class="hidden">
                                        <input id="Control16_ctl13" type="text" data-datafield="BatchJSTblOfJQ.WorkItemId" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.Cnt" class="hidden">
                                        <input id="Control16_ctl14" type="text" data-datafield="BatchJSTblOfJQ.Cnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.ContractNoHidden" class="hidden">
                                        <input id="Control16_ctl15" type="text" data-datafield="BatchJSTblOfJQ.ContractNoHidden" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfJQ.JSObjectID" class="hidden">
                                        <input id="Control16_ctl16" type="text" data-datafield="BatchJSTblOfJQ.JSObjectID" data-type="SheetTextBox" style="">
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
                                    <td data-datafield="BatchJSTblOfJQ.ContractNo"></td>
                                    <td data-datafield="BatchJSTblOfJQ.ContractName"></td>
                                    <td data-datafield="BatchJSTblOfJQ.PostAB"></td>
                                    <td data-datafield="BatchJSTblOfJQ.DKAmount"></td>
                                    <td data-datafield="BatchJSTblOfJQ.FKAmount"></td>
                                    <td data-datafield="BatchJSTblOfJQ.BankFY"></td>
                                    <td data-datafield="BatchJSTblOfJQ.AgencyFY"></td>
                                    <td data-datafield="BatchJSTblOfJQ.OtherFY"></td>
                                    <td data-datafield="BatchJSTblOfJQ.JSResult"></td>
                                    <td data-datafield="BatchJSTblOfJQ.Operate"></td>
                                    <td data-datafield="BatchJSTblOfJQ.WorkItemId"></td>
                                    <td data-datafield="BatchJSTblOfJQ.Cnt"></td>
                                    <td data-datafield="BatchJSTblOfJQ.ContractNoHidden"></td>
                                    <td data-datafield="BatchJSTblOfJQ.JSObjectID"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="JQ_Target" style="">结清对象</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="JQ_Target" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div26877" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="Content" class="" style="">结清内容</span>
                    </div>
                    <div id="div702086" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="Content" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="div31963" class="col-md-2">
                    </div>
                    <div id="div338567" class="col-md-4">
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
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <div id="Control14" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title7" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="CompanyLeaderComment" style="">公司领导审批意见</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <div id="Control15" data-datafield="CompanyLeaderComment" data-type="SheetComment" style="">
                        </div>
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
                <label id="divSheetInfo" data-en_us="Sheet information">批量结清回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackBatchJQTbl" data-type="SheetLabel" id="ctl280690" class="" style="">批量结清回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackBatchJQTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackBatchJQTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackBatchJQTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackBatchJQTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackBatchJQTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackBatchJQTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackBatchJQTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackBatchJQTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackBatchJQTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackBatchJQTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackBatchJQTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackBatchJQTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackBatchJQTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackBatchJQTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackBatchJQTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackBatchJQTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackBatchJQTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackBatchJQTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackBatchJQTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackBatchJQTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackBatchJQTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackBatchJQTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackBatchJQTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackBatchJQTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackBatchJQTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackBatchJQTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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

    <script src="../js/ApprovalTbl.js"></script>
</asp:Content>
