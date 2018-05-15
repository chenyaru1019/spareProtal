function Selection() {
    var ProfessionField = $.MvcSheetUI.GetControlValue("ProfessionField");
    var Region = $.MvcSheetUI.GetControlValue("Region");
    var NumberOfPeople = $.MvcSheetUI.GetControlValue("NumberOfPeople");
    //判断当前招标编号是否有数据（是否进行保存过）
    if (ProfessionField == "") {
        alert("请选择专业领域!");
    } else if (Region == "") {
        alert("请选择地区!");
    } else if (NumberOfPeople == "0") {
        alert("请输入人数!");
        return;
    } else {
        $("#ShowSelectResultWindow").css("display", "block");
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "../../Webservices/BiddingService.asmx/RandomSelectExperts",
            //url: "ContractHandler.ashx?Command=getByContractNo",   //处理页的相对地址
            data: {
                ProfessionField: ProfessionField,
                Region: Region,
                NumberOfPeople: NumberOfPeople,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                ret.index;
                ret.time;
                ret.objectId;
                window.location.href = "";
            }
        });

           // var WorkflowVersion_Update = $.MvcSheetUI.GetControlValue("WorkflowVersion_Update");
            // window.location.href = "/Portal/StartInstance.html?WorkflowCode=Apply2&ContractNo=" + ContractNo + "&ContractName=" + ContractName;
            //window.location.href = "/Portal/MvcDefaultSheet.aspx?SheetCode=UpdateContractNoMy&Mode=Originate&WorkflowCode=UpdateContractNo&WorkflowVersion=" + WorkflowVersion_Update + "&ContractNo=" + ContractNo + "&ContractName=" + ContractName;
           // window.location.href = "/Portal/Sheets/Project/UpdateTenderReferenceNoMy.aspx?Mode=Originate&WorkflowCode=UpdateTenderReference&WorkflowVersion=" + WorkflowVersion_Update + "&TenderReference=" + TenderReference;

    }
}
function CloseWindow(){
    $("#ShowSelectResultWindow").css("display", "none");
}
function closedWindow() {
    $("#ShowSelectWindow").css("display", "none");
}