﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HYContractSet.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.HYContractSet" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script src="HYContractSet.js"></script>


    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">航油合同预设</label>
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
                        <span id="Label11" data-type="SheetLabel" data-datafield="PostB" style="">B角</span>
                    </div>
                    <div id="control1" class="col-md-4">
                        <div id="Control11" data-datafield="PostB" data-type="SheetUser" style=""></div>
                    </div>
                    <div id="div336715" class="col-md-2"><span id="Label12" data-type="SheetLabel" data-datafield="FinalUser" style="" class="">最终用户</span></div>
                    <div id="div837124" class="col-md-4">
                        <input type="text" data-datafield="FinalUser" data-type="SheetTextBox" id="ctl851638" class="" style="" data-popupwindow="PopupWindow" data-schemacode="GetProjectOfCustomer" data-querycode="GetProjectOfCustomer" data-outputmappings="FinalUser:FinalUser,ProjectName:ProjectName,SubProjectName:SubProjectName,SubProjectCode:SubProjectCode">
                    </div>
                </div>
                <div class="row">

                    <div id="div618564" class="col-md-2">
                        <label data-datafield="ProjectName" data-type="SheetLabel" id="ctl51168" class="" style="">项目名称</label>
                    </div>
                    <div id="div369688" class="col-md-4">
                        <input type="text" data-datafield="ProjectName" data-type="SheetTextBox" id="ctl471628" class="" style="">
                    </div>
                     <div id="div543342" class="col-md-2">
                         <label data-datafield="SubProjectName" data-type="SheetLabel" id="ctl227775" class="" style="">子工程名称</label>
                     </div>
                     <div id="div746813" class="col-md-4">
                         <input type="text" data-datafield="SubProjectName" data-type="SheetTextBox" id="ctl903585" class="" style="">
                     </div>
                </div>
                <!--<div class="row">-->
                   <!---->
                    <!--<div id="div318587" class="col-md-2"></div>-->
                    <!--<div id="div871012" class="col-md-4">-->
                        <!---->
                    <!--</div>-->
                <!--</div>-->
                <%--<div class="row">
                    <div id="title3" class="col-md-2">
                        <span id="Label13" data-type="SheetLabel" data-datafield="BidType" style="">是否招标</span>
                    </div>
                    <div id="control3" class="col-md-4">
                        <div data-datafield="BidType" data-type="SheetRadioButtonList" id="ctl995939" class="" style="" data-masterdatacategory="是否招标"
                            data-onchange="BidTypeChange()">
                        </div>
                    </div>
                    <div id="title4" class="col-md-2 BidNo">
                        <span id="Label22" data-type="SheetLabel" data-datafield="BidNo" class="" style="">招标编号</span>
                    </div>
                    <div id="control4" class="col-md-4 BidNo">
                        <input id="Control22" type="text" data-datafield="BidNo" data-type="SheetTextBox" class="" style="" data-popupwindow="PopupWindow" data-schemacode="GetBidProject" data-querycode="GetBidProject" data-outputmappings="BidNo:ProjectCode,ProjectShortNameHidden:ProjectShortName,BidPriceHidden:BidPrice">
                    </div>
                </div>
                <div class="row">
                    <div id="div861006" class="col-md-2">
                        <label data-datafield="BidTblOfHY" data-type="SheetLabel" id="ctl171683" class="" style="">招标详情</label>
                    </div>
                    <div id="div532377" class="col-md-10">

                        <table id="ctl776214" data-datafield="BidTblOfHY" data-type="SheetGridView" class="SheetGridView" style="" data-displayadd="false" data-defaultrowcount="0" data-displaysequenceno="false" data-displaysummary="false">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl776214_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl776214_header0" data-datafield="BidTblOfHY.ProjectShortName" style="">
                                        <label id="ctl776214_Label0" data-datafield="BidTblOfHY.ProjectShortName" data-type="SheetLabel" style="">项目简称</label></td>
                                    <td id="ctl776214_header1" data-datafield="BidTblOfHY.BidPrice" style="">
                                        <label id="ctl776214_Label1" data-datafield="BidTblOfHY.BidPrice" data-type="SheetLabel" style="">中标价</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl776214_control0" data-datafield="BidTblOfHY.ProjectShortName" style="">
                                        <input type="text" data-datafield="BidTblOfHY.ProjectShortName" data-type="SheetTextBox" id="ctl776214_control0" style=""></td>
                                    <td id="ctl776214_control1" data-datafield="BidTblOfHY.BidPrice" style="">
                                        <input type="text" data-datafield="BidTblOfHY.BidPrice" data-type="SheetTextBox" id="ctl776214_control1" style=""></td>
                                    <td class="rowOption"><a class="delete">
                                        <div class="fa fa-minus"></div>
                                    </a><a class="insert">
                                        <div class="fa fa-arrow-down"></div>
                                    </a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>--%>
                <div class="row hidden">
                    <div id="div315170" class="col-md-1">
                        <input type="text" data-datafield="ProjectShortNameHidden" data-type="SheetTextBox" id="ctl822858" class="hidden" style="">
                    </div>
                    <div id="div438330" class="col-md-1">
                        <input type="text" data-datafield="BidPriceHidden" data-type="SheetTextBox" id="ctl21738" class="hidden" style=""
                            data-onchange="
var dtl = $.MvcSheetUI.GetElement('BidTblOfHY').SheetGridView();
dtl._Clear();
dtl._AddRow();
var ProjectShortName= $.MvcSheetUI.GetControlValue('ProjectShortNameHidden');
var BidPrice= $.MvcSheetUI.GetControlValue('BidPriceHidden');
$.MvcSheetUI.SetControlValue(&quot;BidTblOfHY.ProjectShortName&quot;, ProjectShortName, 1);
$.MvcSheetUI.SetControlValue(&quot;BidTblOfHY.BidPrice&quot;, BidPrice, 1);
$(&quot;input[data-datafield='BidTblOfHY.ProjectShortName']&quot;).attr(&quot;disabled&quot;, &quot;disabled&quot;); 
$(&quot;input[data-datafield='BidTblOfHY.BidPrice']&quot;).attr(&quot;disabled&quot;, &quot;disabled&quot;); 
                    ">
                    </div>
                    <div id="div366542" class="col-md-1"></div>
                    <div id="div589212" class="col-md-1"></div>
                    <div id="div242762" class="col-md-1"></div>
                    <div id="div582414" class="col-md-1"></div>
                    <div id="div594663" class="col-md-1"></div>
                    <div id="div127846" class="col-md-1"></div>
                    <div id="div39806" class="col-md-1"></div>
                    <div id="div136725" class="col-md-1"></div>
                    <div id="div816455" class="col-md-1"></div>
                    <div id="div628907" class="col-md-1"></div>
                </div>
                <div class="row">
                    <div id="div470447" class="col-md-2">
                        <span id="Label14" data-type="SheetLabel" data-datafield="ContractName" class="" style="">合同名称</span>
                    </div>
                    <div id="div430445" class="col-md-4">
                        <input id="Control14" type="text" data-datafield="ContractName" data-type="SheetTextBox" class="" style="">
                    </div>
                    <div id="title5" class="col-md-2">
                        <span id="Label15" data-type="SheetLabel" data-datafield="ContractShortName" style="">合同简称</span>
                    </div>
                    <div id="control5" class="col-md-4">
                        <input id="Control15" type="text" data-datafield="ContractShortName" data-type="SheetTextBox" style="">
                    </div>
                </div>
                <!--<div class="row">-->

                    <!--<div id="title6" class="col-md-2">-->
                    <!--</div>-->
                    <!--<div id="control6" class="col-md-4">-->
                    <!--</div>-->
                <!--</div>-->
                <div class="row">
                    <div id="title7" class="col-md-2">
                        <span id="Label16" data-type="SheetLabel" data-datafield="ContractType" style="" class="">合同类型</span>
                    </div>
                    <div id="control7" class="col-md-4">
                        <select data-datafield="ContractType" data-type="SheetDropDownList" id="ctl780098" class="" style="" data-schemacode="GetTypeGN" data-querycode="GetTypeGN" data-datavaluefield="code" data-datatextfield="EnumValue" data-queryable="false">
                        </select>
                    </div>
                    <div id="title8" class="col-md-2">
                        <span id="Label19" data-type="SheetLabel" data-datafield="Country" style="" class="CountrySelect">国别</span>
                    </div>
                    <div id="control8" class="col-md-4">
                        <select data-datafield="Country" data-type="SheetDropDownList" id="ctl493603" class="CountrySelect" style="" data-masterdatacategory="国别" data-displayemptyitem="true" data-emptyitemtext="请选择" data-queryable="false">
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div id="title9" class="col-md-2">
                        <span id="Label17" data-type="SheetLabel" data-datafield="ContractProperty" style="" class="">合同性质</span>
                    </div>
                    <div id="control9" class="col-md-4">
                        <select data-datafield="ContractProperty" data-type="SheetDropDownList" id="ctl103863" class="" style="" data-schemacode="GetPropertyHKMY" data-querycode="GetPropertyHKMY" data-datavaluefield="code" data-datatextfield="EnumValue" data-queryable="false">
                        </select>
                    </div>
                    <%--<div id="space10" class="col-md-2">
                        <span id="Label18" data-type="SheetLabel" data-datafield="TradeMethod" style="" class="">贸易方式</span>
                    </div>
                    <div id="spaceControl10" class="col-md-4">
                        <select data-datafield="TradeMethod" data-type="SheetDropDownList" id="ctl537506" class="" style="" data-masterdatacategory="贸易方式" data-displayemptyitem="true" data-emptyitemtext="请选择" data-queryable="false">
                        </select>
                    </div>--%>
                </div>
                <div class="row tableContent">
                    <div id="title11" class="col-md-2">
                        <span id="Label20" data-type="SheetLabel" data-datafield="ContractRemark" style="">合同说明</span>
                    </div>
                    <div id="control11" class="col-md-10">
                        <textarea id="Control20" data-datafield="ContractRemark" data-type="SheetRichTextBox" style="">					</textarea>
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
                        <span id="Label26" data-type="SheetLabel" data-datafield="SalerTblOfHY" style="">合同卖方详情</span>
                    </div>
                    <div id="control19" class="col-md-10">

                        <table id="ctl9895" data-datafield="SalerTblOfHY" data-type="SheetGridView" class="SheetGridView" style="" data-defaultrowcount="0" data-displayadd="false" data-displaysequenceno="false" data-displaysummary="false"
                            data-onpreremove="rowPreRemoved(this,arguments);">
                            <tbody>
                                <tr class="header">
                                    <td id="ctl9895_SerialNo" class="rowSerialNo">序号</td>
                                    <td id="ctl9895_header0" data-datafield="SalerTblOfHY.CompanyName" style="">
                                        <label id="ctl9895_Label0" data-datafield="SalerTblOfHY.CompanyName" data-type="SheetLabel" style="">公司名称</label></td>
                                    <td id="ctl9895_header1" data-datafield="SalerTblOfHY.ContactName" style="">
                                        <label id="ctl9895_Label1" data-datafield="SalerTblOfHY.ContactName" data-type="SheetLabel" style="">联系人</label></td>
                                    <td id="ctl9895_header2" data-datafield="SalerTblOfHY.Telephone" style="">
                                        <label id="ctl9895_Label2" data-datafield="SalerTblOfHY.Telephone" data-type="SheetLabel" style="">联系电话</label></td>
                                    <td id="ctl9895_header3" data-datafield="SalerTblOfHY.Mobile" style="">
                                        <label id="ctl9895_Label3" data-datafield="SalerTblOfHY.Mobile" data-type="SheetLabel" style="">手机</label></td>
                                    <td id="ctl9895_header4" data-datafield="SalerTblOfHY.Fax" style="">
                                        <label id="ctl9895_Label4" data-datafield="SalerTblOfHY.Fax" data-type="SheetLabel" style="">传真</label></td>
                                    <td id="ctl9895_header5" data-datafield="SalerTblOfHY.Email" style="">
                                        <label id="ctl9895_Label5" data-datafield="SalerTblOfHY.Email" data-type="SheetLabel" style="">邮箱</label></td>
                                    <td class="rowOption">删除</td>
                                </tr>
                                <tr class="template">
                                    <td></td>
                                    <td id="ctl9895_control0" data-datafield="SalerTblOfHY.CompanyName" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.CompanyName" data-type="SheetTextBox" id="ctl9895_control0" style=""></td>
                                    <td id="ctl9895_control1" data-datafield="SalerTblOfHY.ContactName" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.ContactName" data-type="SheetTextBox" id="ctl9895_control1" style=""></td>
                                    <td id="ctl9895_control2" data-datafield="SalerTblOfHY.Telephone" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.Telephone" data-type="SheetTextBox" id="ctl9895_control2" style=""></td>
                                    <td id="ctl9895_control3" data-datafield="SalerTblOfHY.Mobile" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.Mobile" data-type="SheetTextBox" id="ctl9895_control3" style=""></td>
                                    <td id="ctl9895_control4" data-datafield="SalerTblOfHY.Fax" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.Fax" data-type="SheetTextBox" id="ctl9895_control4" style=""></td>
                                    <td id="ctl9895_control5" data-datafield="SalerTblOfHY.Email" style="">
                                        <input type="text" data-datafield="SalerTblOfHY.Email" data-type="SheetTextBox" id="ctl9895_control5" style=""></td>
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
                            data-onchange="EmailSalerChange();">
                    </div>
                    <div id="div971066" class="col-md-1"></div>
                    <div id="div713749" class="col-md-1"></div>
                    <div id="div113087" class="col-md-1"></div>
                    <div id="div994529" class="col-md-1"></div>
                    <div id="div404099" class="col-md-1"></div>
                    <div id="div533925" class="col-md-1">
                        <input type="text" data-datafield="SubProjectCode" data-type="SheetTextBox" id="ctl277370" class="hidden" style="">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
