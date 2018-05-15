<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NoticeViewMy.aspx.cs" Inherits="OThinker.H3.Portal.Sheets.DefaultEngine.NoticeViewMy" EnableEventValidation="false" MasterPageFile="~/MvcSheet.master" %>

<%@ OutputCache Duration="999999" VaryByParam="T" VaryByCustom="browser" %>
<asp:Content ID="head" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="menu" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="master" ContentPlaceHolderID="masterContent" runat="Server">
    <link rel="stylesheet" href="../css/common.css">
    <script src="../js/bootstrap-select.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>

	<script src="../js/jquery.flexText.js"></script>

    <link rel="stylesheet" href="../css/style.css" type="text/css" />
    <link rel="stylesheet" href="../css/comment.css" type="text/css" />
    <link rel="stylesheet" href="../css/NoticeViewMy.css" type="text/css" />

    <link rel="stylesheet" href="../js/bootstrap-select.min.css">
    <link rel="stylesheet" href="../js/bootstrap-table.min.css">

    <div style="text-align: center;" class="DragContainer">
        <label id="lblTitle" class="panel-title"><input id="Control11" type="text" data-datafield="Title" data-type="SheetTextBox" style=""></label>
    </div>
    <div class="panel-body sheetContainer">
        <div class="ContractContent" style="margin-top: 15px">
            <div class="nav-icon fa  fa-chevron-right bannerTitle" style="display: none;">
                <label id="divSheetInfo" data-en_us="Sheet information">表单信息</label>
            </div>
            <div class="divContent" id="divSheet" style="padding: 0px 50px;">
                <div class="row">
                    <div class="col-md-12 noticeMsg">
                        <input id="Control11" type="text" data-datafield="Author" data-type="SheetTextBox" style="">
                        <input id="Control12" type="text" data-datafield="PublishDate" data-type="SheetTime" style="">
                    </div>

                </div>
                <div class="row tableContent">
                    <div id="title3" class="col-md-12">
                        <textarea id="Control13" data-datafield="Content" data-richtextbox="true" data-type="SheetRichTextBox" style=""></textarea>
                    </div>
                </div>
                <div class="row" style="font-size: 15px;margin-top: 5px;">
                    <div id="div106148" class="col-md-2">
                        <label data-datafield="Attachment" data-type="SheetLabel" id="ctl85620" class="" style="">附件</label>
                    </div>
                    <div id="div788145" class="col-md-10">
                        <div data-datafield="Attachment" data-type="SheetAttachment" id="ctl842699" class="" style=""></div>
                    </div>
                </div>
                <div class="row hidden">
                    <div id="div552950" class="col-md-2">
                        <input type="text" data-datafield="NoticeInstanceID" data-type="SheetTextBox" class="hidden" style="" > 
                    </div>
                    <div id="div903542" class="col-md-2">
                    </div>
                    <div id="div553758" class="col-md-2">
                    </div>
                    <div id="div341245" class="col-md-2">
                    </div>
                    <div id="div785335" class="col-md-2">
                    </div>
                    <div id="div392071" class="col-md-2">
                    </div>
                </div>

                <!-- 分割线 -->
                <div class="line" style="border-top: 2px dashed #C7C7C7; margin: 0px 0px 13px 0px;">
                </div>

                <div class="Content_Tab">
                    <div id="title3" class="col-md-12 rightBtn">
                        评论数（<span class="PLCount"></span>）&nbsp;查阅数（<span class="ReadCount"></span>）
                    </div>
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#pltab" aria-controls="pltab" role="tab" data-toggle="tab">评论</a></li>
                        <li role="presentation"><a href="#readtab" aria-controls="readtab" role="tab" data-toggle="tab">阅读</a></li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="pltab">
                            <div class="commentAll">
                                <!--评论区域 begin-->
                                <div class="reviewArea clearfix">
                                    <textarea class="content comment-input" placeholder="请输入评论&hellip;" onkeyup="keyUP(this)"></textarea>
                                    <a href="javascript:;" class="plBtn">评论</a>
                                </div>
                                <!--评论区域 end-->
                                <!--回复区域 begin-->
                                <div class="comment-show">
                                    
                                </div>
                                <!--回复区域 end-->
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="readtab">

                            <div class="myTable">
                                <table data-toggle="table" class="table table-striped table-bordered table-hover" id="tableRead"></table>
                            </div>
                            
                        </div>

                    </div>
                </div>
                
            </div>
        </div>
    </div>

    <script src="NoticeViewMy.js"></script>
</asp:Content>
