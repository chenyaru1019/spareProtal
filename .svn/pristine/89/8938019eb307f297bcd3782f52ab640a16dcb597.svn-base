<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenseOutMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.LicenseOutMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="LicenseOutMy.js"></script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">证照印章外出申请流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet">
                <div class="row">
                    <div id="title1" class="col-md-2">
                        <span id="Label11" data-type="SheetLabel" data-datafield="StartDate" style="">预计借用期限</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <input id="Control11" type="text" data-datafield="StartDate" data-type="SheetTime" class="" style="width:40%">&nbsp;至
                        <input id="Control12" type="text" data-datafield="EndDate" data-type="SheetTime" class="" style="width:40%" data-defaultvalue="">&nbsp;归还
                    </div>
                    <div class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div id="div133104" class="col-md-2"><span id="Label13" data-type="SheetLabel" data-datafield="OutDetails" style="" class="">借用明细</span></div>
                    <div id="div112503" class="col-md-10">
                        <input type="text" data-datafield="LicenceAdd" data-type="SheetTextBox" id="ctl365481" class="hidden" style="" data-popupwindow="PopupWindow" data-displaytext="增加证照" data-schemacode="GetLicence" data-querycode="GetLicences" data-outputmappings="LicenceNoHide:LicenceNo,LicenceNameHide:LicenceName,LicenceTypeHide:LicenceType">
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title3" class="col-md-2">
                    </div>
                    <div id="control3" class="col-md-10">
                        <table id="Control13" data-datafield="OutDetails" data-type="SheetGridView" class="SheetGridView" data-displayadd="false" data-defaultrowcount="0" data-displaysummary="false">
                            <tbody>

                                <tr class="header">
                                    <td id="Control13_SerialNo" class="rowSerialNo">序号								</td>
                                    <td id="Control13_Header3" data-datafield="OutDetails.LicenseName">
                                        <label id="Control13_Label3" data-datafield="OutDetails.LicenseName" data-type="SheetLabel" style="">证照名称</label>
                                    </td>
                                    <td id="Control13_Header4" data-datafield="OutDetails.LicenseNo">
                                        <label id="Control13_Label4" data-datafield="OutDetails.LicenseNo" data-type="SheetLabel" style="">证照编号</label>
                                    </td>
                                    <td id="Control13_Header5" data-datafield="OutDetails.LicenseType">
                                        <label id="Control13_Label5" data-datafield="OutDetails.LicenseType" data-type="SheetLabel" style="">证照类型</label>
                                    </td>
                                    <td class="rowOption">删除								</td>
                                </tr>
                                <tr class="template">
                                    <td id="Control13_Option" class="rowOption"></td>
                                    <td data-datafield="OutDetails.LicenseName">
                                        <input id="Control13_ctl3" type="text" data-datafield="OutDetails.LicenseName" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="OutDetails.LicenseNo">
                                        <input id="Control13_ctl4" type="text" data-datafield="OutDetails.LicenseNo" data-type="SheetTextBox" style="">
                                    </td>
                                    <td data-datafield="OutDetails.LicenseType">
                                        <input id="Control13_ctl5" type="text" data-datafield="OutDetails.LicenseType" data-type="SheetTextBox" style="">
                                    </td>
                                    <td class="rowOption">
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
                                    <td data-datafield="OutDetails.LicenseName"></td>
                                    <td data-datafield="OutDetails.LicenseNo"></td>
                                    <td data-datafield="OutDetails.LicenseType"></td>
                                    <td class="rowOption"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title5" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="Remark" style="">说明</span>
                    </div>
                    <div id="control5" class="col-md-10">
                        <textarea id="Control14" data-datafield="Remark" data-type="SheetRichTextBox" style="">					</textarea>
                    </div>
                </div>
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="Attachment" style="">附件</span>
                    </div>
                    <div id="control7" class="col-md-10">
                        <div id="Control15" data-datafield="Attachment" data-type="SheetAttachment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title9" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="ManagerComment" style="">部门经理审批意见</span>
                    </div>
                    <div id="control9" class="col-md-10">
                        <div id="Control16" data-datafield="ManagerComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="FGManagerComment" style="">分管领导审批意见</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <div id="Control17" data-datafield="FGManagerComment" data-type="SheetComment" style="" class=""></div>
                    </div>
                </div>
                <div class="row">
                    <div id="div377119" class="col-md-2">
                        <label data-datafield="LOuter" data-type="SheetLabel" id="ctl674754" class="" style="">外出人员</label>
                    </div>
                    <div id="div637003" class="col-md-4">
                        <div data-datafield="LOuter" data-type="SheetUser" id="ctl361576" class="" style=""></div>
                    </div>
                    <div id="div753838" class="col-md-6"></div>
                </div>
                <div class="row tableContent">
                    <div id="title13" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="OfficeSignComment" style="">综合办公室办理登记</span>
                    </div>
                    <div id="control13" class="col-md-10">
                        <div id="Control18" data-datafield="OfficeSignComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                
                <div class="row tableContent">
                    <div id="title15" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="OrigComment" style="">发起人意见</span>
                    </div>
                    <div id="control15" class="col-md-10">
                        <div id="Control19" data-datafield="OrigComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title17" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="OuterComment" style="">携带印章外出人员意见</span>
                    </div>
                    <div id="control17" class="col-md-10">
                        <div id="Control20" data-datafield="OuterComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row tableContent">
                    <div id="title19" class="col-md-2">
                        <span id="Label21" data-type="SheetLabel" data-datafield="OfficeCompleteComment" style="">综合办公室办结意见</span>
                    </div>
                    <div id="control19" class="col-md-10">
                        <div id="Control21" data-datafield="OfficeCompleteComment" data-type="SheetComment" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="OrigOrOuterFlg" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div793404" class="col-md-2">
                        <input type="text" data-datafield="LicenceNoHide" data-type="SheetTextBox" id="ctl185012" class="hidden" style="">
                    </div>
                    <div id="div960053" class="col-md-2">
                        <input type="text" data-datafield="LicenceNameHide" data-type="SheetTextBox" id="ctl496970" class="hidden" style="">
                    </div>
                    <div id="div285669" class="col-md-2">
                        <input type="text" data-datafield="LicenceTypeHide" data-type="SheetTextBox" id="ctl631908" class="hidden" style="" data-onchange="LicenceTypeChange()">
                    </div>
                    <div id="div816389" class="col-md-2"></div>
                    <div id="div785335" class="col-md-2">
                    </div>
                    <div id="div392071" class="col-md-2">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
