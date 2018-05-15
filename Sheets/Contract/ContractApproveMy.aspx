﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContractApproveMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.ContractApproveMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="ContractApproveMy.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">合同审签子流程</label>
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
                    <span id="Label14" data-type="SheetLabel" data-datafield="ContractType" style="">合同类型</span>
                </div>
                <div id="control4" class="col-md-4">
                    <input id="Control14" type="text" data-datafield="ContractType" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title5" class="col-md-2">
                    <span id="Label15" data-type="SheetLabel" data-datafield="ContractProperty" style="">合同性质</span>
                </div>
                <div id="control5" class="col-md-4">
                    <input id="Control15" type="text" data-datafield="ContractProperty" data-type="SheetTextBox" style="">
                </div>
                <div id="title6" class="col-md-2">
                    <span id="Label16" data-type="SheetLabel" data-datafield="Salers" style="">合同卖方</span>
                </div>
                <div id="control6" class="col-md-4">
                    <input id="Control16" type="text" data-datafield="Salers" data-type="SheetTextBox" style="">
                </div>
            </div>
            <div class="row">
                <div id="title7" class="col-md-2">
                    <span id="Label17" data-type="SheetLabel" data-datafield="FinalUser" style="">最终用户</span>
                </div>
                <div id="control7" class="col-md-4">
                    <input id="Control17" type="text" data-datafield="FinalUser" data-type="SheetTextBox" style="">
                </div>
                <div id="title8" class="col-md-2">
                </div>
                <div id="control8" class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div id="div731735" class="col-md-2">
                    <span id="Label18" data-type="SheetLabel" data-datafield="BidNo" class="" style="">招标编号</span>
                </div>
                <div id="div542137" class="col-md-4">
                    <input id="Control18" type="text" data-datafield="BidNo" data-type="SheetTextBox" class="" style="">
                </div>
                <div id="div21721" class="col-md-2">
                </div>
                <div id="div294298" class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div id="title9" class="col-md-2">
                    <span id="Label19" data-type="SheetLabel" data-datafield="ContractRemark" style="">合同说明</span>
                </div>
                <div id="control9" class="col-md-4">
                    <input id="Control19" type="text" data-datafield="ContractRemark" data-type="SheetTextBox" style="">
                </div>
                <div id="space10" class="col-md-2">
                </div>
                <div id="spaceControl10" class="col-md-4">
                </div>
            </div>
            
            <div class="row">
                <div id="title13" class="col-md-2">
                    <span id="Label21" data-type="SheetLabel" data-datafield="ContractFile" style="">合同文本</span>
                </div>
                <div id="control13" class="col-md-10">
                    <input type="text" data-datafield="ContractFile" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="ContractFile"></div>
                </div>
            </div>
            <div class="row">
                <div id="title15" class="col-md-2">
                    <span id="Label22" data-type="SheetLabel" data-datafield="AgencyType" style="">代理协议</span>
                </div>
                <div id="control15" class="col-md-4">
                    <input id="Control22" type="text" data-datafield="AgencyType" data-type="SheetTextBox" style="">
                </div>
                <div id="space16" class="col-md-2">
                </div>
                <div id="spaceControl16" class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div id="title17" class="col-md-2">
                    <span id="Label23" data-type="SheetLabel" data-datafield="TalkFile" style="">合同谈判小结</span>
                </div>
                <div id="control17" class="col-md-10">
                    <input type="text" data-datafield="TalkFile" data-type="SheetTextBox" id="" class="hidden" style="">
                    <div id="TalkFile"></div>
                </div>
            </div>
            <div class="row NoHY">
                <div id="div431906" class="col-md-2">
                    <label data-datafield="IsCheck" data-type="SheetLabel" id="ctl612768" class="" style="">资质证明</label>
                </div>
                <div id="div884966" class="col-md-10">
                    <div data-datafield="IsCheck" data-type="SheetCheckboxList" id="ctl762696" class="" style="" data-repeatcolumns="1" data-defaultitems="已提供供应商营业执照及无行贿记录证明等资质证明"></div>
                </div>
            </div>
            <div class="row NoHY">
                <div id="div556496" class="col-md-2">
                    <label data-datafield="Attachment" data-type="SheetLabel" id="ctl978461" class="" style="">资质证明附件</label>
                </div>
                <div id="div42502" class="col-md-10">
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
            <div class="row">
                <div id="div460044" class="col-md-2">
                    <label data-datafield="ManagerSuggest" data-type="SheetLabel" id="ctl693405" class="" style="">部门经理审批意见</label></div>
                <div id="div935203" class="col-md-10">
                    <div data-datafield="ManagerSuggest" data-type="SheetComment" id="ctl488651" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div871701" class="col-md-2">
                    <label data-datafield="FinanceComment" data-type="SheetLabel" id="ctl621381" class="" style="">财务审批意见</label>
                </div>
                <div id="div765392" class="col-md-10">
                    <div data-datafield="FinanceComment" data-type="SheetComment" id="ctl720301" class="" style=""></div>
                </div>
            </div>
            <div class="row">
                <div id="div808827" class="col-md-2">
                    <label data-datafield="CompanyLeaderSuggest" data-type="SheetLabel" id="ctl986495" class="" style="">公司领导审批意见</label></div>
                <div id="div928223" class="col-md-10">
                    <div data-datafield="CompanyLeaderSuggest" data-type="SheetComment" id="ctl147356" class="" style=""></div>
                </div>
            </div>

            <div class="row hidden">
                <div id="div552950" class="col-md-2">
                    <input id="Control20" type="text" data-datafield="IsHYFlg" data-type="SheetTextBox" class="hidden" style="">
                </div>
                <div id="div392071" class="col-md-2">
                    <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                </div>
            </div>
        </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">合同审签回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackContractApproveTbl" data-type="SheetLabel" id="ctl280690" class="" style="">合同审签回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackContractApproveTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackContractApproveTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackContractApproveTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackContractApproveTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackContractApproveTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackContractApproveTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackContractApproveTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackContractApproveTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackContractApproveTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackContractApproveTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackContractApproveTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackContractApproveTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackContractApproveTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackContractApproveTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackContractApproveTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackContractApproveTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackContractApproveTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackContractApproveTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackContractApproveTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackContractApproveTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackContractApproveTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackContractApproveTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackContractApproveTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackContractApproveTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackContractApproveTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackContractApproveTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
