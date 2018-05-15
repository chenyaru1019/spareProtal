﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AircraftOilAgreement.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.Agreement.AircraftOilAgreement" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">

    <script type="text/javascript">			

</script>
    <link rel="stylesheet" href="../../css/common.css">
    <script src="../../js/bootstrap-select.min.js"></script>
    <script src="../../js/bootstrap-table.min.js"></script>
    <script src="../../js/bootstrap-table-zh-CN.min.js"></script>

    <link rel="stylesheet" href="../../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../js/bootstrap-table.min.css">
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">协议主流程</label>
    </div>
    <div class="panel-body sheetContainer">

        <div class="ContractContent ">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleCreate">
                <label id="divSheetInfo" data-en_us="Sheet information">创建协议</label>
            </div>
            <div class="divContent" id="divSheet">
                <div id="cjxy">
                    <div class="row">
                        <div id="title1" class="col-md-2">
                            <span id="Label11" data-type="SheetLabel" data-datafield="Project_head_A" style="">项目负责人A</span>
                        </div>
                        <div id="control1" class="col-md-4">

                            <div data-datafield="Project_head_A" data-type="SheetUser" id="ctl947054" class="" style=""></div>
                        </div>
                        <div id="title2" class="col-md-2">
                            <span id="Label12" data-type="SheetLabel" data-datafield="Project_head_B" style="">项目负责人B</span>
                        </div>
                        <div id="control2" class="col-md-4">

                            <div data-datafield="Project_head_B" data-type="SheetUser" id="ctl16666" class="" style=""></div>
                        </div>
                    </div>
                    <div class="row">
                        <div id="title3" class="col-md-2">
                            <span id="Label13" data-type="SheetLabel" data-datafield="AgreeMent_name" style="">协议名称</span>
                        </div>
                        <div id="control3" class="col-md-4">
                            <input id="Control13" type="text" data-datafield="AgreeMent_name" data-type="SheetTextBox" style="">
                        </div>
                        <div id="title3" class="col-md-2">
                            <span id="Label13" data-type="SheetLabel" data-datafield="Agreement_client" style="">协议委托方</span>
                        </div>
                        <div id="control3" class="col-md-4">
                            <input id="Control13" type="text" data-datafield="Agreement_client" data-type="SheetTextBox" style="" class="" data-popupwindow="PopupWindow" data-schemacode="GetCustomerCompanys" data-querycode="GetCustomerCompanys" data-outputmappings="Agreement_client:CompanyName" data-onchange="SetDatasByAgreement_client()">
                        </div>

                    </div>
                    <div class="row">
                        <div id="title5" class="col-md-2">
                            <span id="Label15" data-type="SheetLabel" data-datafield="Contacts" style="">联系人</span>
                        </div>
                        <div id="control5" class="col-md-4">
                            <input id="Control15" type="text" data-datafield="Contacts" data-type="SheetTextBox" style="">
                        </div>
                        <div id="title6" class="col-md-2">
                            <span id="Label16" data-type="SheetLabel" data-datafield="Con_phone" style="">联系电话</span>
                        </div>
                        <div id="control6" class="col-md-4">
                            <input id="Control16" type="text" data-datafield="Con_phone" data-type="SheetTextBox" style="">
                        </div>
                    </div>
                    <div class="row">
                        <div id="title8" class="col-md-2">
                            <span id="Label18" data-type="SheetLabel" data-datafield="Mobile_phone" style="">电话</span>
                        </div>
                        <div id="control8" class="col-md-4">

                            <input type="text" data-datafield="Mobile_phone" data-type="SheetTextBox" id="ctl388296" class="" style="">
                        </div>
                        <div id="title8" class="col-md-2">
                            <span id="Label18" data-type="SheetLabel" data-datafield="Fax" style="">传真</span>
                        </div>
                        <div id="control8" class="col-md-4">
                            <input id="Control18" type="text" data-datafield="Fax" data-type="SheetTextBox" style="" class="">
                        </div>
                    </div>
                    <div class="row">
                        <div id="title9" class="col-md-2">
                            <span id="Label19" data-type="SheetLabel" data-datafield="Email" style="">邮箱</span>
                        </div>
                        <div id="control9" class="col-md-4">
                            <input id="Control19" type="text" data-datafield="Email" data-type="SheetTextBox" style="">
                        </div>
                        <div id="title10" class="col-md-2">
                            <span id="Label20" data-type="SheetLabel" data-datafield="Contact_address" style="" class="">联系地址</span>
                        </div>
                        <div id="control10" class="col-md-4">
                            <input id="Control20" type="text" data-datafield="Contact_address" data-type="SheetTextBox" style="">
                        </div>
                    </div>
                    <div class="row">
                        <div id="title11" class="col-md-2">

                            <label data-datafield="agency_rate" data-type="SheetLabel" id="ctl971325" class="" style="">代理费</label>
                        </div>
                        <div id="control11" class="col-md-4">
                            <table id="ctl340103" data-datafield="agency_rates_hy" data-type="SheetGridView" class="SheetGridView" style=""  data-defaultrowcount="0" data-displayadd="false" data-displaydelete="false">
                                <tbody>
                                    <tr class="header">
                                        <td id="ctl340103_SerialNo" class="rowSerialNo">序号</td>
                                        <td id="ctl340103_header0" data-datafield="agency_rates_hy.agency_money" style="">
                                            <label id="ctl340103_Label0" data-datafield="agency_rates_hy.agency_money" data-type="SheetLabel" style="">代理费</label></td>
                                        <td id="ctl340103_header1" data-datafield="agency_rates_hy.agency_type" style="width: 30%;" class="">
                                            <label id="ctl340103_Label1" data-datafield="agency_rates_hy.agency_type" data-type="SheetLabel" style="width: 97%;" class="">代理费类型</label></td>
                                        <td id="ctl340103_header2" data-datafield="agency_rates_hy.up_limit" style="" class="">
                                            <label id="ctl340103_Label2" data-datafield="agency_rates_hy.up_limit" data-type="SheetLabel" style="">上限</label></td>
                                        <td id="ctl340103_header3" data-datafield="agency_rates_hy.lower_limit" style="">
                                            <label id="ctl340103_Label3" data-datafield="agency_rates_hy.lower_limit" data-type="SheetLabel" style="">下限</label></td>
                                        <td class="rowOption hidden">删除</td>
                                    </tr>
                                    <tr class="template">
                                        <td class=""></td>
                                        <td id="ctl340103_control0" data-datafield="agency_rates_hy.agency_money" style="">
                                            <input type="text" data-datafield="agency_rates_hy.agency_money" data-type="SheetTextBox" id="ctl340103_control0" style="" class=""></td>
                                        <td id="ctl340103_control1" data-datafield="agency_rates_hy.agency_type" style="" class="">
                                            <select data-datafield="agency_rates_hy.agency_type" data-onchange="agency_typeChange(this)" data-type="SheetDropDownList" id="ctl178362" class="" style="" data-masterdatacategory="代理费费率／金额" data-queryable="false"></select></td>
                                        <td id="ctl340103_control2" data-datafield="agency_rates_hy.up_limit" style="">
                                            <input type="text" data-datafield="agency_rates_hy.up_limit" data-type="SheetTextBox" id="ctl340103_control2" style=""></td>
                                        <td id="ctl340103_control3" data-datafield="agency_rates_hy.lower_limit" style="">
                                            <input type="text" data-datafield="agency_rates_hy.lower_limit" data-type="SheetTextBox" id="ctl340103_control3" style=""></td>
                                        <td class="rowOption hidden"><a class="delete">
                                            <div class="fa fa-minus"></div>
                                        </a></td>
                                    </tr>
                                </tbody>
                            </table>
                            <%-- <input type="text" data-datafield="agency_rate" data-type="SheetTextBox" id="agency_rate" class="" style="width:40%">
                    <input type="text" data-datafield="up_limit" data-type="SheetTextBox" id="up_limit" class="" style="">
                    <input type="text" data-datafield="lower_limit" data-type="SheetTextBox" id="lower_limit" class="" style="">
                    <select data-datafield="Rate_type" data-type="SheetDropDownList"  onchange="gb(this)" id="ctl319790" class="" style="width: 50%" data-displayemptyitem="true" data-masterdatacategory="代理费费率／金额"></select>--%>
                        </div>
                        <%--<div id="title20" class="col-md-2">
                    <span id="Label27" data-type="SheetLabel" data-datafield="Rate_type" style="">费率类型</span>
                </div>--%>
                        <%--<div id="control20" class="col-md-2">

                    <select data-datafield="Rate_type" data-type="SheetDropDownList" id="ctl319790" class="" style="" data-displayemptyitem="true" data-masterdatacategory="代理费费率／金额"></select>
                </div>--%>
                        <div id="title6" class="col-md-2">

                            <div data-datafield="Is_specialist_money" data-type="SheetCheckboxList" id="ctl15865" class="" style="" data-repeatcolumns="1" data-defaultitems="专家费支出预估" data-onchange="setSpeMoney()"></div>
                        </div>
                        <div id="control6" class="col-md-4">

                            <input type="text" data-datafield="specialist_money" data-type="SheetTextBox" id="ctl477177" class="" style="">元/标段
                        </div>

                        <%--<div id="control12" class="col-md-2">
                    <input type="button" value="自动生成" onclick="Create_number()" class="">
                    <a onclick="update_muber(this)">修改申请</a>
                </div>--%>
                    </div>
                    <div class="row">
                       
                        <div id="title12" class="col-md-2">
                            <span id="Label22" data-type="SheetLabel" data-datafield="AgreeMent_number" style="">协议号</span>
                        </div>
                        <div id="control12" class="col-md-10">
                            <input id="Control22" type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox">
                            <%--<input id="zdsc" type="button" onclick="Create_number()" value="生成协议号" class="btn btn-primary" />
                            <input id="xgsq" type="button" onclick="update_muber()" value="申请修改" class="btn btn-primary" />--%>
                        </div>
                    </div>
                    <div class="row">
                        <div id="title13" class="col-md-2">
                            <span id="Label23" data-type="SheetLabel" data-datafield="Agency_Pro_approval" style="">代理协议报批稿</span>
                        </div>
                        <div id="control13" class="col-md-10">
                            <div id="Control23" data-datafield="Agency_Pro_approval" data-type="SheetAttachment" style=""></div>
                        </div>
                    </div>
                    <div class="row tableContent">
                        <div id="title15" class="col-md-2">
                            <span id="Label24" data-type="SheetLabel" data-datafield="Pay_conditions" style="" class="">支付条件</span>
                        </div>
                        <div id="control15" class="col-md-10">

                            <textarea data-datafield="Pay_conditions" style="height: 60px; width: 100%;" data-type="SheetRichTextBox" id="ctl197314" class="">					</textarea>
                        </div>
                    </div>

                    <%--<div class="row tableContent">
                        <div id="title15" class="col-md-2">
                            <span id="Label24" data-type="SheetLabel" data-datafield="Examine_records" style="" class="">协议号申请修改记录</span>

                        </div>
                        <div id="control15" class="col-md-10">
                            <table id="Control24" data-datafield="Examine_records" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false">
                                <tbody>

                                    <tr class="header">
                                        <td id="Control24_SerialNo" class="rowSerialNo">序号								</td>
                                        <td id="Control24_Header3" data-datafield="Examine_records.Apply_people">
                                            <label id="Control24_Label3" data-datafield="Examine_records.Apply_people" data-type="SheetLabel" style="">申请人</label>
                                        </td>
                                        <td id="Control24_Header4" data-datafield="Examine_records.Apply_time">
                                            <label id="Control24_Label4" data-datafield="Examine_records.Apply_time" data-type="SheetLabel" style="">申请时间</label>
                                        </td>
                                        <td id="Control24_Header5" data-datafield="Examine_records.States">
                                            <label id="Control24_Label5" data-datafield="Examine_records.States" data-type="SheetLabel" style="">状态</label>
                                        </td>
                                        <td class="rowOption" style="display: none;">删除								</td>
                                    </tr>
                                    <tr class="template">
                                        <td id="Control24_Option" class="rowOption"></td>
                                        <td data-datafield="Examine_records.Apply_people">
                                            <input id="Control24_ctl3" type="text" data-datafield="Examine_records.Apply_people" data-type="SheetTextBox" style="" class="">
                                        </td>
                                        <td data-datafield="Examine_records.Apply_time">
                                            <input id="Control24_ctl4" type="text" data-datafield="Examine_records.Apply_time" data-type="SheetTime" style="">
                                        </td>
                                        <td data-datafield="Examine_records.States">
                                            <input id="Control24_ctl5" type="text" data-datafield="Examine_records.States" data-type="SheetTextBox" style="">
                                        </td>
                                        <td class="rowOption" style="display: none;">
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
                                        <td data-datafield="Examine_records.Apply_people"></td>
                                        <td data-datafield="Examine_records.Apply_time"></td>
                                        <td data-datafield="Examine_records.States"></td>
                                        <td class="rowOption" style="display: none;"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
        
        <%--协议审签记录--%>
       <%-- <div class="ContractContent " id="sqjl">

            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleApprove">
                <label id="divSheetInfo" data-en_us="Sheet information">协议审签</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row tableContent">
                    <div class="row tableContent">
                        <div id="div5095" class="col-md-2"></div>
                        <div id="div701597" class="col-md-2"></div>
                        <div id="div473092" class="col-md-2"></div>
                        <div id="div876934" class="col-md-2"></div>
                        <div id="div334418" class="col-md-2"></div>
                        <div id="div707679" class="col-md-2 rightBtn">
                            <input id="xs" type="button" onclick="agreement_apply()" class="btn btn-primary" value="协议审签申请" />
                        </div>
                    </div>
                    <div id="title17" class="col-md-2">

                        <label data-datafield="Agreement_signTbl" data-type="SheetLabel" id="ctl765816" class="" style="">代理协议审签记录</label>
                    </div>
                    <div id="control17" class="col-md-10">

                        <table id="ctl884005" data-datafield="Agreement_signTbl" data-type="SheetGridView" class="SheetGridView" style="" data-displaysequenceno="false" data-displaysummary="false" data-defaultrowcount="0" data-displayadd="false" data-displaydelete="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl884005_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl884005_header0" data-datafield="Agreement_signTbl.Approver" style="">
                                        <label id="ctl884005_Label0" data-datafield="Agreement_signTbl.Approver" data-type="SheetLabel" style="">申请人</label></td>
                                    <td id="ctl884005_header1" data-datafield="Agreement_signTbl.ApproveDate" style="">
                                        <label id="ctl884005_Label1" data-datafield="Agreement_signTbl.ApproveDate" data-type="SheetLabel" style="">申请时间</label></td>
                                    <td id="ctl884005_header2" data-datafield="Agreement_signTbl.Status" style="">
                                        <label id="ctl884005_Label2" data-datafield="Agreement_signTbl.Status" data-type="SheetLabel" style="">状态</label></td>
                                    <td id="ctl884005_header3" data-datafield="Agreement_signTbl.Operate" style="">
                                        <label id="ctl884005_Label3" data-datafield="Agreement_signTbl.Operate" data-type="SheetLabel" style="">操作</label></td>
                                    <td id="ctl884005_header4" data-datafield="Agreement_signTbl.WorkItemId" style="" class="hidden">
                                        <label id="ctl884005_Label4" data-datafield="Agreement_signTbl.WorkItemId" data-type="SheetLabel" style="" class="">流程节点Id</label></td>
                                    <td class="rowOption hidden">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl884005_control0" data-datafield="Agreement_signTbl.Approver" style="">
                                        <input type="text" data-datafield="Agreement_signTbl.Approver" data-type="SheetTextBox" id="ctl884005_control0" style=""></td>
                                    <td id="ctl884005_control1" data-datafield="Agreement_signTbl.ApproveDate" style="">
                                        <input type="text" data-datafield="Agreement_signTbl.ApproveDate" data-type="SheetTextBox" id="ctl884005_control1" style=""></td>
                                    <td id="ctl884005_control2" data-datafield="Agreement_signTbl.Status" style="">
                                        <input type="text" data-datafield="Agreement_signTbl.Status" data-type="SheetTextBox" id="ctl884005_control2" style=""></td>
                                    <td id="ctl884005_control3" data-datafield="Agreement_signTbl.Operate" style="">
                                        <a class="btn btn-primary viewApprove" onclick="viewApprove(this)">查看</a></td>
                                    <td id="ctl884005_control4" data-datafield="Agreement_signTbl.WorkItemId" style="" class="hidden">
                                        <input type="text" data-datafield="Agreement_signTbl.WorkItemId" data-type="SheetTextBox" id="ctl884005_control4" style=""></td>
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
        </div>--%>
        <%--//协议执行--%>
        <div class="ContractContent " id="xyzx">
            <div class="nav-icon fa  fa-chevron-right bannerTitle bannerTitleOperate">
                <label id="divSheetInfo" data-en_us="Sheet information">协议执行</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="Content_Tab">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="tabUSD active"><a href="#homeUSD" aria-controls="homeUSD" role="tab" data-toggle="tab">执行情况</a></li>
                       <%-- <li role="presentation" class="tabPercent" ><a href="#homePercent" aria-controls="homePercent" role="tab" data-toggle="tab">执行情况(百分比)</a></li>--%>
                        <li role="presentation"><a href="#xybgtab" aria-controls="xybgtab" role="tab" data-toggle="tab">协议变更</a></li>
                        <li role="presentation"><a href="#xwtab" aria-controls="xwtab" role="tab" data-toggle="tab">协议文件</a></li>
                        <li role="presentation" class="tabGL"><a href="#glhtab" aria-controls="glhtab" role="tab" data-toggle="tab">关联协议/合同</a></li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="homeUSD">
                            <div class="row tableContent">
                                <div id="div50951" class="col-md-2"></div>
                                <div id="div7015971" class="col-md-2"></div>
                                <div id="div4730921" class="col-md-2"></div>
                                <div id="space521" class="col-md-2">
                                    <label data-datafield="SignDate" data-type="SheetLabel" id="ctl292613" class="" style="">签约时间</label>
                                </div>
                                <div id="spaceControl521" class="col-md-4">
                                    <input type="text" data-datafield="SignDate" data-type="SheetTime" id="ctl459800" class="" style="width:50%" data-defaultvalue="">
                                    *选择签约时间后请点击保存</div>
                            </div>
                            <div class="row tableContent YSList_USD">
                                <div id="div5095" class="col-md-12">应收代理费列表</div>
                            </div>
                            <div class="row tableContent YSList_USD">
                                <div id="control27" class="col-md-12">
                                    <table id="ctl52831" data-datafield="YSListUSD" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false" data-defaultrowcount="0">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl52831_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl52831_header0" data-datafield="YSListUSD.Type" style="">
                                                    <label id="ctl52831_Label0" data-datafield="YSListUSD.Type" data-type="SheetLabel" style="">项目类型</label></td>
                                                <td id="ctl52831_header1" data-datafield="YSListUSD.ProjectNo" style="">
                                                    <label id="ctl52831_Label1" data-datafield="YSListUSD.ProjectNo" data-type="SheetLabel" style="">项目编号</label></td>
                                                <td id="ctl52831_header2" data-datafield="YSListUSD.ProjectName" style="">
                                                    <label id="ctl52831_Label2" data-datafield="YSListUSD.ProjectName" data-type="SheetLabel" style="">项目名称</label></td>
                                                <td id="ctl52831_header3" data-datafield="YSListUSD.YSAgencyFee" style="">
                                                    <label id="ctl52831_Label3" data-datafield="YSListUSD.YSAgencyFee" data-type="SheetLabel" style="">应收代理费</label></td>
                                                <td id="ctl52831_header4" data-datafield="YSListUSD.ReceiveAgencyFee" style="">
                                                    <label id="ctl52831_Label4" data-datafield="YSListUSD.ReceiveAgencyFee" data-type="SheetLabel" style="">已收代理费</label></td>
                                                <td id="ctl52831_header5" data-datafield="YSListUSD.AgencyFeeRemain" style="">
                                                    <label id="ctl52831_Label5" data-datafield="YSListUSD.AgencyFeeRemain" data-type="SheetLabel" style="">代理费余额</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl52831_control0" data-datafield="YSListUSD.Type" style="" class="">
                                                    <input type="text" data-datafield="YSListUSD.Type" data-type="SheetTextBox" id="ctl52831_control0" style=""></td>
                                                <td id="ctl52831_control1" data-datafield="YSListUSD.ProjectNo" style="">
                                                    <input type="text" data-datafield="YSListUSD.ProjectNo" data-type="SheetTextBox" id="ctl52831_control1" style=""></td>
                                                <td id="ctl52831_control2" data-datafield="YSListUSD.ProjectName" style="">
                                                    <input type="text" data-datafield="YSListUSD.ProjectName" data-type="SheetTextBox" id="ctl52831_control2" style=""></td>
                                                <td id="ctl52831_control3" data-datafield="YSListUSD.YSAgencyFee" style="">
                                                    <input type="text" data-datafield="YSListUSD.YSAgencyFee" data-type="SheetTextBox" id="ctl52831_control3" style="width:80%;">USD</td>
                                                <td id="ctl52831_control4" data-datafield="YSListUSD.ReceiveAgencyFee" style="">
                                                    <input type="text" data-datafield="YSListUSD.ReceiveAgencyFee" data-type="SheetTextBox" id="ctl52831_control4" style="width:80%;">USD</td>
                                                <td id="ctl52831_control5" data-datafield="YSListUSD.AgencyFeeRemain" style="">
                                                    <input type="text" data-datafield="YSListUSD.AgencyFeeRemain" data-type="SheetTextBox" id="ctl52831_control5" style="width:80%;">USD</td>
                                                <td class="rowOption hidden"><a class="delete">
                                                    <div class="fa fa-minus"></div>
                                                </a><a class="insert">
                                                    <div class="fa fa-arrow-down"></div>
                                                </a></td>
                                            </tr>
                                            <tr class="footer">
                                                <td></td>
                                                <td id="ctl52831_Stat0" data-datafield="YSListUSD.Type" style=""></td>
                                                <td id="ctl52831_Stat1" data-datafield="YSListUSD.ProjectNo" style="" class=""></td>
                                                <td id="ctl52831_Stat2" data-datafield="YSListUSD.ProjectName" style=""></td>
                                                <td id="ctl52831_Stat3" data-datafield="YSListUSD.YSAgencyFee" style="">
                                                    <label id="ctl52831_StatControl3" data-datafield="YSListUSD.YSAgencyFee" data-type="SheetCountLabel" style=""></label>
                                                </td>
                                                <td id="ctl52831_Stat4" data-datafield="YSListUSD.ReceiveAgencyFee" style="">
                                                    <label id="ctl52831_StatControl4" data-datafield="YSListUSD.ReceiveAgencyFee" data-type="SheetCountLabel" style=""></label>
                                                </td>
                                                <td id="ctl52831_Stat5" data-datafield="YSListUSD.AgencyFeeRemain" style="">
                                                    <label id="ctl52831_StatControl5" data-datafield="YSListUSD.AgencyFeeRemain" data-type="SheetCountLabel" style=""></label>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div50952" class="col-md-2"></div>
                                <div id="div7015972" class="col-md-2"></div>
                                <div id="div4730922" class="col-md-2"></div>
                                <div id="div4730923" class="col-md-2"></div>
                                <div id="space522" class="col-md-2"></div>
                                <div id="spaceControl522" class="col-md-2">
                                    <input id="ApproveSKUSDId" type="button" onclick="ApproveSK('USD')" class="btn btn-primary" value="收款申请" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-12">收款记录</div>
                            </div>
                            <div class="row tableContent">
                                <div id="control29" class="col-md-12">
                                    <table id="ctl326409" data-datafield="SKRecordsUSD" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysummary="false" data-defaultrowcount="0">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl326409_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl326409_header0" data-datafield="SKRecordsUSD.ApplyDate" style="">
                                                    <label id="ctl326409_Label0" data-datafield="SKRecordsUSD.ApplyDate" data-type="SheetLabel" style="">申请时间</label></td>
                                                <td id="ctl326409_header1" data-datafield="SKRecordsUSD.SKAmount" style="">
                                                    <label id="ctl326409_Label1" data-datafield="SKRecordsUSD.SKAmount" data-type="SheetLabel" style="">收款金额</label></td>
                                                <td id="ctl326409_header2" data-datafield="SKRecordsUSD.DKDate" style="">
                                                    <label id="ctl326409_Label2" data-datafield="SKRecordsUSD.DKDate" data-type="SheetLabel" style="">到款日期</label></td>
                                                <td id="ctl326409_header3" data-datafield="SKRecordsUSD.Status" style="">
                                                    <label id="ctl326409_Label3" data-datafield="SKRecordsUSD.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl326409_header4" data-datafield="SKRecordsUSD.Operate" style="">
                                                    <label id="ctl326409_Label4" data-datafield="SKRecordsUSD.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl326409_header5" data-datafield="SKRecordsUSD.WorkItemId" style="" class="hidden">
                                                    <label id="ctl326409_Label5" data-datafield="SKRecordsUSD.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl326409_control0" data-datafield="SKRecordsUSD.ApplyDate" style="">
                                                    <input type="text" data-datafield="SKRecordsUSD.ApplyDate" data-type="SKRecordsUSD" id="ctl326409_control0" style=""></td>
                                                <td id="ctl326409_control1" data-datafield="SKRecordsUSD.SKAmount" style="">
                                                    <input type="text" data-datafield="SKRecordsUSD.SKAmount" data-type="SheetTextBox" id="ctl326409_control1" style=""></td>
                                                <td id="ctl326409_control2" data-datafield="SKRecordsUSD.DKDate" style="">
                                                    <input type="text" data-datafield="SKRecordsUSD.DKDate" data-type="SheetTextBox" id="ctl326409_control2" style=""></td>
                                                <td id="ctl326409_control3" data-datafield="SKRecordsUSD.Status" style="">
                                                    <input type="text" data-datafield="SKRecordsUSD.Status" data-type="SheetTextBox" id="ctl326409_control3" style=""></td>
                                                <td id="ctl326409_control4" data-datafield="SKRecordsUSD.Operate" style="">
                                                    <a class="btn btn-primary viewSKUSD" onclick="viewSKUSD(this)">查看</a></td>
                                                <td id="ctl326409_control5" data-datafield="SKRecordsUSD.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="SKRecordsUSD.WorkItemId" data-type="SheetTextBox" id="ctl326409_control5" style=""></td>
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

                        <div role="tabpanel" class="tab-pane" id="xybgtab">
                            <div class="row tableContent">
                                <div id="div5095" class="col-md-2"></div>
                                <div id="div701597" class="col-md-2"></div>
                                <div id="div473092" class="col-md-2"></div>
                                <div id="div876934" class="col-md-2"></div>
                                <div id="div334418" class="col-md-2"></div>
                                <div id="div707679" class="col-md-2 rightBtn">
                                    <input type="button" value="协议变更申请" onclick="Agreement_change()" class="btn btn-primary paddingBtn">
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="title31" class="col-md-2">
                                    <span id="Label33" data-type="SheetLabel" data-datafield="Agreement_bg_hy" style="">协议变更</span>
                                </div>
                                <div id="control31" class="col-md-10">
                                    <table id="ctl104413" data-datafield="Agreement_bg_hy" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-displaysequenceno="false" data-displaysummary="false" data-defaultrowcount="0">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl104413_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl104413_header0" data-datafield="Agreement_bg_hy.old_agency" style="">
                                                    <label id="ctl104413_Label0" data-datafield="Agreement_bg_hy.old_agency" data-type="SheetLabel" style="">原代理费</label></td>
                                                <td id="ctl104413_header1" data-datafield="Agreement_bg_hy.new_agency" style="">
                                                    <label id="ctl104413_Label1" data-datafield="Agreement_bg_hy.new_agency" data-type="SheetLabel" style="">变更后代理费</label></td>
                                                <td id="ctl104413_header2" data-datafield="Agreement_bg_hy.PayConditionOld" style="">
                                                    <label id="ctl104413_Label2" data-datafield="Agreement_bg_hy.PayConditionOld" data-type="SheetLabel" style="">原支付条件</label></td>
                                                <td id="ctl104413_header3" data-datafield="Agreement_bg_hy.PayConditionNew" style="">
                                                    <label id="ctl104413_Label3" data-datafield="Agreement_bg_hy.PayConditionNew" data-type="SheetLabel" style="">变更后支付条件</label></td>
                                                <td id="ctl104413_header4" data-datafield="Agreement_bg_hy.Status" style="">
                                                    <label id="ctl104413_Label4" data-datafield="Agreement_bg_hy.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl104413_header5" data-datafield="Agreement_bg_hy.Operate" style="">
                                                    <label id="ctl104413_Label5" data-datafield="Agreement_bg_hy.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl104413_header6" data-datafield="Agreement_bg_hy.WorkItemId" style="" class="hidden">
                                                    <label id="ctl104413_Label6" data-datafield="Agreement_bg_hy.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl104413_control0" data-datafield="Agreement_bg_hy.old_agency" style="">
                                                    <input type="text" data-datafield="Agreement_bg_hy.old_agency" data-type="SheetTextBox" id="ctl104413_control0" style=""></td>
                                                <td id="ctl104413_control1" data-datafield="Agreement_bg_hy.new_agency" style="">
                                                    <input type="text" data-datafield="Agreement_bg_hy.new_agency" data-type="SheetTextBox" id="ctl104413_control1" style=""></td>
                                                <td id="ctl104413_control2" data-datafield="Agreement_bg_hy.PayConditionOld" style="">
                                                    <input type="text" data-datafield="Agreement_bg_hy.PayConditionOld" data-type="SheetTextBox" id="ctl104413_control2" style=""></td>
                                                <td id="ctl104413_control3" data-datafield="Agreement_bg_hy.PayConditionNew" style="">
                                                    <input type="text" data-datafield="Agreement_bg_hy.PayConditionNew" data-type="SheetTextBox" id="ctl104413_control3" style=""></td>
                                                <td id="ctl104413_control4" data-datafield="Agreement_bg_hy.Status" style="">
                                                    <input type="text" data-datafield="Agreement_bg_hy.Status" data-type="SheetTextBox" id="ctl104413_control4" style=""></td>
                                                <td id="ctl104413_control5" data-datafield="Agreement_bg_hy.Operate" style="">
                                                    <a class="btn btn-primary viewBG" onclick="viewBG(this)">查看</a></td>
                                                <td id="ctl104413_control6" data-datafield="Agreement_bg_hy.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="Agreement_bg_hy.WorkItemId" data-type="SheetTextBox" id="ctl104413_control6" style=""></td>
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
                        <div role="tabpanel" class="tab-pane" id="xwtab">
                            <div class="row tableContent">
                                <div id="div180778" class="col-md-2">
                                    <label data-datafield="FileSignVersion" data-type="SheetLabel" id="ctl5629" class="" style="">代理协议正本签字版</label>
                                </div>
                                <div id="div695347" class="col-md-4">
                                    <input type="text" data-datafield="FileSignVersion" data-type="SheetTextBox" id="ctl429804" class="" style="">
                                </div>
                                <div id="div334423" class="col-md-6">
                                    <input id="ApplyFileGDId" type="button" onclick="ApplyFileGD()" value="归档" class="btn btn-primary paddingBtn" />
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div180778" class="col-md-2">
                                    <label data-datafield="BGFileSignVersion" data-type="SheetLabel" id="ctl5629" class="" style="">代理协议变更书签字版</label>
                                </div>
                                <div id="div695347" class="col-md-4">
                                    <input type="text" data-datafield="BGFileSignVersion" data-type="SheetTextBox" id="ctl429804" class="" style="">
                                </div>
                            </div>
                            <div class="row tableContent">
                                <div id="div434485" class="col-md-2">
                                    <label data-datafield="AgreementFileRecordhy" data-type="SheetLabel" id="ctl523300" class="" style="">确认记录</label>
                                </div>
                                <div id="div975168" class="col-md-10">
                                    <table id="ctl9642" data-datafield="AgreementFileRecordhy" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl9642_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl9642_header0" data-datafield="AgreementFileRecordhy.Applyer" style="">
                                                    <label id="ctl9642_Label0" data-datafield="AgreementFileRecordhy.Applyer" data-type="SheetLabel" style="">申请人</label></td>
                                                <td id="ctl9642_header1" data-datafield="AgreementFileRecordhy.ApplyDate" style="">
                                                    <label id="ctl9642_Label1" data-datafield="AgreementFileRecordhy.ApplyDate" data-type="SheetLabel" style="">申请时间</label></td>
                                                <td id="ctl9642_header2" data-datafield="AgreementFileRecordhy.Status" style="">
                                                    <label id="ctl9642_Label2" data-datafield="AgreementFileRecordhy.Status" data-type="SheetLabel" style="">状态</label></td>
                                                <td id="ctl9642_header3" data-datafield="AgreementFileRecordhy.Operate" style="">
                                                    <label id="ctl9642_Label3" data-datafield="AgreementFileRecordhy.Operate" data-type="SheetLabel" style="">操作</label></td>
                                                <td id="ctl9642_header4" data-datafield="AgreementFileRecordhy.WorkItemId" style="" class="hidden">
                                                    <label id="ctl9642_Label4" data-datafield="AgreementFileRecordhy.WorkItemId" data-type="SheetLabel" style="">WorkItemId</label></td>
                                                <td class="rowOption hidden">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl9642_control0" data-datafield="AgreementFileRecordhy.Applyer" style="">
                                                    <input type="text" data-datafield="AgreementFileRecordhy.Applyer" data-type="SheetTextBox" id="ctl9642_control0" style=""></td>
                                                <td id="ctl9642_control1" data-datafield="AgreementFileRecordhy.ApplyDate" style="">
                                                    <input type="text" data-datafield="AgreementFileRecordhy.ApplyDate" data-type="SheetTextBox" id="ctl9642_control1" style=""></td>
                                                <td id="ctl9642_control2" data-datafield="AgreementFileRecordhy.Status" style="">
                                                    <input type="text" data-datafield="AgreementFileRecordhy.Status" data-type="SheetTextBox" id="ctl9642_control2" style=""></td>
                                                <td id="ctl9642_control3" data-datafield="AgreementFileRecordhy.Operate" style="">
                                                    <a class="btn btn-primary viewGDChange" onclick="viewGDChange(this)">查看</a></td>
                                                <td id="ctl9642_control4" data-datafield="AgreementFileRecordhy.WorkItemId" style="" class="hidden">
                                                    <input type="text" data-datafield="AgreementFileRecordhy.WorkItemId" data-type="SheetTextBox" id="ctl9642_control4" style="" class=""></td>
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
                                    <div data-datafield="OtherFile" data-type="SheetAttachment" id="ctl658417" class="" style=""></div>
                                </div>
                                <div id="div426813" class="col-md-6"></div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="glhtab">

                            <div class="row tableContent">
                                <div id="title33" class="col-md-2">
                                    <span id="Label34" data-type="SheetLabel" data-datafield="Project_contracts_hy" style="">关联项目/合同</span>
                                </div>
                                <div id="control33" class="col-md-10">
                                    <table id="ctl79635" data-datafield="Project_contracts_hy" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-displaydelete="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                                        <tbody>
                                            <tr class="header">
                                                <td id="ctl79635_SerialNo" class="rowSerialNo">序号</td>
                                                <td id="ctl79635_header0" data-datafield="Project_contracts_hy.project_names" style="">
                                                    <label id="ctl79635_Label0" data-datafield="Project_contracts_hy.project_names" data-type="SheetLabel" style="">项目简称</label></td>
                                                <td id="ctl79635_header1" data-datafield="Project_contracts_hy.tender_number" style="">
                                                    <label id="ctl79635_Label1" data-datafield="Project_contracts_hy.tender_number" data-type="SheetLabel" style="">招标编号</label></td>
                                                <td id="ctl79635_header2" data-datafield="Project_contracts_hy.contact_no" style="">
                                                    <label id="ctl79635_Label2" data-datafield="Project_contracts_hy.contact_no" data-type="SheetLabel" style="">合同号</label></td>
                                                <td id="ctl79635_header3" data-datafield="Project_contracts_hy.contact_name" style="">
                                                    <label id="ctl79635_Label3" data-datafield="Project_contracts_hy.contact_name" data-type="SheetLabel" style="">合同名称</label></td>
                                                <td id="ctl79635_header4" data-datafield="Project_contracts_hy.contract_type" style="">
                                                    <label id="ctl79635_Label4" data-datafield="Project_contracts_hy.contract_type" data-type="SheetLabel" style="">合同类型</label></td>
                                                <td class="rowOption">删除</td>
                                            </tr>
                                            <tr class="template">
                                                <td></td>
                                                <td id="ctl79635_control0" data-datafield="Project_contracts_hy.project_names" style="">
                                                    <input type="text" data-datafield="Project_contracts_hy.project_names" data-type="SheetTextBox" id="ctl79635_control0" style=""></td>
                                                <td id="ctl79635_control1" data-datafield="Project_contracts_hy.tender_number" style="">
                                                    <input type="text" data-datafield="Project_contracts_hy.tender_number" data-type="SheetTextBox" id="ctl79635_control1" style=""></td>
                                                <td id="ctl79635_control2" data-datafield="Project_contracts_hy.contact_no" style="">
                                                    <input type="text" data-datafield="Project_contracts_hy.contact_no" data-type="SheetTextBox" id="ctl79635_control2" style=""></td>
                                                <td id="ctl79635_control3" data-datafield="Project_contracts_hy.contact_name" style="">
                                                    <input type="text" data-datafield="Project_contracts_hy.contact_name" data-type="SheetTextBox" id="ctl79635_control3" style=""></td>
                                                <td id="ctl79635_control4" data-datafield="Project_contracts_hy.contract_type" style="">
                                                    <input type="text" data-datafield="Project_contracts_hy.contract_type" data-type="SheetTextBox" id="ctl79635_control4" style=""></td>
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

                        </div>

                    </div>
                </div>
            </div>

        </div>
        <div class="row hidden">
            <div id="title21" class="col-md-2 hidden">
                <span id="Label28" data-type="SheetLabel" data-datafield="agreement_sign" style="">走协议审签子流程标识</span>
            </div>
            <div id="control21" class="col-md-2 hidden">
                <input id="Control28" type="text" data-datafield="agreement_sign" data-type="SheetTextBox" style="" class="">
            </div>
            <div id="title22" class="col-md-1 hidden">
            </div>
            <div id="control22" class="col-md-1 hidden">
            </div>
            <div id="title22" class="col-md-1 hidden">
                <span id="Label29" data-type="SheetLabel" data-datafield="Agreement_changeNumber" style="">协议变更子流程版本号</span>
            </div>
            <div id="control22" class="col-md-1 hidden">
                <input id="Control900" type="text" data-datafield="Agreement_changeNumber" data-type="SheetTextBox" style="">
            </div>
            <div id="title22" class="col-md-1 hidden">
                <span id="Label29" data-type="SheetLabel" data-datafield="Process_version" style="">协议号修改的版本号   </span>
            </div>
            <div id="control22" class="col-md-1 hidden">
                <input id="Control900" type="text" data-datafield="Process_version" data-type="SheetTextBox" style="">
            </div>
            <div id="title22" class="col-md-1 hidden">
                <span id="Label29" data-type="SheetLabel" data-datafield="AgreementGD_file" style="">协议归档版本号</span>
            </div>
            <div id="control22" class="col-md-1 hidden">
                <input id="Control900" type="text" data-datafield="AgreementGD_file" data-type="SheetTextBox" style="">
            </div>



        </div>
        <div class="row hidden">
            <div id="div412566" class="col-md-2">
                <label data-datafield="st_money" data-type="SheetLabel" id="ctl719839" class="" style="">收退款流程版本号</label>
            </div>
            <div id="div132801" class="col-md-2">
                <input type="text" data-datafield="st_money" data-type="SheetTextBox" id="ctl787347" class="" style="">
            </div>
            <div id="div956556" class="col-md-2">
                <input type="text" data-datafield="WorkflowVersion_Back" data-type="SheetTextBox" id="ctl456922" class="hidden" style="">
            </div>
            <div id="div708284" class="col-md-2">
                <input type="text" data-datafield="YSAgencyFeeHidden" data-type="SheetTextBox" id="ctl556757" class="hidden" style="">
            </div>
            <div id="div420417" class="col-md-2">
                <input type="text" data-datafield="ReceiveAgencyFeeHidden" data-type="SheetTextBox" id="ctl835945" class="hidden" style="">
            </div>
            <div id="div420418" class="col-md-2">
                <input type="text" data-datafield="ReceiveAgencyFeeWBHidden" data-type="SheetTextBox" id="ctl835946" class="hidden" style="">
            </div>
            <div id="div583545" class="col-md-2">
                <input type="text" data-datafield="AgencyFeeRemainHidden" data-type="SheetTextBox" id="ctl125599" class="hidden" style="">
            </div>
        </div>

    </div>
    <script src="AgreeMent.js"></script>
</asp:Content>
