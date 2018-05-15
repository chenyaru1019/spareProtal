<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SAgreeMent_main.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.SAgreeMent_main" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <script type="text/javascript">

        var aa = function () {

            $.ajax({
                type: "POST",    //页面请求的类型
                url: "generateContractNo",   //处理页的相对地址
                data: {

                },
                async: false,
                success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                    $.MvcSheetUI.SetControlValue("Control22", '88888');

                }
            });
        }
    </script>
    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title">协议主流程</label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="nav-icon fa fa-chevron-right bannerTitle">
            <label id="divBasicInfo" data-en_us="Basic information">基本信息</label>
        </div>
        <div class="divContent">
            <div class="row">
                <div id="divFullNameTitle" class="col-md-2">
                    <label id="lblFullNameTitle" data-type="SheetLabel" data-datafield="Originator.UserName" data-en_us="Originator" data-bindtype="OnlyVisiable" style="" class="">发起人</label>
                </div>
                <div id="divFullName" class="col-md-4">
                    <label id="lblFullName" data-type="SheetLabel" data-datafield="Originator.UserName" data-bindtype="OnlyData" style=""></label>
                </div>
                <div id="divOriginateDateTitle" class="col-md-2">
                    <label id="lblOriginateDateTitle" data-type="SheetLabel" data-datafield="OriginateTime" data-en_us="Originate Date" data-bindtype="OnlyVisiable" style="">发起时间</label>
                </div>
                <div id="divOriginateDate" class="col-md-4">
                    <label id="lblOriginateDate" data-type="SheetLabel" data-datafield="OriginateTime" data-bindtype="OnlyData" style=""></label>
                </div>
            </div>
            <div class="row">
                <div id="divOriginateOUNameTitle" class="col-md-2">
                    <label id="lblOriginateOUNameTitle" data-type="SheetLabel" data-datafield="Originator.OUName" data-en_us="Originate OUName" data-bindtype="OnlyVisiable" style="">所属组织</label>
                </div>
                <div id="divOriginateOUName" class="col-md-4">
                    <!--										<label id="lblOriginateOUName" data-type="SheetLabel" data-datafield="Originator.OUName" data-bindtype="OnlyData">
<span class="OnlyDesigner">Originator.OUName</span>
										</label>-->
                    <select data-datafield="Originator.OUName" data-type="SheetOriginatorUnit" id="ctlOriginaotrOUName" class="" style="">
                    </select>
                </div>
                <div id="divSequenceNoTitle" class="col-md-2">
                    <label id="lblSequenceNoTitle" data-type="SheetLabel" data-datafield="SequenceNo" data-en_us="SequenceNo" data-bindtype="OnlyVisiable" style="">流水号</label>
                </div>
                <div id="divSequenceNo" class="col-md-4">
                    <label id="lblSequenceNo" data-type="SheetLabel" data-datafield="SequenceNo" data-bindtype="OnlyData" style=""></label>
                </div>
            </div>
        </div>
        <div class="nav-icon fa  fa-chevron-right bannerTitle">
            <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
        </div>
        <div class="divContent" id="divSheet">
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
                <div id="title4" class="col-md-2">
                    <span id="Label14" data-type="SheetLabel" data-datafield="Agreement_client" style="">协议委托方</span>

                </div>
                <div id="control4" class="col-md-4">

                    <div data-datafield="Agreement_client" data-type="SheetUser" id="ctl669726" class="" style=""></div>
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
                <div id="title7" class="col-md-2">
                    <span id="Label17" data-type="SheetLabel" data-datafield="Mobile_phone" style="">电话</span>
                </div>
                <div id="control7" class="col-md-4">
                    <input id="Control17" type="text" data-datafield="Mobile_phone" data-type="SheetTextBox" style="">
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
                <div id="div525734" class="col-md-2">
                    <span id="Label21" data-type="SheetLabel" data-datafield="agency_rate" style="" class="">代理费费率</span>
                </div>
                <div id="div911408" class="col-md-2">
                    <input id="Control21" type="text" data-datafield="agency_rate" data-type="SheetTextBox" style="" class="">
                </div>
                <div id="div953060" class="col-md-2">
                    <select data-datafield="Rate_type" data-type="SheetDropDownList" id="ctl908886" class="" style="" data-masterdatacategory="费率"></select>
                </div>
                <div id="div477014" class="col-md-2"><span id="Label22" data-type="SheetLabel" data-datafield="AgreeMent_number" style="" class="">协议号</span></div>
                <div id="div851951" class="col-md-4">
                    <input id="Control22" type="text" data-datafield="AgreeMent_number" data-type="SheetTextBox" style="" class="">
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
            <div class="row tableContent">
                <div id="title17" class="col-md-2">
                    <span id="Label25" data-type="SheetLabel" data-datafield="Examine_record" style="" class="">协议审批记录</span>

                </div>
                <div id="control17" class="col-md-10">
                    <input type="button" value="修改申请">
                    <table id="Control25" data-datafield="Examine_record" data-type="SheetGridView" class="SheetGridView">
                        <tbody>


                            <tr class="header">
                                <td id="Control25_SerialNo" class="rowSerialNo">序号																</td>
                                <td id="Control25_Header3" data-datafield="Examine_record.Apply_people">
                                    <label id="Control25_Label3" data-datafield="Examine_record.Apply_people" data-type="SheetLabel" style="">申请人</label>
                                </td>
                                <td id="Control25_Header4" data-datafield="Examine_record.Apply_time">
                                    <label id="Control25_Label4" data-datafield="Examine_record.Apply_time" data-type="SheetLabel" style="">申请时间</label>
                                </td>
                                <td id="Control25_Header5" data-datafield="Examine_record.States">
                                    <label id="Control25_Label5" data-datafield="Examine_record.States" data-type="SheetLabel" style="">状态</label>
                                </td>
                                <td class="rowOption">删除																</td>
                            </tr>
                            <tr class="template">
                                <td id="Control25_Option" class="rowOption"></td>
                                <td data-datafield="Examine_record.Apply_people">
                                    <input id="Control25_ctl3" type="text" data-datafield="Examine_record.Apply_people" data-type="SheetTextBox" style="">
                                </td>
                                <td data-datafield="Examine_record.Apply_time">
                                    <input id="Control25_ctl4" type="text" data-datafield="Examine_record.Apply_time" data-type="SheetTime" style="">
                                </td>
                                <td data-datafield="Examine_record.States">
                                    <input id="Control25_ctl5" type="text" data-datafield="Examine_record.States" data-type="SheetTextBox" style="">
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
                                <td data-datafield="Examine_record.Apply_people"></td>
                                <td data-datafield="Examine_record.Apply_time"></td>
                                <td data-datafield="Examine_record.States">
                                    <label id="Control25_stat5" data-datafield="Examine_record.States" data-type="SheetCountLabel" style=""></label>
                                </td>
                                <td class="rowOption"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div id="div375696" class="col-md-2">
                    <label data-datafield="Numberid" data-type="SheetLabel" id="ctl564143" class="" style="">序号</label>
                </div>
                <div id="div695827" class="col-md-4">
                    <input type="text" data-datafield="Numberid" data-type="SheetTextBox" id="ctl997744" class="" style="">
                </div>
                <div id="div326712" class="col-md-2"></div>
                <div id="div286968" class="col-md-4"></div>
            </div>
        </div>
    </div>
</asp:Content>
