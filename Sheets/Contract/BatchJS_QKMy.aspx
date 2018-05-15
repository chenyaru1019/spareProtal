﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchJS_QKMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.BatchJS_QKMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="BatchJS_QKMy.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">批量请款流程</label>
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
                        <span id="Label11" data-type="SheetLabel" data-datafield="QK_Target" style="">请款对象</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="QK_Target" data-type="SheetTextBox" style="">
                    </div>
                    <div id="title2" class="col-md-2">
                    </div>
                    <div id="control2" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="div188556" class="col-md-2">
                        <span id="Label12" data-type="SheetLabel" data-datafield="Content" class="" style="">请款内容</span>
                    </div>
                    <div id="div565984" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="Content" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="div649761" class="col-md-2">
                    </div>
                    <div id="div760355" class="col-md-4">
                    </div>
                </div>
                <div class="row BatchJSTblOfQK">
                    <div id="div760629" class="col-md-12">
                        <span id="Label20" data-type="SheetLabel" data-datafield="BatchJSTblOfQK" class="" style="">批量结算记录</span>
                    </div>
                </div>
                <div class="row BatchJSTblOfQK">
                    <div id="div827632" class="col-md-12">
                        <table id="Control20" data-datafield="BatchJSTblOfQK" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="Control20_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control20_Header3" data-datafield="BatchJSTblOfQK.ContractNo">
                                        <label id="Control20_Label3" data-datafield="BatchJSTblOfQK.ContractNo" data-type="SheetLabel" style="">合同号</label>
                                    </td>
                                    <td id="Control20_Header4" data-datafield="BatchJSTblOfQK.ContractName">
                                        <label id="Control20_Label4" data-datafield="BatchJSTblOfQK.ContractName" data-type="SheetLabel" style="">合同名称</label>
                                    </td>
                                    <td id="Control20_Header5" data-datafield="BatchJSTblOfQK.PostAB">
                                        <label id="Control20_Label5" data-datafield="BatchJSTblOfQK.PostAB" data-type="SheetLabel" style="">负责人</label>
                                    </td>
                                    <td id="Control20_Header6" data-datafield="BatchJSTblOfQK.DKAmount">
                                        <label id="Control20_Label6" data-datafield="BatchJSTblOfQK.DKAmount" data-type="SheetLabel" style="">到账金额</label>
                                    </td>
                                    <td id="Control20_Header7" data-datafield="BatchJSTblOfQK.FKAmount">
                                        <label id="Control20_Label7" data-datafield="BatchJSTblOfQK.FKAmount" data-type="SheetLabel" style="">支付金额</label>
                                    </td>
                                    <td id="Control20_Header8" data-datafield="BatchJSTblOfQK.BankFY">
                                        <label id="Control20_Label8" data-datafield="BatchJSTblOfQK.BankFY" data-type="SheetLabel" style="">银行费用</label>
                                    </td>
                                    <td id="Control20_Header9" data-datafield="BatchJSTblOfQK.AgencyFY">
                                        <label id="Control20_Label9" data-datafield="BatchJSTblOfQK.AgencyFY" data-type="SheetLabel" style="">代理费</label>
                                    </td>
                                    <td id="Control20_Header10" data-datafield="BatchJSTblOfQK.OtherFY">
                                        <label id="Control20_Label10" data-datafield="BatchJSTblOfQK.OtherFY" data-type="SheetLabel" style="">其他费用</label>
                                    </td>
                                    <td id="Control20_Header11" data-datafield="BatchJSTblOfQK.JSResult">
                                        <label id="Control20_Label11" data-datafield="BatchJSTblOfQK.JSResult" data-type="SheetLabel" style="">结算结果</label>
                                    </td>
                                    <td id="Control20_Header12" data-datafield="BatchJSTblOfQK.Operate" class="">
                                        <label id="Control20_Label12" data-datafield="BatchJSTblOfQK.Operate" data-type="SheetLabel" style="">操作</label>
                                    </td>
                                    <td id="Control20_Header13" data-datafield="BatchJSTblOfQK.WorkItemId" class="hidden">
                                        <label id="Control20_Label13" data-datafield="BatchJSTblOfQK.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label>
                                    </td>
                                    <td id="Control20_Header14" data-datafield="BatchJSTblOfQK.Cnt" class="hidden">
                                        <label id="Control20_Label14" data-datafield="BatchJSTblOfQK.Cnt" data-type="SheetLabel" style="">合并数量</label>
                                    </td>
                                    <td id="Control20_Header15" data-datafield="BatchJSTblOfQK.ContractNoHidden" class="hidden">
                                        <label id="Control20_Label15" data-datafield="BatchJSTblOfQK.ContractNoHidden" data-type="SheetLabel" style="" class="">合同号Hidden</label>
                                    </td>
                                    <td id="Control20_Header15" data-datafield="BatchJSTblOfQK.JSObjectID" class="hidden">
                                        <label id="Control20_Label15" data-datafield="BatchJSTblOfQK.JSObjectID" data-type="SheetLabel" style="" class="">JSObjectID</label>
                                    </td>
                                    <td class="rowOption hidden">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control20_Option" class="rowOption"></td>
                                    <td data-datafield="BatchJSTblOfQK.ContractNo">
                                        <input id="Control20_ctl3" type="text" data-datafield="BatchJSTblOfQK.ContractNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.ContractName">
                                        <input id="Control20_ctl4" type="text" data-datafield="BatchJSTblOfQK.ContractName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.PostAB">
                                        <input id="Control20_ctl5" type="text" data-datafield="BatchJSTblOfQK.PostAB" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.DKAmount">
                                        <input id="Control20_ctl6" type="text" data-datafield="BatchJSTblOfQK.DKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.FKAmount">
                                        <input id="Control20_ctl7" type="text" data-datafield="BatchJSTblOfQK.FKAmount" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.BankFY">
                                        <input id="Control20_ctl8" type="text" data-datafield="BatchJSTblOfQK.BankFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.AgencyFY">
                                        <input id="Control20_ctl9" type="text" data-datafield="BatchJSTblOfQK.AgencyFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.OtherFY">
                                        <input id="Control20_ctl10" type="text" data-datafield="BatchJSTblOfQK.OtherFY" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.JSResult">
                                        <input id="Control20_ctl11" type="text" data-datafield="BatchJSTblOfQK.JSResult" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.Operate">
                                       <a class="btn btn-primary viewJS" onclick="viewJS(this)">查看</a>
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.WorkItemId" class="hidden">
                                        <input id="Control20_ctl13" type="text" data-datafield="BatchJSTblOfQK.WorkItemId" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.Cnt" class="hidden">
                                        <input id="Control20_ctl14" type="text" data-datafield="BatchJSTblOfQK.Cnt" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.ContractNoHidden" class="hidden">
                                        <input id="Control20_ctl15" type="text" data-datafield="BatchJSTblOfQK.ContractNoHidden" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="BatchJSTblOfQK.JSObjectID" class="hidden">
                                        <input id="Control20_ctl15" type="text" data-datafield="BatchJSTblOfQK.JSObjectID" data-type="SheetTextBox" style="">
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
                                    <td data-datafield="BatchJSTblOfQK.ContractNo"></td>
                                    <td data-datafield="BatchJSTblOfQK.ContractName"></td>
                                    <td data-datafield="BatchJSTblOfQK.PostAB"></td>
                                    <td data-datafield="BatchJSTblOfQK.DKAmount"></td>
                                    <td data-datafield="BatchJSTblOfQK.FKAmount"></td>
                                    <td data-datafield="BatchJSTblOfQK.BankFY"></td>
                                    <td data-datafield="BatchJSTblOfQK.AgencyFY"></td>
                                    <td data-datafield="BatchJSTblOfQK.OtherFY"></td>
                                    <td data-datafield="BatchJSTblOfQK.JSResult"></td>
                                    <td data-datafield="BatchJSTblOfQK.Operate"></td>
                                    <td data-datafield="BatchJSTblOfQK.WorkItemId"></td>
                                    <td data-datafield="BatchJSTblOfQK.Cnt"></td>
                                    <td data-datafield="BatchJSTblOfQK.ContractNoHidden"></td>
                                    <td data-datafield="BatchJSTblOfQK.JSObjectID"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="Amount" style="">请款金额</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <input id="Control13" type="text" data-datafield="Amount" data-type="SheetTextBox" style="width:70%" class="">人民币
                    </div>
                    <div id="space4" class="col-md-2">
                    </div>
                    <div id="spaceControl4" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title5" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="QKUploadFile" style="">请款文件上传</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <input type="text" data-datafield="QKUploadFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="QKUploadFile"></div>
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
                    <div id="title9" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门领导审批意见</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <div id="Control16" data-datafield="ManagerComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="CompanyLeaderComment" style="">公司领导审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control17" data-datafield="CompanyLeaderComment" data-type="SheetComment" style="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="title13" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="SDDate" style="">请款送达时间</span>
                    </div>
                    <div id="control13" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="SDDate" data-type="SheetTime" style="">
                    </div>
                    <div id="space14" class="col-md-2">
                    </div>
                    <div id="spaceControl14" class="col-md-4">
                    </div>
                </div>
                <div class="row">
                    <div id="title15" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="SignFile" style="">请款文件签字版</span>
                    </div>
                    <div id="control15" class="col-md-10">
                        <input type="text" data-datafield="SignFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="SignFile"></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div93066" class="col-md-2">
                        <label data-datafield="DKDate" data-type="SheetLabel" id="ctl380485" class="" style="">到款日期</label>
                    </div>
                    <div id="div385071" class="col-md-4">
                        <input type="text" data-datafield="DKDate" data-type="SheetTime" id="ctl149904" class="" style="">
                    </div>
                    <div id="div541585" class="col-md-2"></div>
                    <div id="div182467" class="col-md-4"></div>
                </div>
                <div class="row tableContent">
                    <div id="div507309" class="col-md-2">
                        <label data-datafield="DKConfirmRemark" data-type="SheetLabel" id="ctl818667" class="" style="">确认备注</label>
                    </div>
                    <div id="div203297" class="col-md-10">
                        <div data-datafield="DKConfirmRemark" data-type="SheetComment" id="ctl196171" class="" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div454238" class="col-md-1">
                        <input type="text" data-datafield="RejectFlg" data-type="SheetTextBox" id="ctl341857" class="hidden" style="">
                    </div>
                    <div id="div562910" class="col-md-1">
                        <textarea data-datafield="JSObjectIDs" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl674230" class="hidden" ></textarea>
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
                <label id="divSheetInfo" data-en_us="Sheet information">批量请款回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackBatchQKTbl" data-type="SheetLabel" id="ctl280690" class="" style="">批量请款回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackBatchQKTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackBatchQKTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackBatchQKTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackBatchQKTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackBatchQKTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackBatchQKTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackBatchQKTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackBatchQKTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackBatchQKTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackBatchQKTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackBatchQKTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackBatchQKTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackBatchQKTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackBatchQKTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackBatchQKTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackBatchQKTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackBatchQKTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackBatchQKTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackBatchQKTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackBatchQKTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackBatchQKTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackBatchQKTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackBatchQKTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackBatchQKTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackBatchQKTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackBatchQKTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
