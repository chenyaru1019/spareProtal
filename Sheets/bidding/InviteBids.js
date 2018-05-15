var ibs = {
    // =====================================================================
    // 
    // 招标项目模块
    // Bruce Tang
    // 1.0 2017/10/28
    //
    // =====================================================================

    // 表单信息
    _sheetInfo: null,

    // 查询到的专家数组
    _experts: null,

    // 当下选中的专家索引值
    _expertIndex: 0,

    // 国别
    _countries: null,

    // 币种
    _cashTypies: null,

    // 当下选中的中标价索引值
    _tenderPriceIndex: 0,

    //当前流程节点是否在这次编辑中已经被保存
    _ActivitySaved: false,

    //当前流程节点是否在新创建的
    _ActivityIsNew: true,

    _workflowVersion: {},

    _isSubmit: true,

    //专家选择是否需要关联项目
    _isRelProj: true,
    _expfromform: "",

    // =======================================================================
    //
    // 工具方法
    //
    // =======================================================================

    debug: function(msg) {
        console.log(msg);
    },

    // 初始化元数据
    initMetaData: function() {
        var _this = this;
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadMetaData&category=国别", function(data) {
            _this._countries = data;
            _this.initSelect($("#TenderCountry"), data);
            _this.initSelect($("#SupplierCountry"), data);
        });
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadMetaData&category=币种", function(data) {
            _this._cashTypies = data;
            _this.initSelect($("#BiddingRecordForm #BidPrice1Unit"), data);
            _this.initSelect($("#BiddingRecordForm #BidPrice2Unit"), data);
        });
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadWorkflowVersion", function(data) {
            for (var i = 0; i < data.length; i++) {
                ibs._workflowVersion[data[i].code] = data[i].version;
            }
        });
    },

    // 使用元数据更新select
    initSelect: function(select, metaData) {
        if (metaData != null) {
            select.empty();
            for (var i = 0; i < metaData.length; i++) {
                select.append("<option value=\""
                    + metaData[i].value
                    + "\">"
                    + metaData[i].name);
            }
        }
    },

    // 取字典中的唯一字段值
    firstOfDict: function(d) {
        for (var i in d) {
            return i;
        }
    },

    parseInt: function(v) {
        var i = parseInt(v);
        if (i == NaN)
            i = 0;
        return i;
    },

    parseFloat: function(v) {
        var f = parseFloat(v);
        if (f == NaN)
            f = 0;
        return f;
    },

    initXnfile: function(divId, fieldName) {
        var v = $.MvcSheetUI.GetControlValue(fieldName);
        if (v == "") {
            $("#" + divId).xnfile();
        }
        else {
            $("#" + divId).xnfile().xnfile("value", v);
        }
    },

    syncXnfile: function(divId, fieldName) {
        var v = $("#" + divId).xnfile("value");
        $.MvcSheetUI.SetControlValue(fieldName, v);
    },

    checkRedirect: function(activity_code, isnew, saved, newissue) {
        if (activity_code == "CreateActivity") {
        }
        else if (activity_code == "PrepareActivity") {
            if (newissue == "BiddingDocAudit") {
                if ($.MvcSheetUI.GetControlValue("BiddingDoc") == "") {
                    alert("请上传招标文件，并保存表单。");
                    return false;
                } 
            }            
        } 
        else if (activity_code == "BiddingActivity") {
            if (newissue == "BiddingNoticeAudit") { 
                if (isnew && !saved) {
                    alert("请先保存表单。");
                    return false;
                }                
                else if ($.MvcSheetUI.GetControlValue("BiddingNotice") == "") {
                    alert("请上传招标公告文件，并保存表单。");
                    return false;
                }
            }
        }

        return true;
    },

    // =======================================================================
    //
    // 表单框架
    //
    // =======================================================================

    // 初始化表单框架
    init: function(sheetInfo) {
        this.debug("init ibs instance");
        this._sheetInfo = sheetInfo;
        $("#pseudo-input").select(this.delayInit);
        $("#pseudo-input").trigger("select");
    },
    delayInit: function() {
        ibs.debug(ibs._sheetInfo);
        (function() {
            var title = window.parent.document.title;
            window.parent.document.title = "招标";
            $(window).on("beforeunload", function() {
                window.parent.document.title = title;
            });
        })();
        $("#pseudo-input").unbind();
        ibs.initMetaData();
        ibs.initMainForm();
        ibs.initQueryExpertsForm();
        ibs.initSelectExpertForm();
        ibs.initNewSelectExpertsForm();
        ibs.initBiddingRecrodForm();
    },

    // 初始化主表单
    initMainForm: function() {
        if (ibs._sheetInfo.ActivityCode == "CreateActivity") {
            ibs.crOnCreated();
        }
        else if (ibs._sheetInfo.ActivityCode == "PrepareActivity") {
            ibs.preOnCreated();
        }
        else if (ibs._sheetInfo.ActivityCode == "BiddingActivity") {
            ibs.bidOnCreated();
        }
        else if (ibs._sheetInfo.ActivityCode == "FileActivity") {
            ibs.bidOnCreated();
            ibs.fileOnCreated();
        }

        var code = $.MvcSheetUI.GetControlValue("BiddingCode");
        if (code != "") {
            $("span.project-code").text("(" + code + ")");
        }

        // 抽取专家表单
        $("#QueryExpertButton").click(function() {
            ibs.updateExpertsSelectionForm();
        });
        $("#RequeryExpertsButton").click(function() {
            $("#SelectExpertForm").modal("hide");
            $("#QueryExpertsForm").modal("show");
            $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
        });
        $("#OpenQueryExpertsButton").click(function() {
            $("#SelectExpertForm").modal("hide");
            $("#QueryExpertsForm").modal("show");
            $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
        });
        $("#ExportExpertsButton").click(ibs.exportExperts);
        $("CloseSelectExpertFormButton").click(function() {
            $("#SelectExpertForm").modal("hide");
        });
        $("#SaveExpertsButton").click(ibs.saveSelectedExperts);

        // 选取专家
        $("#SelectExpertButton").click(function () {
            ibs.openSelectExpertsForm();
        });
        $("#NewSaveExpertsButton").click(ibs.saveSelectedExperts);    
        $("#CloseQueryExpertButton").click(function() {
            $("#QueryExpertsForm").modal("hide");
        });

        // 关联专家-项目表单
        $("#SetRelatedProjectButton").click(ibs.onRelatedProjectSet);
        $("#CloseSelectProjectFormButton").click(function() {
            $("#SelectProjectForm").modal("hide");
            $("#SelectExpertForm").modal("show");
            ("#SelectExpertForm  div.row").removeAttr("style", "display:none");
        });

        // 废弃专家理由表单
        $("#SetDropReasonButton").click(ibs.onDropReasonSet);
        $("#CloseDropReasonFormButton").click(function() {
            $("#SetDropReasonForm").modal("hide");
            $("#SelectExpertForm").modal("show");
            $("#SelectExpertForm  div.row").removeAttr("style", "display:none");
        });

        // 招投标记录
        $("#SaveBiddingRecordButton").click(ibs.onSaveBiddingRecord);
        $("#UpdateBiddingRecordButton").click(ibs.onUpdateBiddingRecord);
    },

    // 初始化招投标记录
    initBiddingRecrodForm: function() {
        $("#BiddingRecordForm #AddTenderButton").click(ibs.onAddTender);
    },

    // 表单输入检验
    validate: function() {
        if (ibs._sheetInfo.ActivityCode == "CreateActivity") {
            return ibs.crOnValidate();
        }
        else if (ibs._sheetInfo.ActivityCode == "PrepareActivity") {
            return ibs.preOnValidate();
        }
        else if (ibs._sheetInfo.ActivityCode == "BiddingActivity") {
            return ibs.bidopenOnValidate() &&
                ibs.bidevaOnValidate() &&
                ibs.bidrefOnValidate() &&
                ibs.bidCanSubmit();
        }
        else if (ibs._sheetInfo.ActivityCode == "FileActivity") {
            return ibs.validateFileForm();
        }

        return true;
    },

    bidCanSubmit: function() {
        var canSubmit = true;

        if (ibs._isSubmit) {
            canSubmit &= ibs.bidopenGetTabCount() > 0;
            canSubmit &= (ibs.bidopenGetTabCount() == ibs.bidevaGetTabCount())
                && (ibs.bidevaGetTabCount() == ibs.bidrefGetTabCount());
            if (canSubmit) {
                var bidopen = $("table[data-datafield=BidOpening]").SheetUIManager().GetValue();
                var bideva = $("table[data-datafield=BiddingEvaluation]").SheetUIManager().GetValue();
                var winnot = $("table[data-datafield=WinnerNotice]").SheetUIManager().GetValue();
                for (var i = 0; i < ibs.bidopenGetTabCount(); i++) {
                    canSubmit &= bidopen[i].IsFinished &
                        bideva[i].IsFinished &
                        winnot[i].IsFinished;
                }
                if (!canSubmit) {
                    layer.alert("招标子流程未完成。", {icon: 2});
                }
            }
            else {
                layer.alert("招标子流程不完整。", {icon: 2});
            }
        }

        return canSubmit;
    },

    // 表单保存前事件
    onBeforeSave: function() {
        ibs._isSubmit = false;
    },

    onAfterSaved: function() {
        ibs._isSubmit = true;
        ibs._ActivitySaved = true;
        ibs._ActivityIsNew = false;
    },

    
    
    
    // =======================================================================
    //
    // 选取专家
    //
    // =======================================================================

    _expertTarget: "招标",

    initNewSelectExpertsForm: function () {
        ibs.initalNewSelExpertTable();
        
    },

    initalNewSelExpertTable: function () {
        //alert("initalNewSelExpertTable");
        $('#NewSelExpertTable').bootstrapTable({
            columns: [
                {
                    field: 'id',
                    title: '序号',
                    align: 'center',
                },
                {
                    field: 'time',
                    title: '抽取时间',
                    align: 'center',
                },
                {
                    field: 'name',
                    title: '专家姓名',
                    align: 'center',
                },
                {
                    field: 'area',
                    title: '地区',
                    align: 'center',
                },
                {
                    field: 'company',
                    title: '单位',
                    align: 'center',
                },
                {
                    field: 'domain',
                    title: '专业领域',
                    align: 'center',
                },
                {
                    field: 'birthday',
                    title: '出生年月',
                    align: 'center',
                },
                {
                    field: 'mobilePhone',
                    title: '电话',
                    align: 'center',
                },
                {
                    field: 'Email',
                    title: '邮箱',
                    align: 'center',
                },
                {
                    field: 'selected',
                    title: '选取结果',
                    align: 'center',
                    formatter:function(value,row,index){ 
                        if (value == true) {
                            return '选中';
                        }
                        else {
                            return '未选中';
                        }
                    }
                },
                {
                    field: 'dropReason',
                    title: '废弃原因',
                    align: 'center',
                },
                {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    formatter:function(value,row,index){  
                        var myid = row['id'];
                        var d = ''
                        if (row['selected'] == true){
                            d = '<a class="btn btn-warning" href="#" role="button" onclick="ibs.onDropExpert(\'selform\', \''+ myid +'\')">废弃</a> ';  
                        }
                        else {
                            d = '<a class="btn btn-primary" href="#" role="button" onclick="ibs.onExpertSelected(\'selform\', \''+ myid + '\')">选取</a> ';  
                        }
                        return d;  
                    }
                }
            ],
            striped: true,
            pagination: true,//启用分页  
            pageSize: 5,//每页行数  
            pageIndex: 0,//起始页
            pageList: [5, 10], 
            paginationVAlign: 'top',
        });
    },

    updateNewExpertsTable: function (data) {
        $('#NewSelExpertTable').bootstrapTable('load', data);
        $('#NewSelExpertTable').bootstrapTable('refresh');       
    },

    openSelectExpertsForm : function() {
        $("#QueryExpertsForm").modal("hide");
        $("#NewSelectExpertForm").modal("show");
        $("#NewSelectExpertForm div.row").removeAttr("style", "display:none");

        var url = "/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadAllExperts";
        $.getJSON(url, function (data) {
            if (data.length == 0) {
                layer.alert('未找到符合条件的专家，请重试。', { icon: 2 });
                // alert("未找到符合条件的专家，请重试。");
            }
            else {
                ibs._experts = data;
                for (var i = 0; i < data.length; i++) {
                    data[i].id = i+1;
                    data[i].selected = false;
                    data[i].dropReason = "";
                    data[i].relatedProject = "";
                    data[i].projectStage = "";
                }
                ibs.initalNewSelExpertTable();
                ibs.updateNewExpertsTable(data);
            }
        });       
    },

    // 初始化专家查询表单
    initQueryExpertsForm: function() {
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadMetaData&category=专家的专业领域", function(data) {
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    $("#ExpertDomainInput").append(
                        "<option value='" + data[i].name + "'>"
                        + data[i].name + "</option>"
                    );
                }
            }
        });
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadMetaData&category=地区", function(data) {
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    $("#ExpertAreaInput").append(
                        "<option value='" + data[i].name + "'>"
                        + data[i].name + "</option>"
                    );
                }
            }
        });
    },

    // 初始化关联项目表单
    initSelectExpertForm: function() {
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadProjects", function(data) {
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    $("#ProjectsInput").append("<option value='"
                        + data[i].name + "'>" + data[i].name + "</option>");
                }
            }
        });
    },

    // 更新专家抽取表单
    updateExpertsSelectionForm: function() {
        var expertsCount = $("#ExpertCountInput").val();
        if (expertsCount <= 0) {
            layer.alert('人数必须大于1人。', { icon: 2 });
            return ;
        }
        var url = "/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=LoadExperts&"
            + "area=" + $("#ExpertAreaInput").val()
            + "&domain=" + $("#ExpertDomainInput").val()
            + "&count=" + expertsCount;
        $.getJSON(url, function(data) {
            if (data.length == 0) {
                layer.alert('未找到符合条件的专家，请重试。', { icon: 2 });
            }
            else {
                ibs._experts = data;
                $("#QueryExpertsForm").modal("hide");
                $("#SelectExpertForm").modal("show");
                $("#SelectExpertForm div.row").removeAttr("style", "display:none");
                for (var i = 0; i < data.length; i++) {
                    data[i].selected = false;
                    data[i].dropReason = "未选择";
                    data[i].relatedProject = "";
                    data[i].projectStage = "";
                }
                ibs.updateExpertsTable(data);
            }
        });
    },

    // 更新抽取专家表格
    updateExpertsTable: function(data) {
        var table = $("#ExpertsTable>tbody");
        table.empty();
        for (var i = 0; i < data.length; i++) {
            table.append(
                "<tr><td>" + (i + 1)
                + "</td><td>" + data[i].time
                + "</td><td>" + data[i].name
                + "</td><td>" + data[i].area
                + "</td><td>" + data[i].company
                + "</td><td>" + data[i].domain
                + "</td><td>" + data[i].birthday
                + "</td><td>" + data[i].mobilePhone
                + "</td><td>" + data[i].email
                + "</td><td>" + (data[i].relatedProject == "" ? "" : data[i].relatedProject
                    + "-" + data[i].projectStage)
                + "</td><td>" + (data[i].selected ? "选中" : "废弃：" + data[i].dropReason)
                + "</td><td>" + (data[i].selected ?
                    "<button type='button' class='btn' onclick='ibs.onDropExpert(\"queryform\"," + i + ")'>废弃</button>" :
                    "<button type='button' class='btn' onclick='ibs.onExpertSelected(\"queryform\"," + i + ")'>选取</button>")
                + "</td></tr>"
            );
        }
    },

    // 选中专家
    onExpertSelected: function (fromform, index) {
        if (fromform == "queryform") {
            this._expertIndex = index;
            if (ibs._isRelProj == true) {
                $("#SelectExpertForm").modal("hide");
                $("#SelectProjectForm").modal("show");
                $("#SelectProjectForm div.row").removeAttr("style", "display:none");
            }
            else {
                ibs._experts[ibs._expertIndex].dropReason = "";
                ibs._experts[ibs._expertIndex].relatedProject = "";
                ibs._experts[ibs._expertIndex].projectStage = "";
                ibs._experts[ibs._expertIndex].selected = true;
                $("#SelectProjectForm").modal("hide");
                $("#SelectExpertForm").modal("show");
                $("#SelectExpertForm div.row").removeAttr("style", "display:none");
                ibs.updateExpertsTable(ibs._experts);
            }
        } 
        else {
            this._expertIndex = index-1;
            ibs._experts[ibs._expertIndex].dropReason = "";
            ibs._experts[ibs._expertIndex].relatedProject = "";
            ibs._experts[ibs._expertIndex].projectStage = "";
            ibs._experts[ibs._expertIndex].selected = true;
            $("#SelectProjectForm").modal("hide");
            $("#NewSelectExpertForm").modal("show");
            $("#NewSelectExpertForm div.row").removeAttr("style", "display:none");
            ibs.updateNewExpertsTable(ibs._experts);
        }

    },

    // 选好关联项目
    onRelatedProjectSet: function() {
        var projectName = $("#ProjectsInput").val();
        if (projectName == "") {
            layer.alert('请选择关联项目。', { icon: 2 });
            //alert("请选择关联项目。");
            return ;
        }
        var stage = $("#StageInput").val();
        ibs._experts[ibs._expertIndex].relatedProject = projectName;
        ibs._experts[ibs._expertIndex].projectStage = stage;
        ibs._experts[ibs._expertIndex].selected = true;
        $("#SelectProjectForm").modal("hide");
        $("#SelectExpertForm").modal("show");
        $("#SelectExpertForm div.row").removeAttr("style", "display:none");
        ibs.updateExpertsTable(ibs._experts);
    },

    // 废弃专家
    onDropExpert: function (fromform, index) {
        this._expfromform = fromform;

        if (fromform == "queryform") {
            this._expertIndex = index
            $("#SelectExpertForm").modal("hide");
            $("#SetDropReasonForm").modal("show");
            $("#SetDropReasonForm div.row").removeAttr("style", "display:none");
            $("#DropReasonInput").val("");
        }
        else {
            this._expertIndex = index-1;
            $("#NewSelectExpertForm").modal("hide");
            $("#SetDropReasonForm").modal("show");
            $("#SetDropReasonForm div.row").removeAttr("style", "display:none");
            $("#DropReasonInput").val("");
        }
        
        
    },

    // 设置废弃专家原因
    onDropReasonSet: function () {
        var reason = $("#DropReasonInput").val();
        if (reason == "") {
            layer.alert('请输入废弃专家原因。', { icon: 2 });
        }
        ibs._experts[ibs._expertIndex].dropReason = reason;
        ibs._experts[ibs._expertIndex].projectStage = "";
        ibs._experts[ibs._expertIndex].projectName = "";
        ibs._experts[ibs._expertIndex].selected = false;
        if (ibs._expfromform == "queryform") {
            $("#SelectExpertForm").modal("show");
            $("#SetDropReasonForm").modal("hide");
            $("#SetDropReasonForm div.row").removeAttr("style", "display:none");
            ibs.updateExpertsTable(ibs._experts);
        }
        else {
            $("#NewSelectExpertForm").modal("show");
            $("#SetDropReasonForm").modal("hide");
            $("#SetDropReasonForm div.row").removeAttr("style", "display:none");
            ibs.updateNewExpertsTable(ibs._experts);
        }
    },

    // 导出专家
    exportExperts: function() {
        if (ibs._experts != null && ibs._experts.length > 0) {
            var cnt = "";
            for (var i = 0; i < ibs._experts.length; i++) {
                var data = ibs._experts[i];
                cnt += data.time
                    + "," + data.name
                    + "," + data.area
                    + "," + data.company
                    + "," + data.domain
                    + "," + data.birthday
                    + "," + data.mobilePhone
                    + "," + data.email
                    + "\n";
                var a = document.createElement("a");
                a.href = "data:attachment/csv;charset=utf-8,"
                    + encodeURIComponent(cnt);
                a.download = 'experts.csv';
                a.target = '_blank';
                document.body.appendChild(a);
                a.click();
            }   
        }
    },

    // 保存选取专家
    saveSelectedExperts: function() {
        if (ibs._experts.length == 0) {
            layer.alert('请抽取至少一位专家。', { icon: 2 });
            return ;
        }

        var selection = [];
        for (var i = 0; i < ibs._experts.length; i++) {
            var item = {
                name: ibs._experts[i].name,
                company: ibs._experts[i].company,
                name: ibs._experts[i].name,
                mobilePhone: ibs._experts[i].mobilePhone,
                selected: ibs._experts[i].selected,
                dropReason: ibs._experts[i].dropReason,
                relatedProject: ibs._experts[i].relatedProject,
                projectStage: ibs._experts[i].projectStage
            };
            selection.push(item);
        }

        if (ibs._expertTarget == "招标") {
            var table = $("#Control28").SheetUIManager();
            table._Clear();
            var idx = 1;
            for (var i = 0; i < ibs._experts.length; i++) {
                if (ibs._experts[i].selected) {
                    table._AddRow();
                    $.MvcSheetUI.SetControlValue("BiddingDocAuditExperts.ExpertName",
                        ibs._experts[i].name, idx);
                    $.MvcSheetUI.SetControlValue("BiddingDocAuditExperts.Company",
                        ibs._experts[i].company, idx);
                    $.MvcSheetUI.SetControlValue("BiddingDocAuditExperts.Phone",
                        ibs._experts[i].mobilePhone, idx);
                    idx++;
                }
            }
            $("input[data-datafield='BiddingDocAuditExperts.ExpertName']").attr("disabled", "disabled");
            $("input[data-datafield='BiddingDocAuditExperts.Company']").attr("disabled", "disabled");
            $("input[data-datafield='BiddingDocAuditExperts.Phone']").attr("disabled", "disabled");

        }
        else {
            var panel = $("#be-wrap>div.tab-content>div.active");
            var table = $("#evaluation-expert-table", panel);
            $("tr.data", table).remove();
            for (var i = 0; i < ibs._experts.length; i++) {
                if (ibs._experts[i].selected) {
                    var tr = $("tr.template", table).clone();
                    tr.removeClass("template").addClass("data");
                    $(".name", tr).text(ibs._experts[i].name);
                    $(".company", tr).text(ibs._experts[i].company);
                    $(".mobile-phone", tr).text(ibs._experts[i].mobilePhone);
                    $("tbody", table).append(tr);
                }
            }            
        }

        $("#NewSelectExpertForm").modal("hide");
        $("#SelectExpertForm").modal("hide");
        $.post(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "SaveExpertSelection",
                object_id: ibs._sheetInfo.BizObjectID,
                activity_code: ibs._sheetInfo.ActivityCode,
                selection: JSON.stringify(selection)
            },
            function() {}
        );
    },

    // =======================================================================
    // 
    // 创建项目
    //
    // =======================================================================

    crOnCreated: function() {
        var biddingCode = $.MvcSheetUI.GetControlValue("BiddingCode");
        var autoBiddingCode = $("#AutoBiddingCode").val();
        var managerA = $.MvcSheetUI.GetControlValue("ManagerA");
        if (managerA == null || managerA == "") {
            $.MvcSheetUI.SetControlValue("ManagerA", ibs._sheetInfo.UserID);
        }
        $("a[id^=Add_Budget]").text("预算分包");
        ibs.initBiddingCodeHistory();
        $("#Control19").attr("readonly", "readonly");
        $("#CreateBiddingCodeButton").click(ibs.createBiddingCode);        
        $("#RequestBiddingCodeButton").click(ibs.requestBiddingCode);
        $("#prepare-project").hide();
        $("#bid-opening").hide();
        $("#bid-evaluation").hide();
        $("#refund").hide();
        $("#file").hide();
    },
 
    // 创建招标编号
    createBiddingCode: function() {
        var scope = $.MvcSheetUI.GetControlValue("BiddingScope");
        var method = $.MvcSheetUI.GetControlValue("BiddingMethod");
        var biddingCode = $.MvcSheetUI.GetControlValue("BiddingCode");
        
        if (biddingCode != '' && biddingCode != null) {
            return;
        }
        var url = "InviteBidsHandler.ashx?command=GenerateBiddingCode&scope="
            + scope + "&method=" + method;
        ibs.debug("get bidding code: " + url);
        $.getJSON(url, function(result) {
            $.MvcSheetUI.SetControlValue("BiddingCode", result.code);
            $("#AutoBiddingCode").val(result.code);
        });
    },

    crOnTendereeOrgNameChanged: function() {
        setTimeout(function() {
            var data = $("table[data-datafield=Tenderees]").SheetUIManager().GetValue();
            if (data.length > 0) {
                var name = "";
                for (var i = 0; i < data.length; i++) {
                    name += data[i].ProjectName + "(" + data[i].TaskName + ")";
                    if (i != data.length - 1) {
                        name += "、";
                    }
                }
                $.MvcSheetUI.SetControlValue("ProjectShortName", name);
            }
        }, 1000);
    },

    // 发起招标编号审批流程
    requestBiddingCode: function() {
        //ibs.checkRedirect(ibs._sheetInfo.ActivityCode, ibs._ActivityIsNew, ibs._ActivitySaved, "BiddingCode");
        $.getJSON("InviteBidsHandler.ashx?command=GetBiddingCode&object_id="
            + ibs._sheetInfo.BizObjectID,
            function(data) {
                if (data.code == "") {
                    layer.alert('请保存后再发起招标编号审批申请。', { icon: 2 });
                }
                else {
                    var biddingCode = $.MvcSheetUI.GetControlValue("BiddingCode");
                    var projectName = $.MvcSheetUI.GetControlValue("ProjectName");
                    if (projectName.length == 0) {
                        layer.alert('请输入项目名称。', { icon: 2 });
                        return ;
                    }
                    var biddingScope = $.MvcSheetUI.GetControlValue("BiddingScope");
                    var biddingMethod = $.MvcSheetUI.GetControlValue("BiddingMethod");
                    var url = "/Portal/Sheets/bidding/CodeApprove.aspx?"
                        + "Mode=Originate&WorkflowCode=BiddingNumberAuditFlow"
                        + "&WorkflowVersion=" + ibs._workflowVersion["BiddingNumberAuditFlow"]
                        + "&ProjectName=" + projectName
                        + "&WorkItemId=" + ibs._sheetInfo.WorkItemId
                        + "&BiddingScope=" + biddingScope 
                        + "&BiddingMethod=" + biddingMethod 
                        + "&AutoGenerateNumber=" + biddingCode 
                        + "&IssueObjectId=" + ibs._sheetInfo.BizObjectID;
                    window.location.href = url;
                    window.event.returnValue = false;
                }
            }
        );
    },

    // 初始化招标编号审批历史记录
    initBiddingCodeHistory: function() {
        var url = "/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=GetBiddingCodeAudits"
            + "&object_id=" + ibs._sheetInfo.BizObjectID;
        $.getJSON(url, function(data) {
            if (data.length > 0) {
                var canSubmit = true;
                var table = $("#bidding-number-audit-state");
                for (var i = 0; i < data.length; i++) {
                    var tr = $("tr.template", table).clone();
                    tr.removeClass("template").removeAttr("style", "display:none");
                    $("#originator", tr).text(data[i].originatorName);
                    $("#request-time", tr).text(data[i].startTime);
                    $("#state", tr).text(data[i].state);
                    $("tbody", table).append(tr);
                    if (data[i].state == "审批") {
                        canSubmit = false;
                    }
                    else {
                        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=GetApprovedBiddingCode&object_id=" + ibs._sheetInfo.BizObjectID, function(data) {
                            $.MvcSheetUI.SetControlValue("BiddingCode", data.code);
                        });
                    }
                }
                $("#CreateBiddingCodeButton").hide();
                if (!canSubmit) {
                    $("li[data-action='Submit']").hide();
                }
            }
        });
    },

    // 更新项目及子工程简称
    updateProjectShortName: function() {
        var table = $("#Control13").SheetUIManager();
        if (table.RowCount > 0) {
            var values = table.GetValue();
            var projectName = "";
            var taskName = "";
            for (var i = 0; i < values.length; i++) {
                projectName += values[i].ProjectShortName;
                taskName += values[i].TaskName;
                if (i < values.length - 1) {
                    projectName += "、";
                    taskName += "、";
                }
            }
            $.MvcSheetUI.SetControlValue("ProjectShortName", projectName);
            $.MvcSheetUI.SetControlValue("TaskShortName", taskName);
        }
        ibs.debug(values);
    },

    // 检验创建项目表单
    crOnValidate: function() {
        var managerA = $.MvcSheetUI.GetControlValue("ManagerA");
        var managerB = $.MvcSheetUI.GetControlValue("ManagerB");
        if (managerA != ibs._sheetInfo.Originator && managerB != ibs._sheetInfo.Originator) {
            layer.alert('A角或B角必须是流程创建人。', { icon: 2 });
            return false;
        }
        var taxRate = parseInt($.MvcSheetUI.GetControlValue("TaxRate"));
        if (taxRate == NaN || taxRate < 0 || taxRate > 100) {
            layer.alert('税率必须是0-100的整数。', { icon: 2 });
            return false;
        }
        return true;
    },

    // =====================================================================
    // 
    // 招标准备
    //
    // =====================================================================

    preOnCreated: function() {
        $("#RequestBiddingCodeButton").hide();
        $("#bid-opening").hide();
        $("#bid-evaluation").hide();
        $("#refund").hide();
        $("#file").hide();
        $("#BiddingDoc").xnfile();
        $("#owner-comment").xnfile();

        var biddingDoc = $.MvcSheetUI.GetControlValue("BiddingDoc");
        if (biddingDoc != "") {
            $("#BiddingDoc").xnfile("value", biddingDoc);
        }
        var ownerComment = $.MvcSheetUI.GetControlValue("OwnerComment");
        if (ownerComment != "") {
            $("#owner-comment").xnfile("value", ownerComment);
        }
        if (ibs._sheetInfo.ActivityCode == "PrepareActivity") {
            $("#SelectBiddingDocAuditExpertsButton").show();
            $("#RequestBiddingDocAuditButton").show();
            ibs.initBiddingDocHistory();
        }
        else {
            $("label[for=ctl571791]").hide();
            $("#BiddingDoc button").prop("disabled", true);
        }
        $("#SelectBiddingDocAuditExpertsButton").click(function() {
            ibs._isRelProj = true;
            $("#QueryExpertsForm").modal("show");
            $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
            $("#SelectExpertButton").css("display", "none");
        });
        $("#RequestBiddingDocAuditButton").click(ibs.preOnRequestBiddingDocAudit);
    },

    // 校验项目准备表单
    preOnValidate: function() {
        var agencyAgreementType = $.MvcSheetUI.GetControlValue("AgencyAgreementType");
        if (ibs._isSubmit) {
            if (agencyAgreementType == "后审") {
                var comment = $.MvcSheetUI.GetControlValue("PostAuditComment");
                if (comment == "") {
                    layer.alert('请输入后审说明。', { icon: 2 });
                    return false;
                }
            }

            var table = $("#ctl246641").SheetUIManager();
            if (table.RowCount == 0 && agencyAgreementType == "已审") {
                layer.alert('请至少选择一个代理协议。', { icon: 2 });
                return false;
            }

            var biddingDoc = $("#BiddingDoc").xnfile("value");
            if (biddingDoc == "") {
                layer.alert('请上传招标文件。', { icon: 2 });
                return false;
            }
            else {
                $.MvcSheetUI.SetControlValue("BiddingDoc", biddingDoc);
            }

            var ownerComment = $("#owner-comment").xnfile("value");
            if (ownerComment !== "") {
                $.MvcSheetUI.SetControlValue("OwnerComment", ownerComment);
            } 

            if ($.MvcSheetUI.GetControlValue("HasOwnerComment")) {
                if (ownerComment == "") {
                    layer.alert('请上传业主批复文件。', { icon: 2 });
                    return false;
                }
            }
        }
        ibs.preSyncBack();

        return true;
    },

    preSyncBack: function() {
        var biddingDoc = $("#BiddingDoc").xnfile("value");
        $.MvcSheetUI.SetControlValue("BiddingDoc", biddingDoc);
        var ownerComment = $("#owner-comment").xnfile("value");
        $.MvcSheetUI.SetControlValue("OwnerComment", ownerComment);
    },

    // 初始化招标文件审批历史记录
    initBiddingDocHistory: function() {
        var url = "/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=GetBiddingDocAudits"
            + "&object_id=" + ibs._sheetInfo.BizObjectID;
        $.getJSON(url, function(data) {
            if (data.length > 0) {
                var canSubmit = true;
                var table = $("#bidding-doc-audit-state");
                for (var i = 0; i < data.length; i++) {
                    var tr = $("tr.template", table).clone();
                    tr.removeClass("template").removeAttr("style", "display:none");
                    $("#originator", tr).text(data[i].originatorName);
                    $("#request-time", tr).text(data[i].startTime);
                    $("#state", tr).text(data[i].state);
                    $("tbody", table).append(tr);
                    if (data[i].state == "审批") {
                        canSubmit = false;
                    }
                }
                $("#RequestBiddingDocAuditButton").hide();
                if (!canSubmit) {
                    $("li[data-action='Submit']").hide();
                }
            }
        });
    },
    
    // 发起招标文件审批流程
    preOnRequestBiddingDocAudit: function() {
        var v = $.MvcSheetUI.GetControlValue("BiddingDoc");
        if (v.AttachmentIds == "") {
            layer.alert('请上传招标文件。如已上传，请先保存表单。', { icon: 2 });
            return ;
        }
        if ($.MvcSheetUI.GetControlValue("AgencyAgreementType") != "已审") {
            layer.alert('只有已审招标文件才能提交审批。', { icon: 2 });
            return ;
        }
        var url = "/Portal/Sheets/bidding/BiddingDocAudit.aspx?Mode=Originate"
            + "&WorkflowCode=BiddingDocAudit&WorkflowVersion="
            + ibs._workflowVersion["BiddingDocAudit"]
            + "&IssueObjectId=" + ibs._sheetInfo.BizObjectID
            + "&ProjectName=" + $.MvcSheetUI.GetControlValue("ProjectName")
            + "&ParentWorkItemId=" + ibs._sheetInfo.WorkItemId
            + "&BiddingCode=" + $.MvcSheetUI.GetControlValue("BiddingCode")
            + "&BiddingDocPrice=" + $.MvcSheetUI.GetControlValue("BiddingDocPrice")
            + "&AgencyAgreementType=" + $.MvcSheetUI.GetControlValue("AgencyAgreementType")
            + "&BiddingDoc=" + v;
        window.location.href = url;
    },

    // ======================================================================
    //
    // 招标
    //
    // ======================================================================

    bidOnCreated: function() {
       this.bidopenOnCreated();
       this.bidevaOnCreated();
       this.bidrefOnCreated();
       $("#file").hide();
    },

    _bidopenFormChecksum: -1,

    bidopenOnCreated: function() {
        ibs.initXnfile("final-bidding-doc", "FinalBiddingDoc");
        ibs.initXnfile("bidding-notice", "BiddingNotice");
        ibs.initXnfile("bidding-faq", "BiddingFaq");
        $("#IssueBiddingNoticeButton").click(ibs.bidopenRequestBiddingNotice);
        $("#AddBidPackageButton").click(ibs.bidopenOnAddPackage);
        $("#RemoveActiveBidPackageButton").click(ibs.bidopenOnRemovePackage);
        ibs.bidopenLoadBiddingNoticeAuditHistory();
        var pkgs = $("table[data-datafield='BidOpening']").SheetUIManager();
        if (pkgs.RowCount > 0) {
            for (var i = 0; i < pkgs.RowCount; i++) {
                ibs.bidopenAddTab(i + 1);
                var pane = $("#BPTab" + (i + 1));
                var overviewSheet = $.MvcSheetUI.GetControlValue("BidOpening.OverviewSheet", i + 1);
                $("#overview-sheet", pane).xnfile().xnfile("value", overviewSheet);
                var isFinished = $.MvcSheetUI.GetControlValue("BidOpening.IsFinished", i + 1);
                $("#is-opening-finished", pane).prop("checked", isFinished);
                $("#AddBiddingRecordButton", pane).click(function() {
                    ibs.bidopenClearTenderRecord();
                    $("#BiddingRecordForm").modal("show");
                    $("#BiddingRecordForm div").removeAttr("style", "display:none");
                });
                $("#PrintBiddingRecordsButton", pane).click(ibs.bidopenOnPrintBiddingRecord);
                (function() {
                    var _pane = pane;
                    $.getJSON(
                        "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                        {
                            Command: "LoadTenderRecord",
                            object_id: ibs._sheetInfo.BizObjectID,
                            package_name: "包" + (i + 1)
                        },
                        function(data) {
                            $("#BiddingRecords", _pane).data("data", data);
                            ibs.bidopenUpdateTenderRecord(_pane);
                        }
                    )
                })();
           }
        }
        ibs._bidopenFormChecksum = ibs.bidopenGetFormChecksum();
    },

    bidopenGetFormChecksum: function() {
        var s = $.MvcSheetUI.GetControlValue("BidOpeningIssueDate")
            + $.MvcSheetUI.GetControlValue("BidOpeningOpeningDate")
            + $.MvcSheetUI.GetControlValue("BidOpeningTimeAndPlace")
            + $("#final-bidding-doc").xnfile("value")
            + $("#bidding-notice").xnfile("value")
            + $("#bidding-faq").xnfile("value");
        return s.hashCode();
    },

    bidopenLoadBiddingNoticeAuditHistory: function() {
        $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                command: "GetBiddingNoticeAudits",
                object_id: ibs._sheetInfo.BizObjectID
            },
            function(data) {
                if (data.length > 0) {
                    var canSubmit = true;
                    var table = $("#bidding-notice-audit-state");
                    for (var i = 0; i < data.length; i++) {
                        var tr = $("tr.template", table).clone();
                        tr.removeClass("template").removeAttr("style", "display:none");
                        $("#originator", tr).text(data[i].originatorName);
                        $("#request-time", tr).text(data[i].startTime);
                        $("#state", tr).text(data[i].state);
                        $("tbody", table).append(tr);
                        if (data[i].state == "审批") {
                            canSubmit = false;
                        }
                    }
                    $("#IssueBiddingNoticeButton").hide();
                    if (!canSubmit) {
                        $("li[data-action='Submit']").hide();
                    }
                }
            }
        );
    },

    bidevaOnCreated: function() {
        $("#bid-evaluation").show();
        $("#add-evapkg-btn").click(ibs.bidevaOnAddPackage);
        $("#del-evapkg-btn").click(ibs.bidevaOnRemovePackage);
        ibs.bidevaSync();
        ibs._expertTarget = "评标";
    },

    bidevaOnAddPackage: function() {
        ibs.bidevaAddTab();
    },

    bidevaOnRemovePackage: function() {
        var li = $("#be-wrap>ul>li.active");
        if (li != undefined) {
            $("#be-wrap>ul>li").each(function() {
                if ($(this).attr("role") == "presentation" && $(this).hasClass("active")) {
                    $(this).remove();
                } 
            });
            $("#be-wrap>div.tab-content>div.active").remove();
        }
        ibs.bidevaSortTab();
    },

    bidevaSortTab: function() {
        var idx = 1;
        $("#be-wrap>ul>li").each(function() {
            if ($(this).attr("role") == "presentation") {
                $("a", this).attr("href", "#be-tab" + idx);
                $("a", this).text("包" + idx);
                if (idx == 1) {
                    $(this).addClass("active");
                }
                idx++;
            }
        })
        idx = 1;
        $("#be-wrap>div.tab-content>div").each(function() {
            $(this).attr("id", "be-tab" + idx);
            if (idx == 1) 
                $(this).addClass("active");
            idx++;
        })
    },

    bidevaGetTabCount: function() {
        var count = 0;
        $("#be-wrap>div.tab-content>div.data").each(function() {
            count++;
        });
        return count;
    },

    bidevaGetActiveTabIndex: function() {
        var tab = $("#be-wrap>div.tab-content>div.active");
        if (tab != undefined) {
            return tab.attr("id").substring(6) - 1;
        }
        return -1;
    },

    bidevaAddTab: function() {
        var idx = ibs.bidevaGetTabCount() + 1;
        $("#be-wrap>ul").prepend(
            "<li role=\"presentation\"><a href=\"#be-tab"
            + idx
            + "\" role=\"tab\" aria-controls=\"be-tab"
            + idx 
            + "\" data-toggle=\"tab\">包"
            + idx 
            + "</a></li>"
        );

        var tp = $("#be-wrap>div.template").clone();
        tp.attr("id", "be-tab" + idx)
            .removeAttr("style", "display:none")
            .removeClass("template")
            .addClass("data");
        
        $("div", tp).removeAttr("style", "display:none");
        $("#be-wrap>div.tab-content").append(tp);
        $("#add-to-db", tp).click(ibs.bidevaSaveWinner);
        $("#evaluation-report", tp).xnfile();
        $("#clarification", tp).xnfile();
        $("#notice-screenshot", tp).xnfile();
        $("#owner-comment", tp).xnfile();
        $("#add-bid-price-btn", tp).click({pane: tp}, ibs.bidevaOnAddTenerPrice);
        $("#select-expert-btn", tp).click(function() {
            ibs._isRelProj = false;
            $("#QueryExpertsForm").modal("show");
            $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
            $("#SelectExpertButton").css("display", "block");
        });
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadTenders2",
                objectId: ibs._sheetInfo.BizObjectID,
                packageName: "包" + idx, 
            },
            function(data) {
                $("#be-wrap>div.tab-content #winner").each(function() {
                    ibs.initSelect($(this), data);
                });
            }
        );
    
        if (idx == 1) {
            $("#be-wrap>ul>li:first").addClass("active");
            $("#be-wrap>div.tab-content>div.tab-pane").addClass("active");
        }
    },

    bidopenAddTab: function(idx) {
        if (idx > 1) {
            layer.alert("新增包时请保存，以避免发起子流程时丢失未保存内容。", {icon:2});
        }
        var tp = $("#BOWrap>div.template").clone();
        tp.attr("id", "BPTab" + idx)
            .removeClass("template")
            .addClass("data");
        $("div", tp).removeAttr("style", "display:none");
        $("#BOWrap>div.tab-content").append(tp);
        $("#overview-sheet", tp).xnfile();
        $("#AddBiddingRecordButton", tp).click(function() {
            ibs.bidopenClearTenderRecord();
            $("#BiddingRecordForm").modal("toggle");
            $("#BiddingRecordForm div").removeAttr("style", "display:none");
        });
        $("#PrintBiddingRecordsButton", tp).click(ibs.bidopenOnPrintBiddingRecord);

        $("#BOWrap>ul").prepend("<li role=\"presentation\"><a href=\"#BPTab"
            + idx
            + "\" role=\"tab\" aria-controls=\"BPTab"
            + idx
            + "\" data-toggle=\"tab\">包"
            + idx
            + "</a></li>");
        if (idx == 1) {
            $("#BOWrap>ul>li:first").addClass("active");
            $("#BOWrap>div.tab-content>div.tab-pane").addClass("active");
        }
    },

    bidevaSync: function() {
        var table = $("#ctl358014").SheetUIManager();
        if (table.RowCount > 0) {
            var v = table.GetValue();
            for (var i = 0; i < v.length; i++) {
                ibs.bidevaAddTab();
                var pane = $("#be-tab" + (i + 1));
                $("#add-to-db", pane).click(ibs.bidevaSaveWinner);
                $("#evaluation-report", pane).xnfile();
                $("#evaluation-report", pane).xnfile("value", v[i].EvaluationReport);
                $("#clarification", pane).xnfile();
                $("#clarification", pane).xnfile("value", v[i].Clarification);
                $("#notice-screenshot", pane).xnfile();
                $("#notice-screenshot", pane).xnfile("value", v[i].PublicityScreenShot);
                $("#Control46", pane).val(v[i].PublicityDate);
                $("#owner-comment", pane).xnfile();
                $("#owner-comment", pane).xnfile("value", v[i].OwnerComment);
                $("#total-bidding-price", pane).val(v[i].EquivalentRMB);
                $("#is-finished", pane).prop("checked", v[i].IsFinished);
                ibs.bidevaLoadTenderPrice(ibs._sheetInfo.BizObjectID, "包" + (i + 1), pane);
                $("#select-expert-btn", pane).click(function() {
                    ibs._isRelProj = false;
                    $("#QueryExpertsForm").modal("show");
                    $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
                    $("#SelectExpertButton").css("display", "block");
                });
                (function(winner, panel) {
                    $.getJSON(
                        "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                        {
                            Command: "LoadTenders2",
                            objectId: ibs._sheetInfo.BizObjectID,
                            packageName: "包" + (i + 1), 
                        },
                        function(data) {
                            ibs.initSelect($("#winner", panel), data);
                            $("#winner", panel).val(winner);
                        }
                    );
                })(v[i].BidWinner, pane);
                (function(panel) {
                    $.getJSON(
                        "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                        {
                            Command: "LoadAuditExpert",
                            ParentObjectId: ibs._sheetInfo.BizObjectID,
                            PackageName: "包" + (i + 1), 
                        },
                        function(data) {
                            var table = $("#evaluation-expert-table", panel);
                            if (data.length > 0) {
                                for (var i = 0; i < data.length; i++) {
                                    var tr = $("tr.template", table).clone();
                                    tr.removeClass("template").addClass("data");
                                    $(".name", tr).text(data[i].name);
                                    $(".company", tr).text(data[i].company);
                                    $(".mobile-phone", tr).text(data[i].mobilePhone);
                                    $("tbody", table).append(tr);
                                }
                            }
                       }
                    );
                })(pane);
            }
        }
    },

    // 根据开标发标数据创建评标表单
    createBidEvaluationForm: function() {
        ibs.setOpeningFormReadlyonly();
        for (var i = 0; i < ibs._bidPackages.length; i++) {
            $("#be-wrap>ul").prepend("<li role=\"presentation\"><a href=\"#be-tab"
            + (i + 1)
            + "\" role=\"tab\" aria-controls=\"be-tab"
            + (i + 1)
            + "\" data-toggle=\"tab\">包"
            + (i + 1)
            + "</a></li>");

            var tp = $("#be-wrap>div.template").clone();
            tp.attr("id", "be-tab" + (i + 1))
                .removeAttr("style", "display:none")
                .removeClass("template")
                .addClass("data");
            
            $("div", tp).removeAttr("style", "display:none");
            $("#be-wrap>div.tab-content").append(tp);
            $("#add-to-db", tp).click(ibs.bidevaSaveWinner);
            $("#evaluation-report", tp).xnfile();
            $("#clarification", tp).xnfile();
            $("#notice-screenshot", tp).xnfile();
            $("#owner-comment", tp).xnfile();
            $("#add-bid-price-btn", tp).click({pane, tp}, ibs.bidevaOnAddTenerPrice);
            $("#select-expert-btn", tp).click(function() {
                ibs._isRelProj = false;
                $("#QueryExpertsForm").modal("show");
                $("#QueryExpertsForm div.row").removeAttr("style", "display:none");
                $("#SelectExpertButton").css("display", "block");
            });
            $.getJSON(
                "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                {
                    Command: "LoadTenders2",
                    objectId: ibs._sheetInfo.BizObjectID,
                    packageName: "包" + (i + 1), 
                },
                function(data) {
                    $("#be-wrap>div.tab-content #winner").each(function() {
                        ibs.initSelect($(this), data);
                    });
                }
            );
        
            if (i == 0) {
                $("#be-wrap>ul>li:first").addClass("active");
                $("#be-wrap>div.tab-content>div.tab-pane").addClass("active");
            }
        }
    },

    // 增加开标包
    bidopenOnAddPackage: function() {
        ibs.bidopenAddTab(ibs.bidopenGetTabCount() + 1);
    },

   // ---------------------------------------------------------------------- 
    //
    // 开标发标
    // 
    // ----------------------------------------------------------------------

    // 开标包数量
    _bidPackageCount: 0,
    
    // 开标包
    _bidPackages: [],

    // 招投标记录
    _biddingRecords: [],
    
    // 正在修改的投标记录下标
    _editBiddingRecordIndex: 0,
        
    // 校验开标发标表单
    bidopenOnValidate: function() {
        ibs.bidopenSync();
        if (ibs._isSubmit) {
            if (ibs.bidopenGetTabCount() == 0) {
                layer.alert('至少要有一个招投标记录。', { icon: 2 });
                return false;
            }
        }
        ibs.bidopenSyncBack();
        ibs.bidopenSaveTenderRecord();

        return true;
    },

    // 保存招投标子表
    bidopenSaveTenderRecord: function() {
        var data = [];
        var idx = 1;
        $("#BOWrap>div.tab-content>div.data").each(function() {
            data.push({
                name: "包" + idx,
                tenders: $("#BiddingRecords", this).data("data")
            });
            idx++;
        });
        $.post(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "SaveBidPackages",
                parent_object_id: ibs._sheetInfo.BizObjectID,
                jvalue: JSON.stringify(data)
            },
            function(data) {}
        );
    },

    // 更新招投标记录子表= 
    bidopenSyncBack: function() {
        var tbl = $("table[data-datafield=BidOpening]").SheetUIManager();
        tbl._Clear();
        for (var i = 0; i < ibs.bidopenGetTabCount(); i++) {
            var pane = $("#BPTab" + (i + 1));
            tbl._AddRow();
            $.MvcSheetUI.SetControlValue(
                "BidOpening.OverviewSheet", 
                $("#overview-sheet", pane).xnfile("value"),
                i + 1
            );
            $.MvcSheetUI.SetControlValue(
                "BidOpening.PackageName", 
                "包" + (i + 1),
                i + 1
            );
            $.MvcSheetUI.SetControlValue(
                "BidOpening.IsFinished",
                $("#is-opening-finished", pane).prop("checked"),
                i + 1
            );
        }
    },

    bidopenGetTabCount: function() {
        var count = 0;
        $("#BOWrap>div.tab-content>div.data").each(function() {
            count++;
        });
        return count;
    },

    // 更新开投标表单值
    bidopenSync: function() {
        ibs.syncXnfile("final-bidding-doc", "FinalBiddingDoc");
        ibs.syncXnfile("bidding-notice", "BiddingNotice");
        ibs.syncXnfile("bidding-faq", "BiddingFaq");
    },

    // 选中开标包下标
    getActiveBidPackageIndex: function() {
        var tab = $("#BOWrap>div.tab-content>div.active");
        if (tab != undefined) {
            return tab.attr("id").substring(5) - 1;
        }
        return -1;
    },

    bidopenClearTenderRecord: function() {
        $("#BiddingRecordForm #Address").val("");
        $("#BiddingRecordForm #Contact").val("");
        $("#BiddingRecordForm #Telephone").val("");
        $("#BiddingRecordForm #MobilePhone").val("");
        $("#BiddingRecordForm #Fax").val("");
        $("#BiddingRecordForm #Email").val("");
        $("#BiddingRecordForm #BidPrice1").val(0);
        $("#BiddingRecordForm #BidPrice2").val(0);
        $("#BiddingRecordForm #Supplier").val("");
        $("#BiddingRecordForm #Remark").val("");
        $("#BiddingRecordForm #BiddingDocPurchaseRecord").xnfile();
        $("#BiddingRecordForm #BiddingDocPurchaseRecord > div.file2-done > a ").html("");
        $("#BiddingRecordForm #BiddingDocPurchaseRecord > div.file2-done").hide()
        $("#BiddingRecordForm #TenderDoc").xnfile();
        $("#BiddingRecordForm #TenderDoc > div.file2-done > a ").html("");
        $("#BiddingRecordForm #TenderDoc > div.file2-done").hide()
        $("#BiddingRecordForm #Receipts").xnfile();     
        $("#BiddingRecordForm #Receipts > div.file2-done > a ").html("");
        $("#BiddingRecordForm #Receipts > div.file2-done").hide();
        $("#BiddingRecordForm #Tender > tbody > tr.data").remove();
    },

    bidopenOnPrintBiddingRecord: function() {
        var pane = $("#BOWrap>div.tab-content>div.active");
        var data = $("#BiddingRecords", pane).data("data");
        var jsonValue = JSON.stringify(data);
        var url = "/Portal/MvcDefaultSheet.aspx?SheetCode=SPrintBiddingRecords"
            + "&Mode=Originate&WorkflowCode=PrintBiddingRecords"
            + "&WorkflowVersion=" + ibs._workflowVersion["PrintBiddingRecords"]
            + "&JsonValue=" + jsonValue;
        window.location.href = url;
        window.event.returnValue = false;
    },

    // 删除当前开标包
    bidopenOnRemovePackage: function() {
        var li = $("#BOWrap>ul>li.active");
        if (li != undefined) {
            var idx = ibs.getActiveBidPackageIndex();
            $("#BOWrap>ul>li").each(function() {
                if ($(this).attr("role") == "presentation" && $(this).hasClass("active")) {
                    $(this).remove();
                } 
            });
            $("#BOWrap>div.tab-content>div.active").remove();
            ibs._bidPackages.splice(idx, 1);
            ibs._bidPackageCount--;
        }
        ibs.bidopenSortTab();
    },

    bidopenSortTab: function() {
        var idx = 1;
        $("#BOWrap>ul>li").each(function() {
            if ($(this).attr("role") == "presentation") {
                $("a", this).attr("href", "#BPTab" + idx);
                $("a", this).text("包" + idx);
                if (idx == 1) {
                    $(this).addClass("active");
                }
                idx++;
            }
        })
        idx = 1;
        $("#BOWrap>div.tab-content>div").each(function() {
            $(this).attr("id", "BPTab" + idx);
            if (idx == 1) 
                $(this).addClass("active");
            idx++;
        })
    },

    // 招投标记录/增加投标人
    onAddTender: function() {
        var tr = $("#BiddingRecordForm #Tender tr.template").clone(true);
        tr.removeClass("template").removeAttr("style", "display:none").addClass("data");
        $("#BiddingRecordForm #Tender>tbody").append(tr);
        ibs.initSelect($("#Country", tr), ibs._countries);
        if ($.MvcSheetUI.GetControlValue("BiddingScope") == "国内") {
            $("#Country", tr).val("CN");
        }
        ibs.initSelect($("#CashUnit", tr), ibs._cashTypies);
        $("#DeleteMe", tr).click(function() {
            $(this).closest("tr").remove();
        });
    },

    // 招投标记录/保存投标人
    onSaveBiddingRecord: function() {
        var rec = ibs.createBiddingRecord();
        if (ibs.bidopenOnValidateTenderRecord(rec)) {
            var pane = $("#BOWrap>div.tab-content>div.active");
            var data = $("#BiddingRecords", pane).data("data");
            if (data == undefined) {
                data = [];
            }
            data.push(rec);
            $("#BiddingRecords", pane).data("data", data);
            $("#BiddingRecordForm").modal("hide");
            ibs.bidopenUpdateTenderRecord();
        }
    },

    // 招投标记录/更新投标人
    onUpdateBiddingRecord: function() {
        var rec = ibs.createBiddingRecord();
        if (ibs.bidopenOnValidateTenderRecord(rec)) {
            var pane = $("#BOWrap>div.tab-content>div.active");
            var data = $("#BiddingRecords", pane).data("data");
            data[ibs._editBiddingRecordIndex] = rec;
            ibs.bidopenUpdateTenderRecord();
            $("#BiddingRecordForm").modal("hide");
        }
    },

    // 创建招投标记录对象
    createBiddingRecord: function() {
        var tenders = [];
        $("#BiddingRecordForm #Tender tr.data").each(function() {
            var tender = {
                name: $("#Name", this).val(),
                country: $("#Country", this).val(),
                cashType: $("#CashType", this).val(),
                cash: $("#Cash", this).val(),
                cashUnit: $("#CashUnit", this).val()
            };
            tenders.push(tender);
        });
        var record = {
            address: $("#BiddingRecordForm #Address").val(),
            contact: $("#BiddingRecordForm #Contact").val(),
            telephone: $("#BiddingRecordForm #Telephone").val(),
            mobilePhone: $("#BiddingRecordForm #MobilePhone").val(),
            fax: $("#BiddingRecordForm #Fax").val(),
            email: $("#BiddingRecordForm #Email").val(),
            bidPrice1: $("#BiddingRecordForm #BidPrice1").val(),
            bidPrice1Unit: $("#BiddingRecordForm #BidPrice1Unit").val(),
            bidPrice2: $("#BiddingRecordForm #BidPrice2").val(),
            bidPrice2Unit: $("#BiddingRecordForm #BidPrice2Unit").val(),
            supplier: $("#BiddingRecordForm #Supplier").val(),
            supplierCountry: $("#BiddingRecordForm #SupplierCountry").val(),
            biddingDocPurchaseRecord: $("#BiddingRecordForm #BiddingDocPurchaseRecord").xnfile("value"),
            tenderDoc: $("#BiddingRecordForm #TenderDoc").xnfile("value"),
            receipts: $("#BiddingRecordForm #Receipts").xnfile("value"),
            remark: $("#BiddingRecordForm #Remark").val(),
            tenders: tenders
         };
         return record;
    },

    // 校验招投标记录格式
    bidopenOnValidateTenderRecord: function(rec) {
        // TODO #193
        // 删除投标人以外的必填项检查
        if (rec.tenders.length == 0) {
            layer.alert('缺少投标人。', { icon: 2 });
            return false;
        }
        for (var i = 0; i < rec.tenders.length; i++) {
            if (rec.tenders[i].name === "") {
                layer.alert('投标人名称不能为空。', { icon: 2 });
                return false;
            }
        }
        // TODO #191
        // ibs._hasOpeningSaved = true
        return true;
    },

    // 发标开标/更新招投标记录
    bidopenUpdateTenderRecord: function(p) {
        var pane = $("#BOWrap>div.tab-content>div.active");
        if (p !== undefined)
            pane = p;
        $("#BiddingRecords>tbody", pane).empty();
        var data = $("#BiddingRecords", pane).data("data");
        var idx = ibs.getActiveBidPackageIndex();
        for (var i = 0; i < data.length; i++) {
            var br = data[i];
            var html = "<table><tbody>";
            for (var j = 0; j < br.tenders.length; j++) {
                html += "<tr><td>"
                    + br.tenders[j].name
                    + "</td><td>"
                    + br.tenders[j].cashType
                    + br.tenders[j].cash
                    + br.tenders[j].cashUnit
                    + "</td></tr>";
            }
            html += "</tbody></table>";
            $("#BiddingRecords>tbody", pane).append(
                "<tr><td>"
                + (i + 1)
                + "</td><td>"
                + html
                + "</td><td>"
                + br.bidPrice1 + br.bidPrice1Unit + "<br>"
                + br.bidPrice2 + br.bidPrice2Unit
                + "</td><td>"
                + "<button type=\"button\" class=\"btn btn-default\" onclick=\"ibs.onEditBiddingRecord(" + i + ")\">编辑</button>"
                + "<button type=\"button\" class=\"btn btn-default\" onclick=\"ibs.onDeleteBiddingRecord(this, "
                    + i + ")\">删除</button>"
                + "</td></tr>"
            );
        }
    },

    // 编辑招投标记录
    onEditBiddingRecord: function(idx) {
        ibs._editBiddingRecordIndex = idx;
        var pane = $("#BOWrap>div.tab-content>div.active");
        var data = $("#BiddingRecords", pane).data("data");
        ibs.showBiddingRecord(data[idx]);
    },

    // 初始化并弹出招投标记录对话框
    showBiddingRecord: function(rec) {
         $("#BiddingRecordForm").modal("show");
         $("#BiddingRecordForm div.row").removeAttr("style", "display:none");
         $("#BiddingRecordForm #Tender>tbody>tr.data").remove();
         for (var i = 0; i < rec.tenders.length; i++) {
             var tr = $("#BiddingRecordForm #Tender tr.template").clone(true);
             tr.removeClass("template").removeAttr("style", "display:none").addClass("data");
             $("#BiddingRecordForm #Tender>tbody").append(tr);
             ibs.initSelect($("#Country", tr), ibs._countries);
             ibs.initSelect($("#CashUnit", tr), ibs._cashTypies);
             $("#Name", tr).val(rec.tenders[i].name);
             $("#Country", tr).val(rec.tenders[i].country);
             $("#CashType", tr).val(rec.tenders[i].cashType);
             $("#Cash", tr).val(rec.tenders[i].cash);
             $("#CashUnit", tr).val(rec.tenders[i].cashUnit);
             $("#DeleteMe", tr).click(function() {
                 $(this).closest("tr").remove();
             });
         }
         $("#BiddingRecordForm #Address").val(rec.address);
         $("#BiddingRecordForm #Contact").val(rec.contact);
         $("#BiddingRecordForm #Telephone").val(rec.telephone);
         $("#BiddingRecordForm #MobilePhone").val(rec.mobilePhone);
         $("#BiddingRecordForm #Fax").val(rec.fax);
         $("#BiddingRecordForm #Email").val(rec.email);
         $("#BiddingRecordForm #BidPrice1").val(rec.bidPrice1);
         $("#BiddingRecordForm #BidPrice1Unit").val(rec.bidPrice1Unit);
         $("#BiddingRecordForm #BidPrice2").val(rec.bidPrice2);
         $("#BiddingRecordForm #BidPrice2Unit").val(rec.bidPrice2Unit);
         $("#BiddingRecordForm #Supplier").val(rec.supplier);
         $("#BiddingRecordForm #SupplierCountry").val(rec.supplierCountry);
         $("#BiddingRecordForm #BiddingDocPurchaseRecord").xnfile();
         $("#BiddingRecordForm #BiddingDocPurchaseRecord").xnfile("value", rec.biddingDocPurchaseRecord);
         $("#BiddingRecordForm #TenderDoc").xnfile();
         $("#BiddingRecordForm #TenderDoc").xnfile("value", rec.tenderDoc);
         $("#BiddingRecordForm #Receipts").xnfile();
         $("#BiddingRecordForm #Receipts").xnfile("value", rec.receipts);
         $("#BiddingRecordForm #Remark").val(rec.remark);
         $("#BiddingRecordForm #SaveBiddingRecordButton").hide();
         $("#BiddingRecordForm #UpdateBiddingRecordButton").show();
    },

     // 删除招投标记录
    onDeleteBiddingRecord: function(src, idx) {
        var data = $(src).closest("table").data("data");
        data.splice(idx, 1);
        $(src).closest("tr").remove();
    },

    // 更新开标投标表单
    updateBidPackages: function() {
        for (var i = 0; i < ibs._bidPackages.length; i++) {
            var bp = ibs._bidPackages[i];
            var tp = $("#BOWrap>div.template").clone();
            tp.attr("id", "BPTab" + (i + 1))
                .removeAttr("style", "display:none")
                .removeClass("bo")
                .addClass("data");
            $("div", tp).removeAttr("style", "display:none");
            $("#BOWrap>div.tab-content").append(tp);
            $("#Control35", tp).val(bp.issueDate);
            $("#Control36", tp).val(bp.openingDate);
            $("#Control37", tp).val(bp.timeAndPlace);
            $("#FinalBiddingDoc", tp).xnfile();
            $("#FinalBiddingDoc", tp).xnfile("value", bp.finalBiddingDoc);
            $("#BiddingNotice", tp).xnfile();
            $("#BiddingNotice", tp).xnfile("value", bp.biddingNotice);
            $("#IssueBiddingNoticeButton", tp).click(ibs.bidopenRequestBiddingNotice);
            $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?command=GetBiddingNoticeAudits&object_id=" 
                + ibs._sheetInfo.BizObjectID 
                + "&package_name=包" + (i + 1), 
                function(data) {
                    if (data.length > 0) {
                        var canSubmit = true;
                        var table = $("#bidding-notice-audit-state");
                        for (var i = 0; i < data.length; i++) {
                            var tr = $("tr.template", table).clone();
                            tr.removeClass("template").removeAttr("style", "display:none");
                            $("#originator", tr).text(data[i].originatorName);
                            $("#request-time", tr).text(data[i].startTime);
                            $("#state", tr).text(data[i].state);
                            $("tbody", table).append(tr);
                            if (data[i].state == "审批") {
                                canSubmit = false;
                            }
                        }
                        $("#IssueBiddingNoticeButton").hide();
                        if (!canSubmit) {
                            $("li[data-action='Submit']").hide();
                        }
                    }
                }
            );

            $("#BiddingFaq", tp).xnfile();
            $("#BiddingFaq", tp).xnfile("value", bp.biddingFaq);
            $("#BidOpeningOverviewSheet", tp).xnfile();
            $("#BidOpeningOverviewSheet", tp).xnfile("value", bp.overviewSheet);
            $("#AddBiddingRecordButton", tp).click(function() {
                ibs.bidopenClearTenderRecord();

                $("#BiddingRecordForm").modal("show");
                $("#BiddingRecordForm div").removeAttr("style", "display:none");
                $("#BiddingRecordForm #SaveBiddingRecordButton").show();
                $("#BiddingRecordForm #UpdateBiddingRecordButton").hide();
                //$("#BiddingRecordForm #BiddingDocPurchaseRecord").xnfile();
                //$("#BiddingRecordForm #TenderDoc").xnfile();
                //$("#BiddingRecordForm #Receipts").xnfile();
                //$("#BiddingRecordForm #SaveBiddingRecordButton").show();
                //$("#BiddingRecordForm #UpdateBiddingRecordButton").hide();

                
            });
            $("#BOWrap>ul").prepend("<li role=\"presentation\"><a href=\"#BPTab"
                + (i + 1)
                + "\" role=\"tab\" aria-controls=\"BPTab"
                + (i + 1)
                + "\" data-toggle=\"tab\">包"
                + (i + 1)
                + "</a></li>");
            if (i == 0) {
                $("#BOWrap>ul>li:first").addClass("active");
                $("#BOWrap>div.tab-content>div.tab-pane").addClass("active");
            }

            for (var j = 0; j < bp.tenders.length; j++) {
                var br = bp.tenders[j];
                var html = "<table><tbody>";
                for (var k = 0; k < br.tenders.length; k++) {
                    html += "<tr><td>"
                        + br.tenders[k].name
                        + "</td><td>"
                        + br.tenders[k].cashType
                        + br.tenders[k].cash
                        + br.tenders[k].cashUnit
                        + "</td></tr>";
                }
                html += "</tbody></table>";
                $("#BiddingRecords>tbody", tp).append(
                    "<tr><td>"
                    + (j + 1)
                    + "</td><td>"
                    + html
                    + "</td><td>"
                    + br.bidPrice1 + br.bidPrice1Unit + "<br>"
                    + br.bidPrice2 + br.bidPrice2Unit
                    + "</td><td>"
                    + "<button type=\"button\" class=\"btn btn-default\" onclick=\"ibs.onEditBiddingRecord(" + j + ")\">编辑</button>"
                    + "<button type=\"button\" class=\"btn btn-default\" onclick=\"ibs.onDeleteBiddingRecord(this, "
                        + j + ")\">删除</button>"
                    + "</td></tr>"
                );
            }
            $("#PrintBiddingRecordsButton", tp).click(ibs.bidopenOnPrintBiddingRecord);
        }
    },

    // 发起招标公告审批流程
    bidopenRequestBiddingNotice: function() {
        var checksum = ibs.bidopenGetFormChecksum();
        if (checksum == ibs._bidopenFormChecksum) {
            var file = $.MvcSheetUI.GetControlValue("BiddingNotice");
            if (file == "") {
                layer.alert('请上传招标公告。如已上传，请先保存表单。', {icon:2});
                return ;
            }
            var managerA = $.MvcSheetUI.GetControlValue("ManagerA");
            var managerB = $.MvcSheetUI.GetControlValue("ManagerB");
            var projectName = $.MvcSheetUI.GetControlValue("ProjectName");
            var url = "/Portal/Sheets/bidding/BiddingNoticeAudit.aspx?Mode=Originate"
                + "&WorkflowCode=BiddingNotice"
                + "&WorkflowVersion=" + ibs._workflowVersion["BiddingNotice"] 
                + "&IssueObjectId=" + ibs._sheetInfo.BizObjectID
                + "&ParentWorkItemId=" + ibs._sheetInfo.WorkItemId
                + "&ManagerA=" + managerA
                + "&ManagerB=" + managerB
                + "&ProjectName=" + projectName
                + "&PackageName="
                + "&BiddingNotice=" + file
                + "&T=" + Math.random();
            window.location.href = url;
            window.event.returnValue = false;
        }
        else {
            layer.alert("请保存后再发起申请，以免丢失数据。", {icon:2});
        }
    },

    // =======================================================================
    // 
    // 评标
    //
    // =======================================================================

    _evaluationData: null,

    setOpeningFormReadlyonly: function() {
        if (ibs._sheetInfo.ActivityCode == "OpeningActivity")
            return ;
        $("#BOWrap>ul>li.add").hide();
        $("#BOWrap>ul>li.remove").hide();
        $("#BOWrap input").attr("readonly", "readonly").removeAttr("style", "display:none");
        $("#BOWrap button").each(function() {
            if ($(this).text() == "删除" || $(this).text() == "增加" || $(this).text() == "发起公告") {
                $(this).hide();
            }
        });
        $("#BOWrap span").removeAttr("style", "display:none");
        if (ibs._sheetInfo.ActivityCode != "EvaluationActivity")
            ibs.setEvaluationReadonly();
    },

    setEvaluationReadonly: function() {
        $("#bid-evaluation input").attr('readonly', "readonly").removeAttr("style", "display:none");
        $("#bid-evaluation select").attr('disabled', "disabled");
        $("#bid-evaluation span").removeAttr("style", "display:none");
        setTimeout(function() {
            $("#bid-evaluation button").each(function() {
                if ($(this).text() == "选择" || $(this).text() == "删除" || $(this).text() == "增加中标价" || $(this).text() == "-") {
                    $(this).hide();
                }
            });
        }, 3000);
    },

    // 根据子表创建评标表单
    bidevaSaveWinner: function() {
        var winner = $("#be-wrap>div.tab-content>div.active #winner").val();
        $.getJSON("InviteBidsHandler.ashx?Command=GetCustomerObjectId&name="
            + winner, function(data) {
                if (data.objectId === "") {
                    window.open("/Portal/MvcDefaultSheet.aspx?SheetCode=SCustomerList&Mode=Originate&SchemaCode=CustomerList&parentObjectId=" + ibs._sheetInfo.BizObjectID+ "&name=" + winner);
                }
                else {
                    window.open("/Portal/MvcDefaultSheet.aspx?SheetCode=SCustomerList&Mode=Work&SchemaCode=CustomerList&BizObjectID=" + data.objectId + "&parentObjectId=" + ibs._sheetInfo.BizObjectID + "&name=" + winner);
                }
            }
        )
    },

    bidevaOnAddTenerPrice: function(evt) {
        var pane = evt.data.pane;
        var table = $("#bid-prices>.bid-price-template", pane).clone();
        table.removeAttr("style", "display:none")
            .removeClass("bid-price-template")
            .addClass("data");
        $("#bid-prices", pane).append(table);
        ibs.initSelect($("tr.compulsory #bid-price-unit", table), ibs._cashTypies);       
        ibs.initAgencyAgreement($("tr.compulsory #associated-agreement", table));
        $("#add-bid-price-btn2", table).click(function() {
            var tbody = $(this).closest("tbody");
            var tr = $(".template", tbody).clone();
            tr.removeClass("template").addClass("data");
            ibs.initSelect($("#bid-price-unit", tr), ibs._cashTypies);       
            $("#remove-me", tr).click(function() {
                $(this).closest("tr").remove();
            });
            $(".toolbar", tbody).before(tr);
            ibs.bidevaWatchTenderPriceChanged(pane);
        });
        ibs.bidevaWatchTenderPriceChanged(pane);
    },

    bidevaOnTenderPriceChanged: function(evt) {
        var pane = evt.data.pane;
        var total = 0;
        var idx = 0;
        // TODO #207
        // 加入当前标签定语
        $("#bid-prices>table.data", pane).each(function() {
            $("tr.data", this).each(function() {
                total += ibs.parseInt($("#bid-price", this).val()) * ibs.parseFloat($("#exchange-rate", this).val());
            });
        });
        $("#total-bidding-price", pane).val(total);
    },

    bidevaWatchTenderPriceChanged: function(pane) {
        $("#be-wrap>div.tab-content>div.active #bid-price").unbind().change({pane, pane}, ibs.bidevaOnTenderPriceChanged);
        $("#be-wrap>div.tab-content>div.active #exchange-rate").unbind().change({pane, pane}, ibs.bidevaOnTenderPriceChanged);
    },

    getActiveEvaluationIndex: function() {
        return $("#be-wrap>ul>li.active>a").text().substring(1);
    },

    bidevaOnValidate: function() {
        var v = ibs.bidevaGetData();
        if (ibs._isSubmit) {
            for (var i = 0; i < v.length; i++) {
                if (v[i].publicityDate == "") {
                    layer.alert('请选择公示日期。', { icon: 2 });
                    return false;
                }
                if (v[i].tenderPrices.length == 0) {
                    layer.alert('中标价至少要有一条。', { icon: 2 });
                    return false;
                }
                if (v[i].bidWinner == "") {
                    layer.alert("请选择中标人。", {icon: 2});
                    return false;
                }
            }
        }

        ibs._evaluationData = v;
        ibs.bidevaSyncBack();
        ibs.bidevaSaveTenderPrice();
        
        return true;
    },

    bidevaGetData: function() {
        var data = [];
        $("#be-wrap>div.tab-content>div.data").each(function() {
            var ev = {
                evaluationReport: $("#evaluation-report", this).xnfile("value"),
                bidWinner: $("#winner", this).val(),
                clarification: $("#clarification", this).xnfile("value"),
                ownerComment: $("#owner-comment", this).xnfile("value"),
                publicityDate: $("#Control46", this).val(),
                noticeScreenshot: $("#notice-screenshot", this).xnfile("value"),
                packageName: "包" + $(this).attr("id").substring(6),
                tenderPrices: [],
                auditExperts: [],
                EquivalentRMB: $("#total-bidding-price", this).val(),
                isFinished: $("#is-finished", this).prop("checked")
            };
            var idx = 0;
            var priceClass = {
                i: 0,
                j: 0,
                price: 0,
                priceUnit: "",
                exchangeRate: 1,
                hasAssociatedAgreement: false,
                associatedAgreement: "",
                agreementCode: "",
                agreementType: "",
                agreementIndex: 0
            };
            var i = 0;
            $("#bid-prices>table.data", this).each(function() {
                var j = 0;
                var hasAgreement = false;
                var agreement = "";
                var agreementCode = "";
                var agreementType = "";
                var agreementIndex = 0;
                $("tr.data", this).each(function() {
                    var price = Object.assign({}, priceClass);
                    price.i = i;
                    price.j = j;
                    price.price = $("#bid-price", this).val();
                    price.priceUnit = $("#bid-price-unit", this).val();
                    price.exchangeRate = $("#exchange-rate", this).val();
                    if (j == 0) {
                        price.hasAssociatedAgreement = $("#has-associated-agreement", this).prop("checked");
                        hasAgreement = price.hasAssociatedAgreement;
                        if ($("#associated-agreement", this).val() != "") {
                            var fields = $("#associated-agreement", this).val().split(",");
                            price.associatedAgreement = fields[0];
                            agreement = fields[0];
                            price.agreementCode = fields[1];
                            agreementCode = fields[1];
                            price.agreementType = fields[2];
                            agreementType = fields[2];
                            price.agreementIndex = fields[3];
                            agreementIndex = fields[3];
                        }
                    }
                    else {
                        price.hasAssociatedAgreement = hasAgreement;
                        price.associatedAgreement = agreement;
                        price.agreementCode = agreementCode;
                        price.agreementType = agreementType;
                        price.agreementIndex = agreementIndex;
                    }
                    ev.tenderPrices.push(price);
                    j++;
                });
                i++;
            })
            $("#evaluation-expert-table>tbody>tr.data", this).each(function() {
                var expert = {
                    name: $(".name", this).text(),
                    company: $(".company", this).text(),
                    mobilePhone: $(".mobile-phone", this).text()
                };
                ev.auditExperts.push(expert);
            });
            data.push(ev);
        });

        return data;
    },

    bidevaSyncBack: function() {
        var table = $("#ctl358014").SheetUIManager();
        table._Clear();
        for (var i = 0; i < ibs._evaluationData.length; i++) {
            var v = ibs._evaluationData[i];
            table._AddRow();
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.EvaluationReport", v.evaluationReport, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.BidWinner", v.bidWinner, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.Clarification", v.clarification, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.PublicityDate", v.publicityDate, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.PublicityScreenShot", v.noticeScreenshot, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.PackageName", v.packageName, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.OwnerComment", v.ownerComment, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.EquivalentRMB", v.EquivalentRMB, i + 1);
            $.MvcSheetUI.SetControlValue("BiddingEvaluation.IsFinished", v.isFinished, i + 1);
        }
    },

    bidevaSaveTenderPrice: function() {
        for (var i = 0; i < ibs._evaluationData.length; i++) {
            var ev = ibs._evaluationData[i];
            $.post(
                "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                {
                    Command: "SaveTenderPrice",
                    object_id: ibs._sheetInfo.BizObjectID,
                    package_name: ev.packageName,
                    data: JSON.stringify(ev.tenderPrices)
                },
                function() {}
            );
            $.post(
                "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
                {
                    Command: "SaveAuditExpert",
                    ParentObjectId: ibs._sheetInfo.BizObjectID,
                    PackageName: ev.packageName,
                    Data: JSON.stringify(ev.auditExperts)
                },
                function() {}
            );
        }
    },

    bidevaLoadTenderPrice: function(parentObjectId, packageName, panel) {
        var _panel = panel;
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadTenderPrice",
                ParentObjectId: parentObjectId,
                PackageName: packageName
            },
            function(data) {
                if (data.length > 0) {
                    var i = -1;
                    var j = 0;
                    for (var k = 0; k < data.length; k++) {
                        var bidPrice = data[k];
                        if (i != bidPrice.i) {
                            var tbl = $(".bid-price-template", _panel).clone();
                            $("#bid-price", tbl).val(bidPrice.price);
                            ibs.initSelect($("#bid-price-unit", tbl), ibs._cashTypies);
                            $("#bid-price-unit", tbl).val(bidPrice.priceUnit);
                            $("#exchange-rate", tbl).val(bidPrice.exchangeRate);
                            ibs.initAgencyAgreement($("#associated-agreement", tbl));
                            var value = bidPrice.associatedAgreement + ","
                                + bidPrice.agreementCode + ","
                                + bidPrice.agreementType + ","
                                + bidPrice.agreementIndex;
                            $("#associated-agreement", tbl).val(value);
                            if (bidPrice.hasAssociatedAgreement) {
                                $("#has-associated-agreement", tbl).prop("checked", true);
                            }
                            $("#add-bid-price-btn2", tbl).click(function() {
                                var tbody = $(this).closest("tbody");
                                var tr = $(".template", tbody).clone();
                                tr.removeClass("template").addClass("data");
                                ibs.initSelect($("#bid-price-unit", tr), ibs._cashTypies);       
                                $("#remove-me", tr).click(function() {
                                    $(this).closest("tr").remove();
                                });
                                $(".toolbar", tbody).before(tr);
                                ibs.bidevaWatchTenderPriceChanged(_panel);
                            });
                            tbl.removeAttr("style", "display:none").addClass("data").removeClass("bid-price-template");
                            $("#bid-prices", _panel).append(tbl);
                            i = bidPrice.i;
                        }
                        else {
                            var tr = $(".template", tbl).clone();
                            $(".toolbar", tbl).before(tr);
                            $("#bid-price", tr).val(bidPrice.price);
                            tr.removeClass("template").addClass("data");
                            ibs.initSelect($("#bid-price-unit", tr), ibs._cashTypies);
                            $("#bid-price-unit", tr).val(bidPrice.priceUnit);
                            $("#exchange-rate", tr).val(bidPrice.exchangeRate);
                            $("#remove-me", tr).click(function() {
                                $(this).closest("tr").remove();
                            });
                            ibs.bidevaWatchTenderPriceChanged(_panel);
                        }
                    }
                    ibs.bidevaWatchTenderPriceChanged(_panel);
                }
            }
        );
    },

    initAgencyAgreement: function(sel) {
        var agencyAgreements = $.MvcSheetUI.GetControlValue("AgencyAgreements");
        for (var i = 0; i < agencyAgreements.length; i++) {
            var value = agencyAgreements[i].AgreementName + ","
                + agencyAgreements[i].AgreementCode + ","
                + agencyAgreements[i].AgrencyType + ","
                + agencyAgreements[i].TheNo;
            var name = agencyAgreements[i].AgreementName + "-"
                + agencyAgreements[i].AgrencyType + "-"
                + agencyAgreements[i].TheNo;
            $(sel).append("<option value='" + value + "'>"
                + name + "</option>");
        }
    },

    //评标中弹出关联协议选择
    onSelectAssociatedAgreement: function(index) {
        //alert(index);
        
        ibs.initSelectAssociatedAgreementForm(index);
        
        ibs.showSelectAssociatedAgreementForm();
    },

    //初始化
    initSelectAssociatedAgreementForm: function(index) {
        //获取数据
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadAgencyAgreement"
            },
            function(data) {
                ibs.initSelect($("#select-associated-agreement-activity"), data);
                }
            );
        $("#tenderPriceIndex").val(index);
    },

    //宣示关联协议选择框
    showSelectAssociatedAgreementForm: function() {
        $("#AssociatedAgreementForm").modal("show");
        $("#AssociatedAgreementForm div.row").removeAttr("style", "display:none");
    },

    // 选好关联协议
    onSelectAssociatedAgreementFormOk: function() {
        var assagreement = $("#select-associated-agreement-activity").val();
        var index = $("#tenderPriceIndex").val();
        var table = $("#be-wrap>div.tab-content>div.active #tender-price");
        var i = 0;
        $("tr", table).each(function() {
            tr = $(this);
            if (tr.index() == index) {
                $("#associated-agreement", tr).val(assagreement);
            }
        });

        $("#AssociatedAgreementForm").modal("hide");
    },


    // =======================================================================
    // 
    // 中标退保
    // 
    // =======================================================================


    _refundState: null,

    bidrefOnCreated: function() {
        $("#refund").show();
        ibs.bidrefLoad();
    },

    bidrefAddTab: function() {
        var idx = ibs.bidrefGetTabCount() + 1;
        var tp = $("#refund-wrap>div.template").clone();
        tp.attr("id", "ref-tab" + idx)
            .removeAttr("style", "display:none")
            .removeClass("template")
            .addClass("data");
        $("div", tp).removeAttr("style", "display:none");
        $("#refund-wrap>div.tab-content").append(tp);
        $("#refund-wrap>ul").prepend("<li role=\"presentation\"><a href=\"#ref-tab"
            + idx
            + "\" role=\"tab\" aria-controls=\"ref-tab"
            + idx
            + "\" data-toggle=\"tab\">包"
            + idx
            + "</a></li>");
        if (idx == 1) {
            $("#refund-wrap>ul>li:first").addClass("active");
            $("#refund-wrap>div.tab-content>div.tab-pane").addClass("active");
        }
        if (idx == 1) {
            $("#refund-wrap>ul>li:first").addClass("active");
            $("#refund-wrap>div.tab-content>div.tab-pane").addClass("active");
        }
     },

    bidrefOnAddPackage: function() {
        ibs.bidrefAddTab();
    },

    bidrefOnRemovePackage: function() {
        var li = $("#refund-wrap>ul>li.active");
        if (li != undefined) {
            $("#refund-wrap>ul>li").each(function() {
                if ($(this).attr("role") == "presentation" && $(this).hasClass("active")) {
                    $(this).remove();
                } 
            });
            $("#refund-wrap>div.tab-content>div.active").remove();
        }
        ibs.bidrefSortTab();
    },

    bidrefSortTab: function() {
        var idx = 1;
        $("#refund-wrap>ul>li").each(function() {
            if ($(this).attr("role") == "presentation") {
                $("a", this).attr("href", "#ref-tab" + idx);
                $("a", this).text("包" + idx);
                if (idx == 1) {
                    $(this).addClass("active");
                }
                idx++;
            }
        })
        idx = 1;
        $("#refund-wrap>div.tab-content>div").each(function() {
            $(this).attr("id", "ref-tab" + idx);
            if (idx == 1) 
                $(this).addClass("active");
            idx++;
        })
    },

    bidrefGetTabCount: function() {
        var count = 0;
        $("#refund-wrap>div.tab-content>div.data").each(function() {
            count++;
        });
        return count;
    },

    bidrefLoadRefundState: function() {
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadTenders",
                ParentObjectId: ibs._sheetInfo.BizObjectID
            },
            function(data) {
                ibs._refundState = data;            
                ibs.updateRefundTable();
            }
        );
    },

    bidrefLoad: function() {
        var bideva = $("table[data-datafield=BiddingEvaluation]").SheetUIManager();
        if (bideva.RowCount > 0) {
            var data = bideva.GetValue();
            for (var i = 0; i < bideva.RowCount; i++) {
                ibs.bidrefAddTab();
                var idx = data[i].PackageName.substring(1);
                ibs.bidrefLoadPackage(idx);
            }
        }
        ibs.bidrefSync();
    },

    bidrefSync: function() {
        var winnot = $("table[data-datafield=WinnerNotice]").SheetUIManager();
        var data = winnot.GetValue();
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                var pane = $("#ref-tab" + data[i].PackageName.substring(1));
                $("#winner-notice-date",pane).val(data[i].NoticeDate);
                $("#is-finished", pane).prop("checked", data[i].IsFinished);
            }
        }
    },

    bidrefLoadPackage: function(idx) {
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadTenders",
                PackageName: "包" + idx,
                ParentObjectId: ibs._sheetInfo.BizObjectID
            },
            function(data) {
                if (data.length > 0) {
                    var pane = $("#ref-tab" + idx);
                    var tbl = $("#refund-table", pane);
                    for (var i = 0; i < data.length; i++) {
                        tr = $("tbody>tr.template", tbl).clone();
                        $(tr).data("data", data[i]);
                        tr.removeClass("template").addClass("data");
                        $(".tender", tr).text(data[i].name);
                        $(".state", tr).text(data[i].bidResult);
                        $(".cash-deposit-type", tr).text(data[i].cashType);
                        $(".cash-deposit", tr).text(data[i].cash);
                        $(".refund-state", tr).text(data[i].refundState);
                        if (data[i].refundState == "未退") {
                            canSubmit = false;
                            $(".operate", tr).text("退款");
                            $(".operate", tr).on("click", {idx: i}, ibs.onRefund);
                        }
                        else {
                            $(".operate", tr).text("查看");
                            $(".operate", tr).on("click", {idx: i}, ibs.onRefund);
                        }
                        $("tbody", tbl).append(tr);
                    }
                }
            }
        );        
    },

   updateRefundTable: function() {
        var canSubmit = true;
        if (ibs._refundState.length > 0) {
            var tbl = $("#refund #refund-table");
            for (var i = 0; i < ibs._refundState.length; i++) {
                tr = $("tbody>tr.template", tbl).clone();
                tr.removeClass("template").addClass("data");
                $(".tender", tr).text(ibs._refundState[i].name);
                $(".state", tr).text(ibs._refundState[i].bidResult);
                $(".cash-deposit-type", tr).text(ibs._refundState[i].cashType);
                $(".cash-deposit", tr).text(ibs._refundState[i].cash);
                $(".refund-state", tr).text(ibs._refundState[i].refundState);
                if (ibs._refundState[i].refundState == "未退") {
                    canSubmit = false;
                    $(".operate", tr).text("退款");
                    $(".operate", tr).on("click", {idx: i}, ibs.onRefund);
                }
                else {
                    $(".operate", tr).text("查看");
                    $(".operate", tr).on("click", {idx: i}, ibs.onRefund);
                }
                $("tbody", tbl).append(tr);
            }
        }
        if (!canSubmit) {
            $("li[data-action='Submit']").hide();
        }
    },

    onRefund(evt) {
        $("#refund-state-form").modal("show");
        $("#refund-state-form div.row").show();
        var data = $(evt.currentTarget).closest("tr").data("data");
        $("#refund-state-form #package-name").val(data.packageName);
        $("#refund-state-form #name").val(data.name);
        $("#refund-state-form #country").val(data.country);
        $("#refund-state-form #cash-type").val(data.cashType);
        $("#refund-state-form #cash").val(data.cash);
        $("#refund-state-form #cash-type").val(data.cashType);
        $("#refund-state-form #address").val(data.address);
        $("#refund-state-form #contact").val(data.contact);
        $("#refund-state-form #telephone").val(data.telephone);
        $("#refund-state-form #mobile-phone").val(data.mobilePhone);
        $("#refund-state-form #fax").val(data.fax);
        $("#refund-state-form #email").val(data.email);
        $("#refund-state-form #bid-price1").val(data.price1);
        $("#refund-state-form #bid-price1-unit").val(data.price1Unit);
        $("#refund-state-form #bid-price2").val(data.price2);
        $("#refund-state-form #bid-price2-unit").val(data.price2Unit);
        $("#refund-state-form #supplier").val(data.supplier);
        $("#refund-state-form #supplier-country").val(data.supplierCountry);
        $("#refund-state-form #bidding-doc-purchase-record").xnfile();
        $("#refund-state-form #bidding-doc-purchase-record").xnfile("value", data.purchaseBiddingDocForm);
        $("#refund-state-form #bidding-doc-purchase-record button").prop("disabled", "disabled");
        $("#refund-state-form #tender-doc").xnfile();
        $("#refund-state-form #tender-doc").xnfile("value", data.tenderDoc);
        $("#refund-state-form #tender-doc button").prop("disabled", "disabled");
        $("#refund-state-form #receipts").xnfile();
        $("#refund-state-form #receipts").xnfile("value", data.receipts);
        $("#refund-state-form #receipts button").prop("disabled", "disabled");
        $("#refund-state-form #remark").val(data.remark);
        $("#refund-state-form #bidding-result").val(data.bidResult);
        $("#refund-state-form #notice-of-bidding").xnfile();
        $("#refund-state-form #notice-of-bidding").xnfile("value", data.noticeOfBidding);

        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadRefundAudit",
                ParentObjectId: ibs._sheetInfo.BizObjectID,
                TenderName: $("#refund-state-form #name").val()
            },
            function(data) {
                if (data.length > 0) {
                    $("#refund-state-form #request-refund-btn").hide();
                    for (var i = 0; i < data.length; i++) {
                        var tr = $("#refund-state-form #refund-table>tbody>tr.template").clone();
                        tr.removeClass("template").addClass("data");
                        $(".applicant", tr).text(data[i].originator);
                        $(".time", tr).text(data[i].time);
                        $(".type", tr).text(data[i].cashType);
                        $(".amount", tr).text(data[i].cash);
                        $(".state", tr).text(data[i].state);
                        if (data[i].state == "通过") {
                            $("#refund-state-form #request-refund-btn").show().unbind().click(ibs.onRequestRefund);
                        }
                        else {
                            $("#refund-state-form #request-refund-btn").hide();
                        }
                        $("#refund-state-form #refund-table>tbody").append(tr);
                    }
                }
                else {
                    $("#refund-state-form #request-refund-btn").show().unbind().click(ibs.onRequestRefund);
                }
            }
        )

        $("#refund-state-form #save-bidding-result-btn").unbind().click(ibs.onSaveRefundState);
    },

    onSaveRefundState: function() {
        var tenderDoc = $("#refund-state-form #tender-doc").xnfile("value");
        var noticeOfBidding = $("#refund-state-form #notice-of-bidding").xnfile("value");
        var biddingDocPurchaseRecord = $("#refund-state-form #bidding-doc-purchase-record").xnfile("value");
        var receipts = $("#refund-state-form #receipts").xnfile("value");
        if (noticeOfBidding == null || noticeOfBidding == "") {
            layer.alert('请上传中标/落标通知书。', { icon: 2 });
            return ;
        }
        $.post(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "SaveRefundState",
                ParentObjectId: ibs._sheetInfo.BizObjectID,
                PackageName: $("#refund-state-form #package-name").val(),
                TenderDoc: tenderDoc,
                NoticeOfBidding: noticeOfBidding,
                PurchaseRecord: biddingDocPurchaseRecord,
                Receipts: receipts
            },
            function(data) {
                $("#refund-state-form").modal("hide");
            }
        );
    },

    onRequestRefund: function() {
        var url = "/Portal/Sheets/bidding/RefundApprove.aspx?Mode=Originate"
            + "&WorkflowCode=RefundCashDeposit&WorkflowVersion="
            + ibs._workflowVersion["RefundCashDeposit"]
            + "&ProjectName=" + $.MvcSheetUI.GetControlValue("ProjectName")
            + "&ParentWorkItemId=" + ibs._sheetInfo.WorkItemId
            + "&BiddingCode=" + $.MvcSheetUI.GetControlValue("BiddingCode")
            + "&Tender=" + $("#refund-state-form #name").val()
            + "&WinnerOrLoser=" + $("#refund-state-form #bidding-result").val()
            + "&CashDepositType=" + $("#refund-state-form #cash-type").val()
            + "&CashDeposit=" + $("#refund-state-form #cash").val()
            + "&DepositType=退保"
            + "&IssueObjectId=" + ibs._sheetInfo.BizObjectID;
        window.location.href = url;
        window.event.returnValue = false;
    },

    bidrefOnValidate: function() {
        ibs.bidrefSyncBack();
        return true;
    },

    bidrefSyncBack: function() {
        var winnot = $("table[data-datafield=WinnerNotice]").SheetUIManager();
        winnot._Clear();
        var row = 1;
        $("#refund-wrap>div.tab-content>div.data").each(function() {
            winnot._AddRow();
            var v = $("#winner-notice-date", this).val();
            $.MvcSheetUI.SetControlValue("WinnerNotice.PackageName", "包" + row, row);
            $.MvcSheetUI.SetControlValue("WinnerNotice.NoticeDate", v, row);
            $.MvcSheetUI.SetControlValue("WinnerNotice.IsFinished", $("#is-finished", this).prop("checked"), row);
            row++;
        });
    },

    bidSetReadonly: function() {
        setTimeout(function() {
            $("#bid-opening button").attr("disabled", "disabled");
            $("#bid-opening input[type=button]").prop("disabled", true);
            $("#bid-opening input[type=file]").prop("disabled", true);
            $("#bid-evaluation button").attr("disabled", "disabled");
            $("#bid-evaluation input[type=button]").prop("disabled", true);
            $("#bid-evaluation input[type=file]").prop("disabled", true);
            $("#refund button").attr("disabled", "disabled");
            $("#refund input[type=button]").prop("disabled", true);
            $("#refund input[type=file]").prop("disabled", true);
        }, 1000);
    },

    // ======================================================================
    //
    // 归档归尾
    //
    // ======================================================================

    fileOnCreated: function() {
        $("#file").show();
        ibs.bidSetReadonly();
        $.getJSON(
            "/Portal/Sheets/bidding/InviteBidsHandler.ashx",
            {
                Command: "LoadFileAudit",
                ParentObjectId: ibs._sheetInfo.BizObjectID
            },
            function(data) {
                var canSubmit = true;
                if (data.length > 0) {
                    $("#file #request-file-btn").hide();
                    for (var i = 0; i < data.length; i++) {
                        var tr = $("#file #file-audit-table>tbody>tr.template").clone();
                        tr.removeClass("template").addClass("data");
                        $(".applicant", tr).text(data[i].originator);
                        $(".time", tr).text(data[i].time);
                        $(".state", tr).text(data[i].state);
                        if (data[i].state == "通过") {
                            $("#file #request-file-btn").show().unbind().click(ibs.onRequestFile);
                        }
                        else {
                            $("#file #request-file-btn").hide();
                            canSubmit = false;
                        }
                        $("#file #file-audit-table>tbody").append(tr);
                    }
                }
                else {
                    $("#file #request-file-btn").show().unbind().click(ibs.onRequestFile);
                }

                if (!canSubmit) {
                    $("li[data-action='Submit']").hide();
                }
            }
        );
    },

    validateFileForm: function() {
        if (ibs._isSubmit) {
            if ($.MvcSheetUI.GetControlValue("CapitalSavingRate") == "") {
                layer.alert('请输入节资率。', { icon: 2 });
                return false;
            }
        }

        return true;
    },
    
    onRequestFile: function() {
        $("#BiddingDoc").xnfile();
        var url = "/Portal/Sheets/bidding/FileApprove.aspx?Mode=Originate"
            + "&WorkflowCode=FileBidding&WorkflowVersion="
            + ibs._workflowVersion["FileBidding"]
            + "&IssueObjectId=" + ibs._sheetInfo.BizObjectID
            + "&ProjectName=" + $.MvcSheetUI.GetControlValue("ProjectName")
            + "&ParentWorkItemId=" + ibs._sheetInfo.WorkItemId
            + "&BiddingCode=" + $.MvcSheetUI.GetControlValue("BiddingCode")
            + "&BiddingDocLink=" + $("#BiddingDoc").xnfile("value");
        window.location.href = url;
        window.event.returnValue = false;
    },

    // ======================================================================
    //
    // 取回
    // 
    // ======================================================================

    initGoBackForm: function() {
        $("#go-back-btn").click(ibs.onRequestGoBack);
        $.MvcSheet.AddAction({
            Action: "GoBack",
            Icon: "fa-sign-in",
            Text: "取回",
            Datas: [],
            OnAction: function () {
                var activities = [
                    {code: "CreateActivity", name: "创建项目"},
                    {code: "PrepareActivity", name: "招标准备"},
                    {code: "BidActivity", name: "招标"},
                    {code: "FileActivity", name: "资料归档"}
                ];
                if (ibs._sheetInfo.ActivityCode == activities[0].code) {
                    layer.alert('创建项目时不需要取回。', { icon: 2 });
                }
                else {
                    $("#select-go-back-activity").empty();
                    for (var i = 0; i < activities.length; i++) {
                        if (activities[i].code == ibs._sheetInfo.ActivityCode)
                            break;
                        $("#select-go-back-activity").append("<option value='"
                            + activities[i].code + "' "
                            + (i == 0 ? "selected" : "")
                            + ">" + activities[i].name
                            + "</option>"
                        );
                    }
                    $("#go-back-form").modal("show");
                    $("#go-back-form div.row").removeAttr("style", "display:none");
                }
            }
        });
    },

    onRequestGoBack: function() {
        var url = "/Portal/MvcDefaultSheet.aspx?SheetCode=SGoBackBiddingWorkflow"
            + "&Mode=Originate&WorkflowCode=GoBackBiddingWorkflow&WorkflowVersion="
            + ibs._workflowVersion["GoBackBiddingWorkflow"]
            + "&ProjectName=" + $.MvcSheetUI.GetControlValue("ProjectName")
            + "&BiddingCode=" + $.MvcSheetUI.GetControlValue("BiddingCode")
            + "&TheActivityCode=" + $("#select-go-back-activity").val()
            + "&TheInstanceId=" + ibs._sheetInfo.InstanceId;
        window.location.href = url;
        window.event.returnValue = false;
    }
};

ibs.initGoBackForm();

$.MvcSheet.Loaded = function(sheetInfo) {
    ibs.init(sheetInfo);
}

$.MvcSheet.Validate = function () {
    return ibs.validate();
}

$.MvcSheet.SaveAction.OnActionPreDo = function () {
    ibs.onBeforeSave();
}

$.MvcSheet.SaveAction.OnActionDone = function () {
    ibs.onAfterSaved();
}

String.prototype.hashCode = function() {
    var hash = 0, i, chr;
    if (this.length === 0) return hash;
    for (i = 0; i < this.length; i++) {
        chr   = this.charCodeAt(i);
        hash  = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
};

var layer = {
    alert: function(msg, icon) {
        alert(msg);
    }
};
