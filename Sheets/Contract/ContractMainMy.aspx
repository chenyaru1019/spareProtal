﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContractMainMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.ContractMainMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="masterContent" runat="Server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../js/zTree_v3/css/demo.css" type="text/css">
	<link rel="stylesheet" href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script src="ContractMainMY.js"></script>

    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">合同主流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleImage">
                <label id="divSheetInfo" data-en_us="Sheet information">合同状态图</label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="divContent">
                    <div id="process_father">
                        <div id="bg-line"></div>
                        <div id="apDiv1">
                            <input type="button" name="button9" value="创建合同" class="bt_project1" disabled/>
                        </div>
                        <div id="apDiv22">
                            <input type="button" name="button9" value="合同审签" class="bt_project2" disabled />
                        </div>
                        <div id="apDiv3">
                            <input type="button" name="button10" value="合同执行" class="bt_project3" disabled />
                        </div>
                        <div id="apDiv3-1">
                            <input type="button" name="button" value="资金计划" class="operateChild operateChildPlan bt_progress_child_long2" onclick="clickToggle('Plan', '1');" />
                        </div>
                        <div id="apDiv3-2">
                            <input type="button" name="button" value="信用证" class="operateChild operateChildPayment bt_progress_child_long2" onclick="clickToggle('Payment', '1')" />
                        </div>
                        <div id="apDiv3-3">
                            <input type="button" name="button" value="进口许可证" class="operateChild operateChildImport bt_progress_child_long2" onclick="clickToggle('Import', '1')" />
                        </div>
                        <div id="apDiv3-4">
                            <input type="button" name="button" value="到 货" class="operateChild operateChildDH bt_progress_child_long2" onclick="clickToggle('DH', '1')" />
                        </div>
                        <div id="apDiv3-5">
                            <input type="button" name="button" value="合同变更" class="operateChild operateChildBG bt_progress_child_long2" onclick="clickToggle('BG', '1')" />
                        </div>
                        <div id="apDiv3-6">
                            <input type="button" name="button" value="请 款" class="operateChild operateChildQK bt_progress_child_long2" onclick="clickToggle('QK', '1')" />
                        </div>
                        <div id="apDiv3-7">
                            <input type="button" name="button" value="到 款" class="operateChild operateChildDK bt_progress_child_long2" onclick="clickToggle('DK', '1')" />
                        </div>
                        <div id="apDiv3-8">
                            <input type="button" name="button" value="付 款" class="operateChild operateChildFK bt_progress_child_long2" onclick="clickToggle('FK', '1')" />
                        </div>
                        <div id="apDiv3-9">
                            <input type="button" name="button" value="结 算" class="operateChild operateChildJS bt_progress_child_long2" onclick="clickToggle('JS', '1')" />
                        </div>
                        <div id="apDiv3-10">
                            <input type="button" name="button" value="保 函" class="operateChild operateChildBH bt_progress_child_long2" onclick="clickToggle('BH', '1')" />
                        </div>
                        <div id="apDiv4">
                            <input type="button" name="button11" value="合同完成" class="bt_project3" disabled/>
                        </div>
                        <div id="arr1">
                            <img src="../images/tender/arrow_progress.gif" />
                        </div>
                        <div id="arr2">
                            <img src="../images/tender/arrow_progress.gif" />
                        </div>
                        <div id="arr3">
                            <img src="../images/tender/arrow_progress.gif" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentCreate">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleCreate">
                <label id="divSheetInfo" data-en_us="Sheet information">合同创建&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">

                <div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="PostA" style="">A角</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <div id="Control13" data-datafield="PostA" data-type="SheetUser" style="">
                        </div>
                    </div>
                    <div id="title4" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="PostB" style="">B角</span>
                    </div>
                    <div id="control4" class="col-md-4">
                        <div id="Control14" data-datafield="PostB" data-type="SheetUser" style="">
                        </div>
                        <%--<input id="AdjustActivityId" type="button" onclick="AdjustActivity()" value="调整参与者" class="btn btn-primary" />--%>
                    </div>
                </div>
                <div class="row">
                    <div id="div274771" class="col-md-2"><span id="Label15" data-type="SheetLabel" data-datafield="FinalUser" style="" class="">最终用户</span></div>
                    <div id="div231890" class="col-md-4">
                        <%--<input id="Control15" type="text" data-datafield="FinalUser" data-type="SheetTextBox" style="width: 70%" class="" data-popupwindow="PopupWindow" data-schemacode="GetProjectOfCustomer" data-querycode="GetProjectOfCustomer" data-outputmappings="FinalUser:FinalUser,ProjectName:ProjectName,SubProjectName:SubProjectName,SubProjectCode:SubProjectCode,ProjectShortNameHidden:ProjectShortName,SubProjectShortNameHidden:SubProjectShortName">--%>
                        <input id="Control15" type="text" data-datafield="FinalUser" data-type="SheetTextBox" style="width: 70%" class="" ><a id="getFinalUsers" onclick="getFinalUsers()">选择</a>
                    </div>
                    <%--<div id="div735967" class="col-md-2"><span id="Label16" data-type="SheetLabel" data-datafield="ProjectName" style="" class="">项目名称</span></div>
                    <div id="div409232" class="col-md-4">
                        <input id="Control16" type="text" data-datafield="ProjectName" data-type="SheetTextBox" style="" class="">
                    </div>--%>
                </div>
                <%--<div class="row">
                    <div id="div340327" class="col-md-2"><span id="Label17" data-type="SheetLabel" data-datafield="SubProjectName" style="" class="">子工程名称</span></div>
                    <div id="div233075" class="col-md-4">
                        <input id="Control17" type="text" data-datafield="SubProjectName" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div340327" class="col-md-2">
                    </div>
                    <div id="div233075" class="col-md-4">
                    </div>
                </div>--%>
                <div class="row">
                    <div id="div681796" class="col-md-2"><span id="Label12" data-type="SheetLabel" data-datafield="ContractName" style="" class="">合同名称</span></div>
                    <div id="div250803" class="col-md-4">
                        <input id="Control12" type="text" data-datafield="ContractName" data-type="SheetTextBox" style="" class="">
                    </div>
                    <div id="div79482" class="col-md-2"><span id="Label18" data-type="SheetLabel" data-datafield="ContractShortName" style="" class="">合同简称</span></div>
                    <div id="div475480" class="col-md-4">
                        <input id="Control18" type="text" data-datafield="ContractShortName" data-type="SheetTextBox" style="" class="">
                    </div>
                </div>
                <div class="row">
                    <div id="div420179" class="col-md-2"><span id="Label19" data-type="SheetLabel" data-datafield="ContractType" style="" class="">合同类型</span></div>
                    <div id="div631634" class="col-md-4">
                        <select data-datafield="ContractType" data-type="SheetDropDownList" id="ctl154804" class="" style="" data-masterdatacategory="合同类型" data-displayemptyitem="true" data-emptyitemtext="请选择"
                            data-onchange=" ContractTypeChange() "  data-queryable="false">
                        </select>
                    </div>
                    <div id="div155808" class="col-md-2 CountryTitle"><span id="Label28" data-type="SheetLabel" data-datafield="Country" style="" class="">国别</span></div>
                    <div id="div444178" class="col-md-4 CountrySelect">
                        <select data-datafield="Country" data-type="SheetDropDownList" id="ctl779314" class="" style="" data-masterdatacategory="国别" data-displayemptyitem="true" data-emptyitemtext="请选择"  data-queryable="false"></select>
                    </div>
                </div>
                <div class="row">
                    <div id="div947436" class="col-md-2"><span id="Label20" data-type="SheetLabel" data-datafield="ContractProperty" style="" class="">合同性质</span></div>
                    <div id="div703191" class="col-md-2 normal">
                        <select data-datafield="ContractProperty" data-type="SheetDropDownList" id="ctl503496" class="" style="" data-displayemptyitem="true" data-emptyitemtext="请选择" data-schemacode="GetPropertyByType" data-querycode="GetPropertyByType" data-filter="ContractType:Property" data-datavaluefield="code" data-datatextfield="EnumValue"
                            data-onchange="setDataFromHY()"  data-queryable="false">
                        </select>
                    </div>

                    <%--<div id="div312342" class="col-md-1"><span id="Label21" data-type="SheetLabel" data-datafield="TradeMethod" style="" class="">贸易方式</span></div>
                    <div id="div52444" class="col-md-2">
                        <select data-datafield="TradeMethod" data-type="SheetDropDownList" id="ctl834109" class="" style="" data-masterdatacategory="贸易方式" data-displayemptyitem="true" data-emptyitemtext="请选择"  data-queryable="false"></select>
                    </div>--%>
                    <div id="div973922" class="col-md-2"><span id="Label11" data-type="SheetLabel" data-datafield="ContractNo" style="" class="">合同号</span></div>
                    <div id="div724177" class="col-md-6 RowHeight">
                        <input id="Control11" type="text" data-datafield="ContractNo" data-type="SheetTextBox" style="width: 70%" class="" readonly>
                        <input id="generateContractNoId" type="button" onclick="generateContractNo()" value="生成合同号" class="btn btn-primary" />
                        <input id="ApplyContractNoId" type="button" onclick="ApplyContractNo()" value="申请修改" class="btn btn-primary" />
                    </div>
                </div>
                <div class="row">
                    <div id="div571046" class="col-md-2">
                        <label data-datafield="UpdateNoTbl" data-type="SheetLabel" id="ctl942068" class="" style="">合同号修改记录</label>
                    </div>
                    <div id="div665950" class="col-md-10">
                        <table id="ctl244908" data-datafield="UpdateNoTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl244908_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl244908_header0" data-datafield="UpdateNoTbl.Approver" style="width: 20%">
                                        <label id="ctl244908_Label0" data-datafield="UpdateNoTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl244908_header1" data-datafield="UpdateNoTbl.ApproveDate" style="width: 20%">
                                        <label id="ctl244908_Label1" data-datafield="UpdateNoTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl244908_header2" data-datafield="UpdateNoTbl.ContractNoNew" style="width: 40%">
                                        <label id="ctl244908_Label2" data-datafield="UpdateNoTbl.ContractNoNew" data-type="SheetLabel" style="">修改后合同号</label></td>
                                    <td id="ctl244908_header3" data-datafield="UpdateNoTbl.Status" style="" class="width:10%">
                                        <label id="ctl244908_Label3" data-datafield="UpdateNoTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl244908_header4" data-datafield="UpdateNoTbl.Operate" style="width: 10%">
                                        <label id="ctl244908_Label4" data-datafield="UpdateNoTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl244908_header5" data-datafield="UpdateNoTbl.WorkItemId" style="" class="">
                                        <label id="ctl244908_Label5" data-datafield="UpdateNoTbl.WorkItemId" data-type="SheetLabel" style="" class="hidden">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl244908_control0" data-datafield="UpdateNoTbl.Approver" style="">
                                        <input type="text" data-datafield="UpdateNoTbl.Approver" data-type="SheetTextBox" id="ctl244908_control0" style=""></td>
                                    <td id="ctl244908_control1" data-datafield="UpdateNoTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="UpdateNoTbl.ApproveDate" data-type="SheetTime" id="ctl244908_control1" style=""></td>
                                    <td id="ctl244908_control2" data-datafield="UpdateNoTbl.ContractNoNew" style="">
                                        <input type="text" data-datafield="UpdateNoTbl.ContractNoNew" data-type="SheetTextBox" id="ctl244908_control2" style=""></td>
                                    <td id="ctl244908_control3" data-datafield="UpdateNoTbl.Status" style="">
                                        <input type="text" data-datafield="UpdateNoTbl.Status" data-type="SheetTextBox" id="ctl244908_control3" style=""></td>
                                    <td id="ctl244908_control4" data-datafield="UpdateNoTbl.Operate" style="">
                                        <a onclick="viewUpdateNo(this)">查看</a>
                                    </td>
                                    <td id="ctl244908_control5" data-datafield="UpdateNoTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="UpdateNoTbl.WorkItemId" data-type="SheetTextBox" id="ctl244908_control5" style="" class=""></td>
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


                <div class="row">
                    <div id="div819234" class="col-md-2"><span id="Label29" data-type="SheetLabel" data-datafield="ContractRemark" style="" class="">合同说明</span></div>
                    <div id="div76797" class="col-md-10">
                        <textarea id="Control29" data-datafield="ContractRemark" data-type="SheetRichTextBox" style="" class="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title11" class="col-md-2">

                        <span id="Label22" data-type="SheetLabel" data-datafield="BidType" style="" class="">是否招标</span>
                    </div>
                    <div id="control11" class="col-md-4">

                        <div data-datafield="BidType" data-type="SheetRadioButtonList" id="ctl554304" class="" style="" data-masterdatacategory="是否招标"
                            data-onchange="BidTypeChange()">
                        </div>
                    </div>
                    <div id="title12" class="col-md-2 BidNo">

                        <span id="Label23" data-type="SheetLabel" data-datafield="BidNo" style="" class="">招标编号</span>
                    </div>
                    <div id="control12" class="col-md-4 BidNo">
                        <%--<input id="Control23" type="text" data-datafield="BidNo" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetBidProject" data-querycode="GetBidProject" data-outputmappings="ProjectShortNameHide:ProjectShortName,BidPriceHide:BidPrice,BidNo:ProjectCode">--%>
                        <%--<input id="Control23" type="text" data-datafield="BidNo" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetBidProject" data-querycode="GetBidPrices" data-outputmappings="ProjectShortNameHide:ProjectName,BidNoHide:BiddingCode,PackageNameHide:PackageName,TenderPriceNoHide:TenderPriceNo,BidPriceHide:TenderPrice" />--%>
                        <input id="Control15" type="text" data-datafield="BidNo" data-type="SheetTextBox" style="width: 70%" class="" ><a id="getBidNo" onclick="getBidNo()">选择</a>
                    </div>
                </div>

                <div class="row tableContent">
                    <div id="title15" class="col-md-2">
                        <span id="Label24" data-type="SheetLabel" data-datafield="BidTbl" style="" class="">招标详情</span>
                    </div>
                    <div id="control15" class="col-md-10">

                        <table id="ctl650771" data-datafield="BidTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl650771_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl650771_header0" data-datafield="BidTbl.ProjectName" style="">
                                        <label id="ctl650771_Label0" data-datafield="BidTbl.ProjectName" data-type="SheetLabel" style="">项目名称</label></td>
                                    <td id="ctl650771_header1" data-datafield="BidTbl.PackageName" style="">
                                        <label id="ctl650771_Label1" data-datafield="BidTbl.PackageName" data-type="SheetLabel" style="">包名</label></td>
                                    <td id="ctl650771_header1" data-datafield="BidTbl.TenderPriceNo" style="">
                                        <label id="ctl650771_Label1" data-datafield="BidTbl.TenderPriceNo" data-type="SheetLabel" style="">中标价序号</label></td>
                                    <td id="ctl650771_header1" data-datafield="BidTbl.BidPrice" style="">
                                        <label id="ctl650771_Label1" data-datafield="BidTbl.BidPrice" data-type="SheetLabel" style="">中标价</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl650771_control0" data-datafield="BidTbl.ProjectName" style="">
                                        <input type="text" data-datafield="BidTbl.ProjectName" data-type="SheetTextBox" id="ctl650771_control0" style="" class=""></td>
                                    <td id="ctl650771_control1" data-datafield="BidTbl.PackageName" style="">
                                        <input type="text" data-datafield="BidTbl.PackageName" data-type="SheetTextBox" id="ctl650771_control1" style=""></td>
                                    <td id="ctl650771_control1" data-datafield="BidTbl.TenderPriceNo" style="">
                                        <input type="text" data-datafield="BidTbl.TenderPriceNo" data-type="SheetTextBox" id="ctl650771_control1" style=""></td>
                                    <td id="ctl650771_control1" data-datafield="BidTbl.BidPrice" style="">
                                        <input type="text" data-datafield="BidTbl.BidPrice" data-type="SheetTextBox" id="ctl650771_control1" style=""></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                                <tr class="footer">
                                    <td></td>
                                    <td id="ctl650771_Stat0" data-datafield="BidTbl.ProjectName" style=""></td>
                                    <td id="ctl650771_Stat0" data-datafield="BidTbl.PackageName" style=""></td>
                                    <td id="ctl650771_Stat0" data-datafield="BidTbl.TenderPriceNo" style=""></td>
                                    <td id="ctl650771_Stat1" data-datafield="BidTbl.BidPrice" style="">
                                        <label id="ctl650771_StatControl1" data-datafield="BidTbl.BidPrice" data-type="SheetCountLabel" style=""></label>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="title17" class="col-md-2">
                        <span id="Label25" data-type="SheetLabel" data-datafield="Salers" style="">合同卖方</span>
                    </div>
                    <div id="control17" class="col-md-4">
                        <input id="Control25" type="text" data-datafield="Salers" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetContacts" data-querycode="GetContacts" data-outputmappings="CompanyNameSaler:CompanyName,ContactNameSaler:ContactName,TelephoneSaler:Telephone,MobileSaler:Mobile,FaxSaler:Fax,EmailSaler:Email" data-displaytext="增加" />

                    </div>
                    <div id="space18" class="col-md-2">
                    </div>
                    <div id="spaceControl18" class="col-md-4">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label26" data-type="SheetLabel" data-datafield="SalerTbl" style="">合同卖方详情</span>
                    </div>
                    <div id="control19" class="col-md-10">

                        <table id="ctl9895" data-datafield="SalerTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-displayadd="false" data-displaysequenceno="false" data-displaysummary="false"
                            data-onpreremove="rowPreRemoved(this,arguments);">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl9895_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl9895_header0" data-datafield="SalerTbl.CompanyName" style="">
                                        <label id="ctl9895_Label0" data-datafield="SalerTbl.CompanyName" data-type="SheetLabel" style="">公司名称</label></td>
                                    <td id="ctl9895_header1" data-datafield="SalerTbl.ContactName" style="">
                                        <label id="ctl9895_Label1" data-datafield="SalerTbl.ContactName" data-type="SheetLabel" style="">联系人</label></td>
                                    <td id="ctl9895_header2" data-datafield="SalerTbl.Telephone" style="">
                                        <label id="ctl9895_Label2" data-datafield="SalerTbl.Telephone" data-type="SheetLabel" style="">联系电话</label></td>
                                    <td id="ctl9895_header3" data-datafield="SalerTbl.Mobile" style="">
                                        <label id="ctl9895_Label3" data-datafield="SalerTbl.Mobile" data-type="SheetLabel" style="">手机</label></td>
                                    <td id="ctl9895_header4" data-datafield="SalerTbl.Fax" style="">
                                        <label id="ctl9895_Label4" data-datafield="SalerTbl.Fax" data-type="SheetLabel" style="">传真</label></td>
                                    <td id="ctl9895_header5" data-datafield="SalerTbl.Email" style="">
                                        <label id="ctl9895_Label5" data-datafield="SalerTbl.Email" data-type="SheetLabel" style="">邮箱</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl9895_control0" data-datafield="SalerTbl.CompanyName" style="">
                                        <input type="text" data-datafield="SalerTbl.CompanyName" data-type="SheetTextBox" id="ctl9895_control0" style=""></td>
                                    <td id="ctl9895_control1" data-datafield="SalerTbl.ContactName" style="">
                                        <input type="text" data-datafield="SalerTbl.ContactName" data-type="SheetTextBox" id="ctl9895_control1" style=""></td>
                                    <td id="ctl9895_control2" data-datafield="SalerTbl.Telephone" style="">
                                        <input type="text" data-datafield="SalerTbl.Telephone" data-type="SheetTextBox" id="ctl9895_control2" style=""></td>
                                    <td id="ctl9895_control3" data-datafield="SalerTbl.Mobile" style="">
                                        <input type="text" data-datafield="SalerTbl.Mobile" data-type="SheetTextBox" id="ctl9895_control3" style=""></td>
                                    <td id="ctl9895_control4" data-datafield="SalerTbl.Fax" style="">
                                        <input type="text" data-datafield="SalerTbl.Fax" data-type="SheetTextBox" id="ctl9895_control4" style=""></td>
                                    <td id="ctl9895_control5" data-datafield="SalerTbl.Email" style="">
                                        <input type="text" data-datafield="SalerTbl.Email" data-type="SheetTextBox" id="ctl9895_control5" style=""></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row hidden">
                    <div id="div981127" class="col-md-1">

                        <input type="text" data-datafield="UpdateNoFlg" data-type="SheetTextBox" id="ctl430538" class="hidden" style="">
                    </div>
                    <div id="div636227" class="col-md-1">
                        <input id="Control33" type="text" data-datafield="ApproveFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div869646" class="col-md-1">
                        <input id="Control34" type="text" data-datafield="OperateFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div616245" class="col-md-1">
                        <input id="Control35" type="text" data-datafield="CompleteFlg" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div902183" class="col-md-1">
                        <input id="Control27" type="text" data-datafield="ProjectCode" data-type="SheetTextBox" style="" class="hidden">
                        <input id="Control27" type="text" data-datafield="SubProjectCode" data-type="SheetTextBox" style="" class="hidden">
                    </div>
                    <div id="div144518" class="col-md-1">
                        <input type="text" data-datafield="ProjectShortNameHide" data-type="SheetTextBox" id="ctl713761" class="hidden" style="">
                        <input type="text" data-datafield="BidNoHide" data-type="SheetTextBox" id="ctl713761" class="hidden" style="">
                        <input type="text" data-datafield="PackageNameHide" data-type="SheetTextBox" id="ctl713761" class="hidden" style="">
                        <input type="text" data-datafield="TenderPriceNoHide" data-type="SheetTextBox" id="ctl713761" class="hidden" style="">
                    </div>
                    <div id="div748981" class="col-md-1">
                        <input type="text" data-datafield="BidPriceHide" data-type="SheetTextBox" id="ctl850357" class="hidden" style=""
                            data-onchange="BidPriceHideChange()">
                    </div>
                    <div id="div923019" class="col-md-1">
                        <input type="text" data-datafield="ToApproveSubFlg" data-type="SheetTextBox" id="ctl531535" class="hidden" style="">
                        <input type="text" data-datafield="IsMakeHYAgency" data-type="SheetTextBox" id="ctl531535" class="hidden" style="">
                    </div>
                    <div id="div30325" class="col-md-1">
                        <input type="text" data-datafield="AgencyReturnType" data-type="SheetTextBox" id="ctl795572" class="hidden" style="">
                        <input type="text" data-datafield="AgencyTheNo" data-type="SheetTextBox" id="ctl20086" class="hidden" style="">
                    </div>
                    <div id="div183080" class="col-md-1">
                        <input type="text" data-datafield="AgencyReturnNumber" data-type="SheetTextBox" id="ctl20086" class="hidden" style="" data-onchange="AgencySelectChange()">
                    </div>
                    <div id="div113087" class="col-md-1">
                        <input type="text" data-datafield="ToFileGDFlg" data-type="SheetTextBox" id="ctl441157" class="hidden" style="">
                    </div>
                    <div id="div994529" class="col-md-1">
                        <input type="text" data-datafield="ToChangeGDFlg" data-type="SheetTextBox" id="ctl333731" class="hidden" style="">
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div64600" class="col-md-1">
                        <input type="text" data-datafield="CompanyNameSaler" data-type="SheetTextBox" id="ctl918563" class="hidden" style="">
                    </div>
                    <div id="div804558" class="col-md-1">
                        <input type="text" data-datafield="ContactNameSaler" data-type="SheetTextBox" id="ctl555461" class="hidden" style="">
                    </div>
                    <div id="div318257" class="col-md-1">
                        <input type="text" data-datafield="TelephoneSaler" data-type="SheetTextBox" id="ctl249236" class="hidden" style="">
                    </div>
                    <div id="div861813" class="col-md-1">
                        <input type="text" data-datafield="MobileSaler" data-type="SheetTextBox" id="ctl462570" class="hidden" style="">
                    </div>
                    <div id="div55834" class="col-md-1">
                        <input type="text" data-datafield="FaxSaler" data-type="SheetTextBox" id="ctl230942" class="hidden" style="">
                    </div>
                    <div id="div781975" class="col-md-1">
                        <input type="text" data-datafield="EmailSaler" data-type="SheetTextBox" id="ctl877636" class="hidden" style=""
                            data-onchange="EmailSalerChange()">
                    </div>
                    <div id="div971066" class="col-md-1">
                        <input id="Control27" type="text" data-datafield="ProjectShortNameHidden" data-type="SheetTextBox" style="" class="hidden" >
                    </div>
                    <div id="div713749" class="col-md-1">
                        <input type="text" data-datafield="SubProjectShortNameHidden" data-type="SheetTextBox" id="ctl230942" class="hidden" style=""
                            data-onchange="setContractShortName()">
                    </div>
                    <div id="div113087" class="col-md-1">
                    </div>
                    <div id="div994529" class="col-md-1"></div>
                    <div id="div404099" class="col-md-1">
                        <input id="Control36" type="text" data-datafield="CurrentUserId" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div533925" class="col-md-1">
                        <input id="Control36" type="text" data-datafield="IsFirstProperty" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div55446" class="col-md-1">
                        <input id="Control36" type="text" data-datafield="WorkflowVersion_Update" data-type="SheetTextBox" class="hidden" style="">
                    </div>
                    <div id="div963713" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Payment" data-type="SheetTextBox" id="ctl8154" class="hidden" style="">
                    </div>
                    <div id="div771122" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Approve" data-type="SheetTextBox" id="ctl918303" class="hidden" style="">
                    </div>
                    <div id="div635604" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_QK" data-type="SheetTextBox" id="ctl665617" class="hidden" style="">
                    </div>
                    <div id="div674274" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_DK" data-type="SheetTextBox" id="ctl248815" class="hidden" style="">
                    </div>
                    <div id="div353093" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_FK" data-type="SheetTextBox" id="ctl895202" class="hidden" style="">
                    </div>
                    <div id="div164529" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_JS" data-type="SheetTextBox" id="ctl174502" class="hidden" style="">
                    </div>
                    <div id="div956556" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
                    </div>
                    <div id="div786533" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_PaymentUpdate" data-type="SheetTextBox" id="ctl191493" class="hidden" style="">
                    </div>
                    <div id="div659242" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_ImportLicense" data-type="SheetTextBox" id="ctl34414" class="" style="">
                    </div>
                    <div id="div528212" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_DH" data-type="SheetTextBox" id="ctl34414" class="" style="">
                    </div>
                    <div id="div860530" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_BG" data-type="SheetTextBox" id="ctl34414" class="" style="">
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div279531" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_BH" data-type="SheetTextBox" id="ctl857652" class="hidden" style="">
                        <input type="text" data-datafield="WorkflowVersion_BHInput" data-type="SheetTextBox" id="ctl857652" class="hidden" style="">
                    </div>
                    <div id="div439320" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_GD" data-type="SheetTextBox" id="ctl431668" class="hidden" style="">
                    </div>
                    <div id="div181150" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_GDChange" data-type="SheetTextBox" id="ctl331527" class="hidden" style="">
                    </div>
                    <div id="div283840" class="col-md-1">
                        <input type="text" data-datafield="PlanWorkItemId" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div438384" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Plan" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div48820" class="col-md-1">
                        <input type="text" data-datafield="AgencyCode" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div889201" class="col-md-1">
                        <input type="text" data-datafield="CurrencyRMB" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div575748" class="col-md-1">
                        <input type="text" data-datafield="CurrencyWB" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div712391" class="col-md-1">
                        <input type="text" data-datafield="IsComplete" data-type="SheetTextBox" id="" class="hidden" style="">
                    </div>
                    <div id="div187143" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_DHHY" data-type="SheetTextBox" id="ctl34414" class="" style="">
                    </div>
                    <div id="div839985" class="col-md-1">
                        <input type="text" data-datafield="WorkflowVersion_Cancel" data-type="SheetTextBox" id="ctl34414" class="" style="">
                    </div>
                    <div id="div445043" class="col-md-1">
                        <%--<input type="text" data-datafield="BGFinishTime" data-type="SheetTime" id="ctl107917" class="" style="" data-defaultvalue="" data-minvalue="" data-maxvalue="" data-timemode="FullTime"></div>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentApprove">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleApprove">
                <label id="divSheetInfo" data-en_us="Sheet information">合同审签&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">

                <div class="row HYDiv">
                    <div id="div591001" class="col-md-2">
                        <label data-datafield="ValuationType" data-type="SheetLabel" id="ctl309168" class="" style="">计价方式</label>
                    </div>
                    <div id="div805853" class="col-md-4">
                        基准油价<input type="text" data-datafield="ValuationType" data-type="SheetTextBox" id="ctl882739" class="" style="width: 30%;">
                        贴水等<input type="text" data-datafield="Agio" data-type="SheetTextBox" id="ctl974087" class="" style="width: 30%;">
                    </div>
                    <div id="div537031" class="col-md-6"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div497853" class="col-md-2">
                        <label data-datafield="DHDate" data-type="SheetLabel" id="ctl527956" class="" style="">到货日期</label>
                    </div>
                    <div id="div339212" class="col-md-4">
                        <input type="text" data-datafield="DHDate" data-type="SheetTextBox" id="ctl893958" class="" style="">
                    </div>
                    <div id="div758504" class="col-md-2"></div>
                    <div id="div419953" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div676455" class="col-md-2">
                        <label data-datafield="AgencyComputerType" data-type="SheetLabel" id="ctl555578" class="" style="">代理费费率／金额</label>
                    </div>
                    <div id="div153436" class="col-md-2">
                        <input type="text" data-datafield="AgencyComputerNum" data-type="SheetTextBox" id="ctl635775" class="" style="">
                    </div>
                    <div id="div168900" class="col-md-2">
                        <select data-datafield="AgencyComputerType" data-type="SheetDropDownList" id="ctl687968" class="" style="" data-masterdatacategory="代理费费率／金额"  data-queryable="false"></select>
                    </div>
                    <div id="div271411" class="col-md-2"></div>
                    <div id="div239672" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div318802" class="col-md-2">
                        <label data-datafield="PayCondition" data-type="SheetLabel" id="ctl39955" class="" style="">支付条件</label>
                    </div>
                    <div id="div790674" class="col-md-4">
                        <textarea data-datafield="PayCondition" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl441176" class=""></textarea>
                    </div>
                    <div id="div159260" class="col-md-2"></div>
                    <div id="div976975" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="div425062" class="col-md-2">
                        <label data-datafield="ContractFile" data-type="SheetLabel" id="ctl958368" class="" style="">合同文本</label>
                    </div>
                    <div id="div56822" class="col-md-4">
                        <input type="text" data-datafield="ContractFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="ContractFile"></div>
                    </div>
                    <div id="div984497" class="col-md-2"></div>
                    <div id="div461201" class="col-md-4"></div>
                </div>
                <div class="row NotHYDiv">
                    <div id="div995184" class="col-md-2">
                        <label data-datafield="AgencyType" data-type="SheetLabel" id="ctl242241" class="" style="">代理协议类型</label>
                    </div>
                    <div id="div972298" class="col-md-4">
                        <select data-datafield="AgencyType" data-type="SheetDropDownList" id="ctl487547" class="" style="" data-masterdatacategory="合同审签_代理协议类型"
                            data-onchange=" AgencyTypeChange()"  data-queryable="false">
                        </select>
                    </div>
                    <div id="div176197" class="col-md-2"></div>
                    <div id="div246960" class="col-md-4"></div>
                </div>
                <div class="row HYDiv">
                    <div id="div577714" class="col-md-2 ">
                        <label data-datafield="AgencyFile" data-type="SheetLabel" id="ctl164811" class="" style="">代理协议</label>
                    </div>
                    <div id="div526037" class="col-md-4 ">
                        <input type="text" data-datafield="AgencyFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="AgencyFile"></div>
                    </div>
                    <div id="div648309" class="col-md-2"></div>
                    <div id="div596356" class="col-md-4"></div>
                </div>
                <div class="row NotHYDiv AgencySelect">
                    <div id="div504622" class="col-md-2">
                        <label data-datafield="AgencySelect" data-type="SheetLabel" id="ctl786999" class="" style="">代理协议</label>
                    </div>
                    <div id="div673101" class="col-md-4">
                        <input type="text" data-datafield="AgencySelect" data-type="SheetTextBox" id="ctl112592" class="" style="" data-popupwindow="PopupWindow" data-schemacode="GetAgencyList" data-querycode="GetAgencyList"        data-outputmappings="AgencyCode:AgreeMent_number,AgencySelect:AgreeMent_name,AgencyReturnType:agency_type_name,AgencyTheNo:No,AgencyReturnNumber:number">
                    </div>
                    <div id="div816716" class="col-md-2"></div>
                    <div id="div407087" class="col-md-4"></div>
                </div>
                <div class="row NotHYDiv AgencyComment">
                    <div id="div99231" class="col-md-2">
                    </div>
                    <div id="div471324" class="col-md-4">
                        <input type="text" data-datafield="AgencyComment" data-type="SheetTextBox" id="ctl475289" class="AgencyComment2" style="">
                        <div data-datafield="IsCompAgencyFeeByContPrice" data-type="SheetCheckboxList" id="ctl4352" class="IsCompAgencyFeeByContPrice" style="display:none" data-repeatcolumns="1" data-defaultitems="是否按合同价计算代理费" data-onchange="IsCompAgencyFeeByContPriceChange()"></div>
                    </div>
                    <div id="div286577" class="col-md-2"></div>
                    <div id="div989625" class="col-md-4"></div>
                </div>
                <div class="row NotHYDiv AgencyAfterRemark">
                    <div id="div603877" class="col-md-2 ">
                        <label data-datafield="AgencyAfterRemark" data-type="SheetLabel" id="ctl843121" class="" style="">协议后审说明</label>
                    </div>
                    <div id="div874609" class="col-md-4 ">
                        <textarea data-datafield="AgencyAfterRemark" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl49807" class=""></textarea>
                    </div>
                    <div id="div587382" class="col-md-2"></div>
                    <div id="div836047" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="div322025" class="col-md-2">
                        <label data-datafield="TalkFile" data-type="SheetLabel" id="ctl879399" class="" style="">合同谈判小结</label>
                    </div>
                    <div id="div216757" class="col-md-4">
                        <input type="text" data-datafield="TalkFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="TalkFile"></div>
                    </div>
                    <div id="div70794" class="col-md-2"></div>
                    <div id="div84672" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="div185854" class="col-md-2"><span id="Label31" data-type="SheetLabel" data-datafield="ContractApproveTbl" style="" class="">合同审签子表</span></div>
                    <div id="div448637" class="col-md-8">
                        <table id="ctl735291" data-datafield="ContractApproveTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl735291_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl735291_header0" data-datafield="ContractApproveTbl.Approver" style="">
                                        <label id="ctl735291_Label0" data-datafield="ContractApproveTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl735291_header1" data-datafield="ContractApproveTbl.ApproveDate" style="">
                                        <label id="ctl735291_Label1" data-datafield="ContractApproveTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl735291_header2" data-datafield="ContractApproveTbl.Status" style="">
                                        <label id="ctl735291_Label2" data-datafield="ContractApproveTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl735291_header3" data-datafield="ContractApproveTbl.Operate" style="">
                                        <label id="ctl735291_Label3" data-datafield="ContractApproveTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl735291_header4" data-datafield="ContractApproveTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl735291_Label4" data-datafield="ContractApproveTbl.WorkItemId" data-type="SheetLabel" style="" class="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl735291_control0" data-datafield="ContractApproveTbl.Approver" style="">
                                        <input type="text" data-datafield="ContractApproveTbl.Approver" data-type="SheetTextBox" id="ctl735291_control0" style=""></td>
                                    <td id="ctl735291_control1" data-datafield="ContractApproveTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="ContractApproveTbl.ApproveDate" data-type="SheetTextBox" id="ctl735291_control1" style=""></td>
                                    <td id="ctl735291_control2" data-datafield="ContractApproveTbl.Status" style="">
                                        <input type="text" data-datafield="ContractApproveTbl.Status" data-type="SheetTextBox" id="ctl735291_control2" style=""></td>
                                    <td id="ctl735291_control3" data-datafield="ContractApproveTbl.Operate" style="">
                                        <a onclick="viewApprove(this)" class="btn btn-primary">查看</a></td>
                                    <td id="ctl735291_control4" data-datafield="ContractApproveTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="ContractApproveTbl.WorkItemId" data-type="SheetTextBox" id="ctl735291_control4" style=""></td>
                                    <td class="rowOption hidden"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="div903109" class="col-md-2">
                        <input id="ApplyApproveId" type="button" onclick="ApplyApprove()" value="申请审批" class="btn btn-primary">
                    </div>
                </div>
                <div class="row ">
                    <div id="div638078" class="col-md-2">
                        <label data-datafield="SignDate" data-type="SheetLabel" id="ctl436044" class="" style="">合同签约日期</label>
                    </div>
                    <div id="div798456" class="col-md-4">
                        <input type="text" data-datafield="SignDate" data-type="SheetTime" id="ctl989788" class="" style="">
                    </div>
                    <div id="div61755" class="col-md-2"></div>
                    <div id="div748575" class="col-md-4"></div>
                </div>
                <div class="row NotHYDiv">
                    <div id="div102678" class="col-md-2"><span id="Label30" data-type="SheetLabel" data-datafield="ContractTotalPrice" style="" class="">合同金额</span></div>
                    <div id="div333350" class="col-md-2 AmountFormat normal">
                        <input id="Control30" type="text" data-datafield="ContractTotalPrice" data-type="SheetTextBox" style="" class="AmountFormat" data-onchange="compRMBAmount()">
                    </div>
                    <div id="div384808" class="col-md-2 normal"><span>人民币</span></div>
                    <div id="div389018" class="col-md-4"></div>
                </div>
                
                
                <div class="row HYDiv">
                    <div id="div640393" class="col-md-2">
                        <label data-datafield="AgencySignDate" data-type="SheetLabel" id="ctl704247" class="" style="">代理协议签约日期</label>
                    </div>
                    <div id="div42682" class="col-md-4">
                        <input type="text" data-datafield="AgencySignDate" data-type="SheetTime" id="ctl148571" class="" style="">
                    </div>
                    <div id="div417768" class="col-md-2"></div>
                    <div id="div883520" class="col-md-4"></div>
                </div>
                

                <div class="row JKDiv">
                    <div id="div654502" class="col-md-2">
                        <label > </label>
                    </div>
                    <div id="div90010" class="col-md-2 AmountFormat normal">
                        <input type="text" data-datafield="JKTotalAmount" data-type="SheetTextBox" id="ctl607049" class="AmountFormat" style="" data-onchange="compRMBAmount()">
                    </div>
                    <div id="div516252" class="col-md-2" style="text-align: left;">
                        <select data-datafield="Currency" data-type="SheetDropDownList" id="ctl762014" class="" style="" data-masterdatacategory="币种" data-displayemptyitem="true" data-emptyitemtext="请选择币种" data-queryable="false"></select>
                    </div>
                    <div id="div495876" class="col-md-2"></div>
                    <div id="div957115" class="col-md-4"></div>
                </div>
                <div class="row JKDiv">
                    <div id="div444593" class="col-md-2">
                        <label data-datafield="SignDayExchangeRate" data-type="SheetLabel" id="ctl509615" class="" style="">签约日汇率</label>
                    </div>
                    <div id="div861077" class="col-md-2">
                        <input type="text" data-datafield="SignDayExchangeRate" data-type="SheetTextBox" id="ctl354871" class="AmountFormat5"  style="" data-onchange="compRMBAmount()">
                    </div>
                    <div id="div700890" class="col-md-2"></div>
                    <div id="div383009" class="col-md-4"></div>
                </div>
                <div class="row JKDiv">
                    <div id="div416464" class="col-md-2">
                        <label data-datafield="SignDayERFile" data-type="SheetLabel" id="ctl15073" class="" style="">签约日汇率截屏文件</label>
                    </div>
                    <div id="div497071" class="col-md-4">
                        <input type="text" data-datafield="SignDayERFile" data-type="SheetTextBox" id="" class="hidden" style="">
                        <div id="SignDayERFile"></div>
                    </div>
                    <div id="div125121" class="col-md-2"></div>
                    <div id="div209699" class="col-md-4"></div>
                </div>
                <div class="row JKDiv">
                    <div id="div231460" class="col-md-2">
                        <label data-datafield="RMBTotalAmount" data-type="SheetLabel" id="ctl107853" class="" style="">对应人民币总金额</label>
                    </div>
                    <div id="div987394" class="col-md-2 AmountFormat normal">
                        <input type="text" data-datafield="RMBTotalAmount" data-type="SheetTextBox" id="ctl832089" class="AmountFormat" style="">
                    </div>
                    <div id="div99069" class="col-md-2 normal"><span>人民币</span></div>
                    <div id="div185821" class="col-md-4"></div>
                </div>
                <div class="row">
                    <div id="title25" class="col-md-2">

                        <label data-datafield="ContractDHDate" data-type="SheetLabel" id="ctl417392" class="" style="">合同到货期</label>
                    </div>
                    <div id="control25" class="col-md-4">

                        <textarea data-datafield="ContractDHDate" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl788665" class=""></textarea>
                    </div>
                    <div id="space26" class="col-md-6">
                    </div>

                </div>

            </div>
        </div>

        <div class="ContractContent ContractContentOperate">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleOperate">
                <label id="divSheetInfo" data-en_us="Sheet information">合同执行&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div224886" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJQKAmountRMB" data-type="SheetLabel" id="ctl660288" class="" style="">累计合同请款</label>
                    </div>
                    <div id="div687715" class="col-md-2 normal">
                        <input type="text" data-datafield="LJQKAmountRMB" data-type="SheetTextBox" id="ctl840693" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div812484" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJDKAmountRMB" data-type="SheetLabel" id="ctl403889" class="" style="">累计合同到款</label>
                    </div>
                    <div id="div136354" class="col-md-2 normal">
                        <input type="text" data-datafield="LJDKAmountRMB" data-type="SheetTextBox" id="ctl74304" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div721846" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJFKAmountRMB" data-type="SheetLabel" id="ctl997203" class="" style="">累计合同支付</label>
                    </div>
                    <div id="div660990" class="col-md-2 normal">
                        <input type="text" data-datafield="LJFKAmountRMB" data-type="SheetTextBox" id="ctl282662" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div265825" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="FKPercentRMB" data-type="SheetLabel" id="ctl453574" class="" style="">支付占合同比例</label>
                    </div>
                    <div id="div185980" class="col-md-2 normal">
                        <span class="CurrencyRMB"></span>&nbsp;<input type="text" data-datafield="FKPercentRMB" data-type="SheetTextBox" id="ctl678661" class="" style="width:70%">
                    </div>
                </div>
                <div class="row">
                    <div id="div134229" class="col-md-1">
                    </div>
                    <div id="div847461" class="col-md-2 normal">
                        <input type="text" data-datafield="LJQKAmountWB" data-type="SheetTextBox" id="ctl970599" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div683527" class="col-md-1">
                    </div>
                    <div id="div320914" class="col-md-2 normal">
                        <input type="text" data-datafield="LJDKAmountWB" data-type="SheetTextBox" id="ctl215968" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div270272" class="col-md-1">
                    </div>
                    <div id="div558721" class="col-md-2 normal">
                        <input type="text" data-datafield="LJFKAmountWB" data-type="SheetTextBox" id="ctl201874" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div632290" class="col-md-1">
                    </div>
                    <div id="div866189" class="col-md-2 normal">
                        <span class="CurrencyWB"></span>&nbsp;<input type="text" data-datafield="FKPercentWB" data-type="SheetTextBox" id="ctl258919" class="" style="width:70%">
                    </div>
                </div>
                <div class="row JKDiv">
                    <div id="div134229" class="col-md-1">
                    </div>
                    <div id="div847461" class="col-md-2">
                    </div>
                    <div id="div683527" class="col-md-1">
                    </div>
                    <div id="div320914" class="col-md-2">
                    </div>
                    <div id="div270272" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJBGAmount" data-type="SheetLabel" id="ctl453574" class="" style=""></label>
                    </div>
                    <div id="div558721" class="col-md-2 normal">
                        <input type="text" data-datafield="LJBGAmount" data-type="SheetTextBox" id="ctl201874" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div632290" class="col-md-1">
                    </div>
                    <div id="div866189" class="col-md-2">
                    </div>
                </div>
                <div class="row">
                    <div id="div488717" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJQKFYAmountRMB" data-type="SheetLabel" id="ctl727073" class="" style="">累计费用请款</label>
                    </div>
                    <div id="div794797" class="col-md-2 normal">
                        <input type="text" data-datafield="LJQKFYAmountRMB" data-type="SheetTextBox" id="ctl381391" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div81804" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJDKFYAmountRMB" data-type="SheetLabel" id="ctl580462" class="" style="">累计费用到款</label>
                    </div>
                    <div id="div565525" class="col-md-2 normal">
                        <input type="text" data-datafield="LJDKFYAmountRMB" data-type="SheetTextBox" id="ctl315575" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div960865" class="col-md-1 fmtBlod RowHeight">
                        <label data-datafield="LJFKFYAmountRMB" data-type="SheetLabel" id="ctl477932" class="" style="">累计费用支付</label>
                    </div>
                    <div id="div286420" class="col-md-2 RowHeight normal">
                        <input type="text" data-datafield="LJFKFYAmountRMB" data-type="SheetTextBox" id="ctl500501" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyRMB"></span>
                    </div>
                    <div id="div102838" class="col-md-1"></div>
                    <div id="div225032" class="col-md-2"></div>
                </div>
                <div class="row">
                    <div id="div442567" class="col-md-1">
                    </div>
                    <div id="div585082" class="col-md-2 normal">
                        <input type="text" data-datafield="LJQKFYAmountWB" data-type="SheetTextBox" id="ctl905758" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div875561" class="col-md-1">
                    </div>
                    <div id="div54228" class="col-md-2 normal">
                        <input type="text" data-datafield="LJDKFYAmountWB" data-type="SheetTextBox" id="ctl748190" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div94798" class="col-md-1">
                    </div>
                    <div id="div184595" class="col-md-2 normal">
                        <input type="text" data-datafield="LJFKFYAmountWB" data-type="SheetTextBox" id="ctl748645" class="AmountFormat" style="width:60%">&nbsp;<span class="CurrencyWB"></span>
                    </div>
                    <div id="div876477" class="col-md-1"></div>
                    <div id="div149261" class="col-md-2"></div>
                </div>
                <!-- 分割线 -->
                <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 13px 0px 13px 0px;">
                </div>
                <div class="Content_Tab">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation"><a href="#zfgltab" aria-controls="zfgltab" role="tab" data-toggle="tab" onclick="getPayManagers()">支付管理</a></li>
                        <li role="presentation"><a href="#plantab" aria-controls="plantab" role="tab" data-toggle="tab" class="OperatePlan">资金计划</a></li>
                        <li role="presentation" class="active"><a href="#qktab" aria-controls="qktab" role="tab" data-toggle="tab" class="OperateQK" onclick="getQKs()">请款</a></li>
                        <li role="presentation"><a href="#dktab" aria-controls="dktab" role="tab" data-toggle="tab" class="OperateDK" onclick="getDKs()">到款</a></li>
                        <li role="presentation"><a href="#fktab" aria-controls="fktab" role="tab" data-toggle="tab" class="OperateFK" onclick="getFKs()">付款</a></li>
                        <li role="presentation"><a href="#jstab" aria-controls="jstab" role="tab" data-toggle="tab" class="OperateJS" onclick="getJSs()">结算</a></li>

                        <li role="presentation"><a href="#xyztab" aria-controls="xyztab" role="tab" data-toggle="tab" class="OperatePayment" onclick="getPayments()">信用证</a></li>
                        <li role="presentation"><a href="#importlicensetab" aria-controls="importlicensetab" role="tab" data-toggle="tab" class="OperateImport" onclick="getImports()">进口许可证</a></li>
                        <li role="presentation"><a href="#dhtab" aria-controls="dhtab" role="tab" data-toggle="tab" class="OperateDH" onclick="getDHs()">到货</a></li>
                        <li role="presentation"><a href="#bgtab" aria-controls="bgtab" role="tab" data-toggle="tab" class="OperateBG" onclick="getBGs()">合同变更</a></li>
                        <li role="presentation"><a href="#bhtab" aria-controls="bhtab" role="tab" data-toggle="tab" class="OperateBH" onclick="getBHs()">保函</a></li>
                        <li role="presentation"><a href="#gdtab" aria-controls="gdtab" role="tab" data-toggle="tab" class="OperateWC">合同文件</a></li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane" id="zfgltab">
                            <div class="row tableContent">
                                <div id="div42936" class="col-md-12">
                                    <table id="ctl966154" data-datafield="PayManagerTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td colspan="2" style="text-align:center">
                                                    <a class="btn btn-primary createZJPlan" onclick="createZJPlan(this)" disabled>创建资金计划</a></td>
                                                <td colspan="3" style="text-align:center">
                                                    <a class="btn btn-primary applyQK" onclick="applyQK(this)" disabled>请款申请</a></td>
                                                <td colspan="2" style="text-align:center">
                                                    <a class="btn btn-primary applyDK" onclick="applyDK(this)" disabled>到款申请</a></td>
                                                <td colspan="3" style="text-align:center">
                                                    <a class="btn btn-primary applyFK" onclick="applyFK(this)" disabled>付款申请</a></td>
                                                <td colspan="3" style="text-align:center">
                                                    <a class="btn btn-primary applyJS" onclick="applyJS(this)" disabled>结算申请</a></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="header">
                                                <td id="ctl966154_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl966154_header0" data-datafield="PayManagerTbl.ZJPlanContent" style="">
                                                    <label id="ctl966154_Label0" data-datafield="PayManagerTbl.ZJPlanContent" data-type="SheetLabel" style="">资金计划描述</label></td>
                                                <td id="ctl966154_header1" data-datafield="PayManagerTbl.ZJPlanAmount" style="">
                                                    <label id="ctl966154_Label1" data-datafield="PayManagerTbl.ZJPlanAmount" data-type="SheetLabel" style="">资金计划金额</label></td>
                                                <td id="ctl966154_header2" data-datafield="PayManagerTbl.QKZJMS" style="">
                                                    <label id="ctl966154_Label2" data-datafield="PayManagerTbl.QKZJMS" data-type="SheetLabel" style="">请款描述</label></td>
                                                <td id="ctl966154_header3" data-datafield="PayManagerTbl.QKAmount" style="">
                                                    <label id="ctl966154_Label3" data-datafield="PayManagerTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label></td>
                                                <td id="ctl966154_header4" data-datafield="PayManagerTbl.QKDate" style="">
                                                    <label id="ctl966154_Label4" data-datafield="PayManagerTbl.QKDate" data-type="SheetLabel" style="">请款日期</label></td>
                                                <td id="ctl966154_header5" data-datafield="PayManagerTbl.QKSeq" style="" class="hidden">
                                                    <label id="ctl966154_Label5" data-datafield="PayManagerTbl.QKSeq" data-type="SheetLabel" style="">请款批次</label></td>
                                                <td id="ctl966154_header6" data-datafield="PayManagerTbl.QKTheNo" style="" class="hidden">
                                                    <label id="ctl966154_Label6" data-datafield="PayManagerTbl.QKTheNo" data-type="SheetLabel" style="">请款子表序号</label></td>
                                                <td id="ctl966154_header7" data-datafield="PayManagerTbl.DKTotalAmount" style="">
                                                    <label id="ctl966154_Label7" data-datafield="PayManagerTbl.DKTotalAmount" data-type="SheetLabel" style="">到款金额</label></td>
                                                <td id="ctl966154_header9" data-datafield="PayManagerTbl.DKStatus" style="">
                                                    <label id="ctl966154_Label9" data-datafield="PayManagerTbl.DKStatus" data-type="SheetLabel" style="">到款状态</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.DKBizObjectID" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.DKBizObjectID" data-type="SheetLabel" style="">到款BizObjectID</label></td>
                                                <td id="ctl966154_header11" data-datafield="PayManagerTbl.FKAmount" style="">
                                                    <label id="ctl966154_Label11" data-datafield="PayManagerTbl.FKAmount" data-type="SheetLabel" style="">付款金额</label></td>
                                                <td id="ctl966154_header12" data-datafield="PayManagerTbl.FKZKMS" style="">
                                                    <label id="ctl966154_Label12" data-datafield="PayManagerTbl.FKZKMS" data-type="SheetLabel" style="">付款描述</label></td>
                                                <td id="ctl966154_header13" data-datafield="PayManagerTbl.FKDate" style="">
                                                    <label id="ctl966154_Label13" data-datafield="PayManagerTbl.FKDate" data-type="SheetLabel" style="">支付日期</label></td>
                                                <td id="ctl966154_header14" data-datafield="PayManagerTbl.FKTblObjectID" style="" class="hidden">
                                                    <label id="ctl966154_Label14" data-datafield="PayManagerTbl.FKTblObjectID" data-type="SheetLabel" style="" class="">付款子表的ObjectID</label></td>
                                                <td id="ctl966154_header15" data-datafield="PayManagerTbl.JSStatus" style="">
                                                    <label id="ctl966154_Label15" data-datafield="PayManagerTbl.JSStatus" data-type="SheetLabel" style="">结算状态</label></td>
                                                <td id="ctl966154_header16" data-datafield="PayManagerTbl.SubsFee" style="">
                                                    <label id="ctl966154_Label16" data-datafield="PayManagerTbl.SubsFee" data-type="SheetLabel" style="">扣除费用</label></td>
                                                <td id="ctl966154_header17" data-datafield="PayManagerTbl.JSRecAndRemainFee" style="">
                                                    <label id="ctl966154_Label17" data-datafield="PayManagerTbl.JSRecAndRemainFee" data-type="SheetLabel" style="">结算记录及余额</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKObjectID" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKObjectID" data-type="SheetLabel" style="">QKObjectID</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKSubObjectID" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKSubObjectID" data-type="SheetLabel" style="">QKSubObjectID</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKAmountCnt" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKAmountCnt" data-type="SheetLabel" style="">QKAmountCnt</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKCnt" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKCnt" data-type="SheetLabel" style="">QKCnt</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKCurrencyCnt" data-type="SheetLabel" style="">QKCurrencyCnt</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKCurrency" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKCurrency" data-type="SheetLabel" style="">QKCurrency</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.FKObjectID" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.FKObjectID" data-type="SheetLabel" style="">FKObjectID</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.Cnt" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.Cnt" data-type="SheetLabel" style="">Cnt</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.FKCnt" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.FKCnt" data-type="SheetLabel" style="">FKCnt</label></td>
                                                <td id="ctl966154_header10" data-datafield="PayManagerTbl.QKType" style="" class="hidden">
                                                    <label id="ctl966154_Label10" data-datafield="PayManagerTbl.QKType" data-type="SheetLabel" style="">QKType</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl966154_control0" data-datafield="PayManagerTbl.ZJPlanContent" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.ZJPlanContent" data-type="SheetTextBox" id="ctl966154_control0" style=""></td>
                                                <td id="ctl966154_control1" data-datafield="PayManagerTbl.ZJPlanAmount" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.ZJPlanAmount" data-type="SheetTextBox" id="ctl966154_control1" style=""></td>
                                                <td id="ctl966154_control2" data-datafield="PayManagerTbl.QKZJMS" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.QKZJMS" data-type="SheetTextBox" id="ctl966154_control2" style=""></td>
                                                <td id="ctl966154_control3" data-datafield="PayManagerTbl.QKAmount" style="width:8%">
                                                    <div class="QKAmount" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control4" data-datafield="PayManagerTbl.QKDate" style="width:6.5%">
                                                    <input type="text" data-datafield="PayManagerTbl.QKDate" data-type="SheetTextBox" id="ctl966154_control4" style=""></td>
                                                <td id="ctl966154_control5" data-datafield="PayManagerTbl.QKSeq" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKSeq" data-type="SheetTextBox" id="ctl966154_control5" style=""></td>
                                                <td id="ctl966154_control6" data-datafield="PayManagerTbl.QKTheNo" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKTheNo" data-type="SheetTextBox" id="ctl966154_control6" style=""></td>
                                                <td id="ctl966154_control7" data-datafield="PayManagerTbl.DKTotalAmount" style="width:12%">
                                                    <div class="DKTotalAmount" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control9" data-datafield="PayManagerTbl.DKStatus" style="width:6%">
                                                    <input type="text" data-datafield="PayManagerTbl.DKStatus" data-type="SheetTextBox" id="ctl966154_control9" style=""></td>
                                                <td id="ctl966154_control10" data-datafield="PayManagerTbl.DKBizObjectID" style="" class="hidden">
                                                    <div class="DKBizObjectID" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control11" data-datafield="PayManagerTbl.FKAmount" style="width:8%">
                                                    <div class="FKAmount" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control12" data-datafield="PayManagerTbl.FKZKMS" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.FKZKMS" data-type="SheetTextBox" id="ctl966154_control12" style=""></td>
                                                <td id="ctl966154_control13" data-datafield="PayManagerTbl.FKDate" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.FKDate" data-type="SheetTextBox" id="ctl966154_control13" style=""></td>
                                                <td id="ctl966154_control14" data-datafield="PayManagerTbl.FKTblObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.FKTblObjectID" data-type="SheetTextBox" id="ctl966154_control14" style="" class=""></td>
                                                <td id="ctl966154_control15" data-datafield="PayManagerTbl.JSStatus" style="">
                                                    <input type="text" data-datafield="PayManagerTbl.JSStatus" data-type="SheetTextBox" id="ctl966154_control15" style=""></td>
                                                <td id="ctl966154_control16" data-datafield="PayManagerTbl.SubsFee" style="">
                                                    <div class="SubsFee" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control17" data-datafield="PayManagerTbl.JSRecAndRemainFee" style="">
                                                    <div class="JSRecAndRemainFee" style="width: 95%;background-color:white;resize:none;border:0;overflow-y: hidden" ></div></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKObjectID" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKSubObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKSubObjectID" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKAmountCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKAmountCnt" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKCnt" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKCurrencyCnt" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKCurrency" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKCurrency" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.FKObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.FKObjectID" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.Cnt" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.Cnt" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.FKCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.FKCnt" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
                                                <td id="ctl966154_control18" data-datafield="PayManagerTbl.QKType" style="" class="hidden">
                                                    <input type="text" data-datafield="PayManagerTbl.QKType" data-type="SheetTextBox" id="ctl966154_control18" style=""></td>
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

                        <div role="tabpanel" class="tab-pane " id="plantab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="EditZJPlanId" type="button" onclick="EditZJPlan()" class="btn btn-primary" value="编辑资金计划" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl357831" data-datafield="ZJPlanMainTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-displayadd="false" data-displaydelete="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl357831_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl357831_header0" data-datafield="ZJPlanMainTbl.Content" style="width: 25%">
                                                    <label id="ctl357831_Label0" data-datafield="ZJPlanMainTbl.Content" data-type="SheetLabel" style="">资金描述</label></td>
                                                <td id="ctl357831_header1" data-datafield="ZJPlanMainTbl.QKCurrency" style="width: 10%">
                                                    <label id="ctl357831_Label1" data-datafield="ZJPlanMainTbl.QKCurrency" data-type="SheetLabel" style="">请款币种</label></td>
                                                <td id="ctl357831_header2" data-datafield="ZJPlanMainTbl.ExpirationFrom" style="width: 10%">
                                                    <label id="ctl357831_Label2" data-datafield="ZJPlanMainTbl.ExpirationFrom" data-type="SheetLabel" style="">有效期开始日</label></td>
                                                <td id="ctl357831_header3" data-datafield="ZJPlanMainTbl.ExpirationTo" style="width: 10%">
                                                    <label id="ctl357831_Label3" data-datafield="ZJPlanMainTbl.ExpirationTo" data-type="SheetLabel" style="">有效期结束日</label></td>
                                                <td id="ctl357831_header4" data-datafield="ZJPlanMainTbl.IsAfterDK" style="" class="width:10%">
                                                    <label id="ctl357831_Label4" data-datafield="ZJPlanMainTbl.IsAfterDK" data-type="SheetLabel" style="">是否到款后</label></td>
                                                <td id="ctl357831_header1" data-datafield="ZJPlanMainTbl.Amount" style="width: 25%">
                                                    <label id="ctl357831_Label1" data-datafield="ZJPlanMainTbl.Amount" data-type="SheetLabel" style="">金额（人民币）</label></td>

                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl357831_control0" data-datafield="ZJPlanMainTbl.Content" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.Content" data-type="SheetTextBox" id="ctl357831_control0" style=""></td>
                                                <td id="ctl357831_control1" data-datafield="ZJPlanMainTbl.QKCurrency" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.QKCurrency" data-type="SheetTextBox" id="ctl357831_control1" style=""></td>
                                                <td id="ctl357831_control2" data-datafield="ZJPlanMainTbl.ExpirationFrom" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.ExpirationFrom" data-type="SheetTextBox" id="ctl357831_control2" style=""></td>
                                                <td id="ctl357831_control3" data-datafield="ZJPlanMainTbl.ExpirationTo" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.ExpirationTo" data-type="SheetTextBox" id="ctl357831_control3" style=""></td>
                                                <td id="ctl357831_control4" data-datafield="ZJPlanMainTbl.IsAfterDK" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.IsAfterDK" data-type="SheetTextBox" id="ctl357831_control4" style=""></td>
                                                <td id="ctl357831_control1" data-datafield="ZJPlanMainTbl.Amount" style="">
                                                    <input type="text" data-datafield="ZJPlanMainTbl.Amount" data-type="SheetTextBox" id="ctl357831_control1" style=""></td>

                                                <td class="rowOption hidden"><a class="delete">
                                                    <div class="fa fa-minus"></div>
                                                </a><a class="insert">
                                                    <div class="fa fa-arrow-down"></div>
                                                </a></td>
                                            </tr>
                                            <%--<tr class="footer">
                                                <td colspan="6">汇总</td>
                                                <td id="ctl357831_Stat1" data-datafield="ZJPlanMainTbl.Amount" style="">
                                                    <label id="ctl357831_StatControl1" data-datafield="ZJPlanMainTbl.Amount" data-type="SheetCountLabel" style=""></label>
                                                </td>
                                                <td class="hidden"></td>
                                            </tr>--%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div404042" class="col-md-2">
                                    <label data-datafield="ZJPlanRemark" data-type="SheetLabel" id="ctl307882" class="" style="">资金计划备注</label>
                                </div>
                                <div id="div659881" class="col-md-10 RowHeight">
                                    <textarea data-datafield="ZJPlanRemark" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl514325" class=""></textarea>
                                </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane active" id="qktab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveQKId" type="button" onclick="ApproveQK()" class="btn btn-primary" value="请款申请" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl178624" data-datafield="QKMainTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl178624_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl178624_header0" data-datafield="QKMainTbl.QKSeq" style="">
                                                    <label id="ctl178624_Label0" data-datafield="QKMainTbl.QKSeq" data-type="SheetLabel" style="">批次</label></td>
                                                <td id="ctl178624_header0" data-datafield="QKMainTbl.ZJMS" style="">
                                                    <label id="ctl178624_Label0" data-datafield="QKMainTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label></td>
                                                <td id="ctl178624_header1" data-datafield="QKMainTbl.QKAmount" style="">
                                                    <label id="ctl178624_Label1" data-datafield="QKMainTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label></td>
                                                <td id="ctl178624_header2" data-datafield="QKMainTbl.QKTotalAmount" style="">
                                                    <label id="ctl178624_Label2" data-datafield="QKMainTbl.QKTotalAmount" data-type="SheetLabel" style="">折算金额(RMB)</label></td>
                                                <td id="ctl178624_header3" data-datafield="QKMainTbl.QKTarget" style="">
                                                    <label id="ctl178624_Label3" data-datafield="QKMainTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                                <td id="ctl178624_header4" data-datafield="QKMainTbl.Status" style="">
                                                    <label id="ctl178624_Label4" data-datafield="QKMainTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl178624_header5" data-datafield="QKMainTbl.Operate" style="">
                                                    <label id="ctl178624_Label5" data-datafield="QKMainTbl.Operate" data-type="SheetLabel" style="">编辑</label></td>
                                                <td id="ctl468334_header4" data-datafield="QKMainTbl.WorkItemId" class="hidden">
                                                    <label id="ctl468334_Label4" data-datafield="QKMainTbl.WorkItemId" data-type="SheetLabel" style="" class="hidden">流程节点Id</label></td>
                                                <td id="ctl468334_header5" data-datafield="QKMainTbl.RejectFlg" class="hidden">
                                                    <label id="ctl468334_Label5" data-datafield="QKMainTbl.RejectFlg" data-type="SheetLabel" style="" class="hidden">驳回Flg</label></td>
                                                <td id="ctl178624_header6" data-datafield="QKMainTbl.SeqCnt" style="" class="hidden">
                                                    <label id="ctl178624_Label6" data-datafield="QKMainTbl.SeqCnt" data-type="SheetLabel" style="" class="hidden">批次数量</label></td>
                                                <td id="ctl178624_header6" data-datafield="QKMainTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <label id="ctl178624_Label6" data-datafield="QKMainTbl.QKCurrencyCnt" data-type="SheetLabel" style="" class="hidden">批次币种数量</label></td>
                                                <td id="ctl178624_header6" data-datafield="QKMainTbl.QKCurrency" style="" class="hidden">
                                                    <label id="ctl178624_Label6" data-datafield="QKMainTbl.QKCurrency" data-type="SheetLabel" style="" class="hidden">币种</label></td>
                                                <td id="ctl178624_header6" data-datafield="QKMainTbl.QKObjectID" style="" class="hidden">
                                                    <label id="ctl178624_Label6" data-datafield="QKMainTbl.QKObjectID" data-type="SheetLabel" style="" class="hidden">QKObjectID</label></td>
                                                <td id="ctl178624_header6" data-datafield="QKMainTbl.QKType" style="" class="hidden">
                                                    <label id="ctl178624_Label6" data-datafield="QKMainTbl.QKType" data-type="SheetLabel" style="" class="hidden">QKType</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl178624_control0" data-datafield="QKMainTbl.QKSeq" style="">
                                                    <input type="text" data-datafield="QKMainTbl.QKSeq" data-type="SheetTextBox" id="ctl178624_control0" style=""></td>
                                                <td id="ctl178624_control0" data-datafield="QKMainTbl.ZJMS" style="">
                                                    <input type="text" data-datafield="QKMainTbl.ZJMS" data-type="SheetTextBox" id="ctl178624_control0" style=""></td>
                                                <td id="ctl178624_control1" data-datafield="QKMainTbl.QKAmount" style="">
                                                    <input type="text" data-datafield="QKMainTbl.QKAmount" data-type="SheetTextBox" id="ctl178624_control1" style=""></td>
                                                <td id="ctl178624_control2" data-datafield="QKMainTbl.QKTotalAmount" style="">
                                                    <input type="text" data-datafield="QKMainTbl.QKTotalAmount" data-type="SheetTextBox" id="ctl178624_control2" style=""></td>
                                                <td id="ctl178624_control3" data-datafield="QKMainTbl.QKTarget" style="">
                                                    <input type="text" data-datafield="QKMainTbl.QKTarget" data-type="SheetTextBox" id="ctl178624_control3" style=""></td>
                                                <td id="ctl178624_control4" data-datafield="QKMainTbl.Status" style="">
                                                    <input type="text" data-datafield="QKMainTbl.Status" data-type="SheetTextBox" id="ctl178624_control4" style=""></td>
                                                <td id="ctl178624_control5" data-datafield="QKMainTbl.Operate" style="">
                                                    <a class="btn btn-primary viewQK" onclick="viewQK(this)">查看</a>&nbsp;<a class="btn btn-primary updateQK" onclick="updateQK(this)">修改</a></td>
                                                <td id="ctl468334_control4" data-datafield="QKMainTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.WorkItemId" data-type="SheetTextBox" id="ctl468334_control4" style=""></td>
                                                <td id="ctl468334_control5" data-datafield="QKMainTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.RejectFlg" data-type="SheetTextBox" id="ctl468334_control5" style=""></td>
                                                <td id="ctl178624_control6" data-datafield="QKMainTbl.SeqCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.SeqCnt" data-type="SheetTextBox" id="ctl178624_control6" style="" class="hidden"></td>
                                                <td id="ctl178624_control6" data-datafield="QKMainTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.QKCurrencyCnt" data-type="SheetTextBox" id="ctl178624_control6" style="" class="hidden"></td>
                                                <td id="ctl178624_control6" data-datafield="QKMainTbl.QKCurrency" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.QKCurrency" data-type="SheetTextBox" id="ctl178624_control6" style="" class="hidden"></td>
                                                <td id="ctl178624_control6" data-datafield="QKMainTbl.QKObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.QKObjectID" data-type="SheetTextBox" id="ctl178624_control6" style="" class="hidden"></td>
                                                <td id="ctl178624_control6" data-datafield="QKMainTbl.QKType" style="" class="hidden">
                                                    <input type="text" data-datafield="QKMainTbl.QKType" data-type="SheetTextBox" id="ctl178624_control6" style="" class="hidden"></td>
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

                        <div role="tabpanel" class="tab-pane" id="dktab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveDKId" type="button" onclick="ApproveDK()" class="btn btn-primary" value="到款申请" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">到款状态</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl646883" data-datafield="DKStatusTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl646883_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl646883_header0" data-datafield="DKStatusTbl.QKSeq" style="">
                                                    <label id="ctl646883_Label0" data-datafield="DKStatusTbl.QKSeq" data-type="SheetLabel" style="">请款批次</label></td>
                                                <td id="ctl646883_header0" data-datafield="DKStatusTbl.SeqCnt" style="" class="hidden">
                                                    <label id="ctl646883_Label0" data-datafield="DKStatusTbl.SeqCnt" data-type="SheetLabel" style="">批次数量</label></td>
                                                <td id="ctl646883_header0" data-datafield="DKStatusTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <label id="ctl646883_Label0" data-datafield="DKStatusTbl.QKCurrencyCnt" data-type="SheetLabel" style="">批次币种数量</label></td>
                                                <td id="ctl646883_header1" data-datafield="DKStatusTbl.ZJKX" style="">
                                                    <label id="ctl646883_Label1" data-datafield="DKStatusTbl.ZJKX" data-type="SheetLabel" style="">资金款项</label></td>
                                                <td id="ctl646883_header2" data-datafield="DKStatusTbl.ZJMS" style="">
                                                    <label id="ctl646883_Label2" data-datafield="DKStatusTbl.ZJMS" data-type="SheetLabel" style="">资金描述</label></td>
                                                <td id="ctl646883_header3" data-datafield="DKStatusTbl.QKAmount" style="">
                                                    <label id="ctl646883_Label3" data-datafield="DKStatusTbl.QKAmount" data-type="SheetLabel" style="">请款金额</label></td>
                                                <td id="ctl646883_header4" data-datafield="DKStatusTbl.QKCurrency" style="" class="hidden">
                                                    <label id="ctl646883_Label4" data-datafield="DKStatusTbl.QKCurrency" data-type="SheetLabel" style="">请款币种</label></td>
                                                <td id="ctl646883_header5" data-datafield="DKStatusTbl.QKConvertAmount" style="">
                                                    <label id="ctl646883_Label5" data-datafield="DKStatusTbl.QKConvertAmount" data-type="SheetLabel" style="">折算金额(RMB)</label></td>
                                                <td id="ctl646883_header6" data-datafield="DKStatusTbl.QKTarget" style="">
                                                    <label id="ctl646883_Label6" data-datafield="DKStatusTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                                <td id="ctl646883_header7" data-datafield="DKStatusTbl.LJDKTotalAmount" style="">
                                                    <label id="ctl646883_Label7" data-datafield="DKStatusTbl.LJDKTotalAmount" data-type="SheetLabel" style="">累计到款</label></td>
                                                <td id="ctl646883_header8" data-datafield="DKStatusTbl.Status" style="" class="hidden">
                                                    <label id="ctl646883_Label8" data-datafield="DKStatusTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl646883_header9" data-datafield="DKStatusTbl.DisplayName" style="">
                                                    <label id="ctl646883_Label9" data-datafield="DKStatusTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl646883_header8" data-datafield="DKStatusTbl.QKObjectID" style="" class="hidden">
                                                    <label id="ctl646883_Label8" data-datafield="DKStatusTbl.QKObjectID" data-type="SheetLabel" style="" class="">QKObjectID</label></td>
                                                <td id="ctl646883_header8" data-datafield="DKStatusTbl.QKType" style="" class="hidden">
                                                    <label id="ctl646883_Label8" data-datafield="DKStatusTbl.QKType" data-type="SheetLabel" style="" class="">QKType</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl646883_control0" data-datafield="DKStatusTbl.QKSeq" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.QKSeq" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                                <td id="ctl646883_control0" data-datafield="DKStatusTbl.SeqCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.SeqCnt" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                                <td id="ctl646883_control0" data-datafield="DKStatusTbl.QKCurrencyCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.QKCurrencyCnt" data-type="SheetTextBox" id="ctl646883_control0" style=""></td>
                                                <td id="ctl646883_control1" data-datafield="DKStatusTbl.ZJKX" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.ZJKX" data-type="SheetTextBox" id="ctl646883_control1" style=""></td>
                                                <td id="ctl646883_control2" data-datafield="DKStatusTbl.ZJMS" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.ZJMS" data-type="SheetTextBox" id="ctl646883_control2" style=""></td>
                                                <td id="ctl646883_control3" data-datafield="DKStatusTbl.QKAmount" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.QKAmount" data-type="SheetTextBox" id="ctl646883_control3" style=""></td>
                                                <td id="ctl646883_control4" data-datafield="DKStatusTbl.QKCurrency" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.QKCurrency" data-type="SheetTextBox" id="ctl646883_control4" style=""></td>
                                                <td id="ctl646883_control5" data-datafield="DKStatusTbl.QKConvertAmount" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.QKConvertAmount" data-type="SheetTextBox" id="ctl646883_control5" style=""></td>
                                                <td id="ctl646883_control6" data-datafield="DKStatusTbl.QKTarget" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.QKTarget" data-type="SheetTextBox" id="ctl646883_control6" style=""></td>
                                                <td id="ctl646883_control7" data-datafield="DKStatusTbl.LJDKTotalAmount" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.LJDKTotalAmount" data-type="SheetTextBox" id="ctl646883_control7" style=""></td>
                                                <td id="ctl646883_control8" data-datafield="DKStatusTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.Status" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
                                                <td id="ctl646883_control9" data-datafield="DKStatusTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="DKStatusTbl.DisplayName" data-type="SheetTextBox" id="ctl646883_control9" style=""></td>
                                                <td id="ctl646883_control8" data-datafield="DKStatusTbl.QKObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.QKObjectID" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
                                                <td id="ctl646883_control8" data-datafield="DKStatusTbl.QKType" style="" class="hidden">
                                                    <input type="text" data-datafield="DKStatusTbl.QKType" data-type="SheetTextBox" id="ctl646883_control8" style=""></td>
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
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">到款记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl845778" data-datafield="DKRecordTbl" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-displaysummary="false" data-displaydelete="false" data-displayadd="false" >
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl845778_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl845778_header0" data-datafield="DKRecordTbl.QKTarget" style="">
                                                    <label id="ctl845778_Label0" data-datafield="DKRecordTbl.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                                <td id="ctl845778_header1" data-datafield="DKRecordTbl.DKDate" style="">
                                                    <label id="ctl845778_Label1" data-datafield="DKRecordTbl.DKDate" data-type="SheetLabel" style="">到款日期</label></td>
                                                <td id="ctl845778_header2" data-datafield="DKRecordTbl.DKTotalAmount" style="">
                                                    <label id="ctl845778_Label2" data-datafield="DKRecordTbl.DKTotalAmount" data-type="SheetLabel" style="">到款金额</label></td>
                                                <td id="ctl845778_header3" data-datafield="DKRecordTbl.Status" style="" class="hidden">
                                                    <label id="ctl845778_Label3" data-datafield="DKRecordTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl845778_header4" data-datafield="DKRecordTbl.DisplayName" style="">
                                                    <label id="ctl845778_Label4" data-datafield="DKRecordTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl845778_header5" data-datafield="DKRecordTbl.Operate" style="">
                                                    <label id="ctl845778_Label5" data-datafield="DKRecordTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl845778_header6" data-datafield="DKRecordTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl845778_Label6" data-datafield="DKRecordTbl.RejectFlg" data-type="SheetLabel" style="" class="">RejectFlg</label></td>
                                                <td id="ctl845778_header7" data-datafield="DKRecordTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl845778_Label7" data-datafield="DKRecordTbl.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl845778_control0" data-datafield="DKRecordTbl.QKTarget" style="">
                                                    <input type="text" data-datafield="DKRecordTbl.QKTarget" data-type="SheetTextBox" id="ctl845778_control0" style=""></td>
                                                <td id="ctl845778_control1" data-datafield="DKRecordTbl.DKDate" style="">
                                                    <input type="text" data-datafield="DKRecordTbl.DKDate" data-type="SheetTextBox" id="ctl845778_control1" style=""></td>
                                                <td id="ctl845778_control2" data-datafield="DKRecordTbl.DKTotalAmount" style="">
                                                    <input type="text" data-datafield="DKRecordTbl.DKTotalAmount" data-type="SheetTextBox" id="ctl845778_control2" style=""></td>
                                                <td id="ctl845778_control3" data-datafield="DKRecordTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="DKRecordTbl.Status" data-type="SheetTextBox" id="ctl845778_control3" style="" class=""></td>
                                                <td id="ctl845778_control4" data-datafield="DKRecordTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="DKRecordTbl.DisplayName" data-type="SheetTextBox" id="ctl845778_control4" style=""></td>
                                                <td id="ctl845778_control5" data-datafield="DKRecordTbl.Operate" style="">
                                                    <a class="btn btn-primary viewDK" onclick="viewDK(this)">查看</a>&nbsp;<a class="btn btn-primary updateDK" onclick="updateDK(this)">修改</a></td>
                                                <td id="ctl845778_control6" data-datafield="DKRecordTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="DKRecordTbl.RejectFlg" data-type="SheetTextBox" id="ctl845778_control6" style=""></td>
                                                <td id="ctl845778_control7" data-datafield="DKRecordTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="DKRecordTbl.WorkItemId" data-type="SheetTextBox" id="ctl845778_control7" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="fktab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveFKId" type="button" onclick="ApproveFK()" class="btn btn-primary" value="付款申请" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">付款记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl537557" data-datafield="FKRecordTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displaysequenceno="false" data-displaysummary="false" data-displaydelete="false" data-displayadd="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl537557_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl537557_header0" data-datafield="FKRecordTbl.TheNo" style="width:5%">
                                                    <label id="ctl537557_Label0" data-datafield="FKRecordTbl.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                                <td id="ctl537557_header1" data-datafield="FKRecordTbl.ZKMS" style="width:10%">
                                                    <label id="ctl537557_Label1" data-datafield="FKRecordTbl.ZKMS" data-type="SheetLabel" style="">支付描述</label></td>
                                                <td id="ctl537557_header2" data-datafield="FKRecordTbl.Amount" style="width:10%">
                                                    <label id="ctl537557_Label2" data-datafield="FKRecordTbl.Amount" data-type="SheetLabel" style="">付款金额</label></td>
                                                <td id="ctl537557_header3" data-datafield="FKRecordTbl.ConvertAmount" style="width:10%">
                                                    <label id="ctl537557_Label3" data-datafield="FKRecordTbl.ConvertAmount" data-type="SheetLabel" style="">折算金额</label></td>
                                                <td id="ctl537557_header4" data-datafield="FKRecordTbl.FKDate" style="width:10%">
                                                    <label id="ctl537557_Label4" data-datafield="FKRecordTbl.FKDate" data-type="SheetLabel" style="">付款日期</label></td>
                                                <td id="ctl537557_header4" data-datafield="FKRecordTbl.Content" style="width:15%">
                                                    <label id="ctl537557_Label4" data-datafield="FKRecordTbl.Content" data-type="SheetLabel" style="">付款内容</label></td>
                                                <td id="ctl537557_header5" data-datafield="FKRecordTbl.PayType" style="width:10%">
                                                    <label id="ctl537557_Label5" data-datafield="FKRecordTbl.PayType" data-type="SheetLabel" style="">支付方式</label></td>
                                                <td id="ctl537557_header6" data-datafield="FKRecordTbl.Receiver" style="width:15%">
                                                    <label id="ctl537557_Label6" data-datafield="FKRecordTbl.Receiver" data-type="SheetLabel" style="">受款人</label></td>
                                                <td id="ctl537557_header7" data-datafield="FKRecordTbl.Status" style="" class="hidden">
                                                    <label id="ctl537557_Label7" data-datafield="FKRecordTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl537557_header8" data-datafield="FKRecordTbl.DisplayName" style="width:10%">
                                                    <label id="ctl537557_Label8" data-datafield="FKRecordTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl537557_header9" data-datafield="FKRecordTbl.Operate" style="width:5%">
                                                    <label id="ctl537557_Label9" data-datafield="FKRecordTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl537557_header10" data-datafield="FKRecordTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl537557_Label10" data-datafield="FKRecordTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl537557_header11" data-datafield="FKRecordTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl537557_Label11" data-datafield="FKRecordTbl.WorkItemId" data-type="SheetLabel" style="" class="hidden">WorkItemId</label></td>
                                                <td id="ctl537557_header11" data-datafield="FKRecordTbl.Cnt" style="" class="hidden">
                                                    <label id="ctl537557_Label11" data-datafield="FKRecordTbl.Cnt" data-type="SheetLabel" style="" class="hidden">Cnt</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl537557_control0" data-datafield="FKRecordTbl.TheNo" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.TheNo" data-type="SheetTextBox" id="ctl537557_control0" style=""></td>
                                                <td id="ctl537557_control1" data-datafield="FKRecordTbl.ZKMS" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.ZKMS" data-type="SheetTextBox" id="ctl537557_control1" style=""></td>
                                                <td id="ctl537557_control2" data-datafield="FKRecordTbl.Amount" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.Amount" data-type="SheetTextBox" id="ctl537557_control2" style=""></td>
                                                <td id="ctl537557_control3" data-datafield="FKRecordTbl.ConvertAmount" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.ConvertAmount" data-type="SheetTextBox" id="ctl537557_control3" style=""></td>
                                                <td id="ctl537557_control4" data-datafield="FKRecordTbl.FKDate" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.FKDate" data-type="SheetTextBox" id="ctl537557_control4" style=""></td>
                                                <td id="ctl537557_control4" data-datafield="FKRecordTbl.Content" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.Content" data-type="SheetTextBox" id="ctl537557_control4" style=""></td>
                                                <td id="ctl537557_control5" data-datafield="FKRecordTbl.PayType" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.PayType" data-type="SheetTextBox" id="ctl537557_control5" style=""></td>
                                                <td id="ctl537557_control6" data-datafield="FKRecordTbl.Receiver" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.Receiver" data-type="SheetTextBox" id="ctl537557_control6" style=""></td>
                                                <td id="ctl537557_control7" data-datafield="FKRecordTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="FKRecordTbl.Status" data-type="SheetTextBox" id="ctl537557_control7" style=""></td>
                                                <td id="ctl537557_control8" data-datafield="FKRecordTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="FKRecordTbl.DisplayName" data-type="SheetTextBox" id="ctl537557_control8" style=""></td>
                                                <td id="ctl537557_control9" data-datafield="FKRecordTbl.Operate" style="">
                                                    <a class="btn btn-primary viewFK" onclick="viewFK(this)">查看</a>&nbsp;<a class="btn btn-primary updateFK" onclick="updateFK(this)">修改</a></td>
                                                <td id="ctl537557_control10" data-datafield="FKRecordTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="FKRecordTbl.RejectFlg" data-type="SheetTextBox" id="ctl537557_control10" style=""></td>
                                                <td id="ctl537557_control11" data-datafield="FKRecordTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="FKRecordTbl.WorkItemId" data-type="SheetTextBox" id="ctl537557_control11" style=""></td>
                                                 <td id="ctl537557_control11" data-datafield="FKRecordTbl.Cnt" style="" class="hidden">
                                                    <input type="text" data-datafield="FKRecordTbl.Cnt" data-type="SheetTextBox" id="ctl537557_control11" style=""></td>
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
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">拒付记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl428420" data-datafield="FKJFRecordTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl428420_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl428420_header0" data-datafield="FKJFRecordTbl.TheNo" style="width:5%">
                                                    <label id="ctl428420_Label0" data-datafield="FKJFRecordTbl.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                                <td id="ctl428420_header1" data-datafield="FKJFRecordTbl.ZKMS" style="width:10%">
                                                    <label id="ctl428420_Label1" data-datafield="FKJFRecordTbl.ZKMS" data-type="SheetLabel" style="">支付描述</label></td>
                                                <td id="ctl428420_header2" data-datafield="FKJFRecordTbl.Amount" style="width:10%">
                                                    <label id="ctl428420_Label2" data-datafield="FKJFRecordTbl.Amount" data-type="SheetLabel" style="">付款金额</label></td>
                                                <td id="ctl428420_header3" data-datafield="FKJFRecordTbl.ConvertAmount" style="width:10%">
                                                    <label id="ctl428420_Label3" data-datafield="FKJFRecordTbl.ConvertAmount" data-type="SheetLabel" style="">折算金额</label></td>
                                                <td id="ctl428420_header4" data-datafield="FKJFRecordTbl.FKDate" style="width:10%">
                                                    <label id="ctl428420_Label4" data-datafield="FKJFRecordTbl.FKDate" data-type="SheetLabel" style="">付款日期</label></td>
                                                <td id="ctl428420_header5" data-datafield="FKJFRecordTbl.Content" style="width:15%">
                                                    <label id="ctl428420_Label5" data-datafield="FKJFRecordTbl.Content" data-type="SheetLabel" style="">付款内容</label></td>
                                                <td id="ctl428420_header6" data-datafield="FKJFRecordTbl.PayType" style="width:10%">
                                                    <label id="ctl428420_Label6" data-datafield="FKJFRecordTbl.PayType" data-type="SheetLabel" style="">支付方式</label></td>
                                                <td id="ctl428420_header7" data-datafield="FKJFRecordTbl.Receiver" style="width:15%">
                                                    <label id="ctl428420_Label7" data-datafield="FKJFRecordTbl.Receiver" data-type="SheetLabel" style="">受款人</label></td>
                                                <td id="ctl428420_header8" data-datafield="FKJFRecordTbl.Status" style="" class="hidden">
                                                    <label id="ctl428420_Label8" data-datafield="FKJFRecordTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl428420_header9" data-datafield="FKJFRecordTbl.DisplayName" style="width:10%">
                                                    <label id="ctl428420_Label9" data-datafield="FKJFRecordTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl428420_header10" data-datafield="FKJFRecordTbl.Operate" style="width:5%">
                                                    <label id="ctl428420_Label10" data-datafield="FKJFRecordTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl428420_header11" data-datafield="FKJFRecordTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl428420_Label11" data-datafield="FKJFRecordTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl428420_header12" data-datafield="FKJFRecordTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl428420_Label12" data-datafield="FKJFRecordTbl.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td id="ctl428420_header13" data-datafield="FKJFRecordTbl.Cnt" style="" class="hidden">
                                                    <label id="ctl428420_Label13" data-datafield="FKJFRecordTbl.Cnt" data-type="SheetLabel" style="">Cnt</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl428420_control0" data-datafield="FKJFRecordTbl.TheNo" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.TheNo" data-type="SheetTextBox" id="ctl428420_control0" style=""></td>
                                                <td id="ctl428420_control1" data-datafield="FKJFRecordTbl.ZKMS" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.ZKMS" data-type="SheetTextBox" id="ctl428420_control1" style=""></td>
                                                <td id="ctl428420_control2" data-datafield="FKJFRecordTbl.Amount" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.Amount" data-type="SheetTextBox" id="ctl428420_control2" style=""></td>
                                                <td id="ctl428420_control3" data-datafield="FKJFRecordTbl.ConvertAmount" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.ConvertAmount" data-type="SheetTextBox" id="ctl428420_control3" style=""></td>
                                                <td id="ctl428420_control4" data-datafield="FKJFRecordTbl.FKDate" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.FKDate" data-type="SheetTextBox" id="ctl428420_control4" style=""></td>
                                                <td id="ctl428420_control5" data-datafield="FKJFRecordTbl.Content" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.Content" data-type="SheetTextBox" id="ctl428420_control5" style=""></td>
                                                <td id="ctl428420_control6" data-datafield="FKJFRecordTbl.PayType" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.PayType" data-type="SheetTextBox" id="ctl428420_control6" style=""></td>
                                                <td id="ctl428420_control7" data-datafield="FKJFRecordTbl.Receiver" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.Receiver" data-type="SheetTextBox" id="ctl428420_control7" style=""></td>
                                                <td id="ctl428420_control8" data-datafield="FKJFRecordTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="FKJFRecordTbl.Status" data-type="SheetTextBox" id="ctl428420_control8" style=""></td>
                                                <td id="ctl428420_control9" data-datafield="FKJFRecordTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="FKJFRecordTbl.DisplayName" data-type="SheetTextBox" id="ctl428420_control9" style=""></td>
                                                <td id="ctl428420_control10" data-datafield="FKJFRecordTbl.Operate" style="">
                                                    <a class="btn btn-primary viewFKJF" onclick="viewFKJF(this)">查看</a>&nbsp;<a class="btn btn-primary updateFKJF" onclick="updateFKJF(this)">修改</a></td>
                                                <td id="ctl428420_control11" data-datafield="FKJFRecordTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="FKJFRecordTbl.RejectFlg" data-type="SheetTextBox" id="ctl428420_control11" style=""></td>
                                                <td id="ctl428420_control12" data-datafield="FKJFRecordTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="FKJFRecordTbl.WorkItemId" data-type="SheetTextBox" id="ctl428420_control12" style=""></td>
                                                <td id="ctl428420_control13" data-datafield="FKJFRecordTbl.Cnt" style="" class="hidden">
                                                    <input type="text" data-datafield="FKJFRecordTbl.Cnt" data-type="SheetTextBox" id="ctl428420_control13" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="jstab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveJSId" type="button" onclick="ApproveJS()" class="btn btn-primary" value="申请结算" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">到款结算状态</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl233050" data-datafield="DKRecordTblOfJS" data-type="SheetGridView" class="SheetGridView" style=""  data-displaysequenceno="false" data-displaysummary="false" data-displayadd="false" data-displaydelete="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl233050_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl233050_header0" data-datafield="DKRecordTblOfJS.QKTarget" style="">
                                                    <label id="ctl233050_Label0" data-datafield="DKRecordTblOfJS.QKTarget" data-type="SheetLabel" style="">请款对象</label></td>
                                                <td id="Control18_Header4" data-datafield="DKRecordTblOfJS.QKType" style="width: 6%">
                                                    <label id="Control18_Label4" data-datafield="DKRecordTblOfJS.QKType" data-type="SheetLabel" style="">请款类型</label>
                                                </td>
                                                <td id="Control18_Header7" data-datafield="DKRecordTblOfJS.ZJKX" style="width: 6%">
                                                    <label id="Control18_Label7" data-datafield="DKRecordTblOfJS.ZJKX" data-type="SheetLabel" style="">资金款项</label>
                                                </td>
                                                <td id="Control18_Header8" data-datafield="DKRecordTblOfJS.ZJMS" style="width: 8%">
                                                    <label id="Control18_Label8" data-datafield="DKRecordTblOfJS.ZJMS" data-type="SheetLabel" style="">资金描述</label>
                                                </td>
                                                <td id="Control18_Header9" data-datafield="DKRecordTblOfJS.QKAmount" style="width: 8%">
                                                    <label id="Control18_Label9" data-datafield="DKRecordTblOfJS.QKAmount" data-type="SheetLabel" style="">请款金额</label>
                                                </td>
                                                <td id="Control18_Header10" data-datafield="DKRecordTblOfJS.QKCurrencyName" style="width: 6%">
                                                    <label id="Control18_Label10" data-datafield="DKRecordTblOfJS.QKCurrencyName" data-type="SheetLabel" style="">请款币种</label>
                                                </td>
                                                <td id="Control18_Header10" data-datafield="DKRecordTblOfJS.QKCurrency" class="hidden">
                                                    <label id="Control18_Label10" data-datafield="DKRecordTblOfJS.QKCurrency" data-type="SheetLabel" style="">请款币种Code</label>
                                                </td>
                                                <td id="Control18_Header11" data-datafield="DKRecordTblOfJS.QKConvertAmount" style="width: 8%">
                                                    <label id="Control18_Label11" data-datafield="DKRecordTblOfJS.QKConvertAmount" data-type="SheetLabel" style="">折算金额</label>
                                                </td>
                                                <td id="Control18_Header13" data-datafield="DKRecordTblOfJS.SeqCnt" class="hidden">
                                                    <label id="Control18_Label13" data-datafield="DKRecordTblOfJS.SeqCnt" data-type="SheetLabel" style="" class="">SeqCnt</label>
                                                </td>
                                                <td id="Control18_Header13" data-datafield="DKRecordTblOfJS.QKCurrencyCnt" class="hidden">
                                                    <label id="Control18_Label13" data-datafield="DKRecordTblOfJS.QKCurrencyCnt" data-type="SheetLabel" style="" class="">QKCurrencyCnt</label>
                                                </td>
                                                <td id="Control18_Header13" data-datafield="DKRecordTblOfJS.QKObjectID" class="hidden">
                                                    <label id="Control18_Label13" data-datafield="DKRecordTblOfJS.QKObjectID" data-type="SheetLabel" style="" class="">QKObjectID</label>
                                                </td>
                                                <td id="Control18_Header13" data-datafield="DKRecordTblOfJS.QKSubObjectID" class="hidden">
                                                    <label id="Control18_Label13" data-datafield="DKRecordTblOfJS.QKSubObjectID" data-type="SheetLabel" style="" class="">QKSubObjectID</label>
                                                </td>
                                                <td id="ctl784745_header7" data-datafield="DKRecordTblOfJS.DKObjectID" style="" class="hidden">
                                                    <label id="ctl784745_Label7" data-datafield="DKRecordTblOfJS.DKObjectID" data-type="SheetLabel" style="">DKObjectID</label></td>
                                                <td id="ctl233050_header1" data-datafield="DKRecordTblOfJS.DKType" style="">
                                                    <label id="ctl233050_Label1" data-datafield="DKRecordTblOfJS.DKType" data-type="SheetLabel" style="">到款类型</label></td>
                                                <td id="ctl233050_header3" data-datafield="DKRecordTblOfJS.CurDKAmount" style="">
                                                    <label id="ctl233050_Label3" data-datafield="DKRecordTblOfJS.CurDKAmount" data-type="SheetLabel" style="">到款金额</label></td>
                                                <td id="ctl784745_header7" data-datafield="DKRecordTblOfJS.CurDKCurrency" style="width: 6%" class="">
                                                    <label id="ctl784745_Label7" data-datafield="DKRecordTblOfJS.CurDKCurrency" data-type="SheetLabel" style="">到款币种</label></td>
                                                <td id="ctl233050_header2" data-datafield="DKRecordTblOfJS.DKDate" style="">
                                                    <label id="ctl233050_Label2" data-datafield="DKRecordTblOfJS.DKDate" data-type="SheetLabel" style="">到款日期</label></td>
                                                <td id="ctl233050_header4" data-datafield="DKRecordTblOfJS.Status" style="">
                                                    <label id="ctl233050_Label4" data-datafield="DKRecordTblOfJS.Status" data-type="SheetLabel" style="">结算状态</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl233050_control0" data-datafield="DKRecordTblOfJS.QKTarget" style="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.QKTarget" data-type="SheetTextBox" id="ctl233050_control0" style=""></td>
                                                <td data-datafield="DKRecordTblOfJS.QKType">
                                                    <input id="Control18_ctl4" type="text" data-datafield="DKRecordTblOfJS.QKType" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.ZJKX">
                                                    <input id="Control18_ctl7" type="text" data-datafield="DKRecordTblOfJS.ZJKX" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.ZJMS">
                                                    <input id="Control18_ctl8" type="text" data-datafield="DKRecordTblOfJS.ZJMS" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKAmount">
                                                    <input id="Control18_ctl9" type="text" data-datafield="DKRecordTblOfJS.QKAmount" data-type="SheetTextBox" style="" class="AmountFormat">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKCurrency">
                                                    <input id="Control18_ctl10" type="text" data-datafield="DKRecordTblOfJS.QKCurrencyName" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKCurrencyCode" class="hidden">
                                                    <input id="Control18_ctl10" type="text" data-datafield="DKRecordTblOfJS.QKCurrency" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKConvertAmount">
                                                    <input id="Control18_ctl11" type="text" data-datafield="DKRecordTblOfJS.QKConvertAmount" data-type="SheetTextBox" style="" class="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.SeqCnt" class="hidden">
                                                    <input id="Control18_ctl13" type="text" data-datafield="DKRecordTblOfJS.SeqCnt" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKCurrencyCnt" class="hidden">
                                                    <input id="Control18_ctl13" type="text" data-datafield="DKRecordTblOfJS.QKCurrencyCnt" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKObjectID" class="hidden">
                                                    <input id="Control18_ctl13" type="text" data-datafield="DKRecordTblOfJS.QKObjectID" data-type="SheetTextBox" style="">
                                                </td>
                                                <td data-datafield="DKRecordTblOfJS.QKSubObjectID" class="hidden">
                                                    <input id="Control18_ctl13" type="text" data-datafield="DKRecordTblOfJS.QKSubObjectID" data-type="SheetTextBox" style="">
                                                </td>
                                                <td id="ctl233050_control1" data-datafield="DKRecordTblOfJS.DKType" style="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.DKType" data-type="SheetTextBox" id="ctl233050_control1" style=""></td>
                                                <td id="ctl784745_control4" data-datafield="DKRecordTblOfJS.CurDKAmount" style="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.CurDKAmount" data-type="SheetTextBox" class="AmountFormat" id="ctl784745_control4" style=""></td>
                                                <td id="ctl784745_control7" data-datafield="DKRecordTblOfJS.CurDKCurrency" style="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.CurDKCurrency" data-type="SheetTextBox" id="ctl784745_control7" style=""></td>
                                                <td id="ctl233050_control2" data-datafield="DKRecordTblOfJS.DKDate" style="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.DKDate" data-type="SheetTextBox" id="ctl233050_control2" style=""></td>
                                                <td id="ctl233050_control4" data-datafield="DKRecordTblOfJS.Status" style="" class="">
                                                    <input type="text" data-datafield="DKRecordTblOfJS.Status" data-type="SheetTextBox" id="ctl233050_control4" style="" class=""></td>
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
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">付款结算状态</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl865708" data-datafield="FKRecordTblOfJS" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl865708_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl865708_header0" data-datafield="FKRecordTblOfJS.TheNo" style="">
                                                    <label id="ctl865708_Label0" data-datafield="FKRecordTblOfJS.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                                <td id="ctl865708_header1" data-datafield="FKRecordTblOfJS.Receiver" style="">
                                                    <label id="ctl865708_Label1" data-datafield="FKRecordTblOfJS.Receiver" data-type="SheetLabel" style="">受款人</label></td>
                                                <td id="ctl865708_header2" data-datafield="FKRecordTblOfJS.ZKMS" style="">
                                                    <label id="ctl865708_Label2" data-datafield="FKRecordTblOfJS.ZKMS" data-type="SheetLabel" style="">支付描述</label></td>
                                                <td id="ctl865708_header3" data-datafield="FKRecordTblOfJS.Amount" style="">
                                                    <label id="ctl865708_Label3" data-datafield="FKRecordTblOfJS.Amount" data-type="SheetLabel" style="">付款金额</label></td>
                                                <td id="ctl865708_header4" data-datafield="FKRecordTblOfJS.ConvertAmount" style="">
                                                    <label id="ctl865708_Label4" data-datafield="FKRecordTblOfJS.ConvertAmount" data-type="SheetLabel" style="">折算金额</label></td>
                                                <td id="ctl865708_header5" data-datafield="FKRecordTblOfJS.Content" style="">
                                                    <label id="ctl865708_Label5" data-datafield="FKRecordTblOfJS.Content" data-type="SheetLabel" style="">付款内容</label></td>
                                                <td id="ctl865708_header6" data-datafield="FKRecordTblOfJS.Status" style="">
                                                    <label id="ctl865708_Label6" data-datafield="FKRecordTblOfJS.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl865708_header7" data-datafield="FKRecordTblOfJS.Cnt" style="" class="hidden">
                                                    <label id="ctl865708_Label7" data-datafield="FKRecordTblOfJS.Cnt" data-type="SheetLabel" style="">数量</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl865708_control0" data-datafield="FKRecordTblOfJS.TheNo" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.TheNo" data-type="SheetTextBox" id="ctl865708_control0" style=""></td>
                                                <td id="ctl865708_control1" data-datafield="FKRecordTblOfJS.Receiver" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.Receiver" data-type="SheetTextBox" id="ctl865708_control1" style=""></td>
                                                <td id="ctl865708_control2" data-datafield="FKRecordTblOfJS.ZKMS" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.ZKMS" data-type="SheetTextBox" id="ctl865708_control2" style=""></td>
                                                <td id="ctl865708_control3" data-datafield="FKRecordTblOfJS.Amount" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.Amount" data-type="SheetTextBox" id="ctl865708_control3" style=""></td>
                                                <td id="ctl865708_control4" data-datafield="FKRecordTblOfJS.ConvertAmount" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.ConvertAmount" data-type="SheetTextBox" id="ctl865708_control4" style=""></td>
                                                <td id="ctl865708_control5" data-datafield="FKRecordTblOfJS.Content" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.Content" data-type="SheetTextBox" id="ctl865708_control5" style=""></td>
                                                <td id="ctl865708_control6" data-datafield="FKRecordTblOfJS.Status" style="">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.Status" data-type="SheetTextBox" id="ctl865708_control6" style=""></td>
                                                <td id="ctl865708_control7" data-datafield="FKRecordTblOfJS.Cnt" style="" class="hidden">
                                                    <input type="text" data-datafield="FKRecordTblOfJS.Cnt" data-type="SheetTextBox" id="ctl865708_control7" style=""></td>
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

                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">结算记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div688558" class="col-md-12">
                                    <table id="ctl143132" data-datafield="JSRecordTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl143132_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl143132_header0" data-datafield="JSRecordTbl.LJDKAmountRMB" style="width:15%">
                                                    <label id="ctl143132_Label0" data-datafield="JSRecordTbl.LJDKAmountRMB" data-type="SheetLabel" style="">到帐金额</label></td>
                                                <td id="ctl143132_header1" data-datafield="JSRecordTbl.LJFKAmountRMB" style="width:15%">
                                                    <label id="ctl143132_Label1" data-datafield="JSRecordTbl.LJFKAmountRMB" data-type="SheetLabel" style="">支付金额</label></td>
                                                <td id="ctl143132_header2" data-datafield="JSRecordTbl.BankFY" style="width:10%">
                                                    <label id="ctl143132_Label2" data-datafield="JSRecordTbl.BankFY" data-type="SheetLabel" style="">银行费用</label></td>
                                                <td id="ctl143132_header3" data-datafield="JSRecordTbl.AgencyFY" style="width:10%">
                                                    <label id="ctl143132_Label3" data-datafield="JSRecordTbl.AgencyFY" data-type="SheetLabel" style="">代理费</label></td>
                                                <td id="ctl143132_header4" data-datafield="JSRecordTbl.OtherFY" style="width:10%">
                                                    <label id="ctl143132_Label4" data-datafield="JSRecordTbl.OtherFY" data-type="SheetLabel" style="">其他费用</label></td>
                                                <td id="ctl143132_header5" data-datafield="JSRecordTbl.JSResult" style="width:15%">
                                                    <label id="ctl143132_Label5" data-datafield="JSRecordTbl.JSResult" data-type="SheetLabel" style="">结算结果</label></td>
                                                <td id="ctl143132_header6" data-datafield="JSRecordTbl.Status" style="" class="hidden">
                                                    <label id="ctl143132_Label6" data-datafield="JSRecordTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl143132_header7" data-datafield="JSRecordTbl.DisplayName" style="width:10%">
                                                    <label id="ctl143132_Label7" data-datafield="JSRecordTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl143132_header8" data-datafield="JSRecordTbl.Operate" style="width:10%">
                                                    <label id="ctl143132_Label8" data-datafield="JSRecordTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl143132_header9" data-datafield="JSRecordTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl143132_Label9" data-datafield="JSRecordTbl.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td id="ctl143132_header10" data-datafield="JSRecordTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl143132_Label10" data-datafield="JSRecordTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl143132_header10" data-datafield="JSRecordTbl.JSObjectID" style="" class="hidden">
                                                    <label id="ctl143132_Label10" data-datafield="JSRecordTbl.JSObjectID" data-type="SheetLabel" style="">JSObjectID</label></td>
                                                <td id="ctl143132_header10" data-datafield="JSRecordTbl.JSResultNum" style="" class="hidden">
                                                    <label id="ctl143132_Label10" data-datafield="JSRecordTbl.JSResultNum" data-type="SheetLabel" style="">结算结果Num</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl143132_control0" data-datafield="JSRecordTbl.LJDKAmountRMB" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.LJDKAmountRMB" data-type="SheetTextBox" id="ctl143132_control0" style=""></td>
                                                <td id="ctl143132_control1" data-datafield="JSRecordTbl.LJFKAmountRMB" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.LJFKAmountRMB" data-type="SheetTextBox" id="ctl143132_control1" style=""></td>
                                                <td id="ctl143132_control2" data-datafield="JSRecordTbl.BankFY" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.BankFY" data-type="SheetTextBox" id="ctl143132_control2" style=""></td>
                                                <td id="ctl143132_control3" data-datafield="JSRecordTbl.AgencyFY" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.AgencyFY" data-type="SheetTextBox" id="ctl143132_control3" style=""></td>
                                                <td id="ctl143132_control4" data-datafield="JSRecordTbl.OtherFY" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.OtherFY" data-type="SheetTextBox" id="ctl143132_control4" style=""></td>
                                                <td id="ctl143132_control5" data-datafield="JSRecordTbl.JSResult" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.JSResult" data-type="SheetTextBox" id="ctl143132_control5" style=""></td>
                                                <td id="ctl143132_control6" data-datafield="JSRecordTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="JSRecordTbl.Status" data-type="SheetTextBox" id="ctl143132_control6" style=""></td>
                                                <td id="ctl143132_control7" data-datafield="JSRecordTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="JSRecordTbl.DisplayName" data-type="SheetTextBox" id="ctl143132_control7" style=""></td>
                                                <td id="ctl143132_control8" data-datafield="JSRecordTbl.Operate" style="">
                                                    <a class="btn btn-primary viewJS" onclick="viewJS(this)">查看</a>&nbsp;<a class="btn btn-primary updateJS" onclick="updateJS(this)">修改</a>
                                                    &nbsp;<a class="btn btn-primary updateJSQK" onclick="updateJSQK(this)">请款</a>&nbsp;<a class="btn btn-primary updateJSFK" onclick="updateJSFK(this)">付款</a>
                                                </td>
                                                <td id="ctl143132_control9" data-datafield="JSRecordTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="JSRecordTbl.WorkItemId" data-type="SheetTextBox" id="ctl143132_control9" style=""></td>
                                                <td id="ctl143132_control10" data-datafield="JSRecordTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="JSRecordTbl.RejectFlg" data-type="SheetTextBox" id="ctl143132_control10" style=""></td>
                                                <td id="ctl143132_control10" data-datafield="JSRecordTbl.JSObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="JSRecordTbl.JSObjectID" data-type="SheetTextBox" id="ctl143132_control10" style=""></td>
                                                <td id="ctl143132_control10" data-datafield="JSRecordTbl.JSResultNum" style="" class="hidden">
                                                    <input type="text" data-datafield="JSRecordTbl.JSResultNum" data-type="SheetTextBox" id="ctl143132_control10" style=""></td>
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


                        <div role="tabpanel" class="tab-pane" id="xyztab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApprovePaymentId" type="button" onclick="ApprovePayment()" value="信用证申请" class="btn btn-primary" style="padding: 3px;" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">信用证付款状态</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div968359" class="col-md-12">
                                    <table id="ctl839166" data-datafield="PaymentFKStatus" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl839166_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl839166_header0" data-datafield="PaymentFKStatus.Bank" style="width:25%">
                                                    <label id="ctl839166_Label0" data-datafield="PaymentFKStatus.Bank" data-type="SheetLabel" style="">开证银行</label></td>
                                                <td id="ctl839166_header1" data-datafield="PaymentFKStatus.Amount" style="width:25%">
                                                    <label id="ctl839166_Label1" data-datafield="PaymentFKStatus.Amount" data-type="SheetLabel" style="">信用证金额</label></td>
                                                <td id="ctl839166_header2" data-datafield="PaymentFKStatus.PayedAmount" style="width:20%" class="">
                                                    <label id="ctl839166_Label2" data-datafield="PaymentFKStatus.PayedAmount" data-type="SheetLabel" style="">已付金额</label></td>
                                                <td id="ctl839166_header3" data-datafield="PaymentFKStatus.RemainAmount" style="width:20%">
                                                    <label id="ctl839166_Label3" data-datafield="PaymentFKStatus.RemainAmount" data-type="SheetLabel" style="">余额</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl839166_control0" data-datafield="PaymentFKStatus.Bank" style="">
                                                    <input type="text" data-datafield="PaymentFKStatus.Bank" data-type="SheetTextBox" id="ctl839166_control0" style=""></td>
                                                <td id="ctl839166_control1" data-datafield="PaymentFKStatus.Amount" style="">
                                                    <input type="text" data-datafield="PaymentFKStatus.Amount" data-type="SheetTextBox" id="ctl839166_control1" style=""></td>
                                                <td id="ctl839166_control2" data-datafield="PaymentFKStatus.PayedAmount" style="">
                                                    <input type="text" data-datafield="PaymentFKStatus.PayedAmount" data-type="SheetTextBox" id="ctl839166_control2" style=""></td>
                                                <td id="ctl839166_control3" data-datafield="PaymentFKStatus.RemainAmount" style="">
                                                    <input type="text" data-datafield="PaymentFKStatus.RemainAmount" data-type="SheetTextBox" id="ctl839166_control3" style=""></td>
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
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12" align="center">信用证记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="div968359" class="col-md-12">

                                    <table id="ctl267183" data-datafield="PaymentTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl267183_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl267183_header0" data-datafield="PaymentTbl.TheNo" style="width: 10%">
                                                    <label id="ctl267183_Label0" data-datafield="PaymentTbl.TheNo" data-type="SheetLabel">序号</label></td>
                                                <td id="ctl267183_header0" data-datafield="PaymentTbl.Bank" style="width: 25%">
                                                    <label id="ctl267183_Label0" data-datafield="PaymentTbl.Bank" data-type="SheetLabel">开证银行</label></td>
                                                <td id="ctl267183_header1" data-datafield="PaymentTbl.TotalAmount" style="width: 25%">
                                                    <label id="ctl267183_Label1" data-datafield="PaymentTbl.TotalAmount" data-type="SheetLabel">开证金额</label></td>
                                                <td id="ctl267183_header2" data-datafield="PaymentTbl.Status" style="width: 15%">
                                                    <label id="ctl267183_Label2" data-datafield="PaymentTbl.Status" data-type="SheetLabel">状态</label></td>
                                                <td id="ctl267183_header3" data-datafield="PaymentTbl.UpdatePayment" style="width: 15%">
                                                    <label id="ctl267183_Label3" data-datafield="PaymentTbl.UpdatePayment" data-type="SheetLabel">改证</label></td>
                                                <td id="ctl267183_header4" data-datafield="PaymentTbl.Operate" style="width: 10%">
                                                    <label id="ctl267183_Label4" data-datafield="PaymentTbl.Operate" data-type="SheetLabel">操作</label></td>
                                                <td id="ctl267183_header5" data-datafield="PaymentTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl267183_Label5" data-datafield="PaymentTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                                <td id="ctl267183_header6" data-datafield="PaymentTbl.PaymentId" style="" class="hidden">
                                                    <label id="ctl267183_Label6" data-datafield="PaymentTbl.PaymentId" data-type="SheetLabel" style="" class="hidden">信用证表单Id</label></td>
                                                <td id="ctl267183_header6" data-datafield="PaymentTbl.PaymentId" style="" class="hidden">
                                                    <label id="ctl267183_Label6" data-datafield="PaymentTbl.changePaymentFlg" data-type="SheetLabel" style="" class="hidden">改证标识</label></td>
                                                <td id="ctl267183_header6" data-datafield="PaymentTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl267183_Label6" data-datafield="PaymentTbl.RejectFlg" data-type="SheetLabel" style="" class="hidden">驳回Flg</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl267183_control0" data-datafield="PaymentTbl.TheNo" style="">
                                                    <input type="text" data-datafield="PaymentTbl.TheNo" data-type="SheetTextBox" id="ctl267183_control0" style=""></td>
                                                <td id="ctl267183_control0" data-datafield="PaymentTbl.Bank" style="">
                                                    <input type="text" data-datafield="PaymentTbl.Bank" data-type="SheetTextBox" id="ctl267183_control0" style=""></td>
                                                <td id="ctl267183_control1" data-datafield="PaymentTbl.TotalAmount" style="">
                                                    <input type="text" data-datafield="PaymentTbl.TotalAmount" data-type="SheetTextBox" id="ctl267183_control1" style=""></td>
                                                <td id="ctl267183_control2" data-datafield="PaymentTbl.Status" style="">
                                                    <input type="text" data-datafield="PaymentTbl.Status" data-type="SheetTextBox" id="ctl267183_control2" style=""></td>
                                                <td id="ctl267183_control3" data-datafield="PaymentTbl.UpdatePayment" style="">
                                                    <a onclick="updatePaymentApprove(this)">改证</a></td>
                                                <td id="ctl267183_control4" data-datafield="PaymentTbl.Operate" style="">
                                                    <a class="btn btn-primary viewPayment" onclick="viewPayment(this)">查看</a>&nbsp;<a class="btn btn-primary updatePayment" onclick="updatePayment(this)">修改</a></td>
                                                <td id="ctl267183_control5" data-datafield="PaymentTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="PaymentTbl.WorkItemId" data-type="SheetTextBox" id="ctl267183_control5" style=""></td>
                                                <td id="ctl267183_control6" data-datafield="PaymentTbl.PaymentId" style="" class="hidden">
                                                    <input type="text" data-datafield="PaymentTbl.PaymentId" data-type="SheetTextBox" id="ctl267183_control6" style=""></td>
                                                <td id="ctl267183_control6" data-datafield="PaymentTbl.changePaymentFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="PaymentTbl.changePaymentFlg" data-type="SheetTextBox" id="ctl267183_control6" style=""></td>
                                                <td id="ctl267183_control6" data-datafield="PaymentTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="PaymentTbl.RejectFlg" data-type="SheetTextBox" id="ctl267183_control6" style=""></td>
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
                        <div role="tabpanel" class="tab-pane" id="importlicensetab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveImportLicenseId" type="button" onclick="ApproveImportLicense()" class="btn btn-primary" value="进口许可证申请" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div137455" class="col-md-12">
                                    <table id="ctl468334" data-datafield="ImportLicenceTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl468334_SerialNo" class="rowSerialNo" style="width: 10%">序号</td>
                                                <td id="ctl468334_header0" data-datafield="ImportLicenceTbl.GoodName" style="width: 35%">
                                                    <label id="ctl468334_Label0" data-datafield="ImportLicenceTbl.GoodName" data-type="SheetLabel" style="">商品名称</label></td>
                                                <td id="ctl468334_header1" data-datafield="ImportLicenceTbl.GoodCode" style="width: 35%">
                                                    <label id="ctl468334_Label1" data-datafield="ImportLicenceTbl.GoodCode" data-type="SheetLabel" style="">商品编码</label></td>
                                                <td id="ctl468334_header2" data-datafield="ImportLicenceTbl.DisplayName" style="width: 10%">
                                                    <label id="ctl468334_Label2" data-datafield="ImportLicenceTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl468334_header2" data-datafield="ImportLicenceTbl.Status" style="" class="hidden">
                                                    <label id="ctl468334_Label2" data-datafield="ImportLicenceTbl.Status" data-type="SheetLabel" style="" class="hidden">状态</label></td>
                                                <td id="ctl468334_header3" data-datafield="ImportLicenceTbl.Operate" style="width: 10%">
                                                    <label id="ctl468334_Label3" data-datafield="ImportLicenceTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl468334_header4" data-datafield="ImportLicenceTbl.WorkItemId" class="hidden">
                                                    <label id="ctl468334_Label4" data-datafield="ImportLicenceTbl.WorkItemId" data-type="SheetLabel" style="" class="hidden">流程节点Id</label></td>
                                                <td id="ctl468334_header5" data-datafield="ImportLicenceTbl.RejectFlg" class="hidden">
                                                    <label id="ctl468334_Label5" data-datafield="ImportLicenceTbl.RejectFlg" data-type="SheetLabel" style="" class="hidden">驳回Flg</label></td>
                                                <td id="ctl468334_header6" data-datafield="ImportLicenceTbl.ImportLicenseId" class="hidden">
                                                    <label id="ctl468334_Label6" data-datafield="ImportLicenceTbl.ImportLicenseId" data-type="SheetLabel" style="" class="hidden">进口许可证表单Id</label></td>
                                                <td id="ctl468334_header7" data-datafield="ImportLicenceTbl.CancelFlg" class="hidden">
                                                    <label id="ctl468334_Label7" data-datafield="ImportLicenceTbl.CancelFlg" data-type="SheetLabel" style="" class="hidden">废除Flg</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl468334_control0" data-datafield="ImportLicenceTbl.GoodName" style="">
                                                    <input type="text" data-datafield="ImportLicenceTbl.GoodName" data-type="SheetTextBox" id="ctl468334_control0" style=""></td>
                                                <td id="ctl468334_control1" data-datafield="ImportLicenceTbl.GoodCode" style="">
                                                    <input type="text" data-datafield="ImportLicenceTbl.GoodCode" data-type="SheetTextBox" id="ctl468334_control1" style=""></td>
                                                <td id="ctl468334_control2" data-datafield="ImportLicenceTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="ImportLicenceTbl.DisplayName" data-type="SheetTextBox" id="ctl468334_control2" style=""></td>
                                                <td id="ctl468334_control2" data-datafield="ImportLicenceTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="ImportLicenceTbl.Status" data-type="SheetTextBox" id="ctl468334_control2" style="" class="hidden"></td>
                                                <td id="ctl468334_control3" data-datafield="ImportLicenceTbl.Operate" style="">
                                                    <a class="btn btn-primary viewImportLicence" onclick="viewImportLicence(this)">查看</a>&nbsp;<a class="btn btn-primary updateImportLicence" onclick="updateImportLicence(this)">修改</a>
                                                    &nbsp;<a class="btn btn-primary cancelImportLicence" onclick="cancelImportLicence(this)">废除</a>&nbsp;<a class="btn btn-primary undocancelImportLicence" onclick="undocancelImportLicence(this)">取消废除</a>
                                                </td>
                                                <td id="ctl468334_control4" data-datafield="ImportLicenceTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="ImportLicenceTbl.WorkItemId" data-type="SheetTextBox" id="ctl468334_control4" style=""></td>
                                                <td id="ctl468334_control5" data-datafield="ImportLicenceTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="ImportLicenceTbl.RejectFlg" data-type="SheetTextBox" id="ctl468334_control5" style=""></td>
                                                <td id="ctl468334_control6" data-datafield="ImportLicenceTbl.ImportLicenseId" style="" class="hidden">
                                                    <input type="text" data-datafield="ImportLicenceTbl.ImportLicenseId" data-type="SheetTextBox" id="ctl468334_control6" style=""></td>
                                                <td id="ctl468334_control7" data-datafield="ImportLicenceTbl.CancelFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="ImportLicenceTbl.CancelFlg" data-type="SheetTextBox" id="ctl468334_control7" style=""></td>
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
                        <div role="tabpanel" class="tab-pane" id="dhtab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveDHId" type="button" onclick="ApproveDH()" value="到货申请" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div746371" class="col-md-12">
                                    <table id="ctl724574" data-datafield="DHTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl724574_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl724574_header0" data-datafield="DHTbl.TheNo" style="width: 5%">
                                                    <label id="ctl724574_Label0" data-datafield="DHTbl.TheNo" data-type="SheetLabel" style="">序号</label></td>
                                                <td id="ctl724574_header1" data-datafield="DHTbl.DHType" style="">
                                                    <label id="ctl724574_Label1" data-datafield="DHTbl.DHType" data-type="SheetLabel" style="">到货类别</label></td>
                                                <td id="ctl724574_header2" data-datafield="DHTbl.DHSeq" style="">
                                                    <label id="ctl724574_Label2" data-datafield="DHTbl.DHSeq" data-type="SheetLabel" style="">到货批次</label></td>
                                                <td id="ctl724574_header3" data-datafield="DHTbl.ShippingType" style="">
                                                    <label id="ctl724574_Label3" data-datafield="DHTbl.ShippingType" data-type="SheetLabel" style="">运输方式</label></td>
                                                <td id="ctl724574_header4" data-datafield="DHTbl.GoodName" style="">
                                                    <label id="ctl724574_Label4" data-datafield="DHTbl.GoodName" data-type="SheetLabel" style="">品名</label></td>
                                                <td id="ctl724574_header5" data-datafield="DHTbl.Num" style="">
                                                    <label id="ctl724574_Label5" data-datafield="DHTbl.Num" data-type="SheetLabel" style="">数量</label></td>
                                                <td id="ctl724574_header6" data-datafield="DHTbl.Amount" style="">
                                                    <label id="ctl724574_Label6" data-datafield="DHTbl.Amount" data-type="SheetLabel" style="">金额</label></td>
                                                <td id="ctl724574_header7" data-datafield="DHTbl.Currency" style="">
                                                    <label id="ctl724574_Label7" data-datafield="DHTbl.Currency" data-type="SheetLabel" style="">币种</label></td>
                                                <td id="ctl724574_header8" data-datafield="DHTbl.Supplier" style="">
                                                    <label id="ctl724574_Label8" data-datafield="DHTbl.Supplier" data-type="SheetLabel" style="">供货商\发货人</label></td>
                                                <td id="ctl724574_header9" data-datafield="DHTbl.Status" style="" class="hidden">
                                                    <label id="ctl724574_Label9" data-datafield="DHTbl.Status" data-type="SheetLabel" style="" class="hidden">状态Status</label></td>
                                                <td id="ctl724574_header10" data-datafield="DHTbl.DisplayName" style="">
                                                    <label id="ctl724574_Label10" data-datafield="DHTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl724574_header11" data-datafield="DHTbl.Operate" style="width: 8%">
                                                    <label id="ctl724574_Label11" data-datafield="DHTbl.Operate" data-type="SheetLabel">操作</label></td>
                                                <td id="ctl724574_header12" data-datafield="DHTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl724574_Label12" data-datafield="DHTbl.WorkItemId" data-type="SheetLabel" style="" class="hidden">流程节点Id</label></td>
                                                <td id="ctl724574_header13" data-datafield="DHTbl.BizObjectID" style="" class="hidden">
                                                    <label id="ctl724574_Label13" data-datafield="DHTbl.BizObjectID" data-type="SheetLabel" style="" class="hidden">表单Id</label></td>
                                                <td id="ctl724574_header14" data-datafield="DHTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl724574_Label14" data-datafield="DHTbl.RejectFlg" data-type="SheetLabel" style="" class="hidden">驳回Flg</label></td>
                                                <td id="ctl724574_header14" data-datafield="DHTbl.SeqCnt" style="" class="hidden">
                                                    <label id="ctl724574_Label14" data-datafield="DHTbl.SeqCnt" data-type="SheetLabel" style="" class="hidden">批次数量</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl724574_control0" data-datafield="DHTbl.TheNo" style="">
                                                    <input type="text" data-datafield="DHTbl.TheNo" data-type="SheetTextBox" id="ctl724574_control0" style=""></td>
                                                <td id="ctl724574_control1" data-datafield="DHTbl.DHType" style="">
                                                    <input type="text" data-datafield="DHTbl.DHType" data-type="SheetTextBox" id="ctl724574_control1" style=""></td>
                                                <td id="ctl724574_control2" data-datafield="DHTbl.DHSeq" style="">
                                                    <input type="text" data-datafield="DHTbl.DHSeq" data-type="SheetTextBox" id="ctl724574_control2" style=""></td>
                                                <td id="ctl724574_control3" data-datafield="DHTbl.ShippingType" style="">
                                                    <input type="text" data-datafield="DHTbl.ShippingType" data-type="SheetTextBox" id="ctl724574_control3" style=""></td>
                                                <td id="ctl724574_control4" data-datafield="DHTbl.GoodName" style="">
                                                    <input type="text" data-datafield="DHTbl.GoodName" data-type="SheetTextBox" id="ctl724574_control4" style=""></td>
                                                <td id="ctl724574_control5" data-datafield="DHTbl.Num" style="">
                                                    <input type="text" data-datafield="DHTbl.Num" data-type="SheetTextBox" id="ctl724574_control5" style=""></td>
                                                <td id="ctl724574_control6" data-datafield="DHTbl.Amount" style="">
                                                    <input type="text" data-datafield="DHTbl.Amount" data-type="SheetTextBox" id="ctl724574_control6" style=""></td>
                                                <td id="ctl724574_control7" data-datafield="DHTbl.Currency" style="">
                                                    <input type="text" data-datafield="DHTbl.Currency" data-type="SheetTextBox" id="ctl724574_control7" style=""></td>
                                                <td id="ctl724574_control8" data-datafield="DHTbl.Supplier" style="">
                                                    <input type="text" data-datafield="DHTbl.Supplier" data-type="SheetTextBox" id="ctl724574_control8" style=""></td>
                                                <td id="ctl724574_control9" data-datafield="DHTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="DHTbl.Status" data-type="SheetTextBox" id="ctl724574_control9" style="" class=""></td>
                                                <td id="ctl724574_control10" data-datafield="DHTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="DHTbl.DisplayName" data-type="SheetTextBox" id="ctl724574_control10" style=""></td>
                                                <td id="ctl724574_control11" data-datafield="DHTbl.Operate" style="">
                                                    <a class="btn btn-primary viewDH" onclick="viewDH(this)">查看</a>&nbsp;<a class="btn btn-primary updateDH" onclick="updateDH(this)">修改</a></td>
                                                <td id="ctl724574_control12" data-datafield="DHTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="DHTbl.WorkItemId" data-type="SheetTextBox" id="ctl724574_control12" style=""></td>
                                                <td id="ctl724574_control13" data-datafield="DHTbl.BizObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="DHTbl.BizObjectID" data-type="SheetTextBox" id="ctl724574_control13" style=""></td>
                                                <td id="ctl724574_control14" data-datafield="DHTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="DHTbl.RejectFlg" data-type="SheetTextBox" id="ctl724574_control14" style=""></td>
                                                <td id="ctl724574_control14" data-datafield="DHTbl.SeqCnt" style="" class="hidden">
                                                    <input type="text" data-datafield="DHTbl.SeqCnt" data-type="SheetTextBox" id="ctl724574_control14" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="bgtab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveBGId" type="button" onclick="ApproveBG()" value="合同变更申请" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div746371" class="col-md-12">
                                    <table id="ctl566190" data-datafield="BGTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl566190_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl566190_header0" data-datafield="BGTbl.AmountOld" style="">
                                                    <label id="ctl566190_Label0" data-datafield="BGTbl.AmountOld" data-type="SheetLabel" style="">合同原金额</label></td>
                                                <td id="ctl566190_header1" data-datafield="BGTbl.AmountNew" style="">
                                                    <label id="ctl566190_Label1" data-datafield="BGTbl.AmountNew" data-type="SheetLabel" style="">本次变更金额</label></td>
                                                <td id="ctl566190_header2" data-datafield="BGTbl.DHDateOld" style="">
                                                    <label id="ctl566190_Label2" data-datafield="BGTbl.DHDateOld" data-type="SheetLabel" style="">合同原到货期</label></td>
                                                <td id="ctl566190_header3" data-datafield="BGTbl.DHDateNew" style="">
                                                    <label id="ctl566190_Label3" data-datafield="BGTbl.DHDateNew" data-type="SheetLabel" style="">合同变更后到货期</label></td>
                                                <td id="ctl566190_header4" data-datafield="BGTbl.Status" style="" class="hidden">
                                                    <label id="ctl566190_Label4" data-datafield="BGTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl566190_header5" data-datafield="BGTbl.DisplayName" style="">
                                                    <label id="ctl566190_Label5" data-datafield="BGTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl566190_header6" data-datafield="BGTbl.Operate" style="">
                                                    <label id="ctl566190_Label6" data-datafield="BGTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl566190_header7" data-datafield="BGTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl566190_Label7" data-datafield="BGTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                                <td id="ctl566190_header8" data-datafield="BGTbl.BizObjectID" style="" class="hidden">
                                                    <label id="ctl566190_Label8" data-datafield="BGTbl.BizObjectID" data-type="SheetLabel" style="" class="">表单Id</label></td>
                                                <td id="ctl566190_header9" data-datafield="BGTbl.RejectFlg" style="" class="">
                                                    <label id="ctl566190_Label9" data-datafield="BGTbl.RejectFlg" data-type="SheetLabel" style="" class="hidden">驳回Flg</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl566190_control0" data-datafield="BGTbl.AmountOld" style="">
                                                    <input type="text" data-datafield="BGTbl.AmountOld" data-type="SheetTextBox" id="ctl566190_control0" style=""></td>
                                                <td id="ctl566190_control1" data-datafield="BGTbl.AmountNew" style="">
                                                    <input type="text" data-datafield="BGTbl.AmountNew" data-type="SheetTextBox" id="ctl566190_control1" style=""></td>
                                                <td id="ctl566190_control2" data-datafield="BGTbl.DHDateOld" style="">
                                                    <input type="text" data-datafield="BGTbl.DHDateOld" data-type="SheetTextBox" id="ctl566190_control2" style=""></td>
                                                <td id="ctl566190_control3" data-datafield="BGTbl.DHDateNew" style="">
                                                    <input type="text" data-datafield="BGTbl.DHDateNew" data-type="SheetTextBox" id="ctl566190_control3" style=""></td>
                                                <td id="ctl566190_control4" data-datafield="BGTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="BGTbl.Status" data-type="SheetTextBox" id="ctl566190_control4" style=""></td>
                                                <td id="ctl566190_control5" data-datafield="BGTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="BGTbl.DisplayName" data-type="SheetTextBox" id="ctl566190_control5" style=""></td>
                                                <td id="ctl566190_control6" data-datafield="BGTbl.Operate" style="">
                                                    <a class="btn btn-primary viewBG" onclick="viewBG(this)">查看</a>&nbsp;<a class="btn btn-primary updateBG" onclick="updateBG(this)">修改</a></td>
                                                <td id="ctl566190_control7" data-datafield="BGTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="BGTbl.WorkItemId" data-type="SheetTextBox" id="ctl566190_control7" style=""></td>
                                                <td id="ctl566190_control8" data-datafield="BGTbl.BizObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="BGTbl.BizObjectID" data-type="SheetTextBox" id="ctl566190_control8" style=""></td>
                                                <td id="ctl566190_control9" data-datafield="BGTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="BGTbl.RejectFlg" data-type="SheetTextBox" id="ctl566190_control9" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="bhtab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input id="ApproveBHId" type="button" onclick="ApproveBH()" value="录入保函" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div746371" class="col-md-12">
                                    <table id="ctl727077" data-datafield="BHTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl727077_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl727077_header0" data-datafield="BHTbl.BHType" style="">
                                                    <label id="ctl727077_Label0" data-datafield="BHTbl.BHType" data-type="SheetLabel" style="">保函类型</label></td>
                                                <td id="ctl727077_header1" data-datafield="BHTbl.BHProperty" style="">
                                                    <label id="ctl727077_Label1" data-datafield="BHTbl.BHProperty" data-type="SheetLabel" style="">保函性质</label></td>
                                                <td id="ctl727077_header2" data-datafield="BHTbl.BHAmount" style="">
                                                    <label id="ctl727077_Label2" data-datafield="BHTbl.BHAmount" data-type="SheetLabel" style="">保函金额</label></td>
                                                <td id="ctl727077_header3" data-datafield="BHTbl.ReceiveDate" style="">
                                                    <label id="ctl727077_Label3" data-datafield="BHTbl.ReceiveDate" data-type="SheetLabel" style="">接受日期</label></td>
                                                <td id="ctl727077_header4" data-datafield="BHTbl.ExpirationDate" style="">
                                                    <label id="ctl727077_Label4" data-datafield="BHTbl.ExpirationDate" data-type="SheetLabel" style="">保函到期日</label></td>
                                                <td id="ctl727077_header5" data-datafield="BHTbl.TBStatus" style="">
                                                    <label id="ctl727077_Label5" data-datafield="BHTbl.TBStatus" data-type="SheetLabel" style="">退保状态</label></td>
                                                <td id="ctl727077_header5" data-datafield="BHTbl.Status" style="" class="hidden">
                                                    <label id="ctl727077_Label5" data-datafield="BHTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl727077_header6" data-datafield="BHTbl.Edit" style="">
                                                    <label id="ctl727077_Label6" data-datafield="BHTbl.Edit" data-type="SheetLabel" style="">编辑</label></td>
                                                <td id="ctl727077_header7" data-datafield="BHTbl.TB" style="">
                                                    <label id="ctl727077_Label7" data-datafield="BHTbl.TB" data-type="SheetLabel" style="">退保</label></td>
                                                <td id="ctl727077_header8" data-datafield="BHTbl.Operate" style="">
                                                    <label id="ctl727077_Label8" data-datafield="BHTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl727077_header9" data-datafield="BHTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl727077_Label9" data-datafield="BHTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl727077_header10" data-datafield="BHTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl727077_Label10" data-datafield="BHTbl.WorkItemId" data-type="SheetLabel" style="">流程Id</label></td>
                                                <td id="ctl727077_header11" data-datafield="BHTbl.BizObjectID" style="" class="hidden">
                                                    <label id="ctl727077_Label11" data-datafield="BHTbl.BizObjectID" data-type="SheetLabel" style="" class="">BizObjectID</label></td>
                                                <td id="ctl727077_header11" data-datafield="BHTbl.InputWorkitemId" style="" class="hidden">
                                                    <label id="ctl727077_Label11" data-datafield="BHTbl.InputWorkitemId" data-type="SheetLabel" style="" class="">InputWorkitemId</label></td>
                                                <td id="ctl727077_header11" data-datafield="BHTbl.InputBizObjectID" style="" class="hidden">
                                                    <label id="ctl727077_Label11" data-datafield="BHTbl.InputBizObjectID" data-type="SheetLabel" style="" class="">InputBizObjectID</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl727077_control0" data-datafield="BHTbl.BHType" style="">
                                                    <input type="text" data-datafield="BHTbl.BHType" data-type="SheetTextBox" id="ctl727077_control0" style=""></td>
                                                <td id="ctl727077_control1" data-datafield="BHTbl.BHProperty" style="">
                                                    <input type="text" data-datafield="BHTbl.BHProperty" data-type="SheetTextBox" id="ctl727077_control1" style=""></td>
                                                <td id="ctl727077_control2" data-datafield="BHTbl.BHAmount" style="">
                                                    <input type="text" data-datafield="BHTbl.BHAmount" data-type="SheetTextBox" id="ctl727077_control2" style=""></td>
                                                <td id="ctl727077_control3" data-datafield="BHTbl.ReceiveDate" style="">
                                                    <input type="text" data-datafield="BHTbl.ReceiveDate" data-type="SheetTextBox" id="ctl727077_control3" style=""></td>
                                                <td id="ctl727077_control4" data-datafield="BHTbl.ExpirationDate" style="">
                                                    <input type="text" data-datafield="BHTbl.ExpirationDate" data-type="SheetTextBox" id="ctl727077_control4" style=""></td>
                                                <td id="ctl727077_control5" data-datafield="BHTbl.TBStatus" style="">
                                                    <input type="text" data-datafield="BHTbl.TBStatus" data-type="SheetTextBox" id="ctl727077_control5" style=""></td>
                                                <td id="ctl727077_control5" data-datafield="BHTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.Status" data-type="SheetTextBox" id="ctl727077_control5" style=""></td>
                                                <td id="ctl727077_control6" data-datafield="BHTbl.Edit" style="">
                                                    <a class="btn btn-primary editBH" onclick="editBH(this)">编辑</a></td>
                                                <td id="ctl727077_control7" data-datafield="BHTbl.TB" style="">
                                                    <a class="btn btn-primary doTB" onclick="doTB(this)">退保</a></td>
                                                <td id="ctl727077_control8" data-datafield="BHTbl.Operate" style="">
                                                    <a class="btn btn-primary viewBH" onclick="viewBH(this)">查看</a>&nbsp;<a class="btn btn-primary updateBH" onclick="updateBH(this)">修改</a></td>
                                                <td id="ctl727077_control9" data-datafield="BHTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.RejectFlg" data-type="SheetTextBox" id="ctl727077_control9" style=""></td>
                                                <td id="ctl727077_control10" data-datafield="BHTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.WorkItemId" data-type="SheetTextBox" id="ctl727077_control10" style=""></td>
                                                <td id="ctl727077_control11" data-datafield="BHTbl.BizObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.BizObjectID" data-type="SheetTextBox" id="ctl727077_control11" style=""></td>
                                                <td id="ctl727077_control11" data-datafield="BHTbl.InputWorkitemId" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.InputWorkitemId" data-type="SheetTextBox" id="ctl727077_control11" style=""></td>
                                                <td id="ctl727077_control11" data-datafield="BHTbl.InputBizObjectID" style="" class="hidden">
                                                    <input type="text" data-datafield="BHTbl.InputBizObjectID" data-type="SheetTextBox" id="ctl727077_control11" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="gdtab">
                            <div class="row tableContent">
                                <div id="div180778" class="col-md-2">
                                    <label data-datafield="ContractFileNameSignVer" data-type="SheetLabel" id="ctl5629" class="" style="">合同正本签字版</label>
                                </div>
                                <div id="div695347" class="col-md-4">
                                    <input type="text" data-datafield="ContractFileNameSignVer" data-type="SheetTextBox" id="ctl429804" class="" style="">
                                    <div id="ContractFileNameSignVer"></div>
                                </div>
                                <div id="div334423" class="col-md-6">
                                    <input id="GDContractFileId" type="button" onclick="ApplyFileGD()" value="合同文件归档" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent GDAgencyHY HYDiv">
                                <div id="div841342" class="col-md-2">
                                    <label data-datafield="AgencyFileNameSignVer" data-type="SheetLabel" id="ctl407566" class="" style="">协议正本签字版</label>
                                </div>
                                <div id="div519941" class="col-md-4">
                                    <input type="text" data-datafield="AgencyFileNameSignVer" data-type="SheetTextBox" id="ctl731947" class="" style="">
                                    <div id="AgencyFileNameSignVer"></div>
                                </div>
                                <div id="div998306" class="col-md-6">
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div434485" class="col-md-2">
                                    <label data-datafield="ContractFileArchiveTbl" data-type="SheetLabel" id="ctl523300" class="" style="">确认记录</label>
                                </div>
                                <div id="div975168" class="col-md-10">
                                    <table id="ctl105207" data-datafield="ContractFileArchiveTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl105207_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl105207_header0" data-datafield="ContractFileArchiveTbl.Applyer" style="">
                                                    <label id="ctl105207_Label0" data-datafield="ContractFileArchiveTbl.Applyer" data-type="SheetLabel" style="">申请人</label></td>
                                                <td id="ctl105207_header1" data-datafield="ContractFileArchiveTbl.ApplyDate" style="">
                                                    <label id="ctl105207_Label1" data-datafield="ContractFileArchiveTbl.ApplyDate" data-type="SheetLabel" style="">申请时间</label></td>
                                                <td id="ctl105207_header2" data-datafield="ContractFileArchiveTbl.DisplayName" style="">
                                                    <label id="ctl105207_Label2" data-datafield="ContractFileArchiveTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl105207_header3" data-datafield="ContractFileArchiveTbl.Status" style="" class="hidden">
                                                    <label id="ctl105207_Label3" data-datafield="ContractFileArchiveTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl105207_header4" data-datafield="ContractFileArchiveTbl.Operate" style="">
                                                    <label id="ctl105207_Label4" data-datafield="ContractFileArchiveTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl105207_header5" data-datafield="ContractFileArchiveTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl105207_Label5" data-datafield="ContractFileArchiveTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl105207_header6" data-datafield="ContractFileArchiveTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl105207_Label6" data-datafield="ContractFileArchiveTbl.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td id="ctl105207_header7" data-datafield="ContractFileArchiveTbl.BizObjectId" style="" class="hidden">
                                                    <label id="ctl105207_Label7" data-datafield="ContractFileArchiveTbl.BizObjectId" data-type="SheetLabel" style="">BizObjectId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl105207_control0" data-datafield="ContractFileArchiveTbl.Applyer" style="">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.Applyer" data-type="SheetTextBox" id="ctl105207_control0" style=""></td>
                                                <td id="ctl105207_control1" data-datafield="ContractFileArchiveTbl.ApplyDate" style="">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.ApplyDate" data-type="SheetTextBox" id="ctl105207_control1" style=""></td>
                                                <td id="ctl105207_control2" data-datafield="ContractFileArchiveTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.DisplayName" data-type="SheetTextBox" id="ctl105207_control2" style=""></td>
                                                <td id="ctl105207_control3" data-datafield="ContractFileArchiveTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.Status" data-type="SheetTextBox" id="ctl105207_control3" style=""></td>
                                                <td id="ctl105207_control4" data-datafield="ContractFileArchiveTbl.Operate" style="">
                                                    <a class="btn btn-primary viewGD" onclick="viewGD(this)">查看</a>&nbsp;<a class="btn btn-primary updateGD" onclick="updateGD(this)">修改</a></td>
                                                <td id="ctl105207_control5" data-datafield="ContractFileArchiveTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.RejectFlg" data-type="SheetTextBox" id="ctl105207_control5" style=""></td>
                                                <td id="ctl105207_control6" data-datafield="ContractFileArchiveTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.WorkItemId" data-type="SheetTextBox" id="ctl105207_control6" style=""></td>
                                                <td id="ctl105207_control7" data-datafield="ContractFileArchiveTbl.BizObjectId" style="" class="hidden">
                                                    <input type="text" data-datafield="ContractFileArchiveTbl.BizObjectId" data-type="SheetTextBox" id="ctl105207_control7" style=""></td>
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
                            <div class="row tableContent GDAgencyShow">
                                <div id="div520097" class="col-md-2">
                                    <label data-datafield="AgencyArchiveSelect" data-type="SheetLabel" id="ctl14705" class="" style="">代理协议</label>
                                </div>
                                <div id="div109447" class="col-md-4">
                                    <input type="text" data-datafield="AgencyArchiveSelect" data-type="SheetTextBox" id="ctl112592" class="" style="" data-popupwindow="PopupWindow" data-schemacode="GetAgencyList" data-querycode="GetAgencyList" data-outputmappings="AgencyCode:AgreeMent_number,AgencyArchiveSelect:AgreeMent_name,AgencyReturnType:agency_type_name,AgencyTheNo:No,AgencyReturnNumber:number">
                                </div>
                                <div id="div895502" class="col-md-6"></div>
                            </div>
                            <div class="row tableContent GDAgencyShow">
                                <div id="div940909" class="col-md-2">
                                </div>
                                <div id="div749412" class="col-md-4">
                                    <input type="text" data-datafield="AgencyArchiveComment" data-type="SheetTextBox" id="ctl247492" class="" style="">
                                </div>
                                <div id="div518433" class="col-md-6"></div>
                            </div>
                            <div class="row GDChangeShow">
                                <div id="div947976" class="col-md-2">
                                    <label data-datafield="ContractChangeFileNameSignVer" data-type="SheetLabel" id="ctl186355" class="" style="">合同变更书签字版</label>
                                </div>
                                <div id="div939292" class="col-md-4">
                                    <input type="text" data-datafield="ContractChangeFileNameSignVer" data-type="SheetTextBox" id="ctl461855" class="" style="">
                                    <div id="ContractChangeFileNameSignVer"></div>
                                </div>
                                <div id="div409311" class="col-md-6">
                                    <input id="GDChangeContractFileId" type="button" onclick="ApplyFileGDChange()" value="合同变更书归档" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent GDChangeShow">
                                <div id="div129141" class="col-md-2">
                                    <label data-datafield="AgencyChangeFileNameSignVer" data-type="SheetLabel" id="ctl238621" class="" style="">协议变更书签字版</label>
                                </div>
                                <div id="div851876" class="col-md-4">
                                    <input type="text" data-datafield="AgencyChangeFileNameSignVer" data-type="SheetTextBox" id="ctl354309" class="" style="">
                                    <div id="AgencyChangeFileNameSignVer"></div>
                                </div>
                                <div id="div149902" class="col-md-6"></div>
                            </div>
                            <div class="row tableContent GDChangeShow">
                                <div id="div254281" class="col-md-2">
                                    <label data-datafield="ChangeArchiveTbl" data-type="SheetLabel" id="ctl439983" class="" style="">确认记录</label>
                                </div>
                                <div id="div761122" class="col-md-10">
                                    <table id="ctl268125" data-datafield="ChangeArchiveTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl268125_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl268125_header0" data-datafield="ChangeArchiveTbl.Applyer" style="">
                                                    <label id="ctl268125_Label0" data-datafield="ChangeArchiveTbl.Applyer" data-type="SheetLabel" style="">申请人</label></td>
                                                <td id="ctl268125_header1" data-datafield="ChangeArchiveTbl.ApplyDate" style="">
                                                    <label id="ctl268125_Label1" data-datafield="ChangeArchiveTbl.ApplyDate" data-type="SheetLabel" style="">申请时间</label></td>
                                                <td id="ctl268125_header2" data-datafield="ChangeArchiveTbl.Status" style="" class="hidden">
                                                    <label id="ctl268125_Label2" data-datafield="ChangeArchiveTbl.Status" data-type="SheetLabel" style="" class="">状态</label></td>
                                                <td id="ctl268125_header3" data-datafield="ChangeArchiveTbl.DisplayName" style="">
                                                    <label id="ctl268125_Label3" data-datafield="ChangeArchiveTbl.DisplayName" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl268125_header4" data-datafield="ChangeArchiveTbl.Operate" style="">
                                                    <label id="ctl268125_Label4" data-datafield="ChangeArchiveTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl268125_header5" data-datafield="ChangeArchiveTbl.RejectFlg" style="" class="hidden">
                                                    <label id="ctl268125_Label5" data-datafield="ChangeArchiveTbl.RejectFlg" data-type="SheetLabel" style="">RejectFlg</label></td>
                                                <td id="ctl268125_header6" data-datafield="ChangeArchiveTbl.WorkItemId" style="" class="hidden">
                                                    <label id="ctl268125_Label6" data-datafield="ChangeArchiveTbl.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td id="ctl268125_header7" data-datafield="ChangeArchiveTbl.BizObjectId" style="" class="hidden">
                                                    <label id="ctl268125_Label7" data-datafield="ChangeArchiveTbl.BizObjectId" data-type="SheetLabel" style="">BizObjectId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl268125_control0" data-datafield="ChangeArchiveTbl.Applyer" style="">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.Applyer" data-type="SheetTextBox" id="ctl268125_control0" style=""></td>
                                                <td id="ctl268125_control1" data-datafield="ChangeArchiveTbl.ApplyDate" style="">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.ApplyDate" data-type="SheetTextBox" id="ctl268125_control1" style=""></td>
                                                <td id="ctl268125_control2" data-datafield="ChangeArchiveTbl.Status" style="" class="hidden">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.Status" data-type="SheetTextBox" id="ctl268125_control2" style=""></td>
                                                <td id="ctl268125_control3" data-datafield="ChangeArchiveTbl.DisplayName" style="">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.DisplayName" data-type="SheetTextBox" id="ctl268125_control3" style=""></td>
                                                <td id="ctl268125_control4" data-datafield="ChangeArchiveTbl.Operate" style="">
                                                    <a class="btn btn-primary viewGDChange" onclick="viewGDChange(this)">查看</a>&nbsp;<a class="btn btn-primary updateGDChange" onclick="updateGDChange(this)">修改</a></td>
                                                <td id="ctl268125_control5" data-datafield="ChangeArchiveTbl.RejectFlg" style="" class="hidden">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.RejectFlg" data-type="SheetTextBox" id="ctl268125_control5" style=""></td>
                                                <td id="ctl268125_control6" data-datafield="ChangeArchiveTbl.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.WorkItemId" data-type="SheetTextBox" id="ctl268125_control6" style=""></td>
                                                <td id="ctl268125_control7" data-datafield="ChangeArchiveTbl.BizObjectId" style="" class="hidden">
                                                    <input type="text" data-datafield="ChangeArchiveTbl.BizObjectId" data-type="SheetTextBox" id="ctl268125_control7" style=""></td>
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
                            <div class="row tableContent">
                                <div id="div608023" class="col-md-2">
                                    <label data-datafield="OtherFile" data-type="SheetLabel" id="ctl715492" class="" style="">其他文件</label>
                                </div>
                                <div id="div418761" class="col-md-4">
                                    <input type="text" data-datafield="OtherFile" data-type="SheetTextBox" id="" class="hidden" style="">
                                    <div id="OtherFile"></div>
                                </div>
                                <div id="div426813" class="col-md-6"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="ContractContent ContractContentComplete">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleComplete">
                <label id="divSheetInfo" data-en_us="Sheet information">合同完成&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="div849669" class="col-md-2">
                        <label data-datafield="CompleteApplyer" data-type="SheetLabel" id="ctl875125" class="" style="">合同完成提交人</label>
                    </div>
                    <div id="div814641" class="col-md-4">
                        <input type="text" data-datafield="CompleteApplyer" data-type="SheetTextBox" id="ctl606955" class="" style="">
                    </div>
                    <div id="div17426" class="col-md-2">
                        <label data-datafield="CompleteTime" data-type="SheetLabel" id="ctl240829" class="" style="">合同完成时间</label>
                    </div>
                    <div id="div269787" class="col-md-4">
                        <input type="text" data-datafield="CompleteTime" data-type="SheetTime" id="ctl310013" class="" style="" data-defaultvalue="" data-timemode="FullTime">
                    </div>
                </div>
            </div>
        </div>

        <div class="ContractContent ContractContentGetBack">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleGetBack">
                <label id="divSheetInfo" data-en_us="Sheet information">合同回退记录&nbsp;<span class="ContractNoShow"></span></label>
                <span class="pull-right text-muted" id="toggleBtn">
                    <i class="fa fa-fw fa-angle-double-down text" style="display:none"></i>
                    <i class="fa fa-fw  fa-angle-double-up text-active" style="display: block;"></i>
                </span>
            </div>
            <div class="divContent divContent_Tab" id="divSheet">
                <div class="row">
                    <div id="div371959" class="col-md-2">
                        <label data-datafield="GetBackMainTbl" data-type="SheetLabel" id="ctl280690" class="" style="">合同回退记录</label>
                    </div>
                    <div id="div666980" class="col-md-10">
                        <table id="ctl532792" data-datafield="GetBackMainTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl532792_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl532792_header0" data-datafield="GetBackMainTbl.Approver" style="">
                                        <label id="ctl532792_Label0" data-datafield="GetBackMainTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl532792_header1" data-datafield="GetBackMainTbl.ApproveDate" style="">
                                        <label id="ctl532792_Label1" data-datafield="GetBackMainTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl532792_header2" data-datafield="GetBackMainTbl.Remark" style="">
                                        <label id="ctl532792_Label2" data-datafield="GetBackMainTbl.Remark" data-type="SheetLabel" style="">回退事由</label></td>
                                    <td id="ctl532792_header3" data-datafield="GetBackMainTbl.OldInstanceActivityName" style="">
                                        <label id="ctl532792_Label3" data-datafield="GetBackMainTbl.OldInstanceActivityName" data-type="SheetLabel" style="">当前阶段</label></td>
                                    <td id="ctl532792_header4" data-datafield="GetBackMainTbl.InstanceActivityName" style="">
                                        <label id="ctl532792_Label4" data-datafield="GetBackMainTbl.InstanceActivityName" data-type="SheetLabel" style="">回退到</label></td>
                                    <td id="ctl532792_header5" data-datafield="GetBackMainTbl.Status" style="">
                                        <label id="ctl532792_Label5" data-datafield="GetBackMainTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl532792_header6" data-datafield="GetBackMainTbl.Operate" style="">
                                        <label id="ctl532792_Label6" data-datafield="GetBackMainTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl532792_header7" data-datafield="GetBackMainTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl532792_Label7" data-datafield="GetBackMainTbl.WorkItemId" data-type="SheetLabel" style="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl532792_control0" data-datafield="GetBackMainTbl.Approver" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.Approver" data-type="SheetTextBox" id="ctl532792_control0" style=""></td>
                                    <td id="ctl532792_control1" data-datafield="GetBackMainTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.ApproveDate" data-type="SheetTextBox" id="ctl532792_control1" style=""></td>
                                    <td id="ctl532792_control2" data-datafield="GetBackMainTbl.Remark" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.Remark" data-type="SheetTextBox" id="ctl532792_control2" style=""></td>
                                    <td id="ctl532792_control3" data-datafield="GetBackMainTbl.OldInstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.OldInstanceActivityName" data-type="SheetTextBox" id="ctl532792_control3" style=""></td>
                                    <td id="ctl532792_control4" data-datafield="GetBackMainTbl.InstanceActivityName" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.InstanceActivityName" data-type="SheetTextBox" id="ctl532792_control4" style=""></td>
                                    <td id="ctl532792_control5" data-datafield="GetBackMainTbl.Status" style="">
                                        <input type="text" data-datafield="GetBackMainTbl.Status" data-type="SheetTextBox" id="ctl532792_control5" style=""></td>
                                    <td id="ctl532792_control6" data-datafield="GetBackMainTbl.Operate" style="">
                                        <a class="btn btn-primary viewBack" onclick="viewBack(this)">查看</a></td>
                                    <td id="ctl532792_control7" data-datafield="GetBackMainTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="GetBackMainTbl.WorkItemId" data-type="SheetTextBox" id="ctl532792_control7" style=""></td>
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
    <%--<script src="../js/tableS.js"></script>--%>

    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/file2.js"></script>
    <script src="../js/select2.js"></script>

    <script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.excheck.js"></script>

    <script src="ContractMainTree.js"></script>

</asp:Content>
